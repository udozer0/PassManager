#include "authclient.h"
#include <QJsonDocument>
#include <QJsonObject>
#include <QDebug>

AuthClient::AuthClient(QObject* parent) : QObject(parent) {
    connect(&socket, &QWebSocket::connected, this, &AuthClient::onConnected);
    connect(&socket, &QWebSocket::disconnected, this, &AuthClient::disconnected);
    connect(&socket, &QWebSocket::textMessageReceived, this, &AuthClient::onTextMessageReceived);
}

void AuthClient::connectToServer(const QUrl& url) {
    qDebug() << "[Qt] Connecting to" << url;
    socket.open(url);
}

void AuthClient::sendAuthCode(const QString& code) {
    QJsonObject obj;
    obj["code"] = code;
    QJsonDocument doc(obj);
    socket.sendTextMessage(doc.toJson(QJsonDocument::Compact));
}

void AuthClient::onConnected() {
    qDebug() << "[Qt] Connected to WebSocket server!";
    emit connected();
}

void AuthClient::onTextMessageReceived(const QString& message) {
    qDebug() << "[Qt] Received:" << message;

    QString cleanMessage = message;
    cleanMessage.remove(QChar::Null); // Удаляем '\0'

    QJsonDocument doc = QJsonDocument::fromJson(cleanMessage.toUtf8());
    if (!doc.isObject()) return;

    QString status = doc.object().value("status").toString();
    if (status == "confirmed") emit loginConfirmed();
    else if (status == "denied") emit loginDenied();
}

