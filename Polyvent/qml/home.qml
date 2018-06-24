//вкладка 'home'

import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Window 2.3
import org.qtproject.leoapp 1.0

Item
{
    id: item
    width: root_window.screen_width
    height: root_window.screen_height

    EventModel { id: event_model }

    EventList
    {
        depend_model: event_model.events_for_date()
        _no_event_text: "Извини, видимо, мероприятий нет"
    }
}
