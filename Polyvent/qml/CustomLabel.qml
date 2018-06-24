//шаблон label'a для calendar, EventList

import QtQuick 2.9
import QtQuick.Controls 2.3

Label
{
    Fonts { id: fonts }

    width: parent.width
    wrapMode: Text.Wrap
    font.pixelSize: 0.8*root_window.def_marg
    font.family: fonts.main_text_alias.name;
    color: "#000000"
}
