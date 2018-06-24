//шаблон кнопки из footer

import QtQuick 2.9
import QtQuick.Controls 2.3

Rectangle
{
    id: round_btn_wrapper
    width: root_window.btn_width
    height: root_window.btn_width
    color: "transparent"

    property string btn_icon_path: ({})
    property real icon_adj: root_window.def_marg*0.95
    readonly property alias cust_round_btn: control_bnt

    RoundButton
    {
        id: control_bnt
        anchors.fill: parent
        icon.source: btn_icon_path
        icon.width: parent.width-icon_adj
        icon.height: parent.height-icon_adj
        icon.color: "transparent"
    }
}
