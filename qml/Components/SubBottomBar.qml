import QtQuick 2.4
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3

import "../colors.js" as Colors

Rectangle {
    id: subBottomBar

    property var settings
    property string mode: 'none'
    property string stamp

    onModeChanged: {
        if (mode != 'stamp') {
            stamp = '';
        }
    }

    visible: mode != 'none'
    height: units.gu(7)
    color: theme.palette.normal.background

    Component {
        id: colorPickerComponent

        ColorDialog {
            id: dialog
            color: settings.primaryColor

            onColorChanged: {
                settings.primaryColor = color;
            }
        }
    }

    Rectangle {
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }
        height: units.dp(1)
        color: theme.palette.normal.base
    }

    Flickable {
        visible: mode == 'color' || mode == 'bg-color'

        anchors.fill: parent
        flickableDirection: Flickable.HorizontalFlick
        contentWidth: (height + units.gu(1)) * Colors.pickerList.length

        RowLayout {
            anchors.fill: parent

            BottomBarIcon {
                Layout.fillHeight: true
                Layout.preferredWidth: height

                source: '../../assets/palette.svg'
                selected:  {
                    if (mode == 'bg-color') {
                        return !Colors.inPickerList(settings.background);
                    }

                    return !Colors.inPickerList(settings.primaryColor) && !settings.randomize;
                }
                onClicked: {
                    settings.randomize = false;
                    PopupUtils.open(colorPickerComponent, root);
                }
            }

            BottomBarIcon {
                Layout.fillHeight: true
                Layout.preferredWidth: height

                visible: mode != 'bg-color'

                source: '../../assets/question.svg'
                selected: settings.randomize
                onClicked: settings.randomize = true
            }

            Repeater {
                model: Colors.pickerList

                delegate: BottomBarColor {
                    Layout.fillHeight: true
                    Layout.preferredWidth: height

                    color: modelData.hex
                    selected: {
                        if (mode == 'bg-color') {
                            return (modelData.hex == settings.background);
                        }

                        return (modelData.hex == settings.primaryColor && !settings.randomize);
                    }
                    onClicked: {
                        if (mode == 'bg-color') {
                            settings.background = modelData.hex;
                        }
                        else {
                            settings.primaryColor = modelData.hex;
                            settings.randomize = false;
                        }
                    }
                }
            }
        }
    }

    RowLayout {
        visible: mode == 'line'

        anchors.fill: parent

        property var sizes: [
            { brush: 5, height: units.gu(2.5) },
            { brush: 10, height: units.gu(3) },
            { brush: 20, height: units.gu(3.5) },
            { brush: 30, height: units.gu(4) },
            { brush: 40, height: units.gu(4.5) },
            { brush: 50, height: units.gu(5) },
        ]

        Repeater {
            model: parent.sizes

            delegate: Item {
                Layout.fillHeight: true
                Layout.fillWidth: true

                BottomBarIcon {
                    anchors.fill: parent

                    sourceHeight: modelData.height
                    sourceWidth: sourceHeight

                    source: '../../assets/paintbrush.svg'
                    selected: modelData.brush == settings.lineWidth
                    onClicked: settings.lineWidth = modelData.brush
                }
            }
        }
    }

    Flickable {
        visible: mode == 'stamp'

        anchors.fill: parent
        flickableDirection: Flickable.HorizontalFlick
        contentWidth: (height + units.gu(1)) * stamps.length

        RowLayout {
            anchors.fill: parent

            Repeater {
                model: stamps

                delegate: BottomBarIcon {
                    Layout.fillHeight: true
                    Layout.preferredWidth: height

                    source: '../' + modelData.path
                    selected: modelData.path == stamp
                    onClicked: stamp = modelData.path
                }
            }
        }
    }
}
