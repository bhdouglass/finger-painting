import QtQuick 2.4
import Ubuntu.Components 1.3
import Qt.labs.settings 1.0

MainView {
    objectName: 'mainView'
    applicationName: 'finger-painting.bhdouglass'
    automaticOrientation: true

    width: units.gu(100)
    height: units.gu(75)

    PageStack {
        id: pageStack
        Component.onCompleted: push(canvasPage)

        CanvasPage {
            id: canvasPage
            visible: false
            settings: settings

            onSettingsTriggered: pageStack.push(settingsPage)
            onAboutTriggered: pageStack.push(aboutPage)
        }

        SettingsPage {
            id: settingsPage
            visible: false
            settings: settings

            onColorTriggered: {
                colorsPage.settingName = settingName;
                pageStack.push(colorsPage)
            }
        }

        ColorPage {
            id: colorsPage
            visible: false
            settings: settings

            onClose: pageStack.pop()
        }

        AboutPage {
            id: aboutPage
            visible: false
        }
    }

    Settings {
        id: settings

        property string background: '#000000'
        property string lineWidth: '5'
        property bool randomize: true

        property string color0: '#55FF00'
        property string color1: '#00AAAA'
        property string color2: '#AA5555'
        property string color3: '#FF5555'
        property string color4: '#005500'
        property string color5: '#550055'
        property string color6: '#FF55FF'
        property string color7: '#00FFFF'
        property string color8: '#FFFFFF'
        property string color9: '#FFAAAA'
    }
}
