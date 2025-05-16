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

        Row {
            spacing: 10

Row {
        spacing: 10
        Button { text: "← Назад"; onClicked: root.navigateTo("back") }
        Button { text: "Главная"; onClicked: root.navigateTo("PasswordList.qml") }
    }
            Label { text: "Длина пароля:" }
            SpinBox { value: 12; from: 4; to: 64 }
        }

        CheckBox { text: "Заглавные буквы"; checked: true }
        CheckBox { text: "Цифры"; checked: true }
        CheckBox { text: "Символы (!@#...)" }

        Button { text: "Сгенерировать" }
        Label { text: "Пароль: fG$8kR9@zPq!" }
        Button { text: "Скопировать" }
    }
}
