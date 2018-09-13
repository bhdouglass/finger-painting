import QtQuick 2.4
import Ubuntu.Components 1.3

Item {
    id: icon

    property alias selected: background.visible
    property alias source: img.source
    property alias sourceWidth: img.width
    property alias sourceHeight: img.height

    signal clicked()

    Rectangle {
        id: background

        anchors.centerIn: parent
        width: parent.height - units.gu(0.5)
        height: width
        radius: width * 0.5

        color: theme.palette.normal.base
        visible: false
    }

    Image {
        id: img

        anchors.centerIn: parent
        height: parent.height - units.gu(2)
        width: height

        sourceSize.width: parent.height
        sourceSize.height: parent.height

        MouseArea {
            anchors.fill: parent
            onClicked: icon.clicked()
        }
    }
}
