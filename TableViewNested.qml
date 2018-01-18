import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Item {
    id: item1
    property var selectedIndexes: []

    property var tableHeaders: [
        [
            {label: "Id", field: "id"},
            {label: "Species", field: "species"}
        ],
        [
            {label: "Id", field: "id"},
            {label: "Species", field: "species",referenced: true, references: "id", referenceDisplay: "species"},
            {label: "Breed", field: "breed"}
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
        ]
    ]

    ColumnLayout {
        id: topLayout
        anchors.margins: 5
        spacing: 5
        anchors.fill: parent
        Repeater {
            model: tableHeaders
            ColumnLayout {
                property var index0: index
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: 5

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

                ColumnLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing: 5
                    Repeater {
                        model: tableData[index0]
                        RowLayout {
                            property var dIndex0: index
                            Layout.fillWidth: true
                            Layout.preferredHeight: 40
                            spacing: 5
                            Repeater {
                                model: tableHeaders[index0]
                                Rectangle {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 40
                                    TextField {
                                        width: parent.width
                                        enabled: !tableHeaders[index0][index].referenced
                                        anchors.centerIn: parent
                                        text: tableData[index0][dIndex0][tableHeaders[index0][index].field]
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
