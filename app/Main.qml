import QtQuick 2.4
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3
import Qt.labs.settings 1.0

MainView {
    objectName: 'mainView'
    applicationName: 'finger-painting.bhdouglass'
    automaticOrientation: true
    id: root

    width: units.gu(100)
    height: units.gu(75)

    PageStack {
        id: pageStack
        Component.onCompleted: push(Qt.resolvedUrl('CanvasPage.qml'), {
            settings: settings
        })
    }

    BottomEdge {
        id: bottomEdge
        height: parent.height - units.gu(20)

        contentComponent: Rectangle {
            id: bottomEdgeComponent

            PageHeader {
                id: header
                title: i18n.tr('Settings')
            }

            width: bottomEdge.width
            height: bottomEdge.height

            Flickable {
                clip: true
                anchors {
                    top: header.bottom
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }
                contentHeight: contentColumn.height + units.gu(4)

                ColumnLayout {
                    id: contentColumn
                    anchors {
                        left: parent.left;
                        top: parent.top;
                        right: parent.right;
                        topMargin: units.gu(1)
                    }
                    spacing: units.gu(1)

                    ColorPicker {
                        text: i18n.tr('Background Color')
                        color: settings.background

                        onColorChanged : settings.background = color
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
                        text: i18n.tr('Primary Color')
                        color: settings.primaryColor
                        visible: !settings.randomize

                        onColorChanged : settings.primaryColor = color
                    }

                    RowLayout {
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter

                        Label {
                            text: i18n.tr('Line Width')
                        }

                        Slider {
                            minimumValue: 1
                            maximumValue: 50

                            Component.onCompleted: value = settings.lineWidth
                            onValueChanged: settings.lineWidth = value
                        }
                    }
                }
            }
        }
    }

    Settings {
        id: settings

        property string background: '#000000'
        property int lineWidth: 5
        property bool randomize: true
        property string primaryColor: '#55FF00'
    }
}
