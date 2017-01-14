//Forked from: https://github.com/rburchell/qmlstuff/blob/master/fingerpaint/fingerpaint.qml

import QtQuick 2.4
import Ubuntu.Components 1.3
import 'colors.js' as Colors

//TODO load image
//TODO save image
Page {
    title: i18n.tr('Finger Painting')

    property var settings

    header: PageHeader {
        id: header
        title: parent.title

        trailingActionBar.actions: [
            Action {
                iconName: 'info'
                text: i18n.tr('About')
                onTriggered: pageStack.push(Qt.resolvedUrl('AboutPage.qml'))
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
    }

    Rectangle {
        anchors.fill: parent
        color: settings.background

        Canvas {
            id: canvas

            anchors {
                fill: parent
                bottomMargin: units.gu(2) //Give the user some space to swipe up
            }

            property var lastPosById
            property var posById

            property var colors: []

            Component.onCompleted: {
                for (var i = 0; i < 10; i++) {
                    colors.push(settings.primaryColor);
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
}
