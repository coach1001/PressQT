import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Item {
    id: table
    width: 800
    height: 600
    anchors.fill: parent

    property var tableHeaders: []
    property var tableData: []
    property var tableDataRevert: []
    signal saveChanges

    Component.onCompleted: {
        tableDataRevert = JSON.parse(JSON.stringify(tableData))
    }

    ColumnLayout {
        id: columnLayout
        spacing: 5
        anchors.fill: parent
        Rectangle {
            id: headers
            Layout.fillWidth: true
            Layout.preferredHeight: 40
            Row {
                Repeater {
                    model: tableHeaders
                    Rectangle {
                        width: columnLayout.width / tableHeaders.length
                        height: 40
                        border.color: "black"
                        border.width: 1
                        Text {
                            anchors.centerIn: parent
                            text: tableHeaders[index].label
                        }
                    }
                }
            }
        }

        Rectangle {
            id: tableDataRectangle
            Layout.fillWidth: true
            Layout.fillHeight: true
            Flickable {
                anchors.fill: parent
                contentHeight: (headers.height+6) * tableData.length
                clip: true
                anchors.margins: 0
                Pane {
                    width: tableDataRectangle.width
                    anchors.margins: 0
                    //Column {
                    Repeater {
                        anchors.fill: parent
                        anchors.margins: 0
                        model: tableData
                        Row {
                            id: dataRows
                            property int dataIndex: index
                            Repeater {
                                model: tableHeaders
                                Rectangle {
                                    y: dataIndex === 0 ? parent.y : ((headers.height+5) * dataIndex)
                                    width: columnLayout.width / tableHeaders.length
                                    height: headers.height
                                    TextField {
                                        visible: tableHeaders[index].type === "string"
                                                 || tableHeaders[index].type === "int"
                                                 || tableHeaders[index].type === "double"
                                                 ? true : false
                                        anchors.centerIn: parent
                                        text: tableData[dataIndex][tableHeaders[index].field]
                                        width: columnLayout.width / tableHeaders.length
                                        onTextEdited: {
                                            if(tableHeaders[index].type === "string"
                                                    || tableHeaders[index].type === "int"
                                                    || tableHeaders[index].type === "double"){
                                                tableData[dataIndex][tableHeaders[index].field] =  text
                                            }
                                        }
                                    }
                                    CheckBox {
                                        visible: tableHeaders[index].type === "bool" ? true : false
                                        checked: tableData[dataIndex][tableHeaders[index].field] === 0 ? false : true
                                        anchors.centerIn: parent
                                        onCheckedChanged: {
                                            if(tableHeaders[index].type === "bool"){
                                                if(checked)
                                                    tableData[dataIndex][tableHeaders[index].field] =  1
                                                else
                                                    tableData[dataIndex][tableHeaders[index].field] =  0
                                            }
                                        }
                                    }
                                    ComboBox {
                                        visible: tableHeaders[index].type === "select" ? true : false
                                        model: tableHeaders[index].options
                                        anchors.centerIn: parent
                                        currentIndex: tableHeaders[index].type === "select" ? tableHeaders[index].options.indexOf(tableData[dataIndex][tableHeaders[index].field]) : 0
                                        width: columnLayout.width / tableHeaders.length
                                        onCurrentIndexChanged: {
                                            if(tableHeaders[index].type === "select"){
                                                tableData[dataIndex][tableHeaders[index].field] = tableHeaders[index].options[currentIndex]
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    //}
                }
                ScrollBar.vertical: ScrollBar { }
            }
        }

        RowLayout {
            id: rowLayout
            width: 100
            height: 100

            Button {
                id: saveChangesBtn
                text: qsTr("Save Changes")
                onClicked:  {
                    saveChanges(tableData)
                }
            }

            Button {
                id: revertChangesBtn
                text: qsTr("Revert Changes")
                onClicked:  {
                    tableData = JSON.parse(JSON.stringify(tableDataRevert))
                }
            }
        }
    }
}
