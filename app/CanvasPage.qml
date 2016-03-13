//Forked from: https://github.com/rburchell/qmlstuff/blob/master/fingerpaint/fingerpaint.qml

import QtQuick 2.4
import Ubuntu.Components 1.3
import 'colors.js' as Colors

Page {
    id: root
    title: i18n.tr('Finger Painting')

    signal settingsTriggered()
    signal aboutTriggered()
    property var settings

    head.actions: [
        Action {
            iconName: 'info'
            text: i18n.tr('About')
            onTriggered: aboutTriggered()
        },

        Action {
            iconName: 'settings'
            text: i18n.tr('Settings')
            onTriggered: settingsTriggered()
        },

        Action {
            iconName: 'edit-clear'
            text: i18n.tr('Clear')
            onTriggered: {
                canvas.lastPosById = {};
                canvas.posById = {};
                canvas.context.reset();
                canvas.requestPaint();
            }
        }
    ]

    Rectangle {
        anchors.fill: parent
        color: settings.background

        Canvas {
            id: canvas
            anchors.fill: parent
            property var lastPosById
            property var posById

            property var colors: [
                settings.color0,
                settings.color1,
                settings.color2,
                settings.color3,
                settings.color4,
                settings.color5,
                settings.color6,
                settings.color7,
                settings.color8,
                settings.color9
            ]

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

                onPressed: { //TODO handle single presses ("dots")
                    for (var i = 0; i < touchPoints.length; ++i) {
                        var point = touchPoints[i];

                        if (!canvas.lastPosById[point.pointId] && settings.randomize) {
                            //Only randomize the last touch (so current touches don't change colors)

                            var key = 'color' + (point.pointId % canvas.colors.length);
                            settings[key] = Colors.random(settings.background, settings[key])
                        }

                        canvas.lastPosById[point.pointId] = {
                            x: point.x,
                            y: point.y
                        };

                        canvas.posById[point.pointId] = {
                            x: point.x,
                            y: point.y
                        }
                    }
                }

                onUpdated: {
                    for (var i = 0; i < touchPoints.length; ++i) {
                        var point = touchPoints[i];

                        canvas.posById[point.pointId] = {
                            x: point.x,
                            y: point.y
                        };
                    }

                    canvas.requestPaint()
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
}
