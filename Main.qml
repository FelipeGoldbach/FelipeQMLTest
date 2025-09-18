import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "./model" as Model
import "./components" as Components

ApplicationWindow {
    id: win

    width: 600
    height: 500
    visible: true
    title: "Felipe Test QML Project"

    // layout constants
    readonly property int outerMargin: 16
    readonly property int vSpacing: 16

    // External model: model/ColorsModel.qml & Confirm dialog instance
    Model.ColorsModel { id: colorsModel }
    ConfirmDialog { id: confirmDialog }

    Column {
        anchors.fill: parent.horizontalCenter
        anchors.margins: outerMargin
        spacing: vSpacing

        Item {
            width: heading.implicitWidth + 20
            height: heading.implicitHeight

            Text {
                id: heading

                anchors.centerIn: parent
                text: "Available Packages to Load"
                font.pixelSize: 20
                font.bold: true
            }
        }
    }

    Grid {
        id: tiles

        anchors.centerIn: parent      
        columns: 2
        rowSpacing: 12
        columnSpacing: 12
        horizontalItemAlignment: Grid.AlignHCenter
        verticalItemAlignment: Grid.AlignVCenter

        Repeater {
            model: colorsModel

            Components.ColorTile {
                label: model.name
                currentColor: model.color

                onAskToChangeColor: (tile) => {
                    confirmDialog.targetTile = tile
                    confirmDialog.open()
                }
            }
        }   
    }

    // Prevent shrinking smaller than the grid + heading + margins
    minimumWidth:  Math.ceil(tiles.implicitWidth)  + 2 * outerMargin
    minimumHeight: Math.ceil(heading.implicitHeight + vSpacing + tiles.implicitHeight) + 2 * outerMargin
}
