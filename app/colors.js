//TODO translate names

var list = [
    null,
    null,
    {
        'name': 'Bright Green',
        'hex': '#55FF00',
    }, {
        'name': 'Inchworm',
        'hex': '#AAFF55',
    },
    null,
    {
        'name': 'Icterine',
        'hex': '#FFFF55',
    }, {
        'name': 'Pastel Yellow',
        'hex': '#FFFFAA',
    },
    null,
    null,
    null,
    {
        'name': 'Mint Green',
        'hex': '#AAFFAA',
    }, {
        'name': 'Screamin\' Green',
        'hex': '#55FF55',
    }, {
        'name': 'Green',
        'hex': '#00FF00',
    }, {
        'name': 'Spring Bud',
        'hex': '#AAFF00',
    }, {
        'name': 'Yellow',
        'hex': '#FFFF00',
    }, {
        'name': 'Rajah',
        'hex': '#FFAA55',
    }, {
        'name': 'Melon',
        'hex': '#FFAAAA',
    },
    null,
    {
        'name': 'Medium Aquamarine',
        'hex': '#55FFAA',
    }, {
        'name': 'Malachite',
        'hex': '#00FF55',
    }, {
        'name': 'Islamic Green',
        'hex': '#00AA00',
    }, {
        'name': 'Kelly Green',
        'hex': '#55AA00',
    }, {
        'name': 'Brass',
        'hex': '#AAAA55',
    }, {
        'name': 'Limerick',
        'hex': '#AAAA00',
    }, {
        'name': 'Chrome Yellow',
        'hex': '#FFAA00',
    }, {
        'name': 'Orange',
        'hex': '#FF5500',
    }, {
        'name': 'Sunset Orange',
        'hex': '#FF5555',
    }, {
        'name': 'Celeste',
        'hex': '#AAFFFF',
    }, {
        'name': 'Medium Spring Green',
        'hex': '#00FFAA',
    }, {
        'name': 'Jaeger Green',
        'hex': '#00AA55',
    }, {
        'name': 'May Green',
        'hex': '#55AA55',
    }, {
        'name': 'Dark Green (X11)',
        'hex': '#005500',
    }, {
        'name': 'Army Green',
        'hex': '#555500',
    }, {
        'name': 'Windsor Tan',
        'hex': '#AA5500',
    }, {
        'name': 'Red',
        'hex': '#FF0000',
    }, {
        'name': 'Folly',
        'hex': '#FF0055',
    },
    null,
    {
        'name': 'Cadet Blue',
        'hex': '#55AAAA',
    }, {
        'name': 'Tiffany Blue',
        'hex': '#00AAAA',
    }, {
        'name': 'Midnight Green (Eagle Green)',
        'hex': '#005555',
    }, {
        'name': 'White',
        'hex': '#FFFFFF',
    }, {
        'name': 'Black',
        'hex': '#000000',
    }, {
        'name': 'Rose Vale',
        'hex': '#AA5555',
    }, {
        'name': 'Dark Candy Apple Red',
        'hex': '#AA0000',
    },
    null,
    {
        'name': 'Electric Blue',
        'hex': '#55FFFF',
    }, {
        'name': 'Cyan',
        'hex': '#00FFFF',
    }, {
        'name': 'Vivid Cerulean',
        'hex': '#00AAFF',
    }, {
        'name': 'Cobalt Blue',
        'hex': '#0055AA',
    }, {
        'name': 'Light Gray',
        'hex': '#AAAAAA',
    }, {
        'name': 'Dark Gray',
        'hex': '#555555',
    }, {
        'name': 'Bulgarian Rose',
        'hex': '#550000',
    }, {
        'name': 'Jazzberry Jam',
        'hex': '#AA0055',
    }, {
        'name': 'Brilliant Rose',
        'hex': '#FF55AA',
    }, {
        'name': 'Picton Blue',
        'hex': '#55AAFF',
    }, {
        'name': 'Blue Moon',
        'hex': '#0055FF',
    }, {
        'name': 'Blue',
        'hex': '#0000FF',
    }, {
        'name': 'Duke Blue',
        'hex': '#0000AA',
    }, {
        'name': 'Oxford Blue',
        'hex': '#000055',
    }, {
        'name': 'Imperial Purple',
        'hex': '#550055',
    }, {
        'name': 'Purple',
        'hex': '#AA00AA',
    }, {
        'name': 'Fashion Magenta',
        'hex': '#FF00AA',
    }, {
        'name': 'Rich Brilliant Lavender',
        'hex': '#FFAAFF',
    },
    null,
    {
        'name': 'Liberty',
        'hex': '#5555AA',
    }, {
        'name': 'Very Light Blue',
        'hex': '#5555FF',
    }, {
        'name': 'Electric Ultramarine',
        'hex': '#5500FF',
    }, {
        'name': 'Indigo (Web)',
        'hex': '#5500AA',
    }, {
        'name': 'Vivid Violet',
        'hex': '#AA00FF',
    }, {
        'name': 'Magenta',
        'hex': '#FF00FF',
    }, {
        'name': 'Shocking Pink (Crayola)',
        'hex': '#FF55FF',
    },
    null,
    null,
    null,
    null,
    {
        'name': 'Baby Blue Eyes',
        'hex': '#AAAAFF',
    }, {
        'name': 'Lavender Indigo',
        'hex': '#AA55FF',
    }, {
        'name': 'Purpureus',
        'hex': '#AA55AA',
    },
    null,
    null,
    null,
];

function lookupName(hex) {
    var name = '';
    for (var index in list) {
        if (list[index] && list[index].hex == hex) {
            name = list[index].name;
            break;
        }
    }

    return name;
}

function random(not1, not2) {
    var color = '#FFFFFF';
    var rand = Math.floor((Math.random() * list.length) + 1);

    if (!list[rand] || [not1, not2].indexOf(list[rand].hex) > -1) {
        color = random(not1, not2);
    }
    else {
        color = list[rand].hex;
    }

    return color;
}
