import QtQuick
import QtQuick.Controls
Item {
    width: 600
    height: 400
property var navigateTo
    id: root
    Column {
        anchors.centerIn: parent
        spacing: 10

Row {
        spacing: 10
        Button { text: "← Назад"; onClicked: root.navigateTo("PasswordList.qml") }
        Button { text: "Главная"; onClicked: root.navigateTo("PasswordList.qml") }
    }

        Label { text: "Статус: Подключено" }
        Label { text: "Устройство: PC-LEONID" }
        Label { text: "Последняя синхронизация: 2025-04-11 15:34" }

        Button { text: "Синхронизировать вручную" }
        Button { text: "QR для подключения нового устройства" }
    }
}
