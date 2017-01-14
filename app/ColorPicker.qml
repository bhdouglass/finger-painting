import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3

ListItem {
    id: colorPicker

    onClicked: PopupUtils.open(dialogComponent, root);

    property alias text: label.text
    property string color

    Component {
        id: dialogComponent

        ColorDialog {
            id: dialog
            color: colorPicker.color

            onColorChanged: {
                colorPicker.color = color;
                shape.backgroundColor = color;
            }
        }
    }

    Label {
        id: label

        anchors {
            left: parent.left
            leftMargin: units.gu(1)
            verticalCenter: parent.verticalCenter
        }
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

        backgroundColor: colorPicker.color
    }
}
