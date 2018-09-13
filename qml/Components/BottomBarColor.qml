import QtQuick 2.4
import Ubuntu.Components 1.3

Item {
    id: icon

    property alias selected: background.visible
    property alias color: circle.color

    signal clicked()

    Rectangle {
        id: background

        anchors {
            top: parent.top
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
        }
        width: circle.width + units.gu(2)
        radius: width * 0.5

        color: theme.palette.normal.base
        visible: false
    }

    Rectangle {
        anchors {
            top: parent.top
            topMargin: units.gu(0.75)
            bottom: parent.bottom
            bottomMargin: units.gu(0.75)
            horizontalCenter: parent.horizontalCenter
        }
        width: height

        radius: width * 0.5
        color: '#000000'

        MouseArea {
            anchors.fill: parent
            onClicked: icon.clicked()
        }
    }

    Rectangle {
        id: circle

        anchors {
            top: parent.top
            topMargin: units.gu(1)
            bottom: parent.bottom
            bottomMargin: units.gu(1)
            horizontalCenter: parent.horizontalCenter
        }
        width: height

        radius: width * 0.5

        MouseArea {
            anchors.fill: parent
            onClicked: icon.clicked()
        }
    }
}
