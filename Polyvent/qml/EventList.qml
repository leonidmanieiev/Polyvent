//шаблон списока мероприятий для вкладок 'home', 'search' и 'favorites'

import QtQuick 2.9
import QtQuick.Controls 2.3
import org.qtproject.leoapp 1.0

ListView
{
    property string _no_event_text: "Извини, мы не знаем о таких мероприятих."
    property var depend_model

    anchors
    {
        fill: parent
        leftMargin: 3*root_window.def_marg
        rightMargin: 3*root_window.def_marg
        topMargin: 2*root_window.def_marg
        bottomMargin: root_window.bot_marg
    }
    clip: true
    spacing: 1.5*root_window.def_marg
    model: depend_model

    delegate: Rectangle
    {
        id: event_info_block
        anchors.left: parent.left
        anchors.right: parent.right
        height: 1.5*root_window.bot_marg
        gradient: Gradient
        {
            GradientStop { position: 0.0; color: "#409C6A" }
            GradientStop { position: 1.0; color: "#5faf60" }
        }
        opacity: 1
        radius: 20

        Image
        {
            id: backbround_image
            asynchronous: true
            anchors.fill: parent
            source: modelData.img_url
            opacity: 0.13
        }

        Rectangle
        {
            id: event_info_block_rounding
            anchors.fill: event_info_block
            anchors.margins: -root_window.def_marg
            radius: 38
            border.color: root_window.background_color
            border.width: 1.2*root_window.def_marg
            color: "transparent"
        }

        MouseArea
        {
            id: event_redirect
            anchors.fill: event_info_block
            onClicked:
            {
                root_window.main_qml_loader.setSource("qrc:/qml/event_info.qml",
                                                      {"name": modelData.name,
                                                       "date": modelData.start_date,
                                                       "event_desc": modelData.description,
                                                       "url": modelData.url,
                                                       "img_url": modelData.img_url,
                                                       "is_event_favorite": modelData.favorite});
            }
        }

        Fonts { id: fonts }

        Column
        {
            id: event_column
            anchors.fill: parent
            anchors.margins: root_window.def_marg

            CustomLabel
            {
                id: name_label
                text: modelData.name
                font {family: fonts.title_text_alias.name; capitalization: Font.AllUppercase;
                      weight: Font.ExtraBold;}
                color: "#FFFFFF"
            }
            CustomLabel
            {
                id: time_label
                topPadding: root_window.def_marg*1.1
                leftPadding: time_icon.width+root_window.def_marg/3
                text: "  "+modelData.start_date.toLocaleString(Qt.locale("ru_RU"), "ddd, d MMMM")
                font {weight: Font.DemiBold; pixelSize: 0.9*root_window.def_marg}
                color: "#FFFFFF"
            }
        }

        Image
        {
            id: time_icon
            x: root_window.def_marg
            y: name_label.height+2*root_window.def_marg
            sourceSize.width: 1.5*root_window.def_marg
            sourceSize.height: 1.5*root_window.def_marg
            source: "qrc:/resources/icons/time.svg"
        }
    }

    NoEventBlock
    {
        no_event_text: _no_event_text
        show: depend_model.length <= 0
        anchors.left: parent.left
        anchors.right: parent.right
        height: 1.5*root_window.bot_marg
    }
}
