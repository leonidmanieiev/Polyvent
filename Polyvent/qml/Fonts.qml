//custom шрифты

import QtQuick 2.9

Item
{
    readonly property alias main_text_alias: main_text
    readonly property alias title_text_alias: title_text

    FontLoader
    {
        id: main_text
        source: "qrc:/resources/fonts/georgia.ttf"
    }

    FontLoader
    {
        id: title_text
        source: "qrc:/resources/fonts/constanb.ttf"
    }
}
