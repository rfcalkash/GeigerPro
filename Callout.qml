import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia
import QtQuick.Controls.Material
import GeigerPro

Item{
    property alias title: titleId.text
    property alias description: descrId.text
    implicitHeight: labels.implicitHeight
    implicitWidth: labels.implicitWidth+Material.frameVerticalPadding
    property double separatorY: separatorId.y+separatorId.height/2
    property alias separatorColor: separatorId.color
    ColumnLayout{
        id: labels
        width: parent.width
        Label{
            id: titleId
            color: Material.primaryTextColor
            Layout.fillWidth: true
            font.pixelSize: Material.dialogTitleFontPixelSize/1.5
            style: Text.Outline
            styleColor: Material.backgroundColor
        }
        Rectangle{
            id: separatorId
            Layout.fillWidth: true
            Layout.preferredHeight: Material.buttonHeight/10
            color: Material.accentColor
        }

        Label{
            id: descrId
            color: Material.secondaryTextColor
            Layout.fillWidth: true
            Layout.fillHeight: true
            wrapMode: Text.Wrap
            font.pixelSize: Material.dialogTitleFontPixelSize/2
            style: Text.Outline
            styleColor: Material.backgroundColor
        }
    }
}
