import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia
import QtQuick.Controls.Material

ApplicationWindow {
    id: root
    visible: true
    width: 360
    height: 640
    title: "Счетчик Гейгера"
    color: "#F0F0F0"
    RoundButton{
        id: btnId
        icon.source: "qrc:/images/right-arrow.svg"
        rotation: menuDrawer.position*180
        Behavior on rotation {NumberAnimation{duration:100}}
        height: Material.buttonHeight
        width: height
        onClicked: menuDrawer.opened?menuDrawer.close():menuDrawer.open()
        flat: true
    }

    Drawer {
        id: menuDrawer
        y: btnId.height
        width: root.width * 0.7
        height: root.height - btnId.height
        ColumnLayout{
            anchors{top:parent.top;left: parent.left;right: parent.right; margins: Material.frameVerticalPadding}
            Repeater{
                model:[
                    {name:qsTr("Geiger counter simulator"), value:0, separator:false, icon: "qrc:/images/geiger-counter-simulator-icon.svg"},
                    {name:qsTr("How Geiger counter works"), value:1, separator:true, icon: "qrc:/images/how-geiger-counter-works-icon.svg"},
                    {name:qsTr("How radiation works"), value:2, separator:false, icon: "qrc:/images/how-radiation-works-icon.svg"},
                    {name:qsTr("Shielding against radiation"), value:3, separator:false, icon: "qrc:/images/shielding-against-radiation-icon.svg"},
                    {name:qsTr("About GeigerPro"), value:4, separator:true, icon: "qrc:/images/about-geigerpro-icon.svg"},
                ]
                delegate: Item {
                    Layout.fillWidth: true
                    height: separId.height+delegateId.height
                    Item{
                        id:separId
                        height: modelData.separator?Material.frameVerticalPadding:0
                        Rectangle{
                            anchors.verticalCenter: parent.verticalCenter
                            height: 1
                            width: parent.width
                            color: Material.secondaryTextColor
                            opacity: modelData.separator?1:0
                        }
                    }
                    MouseArea{
                        id: delegateId
                        width: parent.width
                        height: Material.delegateHeight
                        anchors.top: separId.bottom
                        onClicked: {
                            stackId.currentIndex=modelData.value
                            menuDrawer.close()
                        }
                        RowLayout{
                            anchors.fill: parent
                            Image {
                                source: modelData.icon
                                Layout.fillHeight: true
                                width: height
                                sourceSize: Qt.size(width,height)
                            }
                            Label{
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                verticalAlignment: Qt.AlignVCenter
                                text: modelData.name
                                color: modelData.value===stackId.currentIndex?Material.accentColor:Material.primaryTextColor
                            }
                        }
                    }
                }
            }
        }
    }

    StackLayout{
        id: stackId
        anchors.fill: parent
        anchors.topMargin: btnId.height
        GeigerEmulator {
            activeSound: stackId.currentIndex===0
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }

}
