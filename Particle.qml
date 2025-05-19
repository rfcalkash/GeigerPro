import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia
import QtQuick.Controls.Material
import QtQuick.Shapes
import GeigerPro

Rectangle{
    property color particleColor
    radius: height/2
    // color: inertGasPainter.particlesColor
    gradient: RadialGradient{
        centerX: 0.3; centerY: 0.3; centerRadius: 0.5; focalX: centerX; focalY: centerY
        GradientStop{position: 0; color:"white"}
        GradientStop{position: 1; color:particleColor}
    }
}
