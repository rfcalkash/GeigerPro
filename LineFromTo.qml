import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia
import QtQuick.Controls.Material
import QtQuick.Shapes
import GeigerPro

Shape{
    id: rootId
    property point from
    property point to
    property double lineWidth: Material.buttonHeight/10
    property alias lineColor: lineId.strokeColor
    ShapePath{
        property real angle: Math.atan2(to.y - from.y, to.x - from.x)
        property real arrowSize: lineWidth * 3
        property var dest: Qt.point(to.x + Math.cos(angle + Math.PI * 5 / 6) * arrowSize,to.y + Math.sin(angle + Math.PI * 5 / 6) * arrowSize)
        id: lineId
        strokeWidth: Math.max(1,lineWidth)
        strokeColor: Material.accentColor
        startX: from.x
        startY: from.y
        fillColor: "transparent"
        PathLine{x:lineId.dest.x;y:lineId.dest.y}
    }
    ShapePath {
        fillColor: lineColor // Use parent.lineColor to access the alias
        strokeColor: lineColor
        strokeWidth: 0
        startX: lineId.dest.x
        startY: lineId.dest.y
        PathLine { x: to.x; y: to.y }
        PathLine {
            x: to.x + Math.cos(lineId.angle - Math.PI * 5 / 6) * lineId.arrowSize
            y: to.y + Math.sin(lineId.angle - Math.PI * 5 / 6) * lineId.arrowSize
        }
        PathLine {
            x: to.x + Math.cos(lineId.angle + Math.PI * 5 / 6) * lineId.arrowSize
            y: to.y + Math.sin(lineId.angle + Math.PI * 5 / 6) * lineId.arrowSize
        }
    }
}
