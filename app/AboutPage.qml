import QtQuick 2.4
import Ubuntu.Components 1.3

Page {
    title: i18n.tr('About')

    Column {
        spacing: units.gu(2)
        anchors {
            left: parent.left
            leftMargin: units.gu(1)
            right: parent.right
            rightMargin: units.gu(1)
        }

        Label {
            anchors {
                left: parent.left
                right: parent.right
            }

            text: i18n.tr('Finger Painting is a simple, multi-touch painting app geared towards children.')
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
        }

        Label {
            anchors {
                left: parent.left
                right: parent.right
            }

            text: i18n.tr('This app was inspired by https://github.com/rburchell/qmlstuff');
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
        }

        Label {
            anchors {
                left: parent.left
                right: parent.right
            }

            text: i18n.tr('This app is dedicated to my two wonderful children.');
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
        }

        Label {
            anchors {
                left: parent.left
                right: parent.right
            }

            text: i18n.tr('This app is open source software under the GPL v3.');
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
        }

        Button {
            anchors.horizontalCenter: parent.horizontalCenter

            text: i18n.tr('Website')
            color: UbuntuColors.orange
            onClicked: Qt.openUrlExternally('http://bhdouglass.com/')
        }
    }
}
