import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Item {    
    anchors.fill: parent    
    property var tableHeaders: []
    property var tableData: []
    property var tableDataRevert: []
    property int selectedRowIndex: -1
    property string id
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
                        color: "silver"
                        Text {
                            anchors.centerIn: parent
                            text: tableHeaders[index].label
                        }
                    }
                }
            }
        }

        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Flickable {
                anchors.fill: parent
                contentHeight:  tableLayout.height
                clip: true
                ColumnLayout {
                    id: tableLayout
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: 1
                    Repeater {
                        model: tableData
                        Row {
                            property int tIndex: index
                            Repeater {
                                model: tableHeaders
                                Rectangle {
                                    width: columnLayout.width / tableHeaders.length
                                    height: 40
                                    color: selectedRowIndex === tIndex ? "grey" : "white"
                                    MouseArea {
                                        anchors.fill: parent
                                        onClicked: {
                                            selectedRowIndex = tIndex
                                        }
                                    }
                                    Rectangle {
                                        anchors.fill: parent
                                        anchors.margins: 4
                                        TextField {
                                            anchors.fill: parent
                                            visible: tableHeaders[index].type === "string"
                                                     || tableHeaders[index].type === "int"
                                                     || tableHeaders[index].type === "double"
                                                     ? true : false
                                            text: tableData[tIndex][tableHeaders[index].field]
                                            onTextEdited: {
                                                if(tableHeaders[index].type === "string"
                                                        || tableHeaders[index].type === "int"
                                                        || tableHeaders[index].type === "double"){
                                                    tableData[tIndex][tableHeaders[index].field] =  text
                                                }
                                            }
                                            onFocusChanged: {
                                                if (focus) {
                                                    selectedRowIndex = tIndex
                                                }
                                            }
                                        }
                                        CheckBox {
                                            anchors.fill: parent
                                            visible: tableHeaders[index].type === "bool" ? true : false
                                            checked: tableData[tIndex][tableHeaders[index].field] === 0 ? false : true
                                            anchors.centerIn: parent
                                            onCheckedChanged: {
                                                if(tableHeaders[index].type === "bool"){
                                                    if(checked)
                                                        tableData[tIndex][tableHeaders[index].field] =  1
                                                    else
                                                        tableData[tIndex][tableHeaders[index].field] =  0
                                                }
                                            }
                                            onFocusChanged: {
                                                if (focus) {
                                                    selectedRowIndex = tIndex
                                                }
                                            }
                                        }
                                        ComboBox {
                                            anchors.fill: parent
                                            visible: tableHeaders[index].type === "select" ? true : false
                                            model: tableHeaders[index].options
                                            currentIndex: tableHeaders[index].type === "select" ? tableHeaders[index].options.indexOf(tableData[tIndex][tableHeaders[index].field]) : 0
                                            width: columnLayout.width / tableHeaders.length
                                            onCurrentIndexChanged: {
                                                if(tableHeaders[index].type === "select"){
                                                    tableData[tIndex][tableHeaders[index].field] = tableHeaders[index].options[currentIndex]
                                                }
                                            }
                                        }
                                        onFocusChanged: {
                                            if (focus) {
                                                selectedRowIndex = tIndex
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                ScrollBar.vertical: ScrollBar { }
            }
        }

        RowLayout {
            id: rowLayout
            width: 100
            height: 100


            Button {
                id: addRowBtn
                text: qsTr("Add Row")
                onClicked:  {
                    var row = {}
                    tableHeaders.map(function (header){
                        if(header.type === "string"){

                        } else if
                    })
                }
            }

            Button {
                id: removeRowBtn
                text: qsTr("Remove Row")
                onClicked:  {
                    if(selectedRowIndex > -1) {
                        tableData.splice(selectedRowIndex, 1)
                        tableData = JSON.parse(JSON.stringify(tableData))
                        selectedRowIndex = -1
                    }
                }
            }

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
