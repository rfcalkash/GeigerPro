import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    id: page

    property var article

    header: ToolBar {
        RowLayout {
            anchors.fill: parent
            ToolButton {
                text: qsTr("←")
                onClicked: stackView.pop()
            }
            Label {
                text: article.title
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }
        }
    }

    ScrollView {
        anchors.fill: parent
        anchors.margins: 20

        Label {
            text: article.content
            wrapMode: Text.WordWrap
            width: parent.width
        }
    }
} 