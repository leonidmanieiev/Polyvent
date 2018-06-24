//шаблон поля для даты для вкладки 'search'

import QtQuick 2.9
import QtQuick.Layouts 1.3

Rectangle
{
    readonly property alias date_text_alias: date_text
    readonly property alias mouse_area_alias: mouse_area

    id: date_block
    Layout.topMargin: root_window.def_marg
    width: 1.5*root_window.btn_width
    height: root_window.btn_width/1.5
    color: "#FFFFFF"
    radius: 10

    Fonts { id: fonts }

    Text
    {
        id: date_text
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.family: fonts.main_text_alias.name
    }

    MouseArea
    {
        id: mouse_area
        anchors.fill: parent
    }
}
