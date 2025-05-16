import QtQuick
import QtQuick.Controls
import App  // ⬅️ это обязательно, чтобы QML знал тип AuthClient

Item {
    width: 600
    height: 400

    property var auth
    property var navigateTo
    Column {
        anchors.centerIn: parent
        spacing: 16

        TextField {
            id: codeInput
            placeholderText: "Введите мастер-ключ"
            width: 240
        }

        Button {
            text: "Подключиться"
            onClicked: {
                auth.connectToServer("ws://localhost:9001")
            }
        }

        Button {
            text: "Отправить код авторизации"
            onClicked: {
                auth.sendAuthCode(codeInput.text)
            }
        }

        Label {
            id: statusLabel
            text: "⌛ Ожидание действий..."
            wrapMode: Text.WordWrap
            width: 240
        }

        Connections {
                target: auth
                onConnected: statusLabel.text = "🔗 Подключено к серверу"
                onDisconnected: statusLabel.text = "🔌 Отключено от сервера"
                onLoginDenied: statusLabel.text = "❌ Вход отклонён"
                onErrorOccurred: function(msg) {
                    statusLabel.text = "❗ Ошибка: " + msg
                }
            }
    }
}
