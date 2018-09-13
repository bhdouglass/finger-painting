import QtQuick 2.4
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3

Rectangle {
    anchors {
        left: parent.left
        right: parent.right
        bottom: parent.bottom
    }

    property string mode: 'none'
    function toggleMode(newMode) {
        if (mode == newMode) {
            mode = 'none';
        }
        else {
            mode = newMode;
        }
    }

    height: units.gu(7)
    color: theme.palette.normal.background

    Rectangle {
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }
        height: units.dp(1)
        color: theme.palette.normal.base
    }

    RowLayout {
        spacing: units.gu(0.5)
        anchors.fill: parent

        BottomBarIcon {
            Layout.fillHeight: true
            Layout.fillWidth: true

            source: '../../assets/palette.svg'
            selected: mode == 'color'
            onClicked: toggleMode('color')
        }

        BottomBarIcon {
            Layout.fillHeight: true
            Layout.fillWidth: true

            source: '../../assets/paintbrush.svg'
            selected: mode == 'line'
            onClicked: toggleMode('line')
        }

        BottomBarIcon {
            Layout.fillHeight: true
            Layout.fillWidth: true

            source: '../../assets/smile.svg'
            selected: mode == 'stamp'
            onClicked: toggleMode('stamp')
        }

        BottomBarIcon {
            Layout.fillHeight: true
            Layout.fillWidth: true

            source: '../../assets/page.svg'
            selected: mode == 'bg-color'
            onClicked: toggleMode('bg-color')
        }

        BottomBarIcon {
            Layout.fillHeight: true
            Layout.fillWidth: true

            source: '../../assets/trash.svg'
            onClicked: canvas.clear()
        }
    }
}
