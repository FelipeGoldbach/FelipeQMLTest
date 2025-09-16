import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "./model" as Model
import "./components" as Components

ApplicationWindow {
    id: win
    width: 1000
    height: 700
    visible: true
    title: "Felipe Test QML Project"

    // External model: model/ColorsModel.qml
    Model.ColorsModel { id: colorsModel }

    // Confirm dialog instance
    ConfirmDialog { id: confirmDialog }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 16

        Text {
            text: "Available Packages to Load"
            font.pixelSize: 20
            font.bold: true
        }

        GridLayout {
            anchors.centerIn: parent
            columns: 3
            rowSpacing: 12
            columnSpacing: 12

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
    }
}
