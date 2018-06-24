//шаблон для блока-информации об отсутствии мероприятия

import QtQuick 2.9
import QtQuick.Layouts 1.3

Rectangle
{
    property bool show: false
    property string no_event_text
    readonly property alias no_event_image_block_alias: no_event_image_block

    radius: 20
    visible: show
    color: root_window.event_info_color

    Image
    {
        id: no_event_image_block
        visible: true
        source: "qrc:/resources/icons/sad.svg"
        sourceSize.height: 64
        sourceSize.width: 64
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 2*root_window.def_marg
    }

    Fonts { id: fonts }

    Text
    {
        id: no_event_text_block
        visible: true
        anchors.top: no_event_image_block.bottom
        anchors.topMargin: root_window.def_marg
        width: parent.width
        font.pixelSize: root_window.def_marg
        font.family: fonts.main_text_alias.name
        text: no_event_text
        wrapMode: Text.Wrap
        horizontalAlignment: Text.AlignHCenter
    }
}
