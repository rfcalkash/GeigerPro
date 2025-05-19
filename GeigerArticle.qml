import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia
import QtQuick.Controls.Material
import QtQuick.Shapes
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
                animatedImage.frameNumber: 59
                anodeCathodeOverlayId.opacity: 1.0
            }
        },
        State {
            name: "2"
            PropertyChanges {
                animatedImage.frameNumber: animatedImage.totalFrames()-1
                gasOverlayId.opacity: 1.0
            }
        },
        State {
            name: "3"
            PropertyChanges {
                animatedImage.frameNumber: 59
                radiationOverlayId.opacity: 1.0
            }
        },
        State {
            name: "4"
            PropertyChanges {
                animatedImage.frameNumber: animatedImage.totalFrames()-1
                animatedImage.opacity: 0.0
                schematicId.opacity: 1.0
                impactId.opacity: 1.0
                radiationHitterId.x:gasVictumId.x
                radiationHitterId.y:gasVictumId.y
                gasVictumId.opacity: 0
                gasIonId.opacity: 1
                gasElectronId.opacity: 1
                gasIonId.x: radiationHitterId.x-gasIonId.width
                gasElectronId.x: radiationHitterId.x-gasElectronId.width
                gasIonId.y: radiationHitterId.y-gasIonId.height
                gasElectronId.y: radiationHitterId.y+radiationHitterId.height
                impactLabelsId.opacity: 1
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
            SequentialAnimation{
                NumberAnimation{target: animatedImage; property: "frameNumber"; duration: Math.abs(60-animatedImage.frameNumber)*1000/30}
                NumberAnimation{target: anodeCathodeOverlayId; property: "opacity"; duration: 200}
            }
        },
        Transition {
            from: "*"
            to: "2"
            SequentialAnimation{
                NumberAnimation{target: animatedImage; property: "frameNumber"; duration: Math.abs(animatedImage.totalFrames()-1-animatedImage.frameNumber)*1000/30}
                NumberAnimation{target: gasOverlayId; property: "opacity"; duration: 200}
            }
        },
        Transition {
            from: "*"
            to: "3"
            SequentialAnimation{
                NumberAnimation{target: animatedImage; property: "frameNumber"; duration: Math.abs(60-animatedImage.frameNumber)*1000/30}
                NumberAnimation{target: radiationOverlayId; property: "opacity"; duration: 200}
            }
        },
        Transition {
            from: "*"
            to: "4"
            SequentialAnimation{
                NumberAnimation{target: animatedImage; property: "frameNumber"; duration: Math.abs(animatedImage.totalFrames()-1-animatedImage.frameNumber)*1000/30}
                ParallelAnimation{
                    NumberAnimation{target: animatedImage; property: "opacity"; duration: 200}
                    NumberAnimation{target: schematicId; property: "opacity"; duration: 200}
                    NumberAnimation{target: impactId; property: "opacity"; duration: 200}
                }
                NumberAnimation{target: radiationHitterId; properties: "x,y"; duration: 1000}
                ParallelAnimation{
                    NumberAnimation{target: gasVictumId; property: "opacity"; duration: 200}
                    NumberAnimation{target: gasIonId; property: "opacity"; duration: 200}
                    NumberAnimation{target: gasElectronId; property: "opacity"; duration: 200}
                    NumberAnimation{target: impactLabelsId; property: "opacity"; duration: 200}
                }
                ParallelAnimation{
                    NumberAnimation{target: gasIonId; properties: "x,y"; duration: 2000; easing.type: Easing.OutExpo}
                    NumberAnimation{target: gasElectronId; properties: "x,y"; duration: 2000; easing.type: Easing.OutExpo}
                }
            }
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

            Item{
                opacity: 0
                id: anodeCathodeOverlayId
                anchors.fill: animatedImage
                Callout {
                    id: cathodeId
                    anchors.right: parent.right
                    anchors.top: parent.top
                    width: parent.width/3
                    title: qsTr("Cathode")
                    description: qsTr("For example, a thin coating of tin oxide")
                    visible: geigerArticle.state!=="2"
                }
                Callout{
                    id: anodeId
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    width: parent.width/3
                    title: qsTr("Anode")
                    description: qsTr("For example, a tungsten filament")
                }
                LineFromTo {
                    anchors.fill: parent
                    from: Qt.point(anodeCathodeOverlayId.width*2/3,cathodeId.separatorY)
                    to: Qt.point(anodeCathodeOverlayId.width*0.4,anodeCathodeOverlayId.height*0.3)
                }
                LineFromTo {
                    anchors.fill: parent
                    from: Qt.point(anodeCathodeOverlayId.width/3,anodeId.y+anodeId.separatorY)
                    to: Qt.point(anodeCathodeOverlayId.width*0.5,anodeCathodeOverlayId.height*0.52)
                }
            }

            Item{
                id: radiationOverlayId
                opacity: 0
                anchors.fill: animatedImage
                GasPainter{
                    id: radiationPainter
                    anchors.fill: parent
                    hitWalls: false
                    particlesColor: "green"
                    particleSize: 0.05
                    speed: 0.5
                    particlesAmount: 10
                }
                Callout{
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.margins: parent.height/5
                    separatorColor: "green"
                    width: parent.width/3
                    title: qsTr("Radiation")
                    description: qsTr("alpha, beta and/or gamma particles")
                }
            }



            Item{
                opacity: 0
                id: gasOverlayId
                anchors.fill: animatedImage
                GasPainter{
                    id: inertGasPainter
                    anchors.fill: parent
                    anchors.topMargin: parent.height*0.08
                    anchors.bottomMargin: parent.height*0.11
                }
                Callout {
                    id: gasId
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    // width: parent.width/3
                    title: qsTr("Inert gas")
                    description: qsTr("Usually argon")
                }
                LineFromTo {
                    anchors.fill: parent
                    from: Qt.point(gasId.x,gasId.y+gasId.separatorY)
                    to: Qt.point(gasOverlayId.width*0.4,gasOverlayId.height*0.4)
                }
            }

            Item{
                id: schematicId
                opacity: 0
                anchors.fill: animatedImage
                Rectangle{
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "black" }
                        GradientStop { position: 1.0; color: "blue" }
                    }
                    y: parent.height*0.035
                    height: parent.height*0.045
                    width: parent.width
                }
                Rectangle{
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "#4d0301" }
                        GradientStop { position: 0.33; color: "#fb7f6f" }
                        GradientStop { position: 0.66; color: "#4d0301" }
                    }
                    y:parent.height*0.89
                    height: parent.height*0.09
                    width: parent.width
                }
            }

            Item{
                id: impactId
                opacity: 0
                anchors.fill: animatedImage
                property double sizeMultiplier: Math.sqrt(width*height)
                ParticlePainter{
                    id: radiationHitterId
                    width: impactId.sizeMultiplier*radiationPainter.particleSize
                    height: width
                    x: parent.width+width
                    y:-height
                    color: radiationPainter.particlesColor
                }
                ParticlePainter {
                    id: gasVictumId
                    width: impactId.sizeMultiplier*inertGasPainter.particleSize
                    height: width
                    x: parent.width/2
                    y:parent.height/3
                    color: inertGasPainter.particlesColor
                }
                ParticlePainter {
                    opacity: 0
                    id: gasIonId
                    width: impactId.sizeMultiplier*inertGasPainter.particleSize
                    height: width
                    x: gasVictumId.x
                    y:gasVictumId.y
                    color: "red"
                }
                ParticlePainter {
                    opacity: 0
                    id: gasElectronId
                    width: impactId.sizeMultiplier*inertGasPainter.particleSize
                    height: width
                    x: gasVictumId.x
                    y:gasVictumId.y
                    color: "blue"
                }
                Item{
                    anchors.fill: parent
                    id: impactLabelsId
                    opacity: 0
                    Callout{
                        id: radiationParticleId
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: parent.height*0.11
                        width: parent.width/3
                        title: qsTr("Radiation")
                        description: qsTr("alpha, beta and/or gamma particle")
                    }
                    LineFromTo {
                        anchors.fill: parent
                        from: Qt.point(radiationParticleId.x,radiationParticleId.y+radiationParticleId.separatorY)
                        to: Qt.point(radiationHitterId.x+radiationHitterId.width,radiationHitterId.y+radiationHitterId.height)
                    }
                    Callout{
                        id: ionParticleId
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.topMargin: parent.height*0.11
                        width: parent.width/3
                        title: qsTr("Ion")
                        description: qsTr("Positive particle")
                    }
                    LineFromTo {
                        anchors.fill: parent
                        from: Qt.point(ionParticleId.x+ionParticleId.width,ionParticleId.y+ionParticleId.separatorY)
                        to: Qt.point(gasIonId.x,gasIonId.y)
                    }
                    Callout{
                        id: electronParticleId
                        anchors.left: parent.left
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: parent.height*0.11
                        width: parent.width/3
                        title: qsTr("Electron")
                        description: qsTr("Negative particle")
                    }
                    LineFromTo {
                        anchors.fill: parent
                        from: Qt.point(electronParticleId.x+electronParticleId.width,electronParticleId.y+electronParticleId.separatorY)
                        to: Qt.point(gasElectronId.x,gasElectronId.y+gasElectronId.height)
                    }

                    LineFromTo {
                        lineWidth: Material.buttonHeight/20
                        anchors.fill: parent
                        from: Qt.point(gasIonId.x+gasIonId.width/2,gasIonId.y)
                        to: Qt.point(gasIonId.x+gasIonId.width/2,gasIonId.y/2)
                        lineColor: "red"
                    }
                    LineFromTo {
                        lineWidth: Material.buttonHeight/20
                        anchors.fill: parent
                        from: Qt.point(gasElectronId.x+gasElectronId.width/2,gasElectronId.y+gasElectronId.height)
                        to: Qt.point(gasElectronId.x+gasElectronId.width/2,gasElectronId.y+gasElectronId.height+gasIonId.y/2)
                        lineColor: "blue"
                    }
                }
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
