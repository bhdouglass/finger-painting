import QtQuick 2.4
import Ubuntu.Components 1.3
import 'colors.js' as Colors

ListItem {
    id: root

    property string text
    property string color

    Label {
        anchors {
            left: parent.left
            leftMargin: units.gu(1)
            verticalCenter: parent.verticalCenter
        }

        text: root.text + ': ' + Colors.lookupName(root.color)
    }

    UbuntuShape {
        id: shape
        anchors {
            right: parent.right
            rightMargin: units.gu(1)
            top: parent.top
            topMargin: units.gu(1)
            bottom: parent.bottom
            bottomMargin: units.gu(1)
        }

        width: height

        backgroundColor: root.color
    }
}
