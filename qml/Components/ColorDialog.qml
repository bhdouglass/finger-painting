import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3

Dialog {
    id: colorPopup

    property string color
    property string original

    Component.onCompleted: {
        original = color;
        var rgb = hexToRgb(color);

        red.value = rgb.r;
        green.value = rgb.g;
        blue.value = rgb.b;
    }
    onColorChanged: shape.backgroundColor = color

    //Thanks to: http://stackoverflow.com/a/5624139
    function hexToRgb(hex) {
        var result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
        return result ? {
            r: parseInt(result[1], 16),
            g: parseInt(result[2], 16),
            b: parseInt(result[3], 16)
        } : null;
    }

    function toHex(i) {
        i = parseInt(i);
        if (i === NaN) {
            i = 0;
        }
        else {
            i = i.toString(16);
            i = (i.length == 1) ? '0' + i : i;
        }

        return i;
    }

    function rgbToHex(r, g, b) {
        return '#' + toHex(r) + toHex(g) + toHex(b);
    }

    UbuntuShape {
        id: shape
        height: units.gu(5)

        backgroundColor: color
    }

    Slider {
        id: red

        minimumValue: 0
        maximumValue: 255
        stepSize: 1
        live: true

        onValueChanged: color = rgbToHex(red.value, green.value, blue.value)
    }

    Slider {
        id: green

        minimumValue: 0
        maximumValue: 255
        stepSize: 1
        live: true

        onValueChanged: color = rgbToHex(red.value, green.value, blue.value)
    }

    Slider {
        id: blue

        minimumValue: 0
        maximumValue: 255
        stepSize: 1
        live: true

        onValueChanged: color = rgbToHex(red.value, green.value, blue.value)
    }

    //TODO previously picked colors

    Button {
        text: i18n.tr('Ok')
        color: UbuntuColors.orange

        onClicked: PopupUtils.close(colorPopup)
    }

    Button {
        text: i18n.tr('Cancel')

        onClicked: {
            color = original;
            PopupUtils.close(colorPopup);
        }
    }
}
