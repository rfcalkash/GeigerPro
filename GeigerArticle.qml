import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia
import QtQuick.Controls.Material
import GeigerPro

Item{
    id: geigerArticle
    property bool animating: false
    property int stateInt: 0
    Component.onCompleted: {
        animatedImage.setSource(":/images/articles/geiger/1st")
        state="0"
    }

    function nextState(){
        if(stateInt<states.length-1){
            stateInt++
            state=states[stateInt].name
        }
    }
    function prevState(){
        if(stateInt>0){
            stateInt=stateInt-1
            state=states[stateInt].name
        }
    }

    states: [
        State {
            name: "0"
            PropertyChanges {
                target: animatedImage
                frameNumber:0
            }
        },
        State {
            name: "1"
            PropertyChanges {
                target: animatedImage
                frameNumber:59
            }
        },
        State {
            name: "2"
            PropertyChanges {
                target: animatedImage
                frameNumber:animatedImage.totalFrames()-1
            }
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "0"
            NumberAnimation {property: "frameNumber"; duration: animatedImage.frameNumber*1000/30}
        },
        Transition {
            from: "*"
            to: "1"
            NumberAnimation{property: "frameNumber"; duration: Math.abs(60-animatedImage.frameNumber)*1000/30}
        },
        Transition {
            from: "*"
            to: "2"
            NumberAnimation{property: "frameNumber"; duration: Math.abs(animatedImage.totalFrames()-1-animatedImage.frameNumber)*1000/30}
        }
    ]

    ColumnLayout{
        anchors.fill: parent
        Item{
            Layout.fillWidth: true
            Layout.fillHeight: true
            Label{
                text: "state "+geigerArticle.state+", frame "+animatedImage.frameNumber
            }

            AnimatedFrameItem{
                id: animatedImage
                anchors.centerIn: parent
                width: Math.min(parent.height,parent.width)
                height: width
            }
        }
        RowLayout{
            opacity: geigerArticle.animating?0:1
            Behavior on opacity {NumberAnimation {duration: 200}}
            Layout.fillWidth: true
            RoundButton{
                icon.source: "qrc:/images/right-arrow.svg"
                rotation: 180
                height: Material.buttonHeight
                width: height
                flat: true
                onClicked: prevState()
            }
            Label{
                text: qsTr("Geiger Counter: Your reliable detector of ionizing radiation. Discover the world of invisible particles!")
                // Layout.fillHeight: true
                Layout.fillWidth: true
                wrapMode: Text.Wrap
                verticalAlignment: Text.AlignVCenter
            }
            RoundButton{
                icon.source: "qrc:/images/right-arrow.svg"
                height: Material.buttonHeight
                width: height
                flat: true
                onClicked: nextState()
            }
        }
    }
}
