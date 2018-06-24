//qml для организации выкачки мероприятий с http://www.spbstu.ru/media/announcements/

import QtQuick 2.9
import QtQuick.Controls 2.2
import QtWebView 1.1
import QtQuick.Window 2.3
import "qrc:/js/http_request_handler.js" as Handler
import org.qtproject.leoapp 1.0

Item
{
    id: root_item
    width: root_window.width
    height: root_window.height

    property int cnt: 0
    readonly property string spbstu_site: "http://www.spbstu.ru/media/announcements/"
    readonly property string api_request: 'https://api.vk.com/method/wall.get?domain'+
                                           '=prometheus&count=30&filter=owner&access_token'+
                                           '=7f45612f199ca6ccac78605e625e71c7b7db5ef08f523d96'+
                                           'b6e11484391ecda8b79e86a10f29c7fe97a60&v=5.74'

    Label
    {
        id: connection_status
        anchors.left: root_item.left
        anchors.bottom: root_item.bottom
        color: "#e0e1e2"
        text: "Загружаем страницу..."
        width: text.length
        font.pointSize: root_window.def_marg/1.8
        leftPadding: 3
        bottomPadding: 2
    }

    EventModel
    {
        id: event_model
        Component.onCompleted: event_model.delete_passed_events();
    }
    Event { id: event }

    BusyIndicator
    {
        id: fetching_busy_ind
        anchors.centerIn: parent
        width: parent.width / 5
        height: fetching_busy_ind.width
        running: true
    }

    Popup
    {
        id: error_popup
        parent: root_item
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        background: Rectangle
        {
            color: root_window.background_color
            radius: 30
        }
        modal: true
        focus: true
        Label
        {
            id: error_text
            color: "#FFFFFF"
            text: "Невозможно обновить ленту"
            font.pointSize: root_window.def_marg/1.2
        }
    }

    Timer
    {
        id: timer
        function delay(cb, delay_time)
        {
            timer.interval = delay_time;
            timer.repeat = false;
            timer.triggered.connect(cb);
            timer.triggered.connect(function()
            {
                timer.triggered.disconnect(cb);
            });
            timer.start();
        }
    }

    WebView
    {
        id: webview
        url: spbstu_site
        function end_loading()
        {
            webview.url = "about:blank";
            fetching_busy_ind.running = false;
        }
        onLoadingChanged:
        {
            var ret_value = Handler.http_request_handler(loadRequest, webview,
                                         function get_url(url) { event.set_url(url); },
                                         function get_img_url(img_url) { event.set_img_url(img_url); },
                                         function get_title(title) { event.set_name(title); },
                                         function get_date(date) { event.set_start_date(date); },
                                         function get_desc(desc, cnt_of_events)
                                         {
                                             event.set_description(desc);
                                             console.log(event.get_name() + " added: " +
                                                         event_model.add_event(event));
                                             cnt += 1;

                                             if(cnt === cnt_of_events)
                                             {
                                                 end_loading();
                                                 main_qml_loader.source = "qrc:/qml/home.qml";
                                             }
                                         }
                                        );
            if(ret_value === -1)
            {
                console.log("Cannot update events");
                connection_status.text="";
                end_loading();
                error_popup.open();
                timer.delay(function(){ error_popup.close(); main_qml_loader.source = "qrc:/qml/home.qml"; }, 2000);
            }
            else if(ret_value === 1)
            {
                connection_status.text = "Подключаемся...";
                console.log("Loading...");
            }
        }
    }
}
