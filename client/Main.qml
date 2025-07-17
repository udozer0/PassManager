import QtQuick
import QtQuick.Controls
import App

ApplicationWindow {
    id: window
    visible: true
    width: 600
    height: 400
    title: qsTr("Авторизация через Telegram")
    function navigateTo(screen) {
            const url = screen;
            console.log("🔁 Переход на экран:", url);

            var component = Qt.createComponent(url);
            if (component.status === Component.Ready) {
                stackView.push(component.createObject(stackView, {
                    navigateTo: navigateTo
                }));
            } else {
                console.log("❌ Ошибка загрузки:", component.errorString());
            }
        }

    AuthClient {
        id: auth

        onLoginConfirmed: {
            console.log("✅ Вход подтверждён")
            navigateTo("PasswordList.qml")
        }

        onLoginDenied: {
            console.log("❌ Вход отклонён")
        }

        onMessageReceived: function(message) {
            console.log("[WS] Сообщение: " + message)
        }

        onConnected: {
            console.log("🔗 Подключено к серверу")
        }

        onDisconnected: {
            console.log("🔌 Отключено от сервера")
        }

        onErrorOccurred: function(msg) {
            console.log("❗ Ошибка: " + msg)
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent
    }

    Component.onCompleted: {
            // ⬇️ Загружаем стартовый экран с проверкой
            var component = Qt.createComponent("LoginScreen.qml");
            if (component.status === Component.Ready) {
                stackView.push(component.createObject(stackView, {
                    auth: auth,
                    navigateTo: navigateTo
                }));
            } else {
                console.log("❌ Ошибка при загрузке LoginScreen:", component.errorString());
            }
        }
}
