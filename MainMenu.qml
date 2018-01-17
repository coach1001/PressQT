import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Item {
    id: mainMenu

    ColumnLayout {
        id: mainMenuLayout
        spacing: 5
        anchors.bottomMargin: 50
        anchors.topMargin: 50
        anchors.rightMargin: 100
        anchors.leftMargin: 100
        anchors.fill: parent

        Button {
            id: selectTestBtn
            text: qsTr("Select Test")
            Layout.fillHeight: true
            Layout.fillWidth: true
            onClicked: {
                mainStack.push(Qt.createComponent("SelectTest.qml"))
            }
        }

        Button {
            id: viewResultsBtn
            text: qsTr("View Results")
            Layout.fillHeight: true
            Layout.fillWidth: true
            onClicked: {
                mainStack.push(Qt.createComponent("ViewResults.qml"))
            }
        }

        Button {
            id: settingsBtn
            text: qsTr("Settings")
            Layout.fillHeight: true
            Layout.fillWidth: true
            onClicked: {
                mainStack.push(Qt.createComponent("Settings.qml"))
            }
        }
    }

}
