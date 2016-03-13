import QtQuick 2.4
import Ubuntu.Components 1.3

Page {
    title: i18n.tr('Settings')
    property var settings

    signal colorTriggered(string settingName)

    Flickable {
        anchors.fill: parent
        flickableDirection: Flickable.VerticalFlick
        clip: true

        contentWidth: parent.width
        contentHeight: column.height

        Column {
            id: column
            anchors {
                left: parent.left
                right: parent.right
            }

            ColorPicker {
                text: i18n.tr('Background Color')
                color: settings.background

                onClicked: colorTriggered('background')
            }

            ListItem {
                Label {
                    anchors {
                        left: parent.left
                        leftMargin: units.gu(1)
                        verticalCenter: parent.verticalCenter
                    }

                    text: i18n.tr('Line Width')
                }

                TextField {
                    anchors {
                        right: parent.right
                        rightMargin: units.gu(1)
                        verticalCenter: parent.verticalCenter
                    }

                    text: settings.lineWidth
                    onTextChanged: {
                        if (settings && settings.lineWidth && text) {
                            settings.lineWidth = text
                        }
                    }

                    hasClearButton: false
                }
            }

            ListItem {
                onClicked: settings.randomize = !settings.randomize

                Label {
                    anchors {
                        left: parent.left
                        leftMargin: units.gu(1)
                        verticalCenter: parent.verticalCenter
                    }

                    text: i18n.tr('Randomize Colors')
                }

                CheckBox {
                    anchors {
                        right: parent.right
                        rightMargin: units.gu(1)
                        verticalCenter: parent.verticalCenter
                    }

                    checked: settings.randomize
                    onCheckedChanged: {
                        if (settings && settings.lineWidth) {
                            settings.randomize = checked
                        }
                    }
                }
            }

            ColorPicker {
                text: i18n.tr('Color 1')
                color: settings.color0
                visible: !settings.randomize

                onClicked: colorTriggered('color0')
            }

            ColorPicker {
                text: i18n.tr('Color 2')
                color: settings.color1
                visible: !settings.randomize

                onClicked: colorTriggered('color1')
            }

            ColorPicker {
                text: i18n.tr('Color 3')
                color: settings.color2
                visible: !settings.randomize

                onClicked: colorTriggered('color2')
            }

            ColorPicker {
                text: i18n.tr('Color 4')
                color: settings.color3
                visible: !settings.randomize

                onClicked: colorTriggered('color3')
            }

            ColorPicker {
                text: i18n.tr('Color 5')
                color: settings.color4
                visible: !settings.randomize

                onClicked: colorTriggered('color4')
            }

            ColorPicker {
                text: i18n.tr('Color 6')
                color: settings.color5
                visible: !settings.randomize

                onClicked: colorTriggered('color5')
            }

            ColorPicker {
                text: i18n.tr('Color 7')
                color: settings.color6
                visible: !settings.randomize

                onClicked: colorTriggered('color6')
            }

            ColorPicker {
                text: i18n.tr('Color 8')
                color: settings.color7
                visible: !settings.randomize

                onClicked: colorTriggered('color7')
            }

            ColorPicker {
                text: i18n.tr('Color 9')
                color: settings.color8
                visible: !settings.randomize

                onClicked: colorTriggered('color8')
            }

            ColorPicker {
                text: i18n.tr('Color 10')
                color: settings.color9
                visible: !settings.randomize

                onClicked: colorTriggered('color9')
            }
        }
    }
}
