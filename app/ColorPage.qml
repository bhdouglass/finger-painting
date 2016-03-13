import QtQuick 2.4
import Ubuntu.Components 1.3
import 'colors.js' as Colors

Page {
    id: root
    title: i18n.tr('Pick a Color')

    property var settings
    property string settingName
    signal close()

    Flickable {
        anchors.fill: parent
        flickableDirection: Flickable.VerticalFlick
        clip: true

        Grid {
            anchors.horizontalCenter: parent.horizontalCenter
            columns: 9

            Repeater {
                model: Colors.list

                UbuntuShape { //TODO have the currently selected one "checked"
                    width: root.width / 10
                    height: width
                    backgroundColor: modelData ? modelData.hex : '#FFFFFF'

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            settings[settingName] = modelData ? modelData.hex : '#FFFFFF';
                            root.close();
                        }
                    }
                }
            }
        }
    }
}
