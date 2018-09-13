import QtQuick 2.4
import Ubuntu.Components 1.3

MainView {
    objectName: 'mainView'
    applicationName: 'finger-painting.bhdouglass'
    automaticOrientation: true
    id: root

    width: units.gu(100)
    height: units.gu(75)

    PageStack {
        id: pageStack
        Component.onCompleted: push(Qt.resolvedUrl('CanvasPage.qml'))
    }
}
