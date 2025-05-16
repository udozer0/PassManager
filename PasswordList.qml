import QtQuick
import QtQuick.Controls

Item {
    width: 600
    height: 400
    property var navigateTo


    Column {
        anchors.centerIn: parent
        spacing: 10

                TextField {
                    placeholderText: "Поиск..."
                    width: 300
                }

                ListView {
                    width: 500
                    height: 200
                    model: ListModel {
                        ListElement { service: "GitHub"; login: "user@mail" }
                        ListElement { service: "Gmail"; login: "user@gmail" }
                        ListElement { service: "Telegram"; login: "@username" }
                        ListElement { service: "VK"; login: "id12345" }
                    }
                    delegate: Row {
                        spacing: 30
                        Text { text: service }
                        Text { text: login }
                    }
                }

                Row {
                    spacing: 20
                    Button {
                        text: "Добавить пароль"
                        onClicked: navigateTo("PasswordForm.qml")
                    }
                    Button {
                        text: "Настройки"
                        onClicked: navigateTo("Settings.qml")
                    }
                    Button {
                        text: "Синхронизация"
                        onClicked: navigateTo("SyncScreen.qml")
                    }
                }
            }
        }
