//вкладка 'map'

import QtQuick 2.9
import QtLocation 5.9
import QtPositioning 5.8
import QtQuick.Controls 2.3

Rectangle
{
    id: field
    width: root_window.screen_width
    height: root_window.screen_height
    color: "transparent"

    property var user_coord: ({})
    readonly property color arrow_color: "#419d6b"
    readonly property real btn_size: root_window.btn_width
    readonly property var polypoints_names:
        [QtPositioning.coordinate(60.007458, 30.372984), //ГЗ
         QtPositioning.coordinate(60.006706, 30.376464), //хим. корп.
         QtPositioning.coordinate(60.008090, 30.377186), //мех. корп.
         QtPositioning.coordinate(60.005799, 30.381931), //гидрак 1
         QtPositioning.coordinate(60.006577, 30.383699), //гидрак 2
         QtPositioning.coordinate(60.005548, 30.374165), //гидробашня
         QtPositioning.coordinate(60.007419, 30.379888), //лабораторный корп.
         QtPositioning.coordinate(60.002970, 30.373632), //НОЦ РАН
         QtPositioning.coordinate(60.008836, 30.372984), //1 уч. корп.
         QtPositioning.coordinate(60.008548, 30.374706), //2 уч. корп.
         QtPositioning.coordinate(60.007276, 30.381744), //3 уч. корп.
         QtPositioning.coordinate(60.007251, 30.376872), //4 уч. корп.
         QtPositioning.coordinate(59.999656, 30.374829), //5 уч. корп.
         QtPositioning.coordinate(60.000112, 30.367549), //6 уч. корп.
         QtPositioning.coordinate(60.000814, 30.366497), //9 уч. корп.
         QtPositioning.coordinate(60.000609, 30.369673), //10 уч. корп.
         QtPositioning.coordinate(60.009206, 30.377548), //11 уч. корп.
         QtPositioning.coordinate(60.007206, 30.390447), //15 уч. корп.
         QtPositioning.coordinate(60.008014, 30.389825), //16 уч. корп.
         QtPositioning.coordinate(60.009471, 30.371628), //секриториат прием. ком.
         QtPositioning.coordinate(60.004970, 30.369996), //1 професс. корп.
         QtPositioning.coordinate(60.004950, 30.378117), //2 професс. корп.
         QtPositioning.coordinate(60.004472, 30.379734), //дом ученых в Лесном
         QtPositioning.coordinate(60.002797, 30.369143), //спорт. комплекс
         QtPositioning.coordinate(59.998925, 30.374325), //управление студ. городка
         QtPositioning.coordinate(59.994600, 30.358602), //ИПМЭиТ
         QtPositioning.coordinate(60.006733, 30.379523)] //НИК

    PositionSource
    {
        id: pos_src
        active: true
        onPositionChanged: { user_coord = position.coordinate; }
    }

    Plugin
    {
        id: map_plugin
        name: "osm"
        PluginParameter {name: "osm.useragent"; value: "Polyvent"}
        PluginParameter {name: "osm.mapping.host"; value: "http://a.tile.openstreetmap.org/"}
    }

    Fonts { id: fonts }

    Map
    {
        id: map
        anchors
        {
            left: parent.left
            right: parent.right
            top: parent.top
            bottom: parent.bottom
            leftMargin: root_window.def_marg
            rightMargin: root_window.def_marg
            topMargin: root_window.def_marg
            bottomMargin: root_window.bot_marg
        }
        plugin: map_plugin
        zoomLevel: 16
        activeMapType: supportedMapTypes[6]
        copyrightsVisible: false

        MapQuickItem
        {
            id: user_location_pointer
            visible: false
            sourceItem: Image
            {
                id: pointer_image
                source: "qrc:/resources/icons/location_pointer.png"
            }
            anchorPoint.x: pointer_image.width / 2
            anchorPoint.y: pointer_image.height
        }

        MapQuickItem
        {
            id: pin
            visible: false
            sourceItem: Rectangle
            {
                id: pin_rect
                height: 0.32 * btn_size
                width: 0.32 * btn_size
                color: "#e01d08"
                radius: 100
            }

            anchorPoint.x: pin_rect.width / 2
            anchorPoint.y: pin_rect.height + 0.3 * btn_size
        }

        PolyPoints { coordinate: polypoints_names[0] }//ГЗ
        PolyPoints { coordinate: polypoints_names[1] }//хим. корп.
        PolyPoints { coordinate: polypoints_names[2] }//мех. корп.
        PolyPoints { coordinate: polypoints_names[3] }//гидрак 1
        PolyPoints { coordinate: polypoints_names[4] }//гидрак 2
        PolyPoints { coordinate: polypoints_names[5] }//гидробашня
        PolyPoints { coordinate: polypoints_names[6] }//лабораторный корп.
        PolyPoints { coordinate: polypoints_names[7] }//НОЦ РАН
        PolyPoints { coordinate: polypoints_names[8] }//1 уч. корп.
        PolyPoints { coordinate: polypoints_names[9] }//2 уч. корп.
        PolyPoints { coordinate: polypoints_names[10] }//3 уч. корп.
        PolyPoints { coordinate: polypoints_names[11] }//4 уч. корп.
        PolyPoints { coordinate: polypoints_names[12] }//5 уч. корп.
        PolyPoints { coordinate: polypoints_names[13] }//6 уч. корп.
        PolyPoints { coordinate: polypoints_names[14] }//9 уч. корп.
        PolyPoints { coordinate: polypoints_names[15] }//10 уч. корп.
        PolyPoints { coordinate: polypoints_names[16] }//11 уч. корп.
        PolyPoints { coordinate: polypoints_names[17] }//15 уч. корп.
        PolyPoints { coordinate: polypoints_names[18] }//16 уч. корп.
        PolyPoints { coordinate: polypoints_names[19] }//секриториат прием. ком.
        PolyPoints { coordinate: polypoints_names[20] }//1 професс. корп.
        PolyPoints { coordinate: polypoints_names[21] }//2 професс. корп.
        PolyPoints { coordinate: polypoints_names[22] }//дом ученых в Лесном
        PolyPoints { coordinate: polypoints_names[23] }//спорт. комплекс
        PolyPoints { coordinate: polypoints_names[24] }//управление студ. городка
        PolyPoints { coordinate: polypoints_names[25] }//ИПМЭиТ
        PolyPoints { coordinate: polypoints_names[26] }//НИК
    }

    Rectangle
    {
        id: map_substrate
        anchors.fill: map
        anchors.margins: -0.3 * btn_size
        radius: 50
        border.color: root_window.background_color
        border.width: 0.3 * btn_size
        color: "transparent"
    }

    Rectangle
    {
        id: text_substrate
        width: map_copyright.width+5
        height: map_copyright.height
        color: "#ffffff"
        opacity: 0.9
        anchors
        {
            horizontalCenter: map.horizontalCenter
            bottom: map.bottom
            bottomMargin: 0.1 * btn_size
        }
        radius: 50

        Text
        {
            id: map_copyright
            text: "© <a href='https://www.openstreetmap.org'>Open Street Map</a> contributors"
            onLinkActivated: Qt.openUrlExternally("https://www.openstreetmap.org")
            font.family: fonts.main_text_alias.name
            font.pointSize: 0.2 * btn_size
            anchors.centerIn: parent
        }
    }

    RoundButton
    {
        id: gps_location_btn
        anchors
        {
            right: map_substrate.right
            rightMargin: 0.6 * btn_size
            bottom: map_substrate.bottom
            bottomMargin: 0.6 * btn_size
        }
        opacity: 1
        icon.source: "qrc:/resources/icons/gps_location.svg"
        icon.width: btn_size / 2
        icon.height: btn_size / 2
        icon.color: "transparent"
        onClicked:
        {
            map.center = user_coord;
            map.zoomLevel = 16;
            user_location_pointer.coordinate = user_coord;
            user_location_pointer.visible = true;
        }
    }

    ComboBox
    {
        id: polypoints_box
        model: ["Главный учебный корпус", "Химический корпус", "Механический корпус",
                "Гидрокорпус-1", "Гидрокорпус-2", "Гидробашня", "Лабораторный корпус",
                "НОЦ РАН                ", "1-й учебный корпус", "2-й учебный корпус",
                "3-й учебный корпус", "4-й учебный корпус", "5-й учебный корпус",
                "6-й учебный корпус", "9-й учебный корпус", "10-й учебный корпус",
                "11-й учебный корпус", "15-й учебный корпус", "16-й учебный корпус",
                "Секретариат прием. ком.", "1-й профессорский корпус",
                "2-й профессорский корпус", "Дом ученых в Лесном", "Спортивный комплекс",
                "Управление cтуд. городка", "ИПМЭиТ                 ",  "НИК                    "]
        anchors
        {
            right: map.right
            rightMargin: 0.4 * btn_size
            top: map.top
            topMargin: 0.4 * btn_size
        }

        delegate: ItemDelegate
        {
            width: polypoints_box.width
            contentItem: Text
            {
                text: modelData
                color: "#000000"
                font: fonts.main_text_alias.name
                elide: Text.ElideRight
                verticalAlignment: Text.AlignVCenter
            }
            highlighted: polypoints_box.highlightedIndex === index
        }

        indicator: Canvas
        {
            id: down_arrow
            x: polypoints_box.width - width - polypoints_box.rightPadding
            y: polypoints_box.topPadding + (polypoints_box.availableHeight - height) / 2
            width: 0.24 * btn_size
            height: 0.16 * btn_size
            contextType: "2d"

            Connections
            {
                target: polypoints_box
                onPressedChanged: down_arrow.requestPaint()
            }

            onPaint:
            {
                context.reset();
                context.moveTo(0, 0);
                context.lineTo(width, 0);
                context.lineTo(width / 2, height);
                context.closePath();
                context.fillStyle = arrow_color;
                context.fill();
            }
        }

        contentItem: Text
        {
            id: points
            leftPadding: 0.24 * btn_size
            rightPadding: polypoints_box.indicator.width + 0.2 * btn_size
            font.family: fonts.main_text_alias.name
            text: polypoints_box.displayText
            color: "#000000"
            verticalAlignment: Text.AlignVCenter
        }

        background: Rectangle
        {
            id: point_background
            implicitWidth: 3 * 0.24 * btn_size
            implicitHeight: 0.6 * 0.24 * btn_size
            opacity: 0.8
            border.color: "#000000"
            radius: 3
        }

        popup: Popup
        {
            y: polypoints_box.height - 1
            width: polypoints_box.width
            implicitHeight: map.height - 1.4 * btn_size
            padding: 1

            contentItem: ListView
            {
                clip: true
                implicitHeight: contentHeight
                model: polypoints_box.popup.visible ? polypoints_box.delegateModel : null
                currentIndex: polypoints_box.highlightedIndex

                ScrollIndicator.vertical: ScrollIndicator { }
            }

            background: Rectangle
            {
                border.color: "#000000"
                opacity: 0.8
                radius: 3
            }
        }

        onCurrentIndexChanged:
        {
            map.center = polypoints_names[currentIndex]
            map.zoomLevel = 16;
            pin.coordinate = polypoints_names[currentIndex];
            pin.visible = true;
        }
    }
}
