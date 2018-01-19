import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Item {
    property string id: "table"
    property var selectedIndexes: [-1, -1]

    function findWithAttr(array, attr, value) {
        for(var i = 0; i < array.length; i += 1) {
            if(array[i][attr] === value) {
                return i;
            }
        }
        return -1;
    }

    property var tableHeaders: [
        [
            {label: "Id", field: "id", type: "int"},
            {label: "Species", field: "species", type: "string"}
        ],
        [
            {label: "Id", field: "id", type: "int"},
            {label: "Species", field: "species",referenced: true, reference: "id", referenceDisplay: "species"},
            {label: "Breed", field: "breed", type: "string"}
        ],
        [
            {label: "Id", field: "id", type: "int"},
            {label: "Breed", field: "breed",referenced: true, reference: "id", referenceDisplay: "breed"},
            {label: "Name", field: "name", type: "string"}
        ]
    ]
    property var tableData: [
        [
            {id: 0, species: "Dog"},
            {id: 1, species: "Snake"},
            {id: 2, species: "Cat"}
        ],
        [
            {id: 0, species: 0, breed: "Pit Bull"},
            {id: 1, species: 2, breed: "Aegean"},
            {id: 2, species: 2, breed: "Bambino"},
            {id: 3, species: 0, breed: "Poodle"},
            {id: 4, species: 1, breed: "Cobra"},
            {id: 5, species: 0, breed: "Labrador"}
        ],
        [
            {id: 0, breed: 0, name: "Sasha"},
            {id: 0, breed: 0, name: "Sasha"},
            {id: 0, breed: 0, name: "Sasha"},
            {id: 0, breed: 0, name: "Sasha"},
            {id: 0, breed: 0, name: "Sasha"},
            {id: 0, breed: 0, name: "Sasha"},
            {id: 0, breed: 0, name: "Sasha"},
            {id: 0, breed: 0, name: "Sasha"},
            {id: 0, breed: 0, name: "Sasha"},
            {id: 0, breed: 0, name: "Sasha"},
            {id: 0, breed: 0, name: "Sasha"},
            {id: 0, breed: 0, name: "Sasha"},
            {id: 0, breed: 0, name: "Sasha"},
            {id: 0, breed: 0, name: "Sasha"},
            {id: 0, breed: 0, name: "Sasha"},
            {id: 0, breed: 0, name: "Sasha"},
            {id: 0, breed: 0, name: "Sasha"},
            {id: 0, breed: 0, name: "Sasha"},
            {id: 0, breed: 0, name: "Sasha"},
            {id: 1, breed: 0, name: "Killer"},
            {id: 2, breed: 3, name: "Frenchy"},
            {id: 3, breed: 1, name: "Whiskers"},
            {id: 4, breed: 2, name: "Sasha"}
        ]
    ]

    Flickable {
        clip: true
        contentHeight: topLayout.height
        anchors.fill: parent
        ColumnLayout {
            id: topLayout
            anchors.margins: 5
            spacing: 5
            anchors.left: parent.left
            anchors.right: parent.right
            RowLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Button {
                    text: "Save Changes"
                }
                Button {
                    text: "Revert Changes"
                }
            }
            Repeater {
                model: tableHeaders
                ColumnLayout {
                    property var index0: index
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop

                    RowLayout {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 40
                        spacing: 5
                        Repeater {
                            model: tableHeaders[index0]
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 40
                                color: "silver"
                                border.color: "grey"
                                border.width: 1
                                Text {
                                    anchors.centerIn: parent
                                    text: tableHeaders[index0][index].label
                                }
                            }
                        }
                    }

                    Repeater {
                        model: tableData[index0]
                        RowLayout {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 40
                            spacing: 5
                            visible : {
                                if (index0 > 0) {
                                    var parentfilterFieldIndex = findWithAttr(tableHeaders[index0], "referenced", true)
                                    var filterField = tableHeaders[index0][parentfilterFieldIndex].field
                                    var parentfilterField = tableHeaders[index0][parentfilterFieldIndex].reference
                                    try {
                                        if (tableData[index0 - 1][selectedIndexes[index0 - 1]][parentfilterField] === tableData[index0][index][filterField]){
                                            return true
                                        }
                                    } catch (ex) {
                                        return false
                                    }
                                    return false
                                } else {
                                    return true
                                }
                            }
                            property var dIndex0: index
                            Repeater {
                                model: tableHeaders[index0]
                                Rectangle {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 40
                                    TextField {
                                        width: parent.width - 5
                                        height: 35
                                        enabled: !tableHeaders[index0][index].referenced
                                        anchors.centerIn: parent
                                        text: {
                                            if(tableHeaders[index0][index].referenced)
                                            {
                                                try {
                                                    return tableData[index0 - 1][selectedIndexes[index0 - 1]][tableHeaders[index0][index].referenceDisplay]
                                                } catch (ex) {
                                                }
                                            }
                                            return tableData[index0][dIndex0][tableHeaders[index0][index].field]
                                        }
                                        onFocusChanged: {
                                            if(focus){
                                                selectedIndexes[index0] = dIndex0
                                                for(var i = index0; i < selectedIndexes.length; i++ ) {
                                                    if(i !== index0) {
                                                       selectedIndexes[i] = -1
                                                    }
                                                }
                                                tableData = JSON.parse(JSON.stringify(tableData))
                                                selectedIndexes = JSON.parse(JSON.stringify(selectedIndexes))
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    RowLayout {
                        Layout.fillWidth: true
                        visible: index0 === 0 || selectedIndexes[index0 - 1] > -1 ? true : false
                        Button {
                            text: "Add"
                            onClicked: {
                                var row = {}
                                tableHeaders[index0].map(function(header){
                                    if(header.type === "string"){
                                        row[header.field] = ''
                                    }else if(header.type === "int"){
                                        row[header.field] = -1
                                    }else if(header.referenced){
                                        row[header.field] = tableData[index0][selectedIndexes[index0 - 1]][header.reference]
                                    }
                                })
                                tableData[index0].push(row)
                                tableData = JSON.parse(JSON.stringify(tableData))
                            }
                        }
                        Button {
                            text: "Remove"
                        }
                    }
                }
            }
        }
        ScrollBar.vertical: ScrollBar { }
    }
}
