FROM ubuntu:22.04

# Установка зависимостей
RUN apt-get update && apt-get install -y \
    g++ cmake make git curl wget \
    openssl libssl-dev zlib1g-dev \
    libcurl4-openssl-dev pkg-config \
    libjsoncpp-dev nlohmann-json3-dev \
    libboost-system-dev libboost-thread-dev \
    libwebsockets-dev libfmt-dev

# Установка TgBot
RUN git clone https://github.com/reo7sp/tgbot-cpp.git && \
    cd tgbot-cpp && \
    cmake -Bbuild -S. && \
    cmake --build build && \
    cmake --install build && \
    cd .. && rm -rf tgbot-cpp

WORKDIR /app
COPY . .

# Сборка
RUN cmake -Bbuild -S. && cmake --build build

# Пробрасываем порт наружу
EXPOSE 9001

# Запуск
CMD ["./build/botapp"]
