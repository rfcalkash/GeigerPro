import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia
import QtQuick.Controls.Material

Item{
    id: geigerArticle
    property bool animating: false
    ColumnLayout{
        anchors.fill: parent
        AnimatedImage{
            id: animatedImage
            sourceSize: Qt.size(1000,1000)
            Layout.fillWidth: true
            Layout.fillHeight: true
            fillMode: Image.PreserveAspectFit
            source:"qrc:/images/articles/geiger/anim1-2.webp"
            playing: geigerArticle.animating && currentFrame<frameCount-1
            speed: 1
            onCurrentFrameChanged: {
                if(currentFrame===frameCount-1){
                    geigerArticle.animating=false
                }
            }
        }
        RowLayout{
            opacity: geigerArticle.animating?0:1
            Behavior on opacity {NumberAnimation {duration: 200}}
            RoundButton{
                icon.source: "qrc:/images/right-arrow.svg"
                rotation: 180
                height: Material.buttonHeight
                width: height
                flat: true
                enabled: !geigerArticle.animating
            }
            Label{
                text: qsTr("Geiger Counter: Your reliable detector of ionizing radiation. Discover the world of invisible particles!")
                Layout.fillHeight: true
                Layout.fillWidth: true
                wrapMode: Text.Wrap
                verticalAlignment: Text.AlignVCenter
            }
            RoundButton{
                icon.source: "qrc:/images/right-arrow.svg"
                height: Material.buttonHeight
                width: height
                flat: true
                onClicked: geigerArticle.animating=true
                enabled: !geigerArticle.animating
            }
        }
    }
}
