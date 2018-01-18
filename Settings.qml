import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import TestData 1.0

Item {
    id: selectTest
    TestData {
        id: testData
    }

    ColumnLayout {
        id: selectTestMainLayout
        anchors.rightMargin: 5
        anchors.leftMargin: 5
        anchors.fill: parent

        TabBar {
            id: modelTab
            font.pointSize: 11
            anchors.top: parent.top
            Layout.preferredWidth: parent.width

            TabButton {
                id: settingsTabHeader
                text: "Settings"
            }
            TabButton {
                id: forceTabHeader
                text: "Force"
            }
            TabButton {
                id: displacementTabHeader
                text: "Displacement"
            }
            TabButton {
                id: directionTabHeader
                text: "Direction"
            }
            TabButton {
                id: limitTabHeader
                text: "Limit"
            }
            TabButton {
                id: motorTabHeader
                text: "Motor"
            }
            TabButton {
                id: testTabHeader
                text: "Test"
            }
        }
        StackLayout {
            currentIndex: modelTab.currentIndex
            Layout.fillHeight: true
            Layout.fillWidth: true
            Item {
                id: settingsTab
                TableView2 {
                    tableHeaders: [
                        {label: "Id", field: "id", type: "int"},
                        {label: "Machine Type", field: "machine_type",type: "select", options: ["Hydraulic", "Chain Driven"]},
                        {label: "Comm. Type", field: "comm_type", type: "select", options: ["USB Serial","Bluetooth Serial","Serial"]},
                        {label: "Comm. Port", field: "comm_port", type: "string"},
                        {label: "Buad Rate", field: "baud_rate", type: "select", options: [9600,38900,115200]},
                        {label: "Active", field: "active", type: "bool"}
                    ]
                    tableData: [
                        {id: 0, machine_type: "Hydraulic",comm_type: "USB Serial", comm_port: "COM16", baud_rate: 9600, active: 1}
                    ]
                }
            }
            Item {
                id: forceTab
                TableView2 {
                    tableHeaders: [
                        {label: "Id", field: "id", type: "int"},
                        {label: "Channel", field: "channel",type: "int" },
                        {label: "Coff. A", field: "coff_a", type: "double"},
                        {label: "Coff. B", field: "coff_b", type: "double"},
                        {label: "Coff. C", field: "coff_c", type: "double"},
                        {label: "Samples", field: "samples", type: "int"},
                        {label: "Direction", field: "direction", type: "select", options: ["UP","DOWN"]},
                        {label: "Active", field: "active", type: "bool"}
                    ]
                    tableData: testData.getTests()
                    onSaveChanges: {
                        console.log(JSON.stringify(tableData))
                    }
                }
            }
            Item {
                id: displacementTab
            }
            Item {
                id: directionTab
            }
            Item {
                id: limitTab
            }
            Item {
                id: motorTab
            }
            Item {
                id: testStack
                anchors.fill: parent
                ColumnLayout {
                    anchors.fill: parent
                    spacing: 5
                    Rectangle {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        TableView2 {
                            id: tests
                            height: parent.height/2
                            Layout.fillWidth: true
                            tableHeaders: [
                                {label: "Id", field: "id", type: "int"},
                                {label: "Test Name", field: "test_name",type: "string" },
                                {label: "Rate", field: "rate", type: "double"}
                            ]
                            tableData: [
                                {id: 0, test_name: "Test 1", rate: 0.9},
                                {id: 1, test_name: "Test 2", rate: 0.1},
                                {id: 2, test_name: "Test 3", rate: 0.3},
                            ]
                        }
                    }
                    Rectangle {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        TableView2 {
                            id: testLimits
                            height: parent.height/2
                            Layout.fillWidth: true                            
                            tableHeaders: [
                                {label: "Id", field: "id", type: "int"},
                                {label: "Test Id", field: "test", type: "int"},
                                {label: "Limit Type", field: "limit_type",type: "select", options: ["Time in Seconds", "Time in Hours", "Percentage of Force"] },
                                {label: "Rate", field: "rate", type: "double"}
                            ]
                            tableData: [
                                { id: 0, test: 0, limit_type: "Time in Seconds", rate: 0.21 },
                                { id: 1, test: 1,limit_type: "Time in Seconds", rate: 0.8 },
                                { id: 2, test: 1,limit_type: "Percentage of Force", rate: 0.1 },
                            ]
                        }
                    }

                }
            }
        }
    }
}
