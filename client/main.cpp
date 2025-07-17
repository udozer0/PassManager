#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QtQml>
#include "authclient.h"
#include <QQuickStyle>

int main(int argc, char *argv[])
{
    QQuickStyle::setStyle("Basic");  // 👈 задать стиль явно
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    qmlRegisterType<AuthClient>("App", 1, 0, "AuthClient"); // ✅ ОК


    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
        engine.load(QUrl(QStringLiteral("qrc:/Main.qml")));




    return app.exec();
}
