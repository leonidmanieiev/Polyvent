//подробная информация о мероприятии

import QtQuick 2.9
import QtQuick.Controls 2.3
import org.qtproject.leoapp 1.0

Item
{
    id: item
    width: root_window.screen_width
    height: root_window.screen_height

    property string name: ({})
    property date date: ({})
    property string event_desc: ({})
    property string url: ({})
    property string img_url: ({})
    property bool is_event_favorite: ({})

    EventModel { id: event_model }

    Rectangle
    {
        id: info_block
        anchors
        {
            fill: parent
            leftMargin: root_window.def_marg
            rightMargin: root_window.def_marg
            topMargin: root_window.def_marg
            bottomMargin: root_window.bot_marg
        }
        radius: 20
        color: "#98baa7"

        Fonts { id: fonts }

        Flickable
        {
            id: flickable_area
            contentHeight: top_image.height+title_text.height+info_block_text.height+desc_text.height
            anchors
            {
                top: parent.top
                left: parent.left
                right: parent.right
                bottom: add_to_favorite.top
                leftMargin: root_window.def_marg
                rightMargin: root_window.def_marg
                topMargin: root_window.def_marg
                bottomMargin: root_window.def_marg
            }
            flickableDirection: Flickable.VerticalFlick
            clip: true

            Image
            {
                id: top_image
                source: img_url
                asynchronous: true
                width: 248
                height: 166
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text
            {
                id: title_text
                anchors.top: top_image.bottom
                topPadding: root_window.def_marg
                text: name
                wrapMode: Text.Wrap
                width: flickable_area.width
                font.pixelSize: 1.2*root_window.def_marg
                font.family: fonts.title_text_alias.name
                font.bold: true
                horizontalAlignment: Text.AlignLeft
                color: "#FFFFFF"
            }

            Text
            {
                id: info_block_text
                anchors.top: title_text.bottom
                topPadding: root_window.def_marg
                text: "Когда: "+date.toLocaleString(Qt.locale("ru_RU"), "ddd, d MMMM")+
                      "<br/>Источник: <a href='"+url+"'>подробнее</a>"
                onLinkActivated: Qt.openUrlExternally(url);
                linkColor: "#FFFFFF"
                width: flickable_area.width
                font.pixelSize: 0.9*root_window.def_marg
                font.family: fonts.main_text_alias.name
                font.bold: true
                horizontalAlignment: Text.AlignLeft
                color: "#FFFFFF"
            }

            Text
            {
                id: desc_text
                anchors.top: info_block_text.bottom
                topPadding: root_window.def_marg
                text: event_desc;
                wrapMode: Text.Wrap
                width: flickable_area.width
                font.pixelSize: 0.9*root_window.def_marg
                font.family: fonts.main_text_alias.name
                horizontalAlignment: Text.AlignHCenter
                color: "#FFFFFF"
            }
        }

        RoundButton
        {
            id: add_to_favorite
            anchors.bottom: info_block.bottom
            anchors.bottomMargin: root_window.def_marg
            anchors.horizontalCenter: parent.horizontalCenter
            checkable: true
            checked: is_event_favorite
            icon.source:
            {
                if(checked)
                {
                    event_model.update_favorite(url, true);
                    "qrc:/resources/icons/favorite_on.svg";
                }
                else
                {
                    event_model.update_favorite(url, false);
                    "qrc:/resources/icons/favorite_off.svg";
                }
            }
            icon.width: root_window.btn_width/1.5
            icon.height: root_window.btn_width/1.5
            icon.color: "transparent"
            background: Rectangle { color: "#e0e0e0"; radius: 100 }
        }
    }
}
