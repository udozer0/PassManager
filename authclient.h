#pragma once

#include <QObject>
#include <QWebSocket>

class AuthClient : public QObject {
    Q_OBJECT

public:
    explicit AuthClient(QObject* parent = nullptr);

    Q_INVOKABLE void connectToServer(const QUrl& url);
    Q_INVOKABLE void sendAuthCode(const QString& code);

signals:
    void connected();
    void disconnected();
    void loginConfirmed();
    void loginDenied();
    void messageReceived(QString message); // ✅ нужно для MessageReceived
    void errorOccurred(QString error);     // ✅ нужно для onErrorOccurred

private slots:
    void onConnected();
    void onTextMessageReceived(const QString& message);

private:
    QWebSocket socket;
};
