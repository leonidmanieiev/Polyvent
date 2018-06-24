//вкладка 'calendar'

import QtQuick 2.9
import QtQuick.Controls 1.4
import QtQuick.Controls 2.3
import QtQuick.Controls.Styles 1.4
import org.qtproject.leoapp 1.0

Item
{
    id: item
    width: root_window.screen_width
    height: root_window.screen_height

    readonly property string _no_event_text:
        "Никаких событий в этот день, придётся тебе придумать что-нибудь самому."
    EventModel { id: event_model }

    Rectangle
    {
        id: calendar_and_event_info_substrate
        anchors
        {
            fill: parent
            topMargin: root_window.def_marg
            leftMargin: 2*root_window.def_marg
            rightMargin: 2*root_window.def_marg
            bottomMargin: root_window.bot_marg
        }
        color: root_window.event_info_color
    }

    CustomCalendar
    {
        id: event_calendar
        width: root_window.screen_width
        height: 0.4 * root_window.screen_height
        has_event_mark_leftMargins: root_window.def_marg / 1.8
        has_event_mark_topMargins: -root_window.def_marg / 4

        anchors
        {
            left: parent.left
            right: parent.right
            top: parent.top
            topMargin: root_window.def_marg
            leftMargin: 2*root_window.def_marg
            rightMargin: 2*root_window.def_marg
        }
    }

    Rectangle
    {
        id: calendar_and_event_info_substrate_rounding
        anchors.fill: calendar_and_event_info_substrate
        anchors.margins: -root_window.def_marg
        border.color: root_window.background_color
        border.width: 1.06*root_window.def_marg
        color: "transparent"
        radius: 50
    }

    Rectangle
    {
        id: event_info_field
        width: event_calendar.width
        height: calendar_and_event_info_substrate.height - event_calendar.height
        anchors.top: event_calendar.bottom
        anchors.left: event_calendar.left
        anchors.right: event_calendar.right
        anchors.bottom: calendar_and_event_info_substrate.bottom
        anchors.margins: root_window.def_marg
        color: "transparent"

        ListView
        {
            id: events_list_view
            clip: true
            anchors.fill: parent
            anchors.margins: root_window.def_marg/3
            model: event_model.events_for_date(event_calendar.selectedDate)

            delegate: Rectangle
            {
                id: list_view_content
                width: event_info_field.width
                height: event_column.height
                anchors.horizontalCenter: parent.horizontalCenter
                color: "transparent"

                MouseArea
                {
                    id: event_redirect
                    anchors.fill: event_column
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
                    anchors.left: parent.left
                    anchors.leftMargin: root_window.def_marg/3
                    anchors.right: parent.right
                    height: name_label.height + root_window.def_marg/2

                    CustomLabel {id: name_label; text: modelData.name}
                }

                Rectangle
                {
                    id: event_separator
                    width: parent.width
                    anchors.top: event_column.bottom
                    height: 1
                    color: "#000000"
                }
            }
        }
    }

    NoEventBlock
    {
        anchors.fill: event_info_field
        no_event_text: _no_event_text
        show: event_model.events_for_date(event_calendar.selectedDate).length <= 0
    }
}
