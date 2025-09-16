import QtQuick
import QtQuick.Controls

Item {
    id: root
    width: 200; height: 100

    // Inputs from the model
    property string label: "Button"
    property color currentColor: "lightgray"

    // Let Main.qml (via ConfirmDialog) decide if/when to change
    signal askToChangeColor(Item tile)

    Rectangle {
        anchors.fill: parent
        radius: 12
        color: root.currentColor
        border.color: "#333"
        border.width: 1
    }

    Button {
        anchors.centerIn: parent
        text: root.label
        onClicked: root.askToChangeColor(root)
    }
}