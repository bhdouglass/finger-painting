// Canvas code inspired by: https://github.com/rburchell/qmlstuff/blob/master/fingerpaint/fingerpaint.qml

import QtQuick 2.4
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import Qt.labs.settings 1.0

import "colors.js" as Colors
import "Components"

// TODO load image
// TODO save image
Page {
    id: page
    title: i18n.tr('Finger Painting')

    property string stamp
    property var stamps: [
        { path: '../assets/smile.svg' },
        { path: '../assets/happy.svg' },
        { path: '../assets/happy2.svg' },
        { path: '../assets/heart-eyes.svg' },
        { path: '../assets/joy.svg' },
        { path: '../assets/sleep.svg' },
        { path: '../assets/sunglasses.svg' },
        { path: '../assets/surprise.svg' },
        { path: '../assets/tongue.svg' },
        { path: '../assets/wink.svg' },
        { path: '../assets/party.svg' },
        { path: '../assets/thumbsup.svg' },
        { path: '../assets/star.svg' },
        { path: '../assets/heart.svg' },
    ]

    Settings {
        id: settings

        property string background: '#000000'
        property int lineWidth: 5
        property bool randomize: true
        property string primaryColor: '#55FF55'
    }

    header: PageHeader {
        id: header
        title: parent.title

        trailingActionBar.actions: [
            Action {
                iconName: 'info'
                text: i18n.tr('About')
                onTriggered: pageStack.push(Qt.resolvedUrl('AboutPage.qml'))
            }
        ]
    }

    Rectangle {
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: bottomBar.top
        }
        color: settings.background

        Canvas {
            id: canvas

            anchors.fill: parent

            property var lastPosById
            property var posById

            property var colors: []

            function clear() {
                canvas.lastPosById = {};
                canvas.posById = {};
                canvas.context.reset();
                canvas.requestPaint();
            }

            Component.onCompleted: {
                for (var i = 0; i < 10; i++) {
                    colors.push(settings.primaryColor);
                }

                for (var i = 0; i < stamps.length; i++) {
                    canvas.loadImage(stamps[i].path);
                }
            }

            onPaint: {
                var ctx = getContext('2d');
                if (!lastPosById) {
                    lastPosById = {};
                    posById = {};
                }

                for (var id in lastPosById) {
                    ctx.strokeStyle = colors[id % colors.length];
                    ctx.lineWidth = parseInt(settings.lineWidth);
                    ctx.lineCap = 'round';

                    ctx.beginPath();
                    ctx.moveTo(lastPosById[id].x, lastPosById[id].y);
                    ctx.lineTo(posById[id].x, posById[id].y);
                    ctx.stroke();

                    lastPosById[id] = posById[id]
                }
            }

            MultiPointTouchArea {
                anchors.fill: parent

                onPressed: {
                    for (var i = 0; i < touchPoints.length; ++i) {
                        var point = touchPoints[i];

                        if (stamp) {
                            canvas.getContext('2d').drawImage(stamp, point.x - 20, point.y - 20);
                        }
                        else {
                            if (!canvas.lastPosById[point.pointId]) {
                                var key = (point.pointId % canvas.colors.length);
                                //Only randomize the last touch (so current touches don't change colors)
                                if (settings.randomize) {
                                    canvas.colors[key] = Colors.random(settings.background, canvas.colors[key]);
                                }
                                else {
                                    canvas.colors[key] = settings.primaryColor;
                                }
                            }

                            canvas.lastPosById[point.pointId] = {
                                x: point.x,
                                y: point.y
                            };

                            //Offset slightly to allow a single tap/dot
                            canvas.posById[point.pointId] = {
                                x: point.x + 0.1,
                                y: point.y + 0.1
                            };
                        }
                    }

                    canvas.requestPaint();
                }

                onUpdated: {
                    for (var i = 0; i < touchPoints.length; ++i) {
                        var point = touchPoints[i];

                        canvas.posById[point.pointId] = {
                            x: point.x,
                            y: point.y
                        };
                    }

                    canvas.requestPaint();
                }

                onReleased: {
                    for (var i = 0; i < touchPoints.length; ++i) {
                        var point = touchPoints[i];

                        delete canvas.lastPosById[point.pointId];
                        delete canvas.posById[point.pointId];
                    }
                }
            }
        }
    }

    SubBottomBar {
        id: subBottomBar

        anchors {
            left: parent.left
            right: parent.right
            bottom: bottomBar.top
        }

        settings: settings
        mode: bottomBar.mode

        onStampChanged: parent.stamp = stamp
    }

    BottomBar {
        id: bottomBar
    }
}
