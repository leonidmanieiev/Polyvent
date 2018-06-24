//custom шаблон календаря для вкладок 'calendar' и 'search'

import QtQuick 2.9
import QtQuick.Controls 1.4
import QtQuick.Controls 2.3
import QtQuick.Controls.Styles 1.4

Calendar
{
    property double has_event_mark_topMargins: ({})
    property double has_event_mark_leftMargins: ({})
    readonly property var month_names: ["Январь", "Февраль", "Март", "Апрель",
                                        "Май", "Июнь", "Июль", "Август", "Сентябрь",
                                        "Октябрь", "Ноябрь", "Декабрь"]
    locale: Qt.locale("ru_RU")

    style: CalendarStyle
    {
        gridVisible: false

        background: Rectangle
        {
            id: calendar_background_color
            color: root_window.main_green_color
            anchors.fill: parent
        }

        dayDelegate: Text
        {
            id: date_specs
            readonly property color selected_day_color: "#000000"
            property color day_color: styleData.visibleMonth ? "#FFFFFF" : "#b4b6ba";

            font.pixelSize: root_window.def_marg
            text: styleData.date.getDate()
            horizontalAlignment: Text.AlignHCenter
            color: styleData.selected ? selected_day_color : day_color

            Rectangle
            {
                id: has_event_for_date
                visible: event_model.events_for_date(styleData.date).length > 0
                width: 1.73 * root_window.def_marg
                height: width
                opacity: 1
                color: "transparent"
                border.color: "#8dcb7b"
                border.width: root_window.def_marg / 5
                radius: 50

                anchors.top: parent.top
                anchors.topMargin: has_event_mark_topMargins
                anchors.left: parent.left
                anchors.leftMargin: has_event_mark_leftMargins
            }
        }

        Fonts { id: fonts }

        navigationBar: Text
        {
            id: month_year_view
            font.pixelSize: 1.66 * root_window.def_marg
            text: month_names[visibleMonth] + ' ' + visibleYear
            font.family: fonts.main_text_alias.name
            horizontalAlignment: Text.AlignHCenter
            color: "#FFFFFF"
        }

        dayOfWeekDelegate: Text
        {
            //to erase day of the week
        }
    }

    RoundButton
    {
        id: left_arrow
        anchors.top: parent.top
        anchors.topMargin: root_window.def_marg/5
        anchors.left: parent.left
        anchors.leftMargin: root_window.def_marg/3
        opacity: down ? 0.8 : 1
        icon.source: "qrc:/resources/icons/arrow.svg"
        icon.width: root_window.btn_width/2
        icon.height: root_window.btn_width/2
        icon.color: "transparent"
        background: Rectangle { visible: false }
        onClicked: showPreviousMonth()
    }

    RoundButton
    {
        id: right_arrow
        anchors.top: parent.top
        anchors.topMargin: root_window.def_marg/5
        anchors.right: parent.right
        anchors.rightMargin: -2*root_window.def_marg
        transform: Rotation { origin.x: 0; origin.y: 0; axis { x: 0; y: 1; z: 0 } angle: 180 }
        opacity: down ? 0.8 : 1
        icon.source: "qrc:/resources/icons/arrow.svg"
        icon.width: root_window.btn_width/2
        icon.height: root_window.btn_width/2
        icon.color: "transparent"
        background: Rectangle { visible: false }
        onClicked: showNextMonth()
    }
}
