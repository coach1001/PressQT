import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3

ApplicationWindow {
    id: mainWindow
    visible: true
    //visibility: "FullScreen"
    width: 1024
    height: 768
    title: qsTr("Hello World")
    flags: Qt.FramelessWindowHint
    x: Screen.width / 2 - width / 2
    y: Screen.height / 2 - height / 2

    Rectangle {
        id: mainRect
        anchors.fill: parent
        border.color: "grey"
        border.width: 1

        ColumnLayout {
            id: mainLayout
            enabled: true
            anchors.fill: parent

            Rectangle {
                id: header
                color: "lightgrey"
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.preferredHeight: 70
                Layout.fillWidth: true
                border.color: "grey"
                border.width: 1

                MouseArea {
                    id: headerMouseArea
                    property int prevX: 0
                    property int prevY: 0
                    anchors.fill: parent
                    onPressed: {prevX=mouse.x; prevY=mouse.y}
                    onPositionChanged:{
                        var deltaX = mouse.x - prevX;
                        mainWindow.x += deltaX;
                        prevX = mouse.x - deltaX;
                        var deltaY = mouse.y - prevY
                        mainWindow.y += deltaY;
                        prevY = mouse.y - deltaY;
                    }
                }

                RowLayout {
                    id: headerLayout
                    anchors.fill: parent
                    anchors.margins: 5
                    Button {
                        id: homeBtn
                        text: qsTr("Main Menu")
                        Layout.preferredWidth: 150
                        Layout.fillHeight: true
                        onClicked: {
                            mainStack.push(Qt.createComponent("MainMenu.qml"))
                        }
                    }
                    Button {
                        id: exitBtn
                        text: qsTr("Exit")
                        Layout.preferredWidth: 100
                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                        Layout.fillHeight: true
                        onClicked: {
                            mainLayout.enabled = false
                            exitDiag.visible = !exitDiag.visible
                        }
                    }
                }
            }
            StackView {
                id: mainStack
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillWidth: true
                initialItem: Qt.createComponent("MainMenu.qml")
            }
            Rectangle {
                id: footer
                color: "lightgrey"
                Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
                Layout.preferredHeight: 70
                Layout.fillWidth: true
                border.color: "grey"
                border.width: 1
            }
        }

        Rectangle {
            id: exitDiag
            visible: false
            width: 400
            height: 150
            color: "lightgrey"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            border.width: 1
            border.color: "grey"

            ColumnLayout {
                id: exitDiagMainLayout
                anchors.bottomMargin: 20
                anchors.topMargin: 20
                anchors.fill: parent

                Text {
                    id: exitDiagText
                    text: qsTr("Are you sure?")
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                }

                    RowLayout {
                        id: exitDiagLayoutBtn
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        Layout.fillHeight: false
                        Layout.fillWidth: false

                        Button {
                            id: exitDiagBtnYes
                            text: qsTr("Yes")
                            Layout.preferredWidth: 100
                            onClicked: {
                                mainWindow.close()
                            }
                        }

                        Button {
                            id: exitDiagBtnNo
                            text: qsTr("No")
                            Layout.preferredWidth: 100
                            onClicked: {
                                mainLayout.enabled = true
                                exitDiag.visible = false
                            }
                        }
                }
            }
        }
    }
}
