//вкладка 'favorites'

import QtQuick 2.9
import org.qtproject.leoapp 1.0

Item
{
    id: item
    width: root_window.screen_width
    height: root_window.screen_height

    EventModel { id: event_model }

    EventList { depend_model: event_model.favorite_events() }
}
