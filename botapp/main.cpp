#include <boost/beast/core.hpp>
#include <boost/beast/websocket.hpp>
#include <boost/asio.hpp>
#include <boost/asio/strand.hpp>
#include <tgbot/tgbot.h>
#include <nlohmann/json.hpp>
#include <unordered_map>
#include <thread>
#include <iostream>

using tcp = boost::asio::ip::tcp;
namespace websocket = boost::beast::websocket;
using json = nlohmann::json;

const std::string botToken = "8170486673:AAEIOfws9GcWN0s_Qf37jpNwB_Jj0RaBSUU";
std::unordered_map<std::string, std::string> masterKeys = { { "superkey", "1463585481" } };
std::string expectedUserId;
websocket::stream<tcp::socket>* activeWs = nullptr;

void runBot(TgBot::Bot& bot) {
    TgBot::TgLongPoll longPoll(bot);
    while (true) {
        longPoll.start();
    }
}

void doSession(tcp::socket socket, TgBot::Bot& bot) {
    try {
        websocket::stream<tcp::socket> ws(std::move(socket));
        ws.accept();
        activeWs = &ws;

        for (;;) {
            boost::beast::flat_buffer buffer;
            ws.read(buffer);
            std::string message = boost::beast::buffers_to_string(buffer.data());
            std::cout << "[WS] Получено сообщение: " << message << std::endl;

            try {
                auto j = json::parse(message);
                std::string code = j["code"];

                if (masterKeys.contains(code)) {
                    expectedUserId = masterKeys[code];
                    bot.getApi().sendMessage(
                        std::stoll(expectedUserId),
                        "⚠ Попытка входа!\nОтветьте: `да` или `нет`.",
                        nullptr,
                        nullptr,
                        nullptr,
                        "Markdown"
                        );
                    std::cout << "[WS] ✅ Telegram уведомление отправлено" << std::endl;
                } else {
                    std::cout << "[WS] ❌ Неизвестный код" << std::endl;
                }
            } catch (...) {
                std::cerr << "[WS] ❌ Ошибка парсинга JSON" << std::endl;
            }
        }
    } catch (std::exception const& e) {
        std::cerr << "[WS] ❌ Ошибка в сессии: " << e.what() << std::endl;
    }
}

int main() {
    try {
        boost::asio::io_context ioc;

        TgBot::Bot bot(botToken);
        bot.getEvents().onCommand("start", [&bot](TgBot::Message::Ptr message) {
            bot.getApi().sendMessage(message->chat->id, "🟢 Бот запущен!");
        });

        bot.getEvents().onAnyMessage([&bot](TgBot::Message::Ptr message) {
            std::string userId = std::to_string(message->chat->id);
            std::cout << "[TG] Получено сообщение от " << userId << ": " << message->text << std::endl;

            if (!activeWs || userId != expectedUserId) return;

            if (message->text == "да") {
                activeWs->write(boost::asio::buffer(R"({"status":"confirmed"})"));
                bot.getApi().sendMessage(message->chat->id, "✅ Вход подтверждён");
            } else if (message->text == "нет") {
                activeWs->write(boost::asio::buffer(R"({"status":"denied"})"));
                bot.getApi().sendMessage(message->chat->id, "❌ Вход отклонён");
            }
        });

        std::thread([&bot]() { runBot(bot); }).detach();

        tcp::acceptor acceptor(ioc, { tcp::v4(), 9001 });
        std::cout << "[WS] Сервер слушает на порту 9001 ✅" << std::endl;

        while (true) {
            tcp::socket socket(ioc);
            acceptor.accept(socket);
            std::thread([&bot, s = std::move(socket)]() mutable {
                doSession(std::move(s), bot);
            }).detach();
        }

    } catch (const std::exception& e) {
        std::cerr << "❌ Ошибка: " << e.what() << std::endl;
        return 1;
    }
}
