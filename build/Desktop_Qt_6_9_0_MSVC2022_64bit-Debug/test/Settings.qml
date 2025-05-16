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

        GroupBox {
            title: "Безопасность"
            Column {
                CheckBox { text: "Запрос 2FA при входе" }
                CheckBox { text: "Автоматический выход" }
                Button { text: "Изменить мастер-пароль" }
            }
        }

        GroupBox {
            title: "Синхронизация"
            Column {
                CheckBox { text: "Разрешить P2P-обмен" }
                CheckBox { text: "Авто-синхронизация" }
            }
        }

        GroupBox {
            title: "Расширения"
            Column {
                Button { text: "Подключено к Chrome" }
                Button { text: "Открыть папку расширения" }
            }
        }
    }
}
