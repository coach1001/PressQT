import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Item {
    id: selectTest

    ColumnLayout {
        id: selectTestMainLayout
        anchors.fill: parent

        Text {
            id: text1
            text: qsTr("View Results")
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }
    }
}
