import QtQuick
import QtQuick.Controls

Item {
    width: 600
    height: 400
    id: root
    property var navigateTo
    Column {
        anchors.centerIn: parent
        spacing: 10

Row {
        spacing: 10
        Button { text: "← Назад"; onClicked: root.navigateTo("PasswordList.qml") }
        Button { text: "Главная"; onClicked: root.navigateTo("PasswordList.qml") }
    }

        TextField { placeholderText: "Название сервиса" }
        TextField { placeholderText: "Логин/Email" }
        TextField { placeholderText: "Пароль"; echoMode: TextInput.Password }
        TextField { placeholderText: "Примечание" }
        Label { text: "Дата создания: 2025-04-12" }

        Row {
            spacing: 20
            Button { text: "Сохранить" }
            Button { text: "Отмена" }
        }
    }
}
