//вкладка 'search'

import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import org.qtproject.leoapp 1.0

Item
{
    property bool block_from_clicked: false
    property date from_date: new Date()
    property date to_date

    id: root_item
    width: root_window.screen_width
    height: root_window.screen_height

    EventModel { id: event_model }

    Loader
    {
        id: loader
        sourceComponent: satisfied_events
        active: true
        anchors
        {
            top: search_block.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            topMargin: -root_window.def_marg
        }
        function reload()
        {
            loader.active = false;
            loader.active = true;
        }
    }

    Rectangle
    {
        id: search_block
        anchors
        {
            top: parent.top
            left: parent.left
            right: parent.right
            leftMargin: 3*root_window.def_marg
            rightMargin: 3*root_window.def_marg
            topMargin: 2*root_window.def_marg
            bottomMargin: root_window.bot_marg
        }
        height: root_window.bot_marg
        color: "#cdebdb"
        opacity: 1
        radius: 20

        Fonts { id: fonts }

        Column
        {
            id: event_column
            anchors.fill: parent
            anchors.margins: root_window.def_marg

            TextField
            {
                id: text_edit
                color: "#596d63"
                placeholderText: "Напечатай что-нибудь…"
                font.family: fonts.main_text_alias.name
                background: Rectangle
                {
                    id: text_field_backgr
                    implicitHeight: root_window.def_marg
                    implicitWidth: event_column.width-2*root_window.def_marg
                    color: "transparent"

                    Rectangle
                    {
                        id: underline
                        width: parent.width
                        anchors.top: text_field_backgr.bottom
                        height: 1
                        color: "#abc5b7"
                    }
                }
            }

            RowLayout
            {
                Label
                {
                    id: from_date_label
                    topPadding: root_window.def_marg
                    text: "C: "
                    font.family: fonts.main_text_alias.name
                    color: "#596d63"
                }

                DateField
                {
                    id: from_date_block
                    date_text_alias.text:
                        from_date.toLocaleString(Qt.locale("ru_RU"), "d MMMM")
                    date_text_alias.font.pixelSize: root_window.def_marg/1.3

                    mouse_area_alias.onClicked:
                    {
                        block_from_clicked = true;
                        date_picker.visible = true;
                        calendar_rounding.visible = true;
                    }
                }

                Label
                {
                    id: to_date_label
                    topPadding: root_window.def_marg
                    text: " ПО: "
                    font.family: fonts.main_text_alias.name
                    color: "#596d63"
                }

                DateField
                {
                    id: to_date_block
                    visible: false
                    date_text_alias.font.pixelSize: root_window.def_marg/1.3
                    mouse_area_alias.onClicked:
                    {
                        block_from_clicked = false;
                        date_picker.visible = true;
                        calendar_rounding.visible = true;
                    }
                }

                RoundButton
                {
                    id: add_to_date_btn
                    text: "+"
                    Layout.topMargin: root_window.def_marg
                    implicitHeight: root_window.def_marg
                    implicitWidth: root_window.def_marg
                    opacity: down ? 0.85 : 1
                    background: Rectangle { color: "#FFFFFF"; radius: 100; }
                    onClicked:
                    {
                        add_to_date_btn.visible = false;
                        block_from_clicked = false;
                        to_date_block.visible = true;
                        date_picker.visible = true
                        calendar_rounding.visible = true;
                    }
                }
            }
        }

        CustomCalendar
        {
            id: date_picker
            width: search_block.width
            height: 0.3 * root_window.screen_height
            anchors.top: search_block.bottom
            anchors.topMargin: root_window.def_marg
            has_event_mark_leftMargins: root_window.def_marg / 2.5
            has_event_mark_topMargins: -root_window.def_marg / 4
            visible: false

            onClicked:
            {
                if(block_from_clicked)
                {
                    from_date_block.date_text_alias.text =
                             date_picker.selectedDate.toLocaleString(Qt.locale("ru_RU"), "d MMMM")
                    from_date = date_picker.selectedDate.toLocaleString(Qt.locale("ru_RU"), "yyyy-MM-dd")
                }
                else
                {
                    to_date_block.date_text_alias.text =
                             date_picker.selectedDate.toLocaleString(Qt.locale("ru_RU"), "d MMMM")
                    to_date = date_picker.selectedDate.toLocaleString(Qt.locale("ru_RU"), "yyyy-MM-dd")
                }

                visible = false;
                calendar_rounding.visible = false;
                loader.reload();
            }
        }

        Rectangle
        {
            id: calendar_rounding
            visible: false
            anchors.fill: date_picker
            anchors.margins: -root_window.def_marg
            border.color: root_window.background_color
            border.width: 1.06*root_window.def_marg
            color: "transparent"
            radius: 38
        }

        RoundButton
        {
            id: search_btn
            anchors.right: parent.right
            anchors.top: parent.top
            rightPadding: root_window.def_marg
            topPadding: root_window.def_marg
            icon.source: "qrc:/resources/icons/search.svg"
            icon.width: root_window.btn_width/2
            icon.height: root_window.btn_width/2
            icon.color: "transparent"
            opacity: down ? 0.85 : 1
            background: Rectangle { color: "transparent"; radius: 100 }
        }
    }

    Component
    {
        id: satisfied_events
        EventList
        {
            id: event_list
            depend_model: event_model.events_satisfy_search(from_date, to_date, text_edit.text)
        }
    }
}
