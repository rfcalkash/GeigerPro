import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia
import QtQuick.Controls.Material
import QtQuick.Shapes
import GeigerPro

Shape{
    property point from
    property point to
    ShapePath{
        strokeWidth: Material.buttonHeight/10
        strokeColor: Material.accentColor
        startX: from.x
        startY: from.y
        fillColor: "transparent"
        PathLine{x:to.x;y:to.y}
    }
}
