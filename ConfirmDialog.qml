import QtQuick
import QtQuick.Controls

Dialog {
    id: dlg
    title: "Confirm"
    modal: true
    standardButtons: Dialog.Ok | Dialog.Cancel

    // The tile whose color we will modify
    property Item targetTile: null

    // Fixed cycle sequence
    readonly property var cycle: [
        Qt.color("red"),
        Qt.color("green"),
        Qt.color("blue"),
        Qt.color("yellow"),
        Qt.color("purple"),
        Qt.color("gray")
    ]

    contentItem: Column {
        spacing: 12
        padding: 16

        Text {
            text: "Hey Are you sure you want to change the color of the button ?"
            wrapMode: Text.WordWrap
        }
    }

    function normalized(c) {
        const s = String(c || "").toLowerCase()
        return (s === "grey") ? "gray" : s
    }

    function nextColor(cur) {
        let qcur = Qt.colorEqual ? cur : Qt.rgba(0,0,0,0)   // Qt.colorEqual is available in Qt 6
        for (var i = 0; i < cycle.length; i++) {
            if (Qt.colorEqual(cur, cycle[i])) {
                return cycle[(i + 1) % cycle.length]
            }
        }
        // fallback if not matched
        return cycle[0]
    }

    onAccepted: {
        if (targetTile) {
            targetTile.currentColor = nextColor(targetTile.currentColor)
        }
    }
    // onRejected: do nothing (just close)
}