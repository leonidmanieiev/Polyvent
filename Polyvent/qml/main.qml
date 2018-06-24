import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Window 2.3
import QtQuick.Layouts 1.3


ApplicationWindow
{
    id: root_window
    visible: true
    width: screen_width
    height: screen_height
    color: background_color

    readonly property real btn_width: width / 7.2
    readonly property real def_marg: btn_width / 3.33
    readonly property real bot_marg: 3.66 * def_marg + btn_width
    readonly property int screen_width: Qt.platform.os === "windows" ? 360 : Screen.width
    readonly property int screen_height: Qt.platform.os === "windows" ? 592 : Screen.height
    readonly property color background_color: "#4D5A57"
    readonly property color main_green_color: "#419d6b"
    readonly property color event_info_color: "#dbdedd"
    property alias main_qml_loader: qml_loader

    RowLayout
    {
        id: bot_btns_layout
        spacing: (parent.width - 5.6 * btn_width) / 4
        anchors
        {
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
            bottomMargin: def_marg
            leftMargin: def_marg
            rightMargin: def_marg
        }

        BottomBtn
        {
            id: calendar_btn
            btn_icon_path: "qrc:/resources/icons/calendar.svg"
            cust_round_btn.onClicked: qml_loader.source = "qrc:/qml/calendar.qml"
        }
        BottomBtn
        {
            id: map_btn
            btn_icon_path: "qrc:/resources/icons/map.svg"
            cust_round_btn.onClicked: qml_loader.source = "qrc:/qml/map.qml"
        }
        BottomBtn
        {
            id: home_btn
            btn_icon_path: "qrc:/resources/icons/home.svg"
            cust_round_btn.onClicked: qml_loader.source = "qrc:/qml/home.qml"
        }
        BottomBtn
        {
            id: search_btn
            btn_icon_path: "qrc:/resources/icons/search.svg"
            cust_round_btn.onClicked: qml_loader.source = "qrc:/qml/search.qml"
        }
        BottomBtn
        {
            id: favorites_btn
            btn_icon_path: "qrc:/resources/icons/favorite_on.svg"
            cust_round_btn.onClicked: qml_loader.source = "qrc:/qml/favorites.qml"
        }
    }


    Loader
    {
        id: qml_loader
        asynchronous: true
        visible: qml_loader.status == Loader.Ready
        source: "qrc:/qml/fetch_events.qml"
    }

    BusyIndicator
    {
        id: busy_ind
        anchors.centerIn: parent
        width: parent.width / 5
        height: busy_ind.width
        running: qml_loader.status == Loader.Loading
    }
}
