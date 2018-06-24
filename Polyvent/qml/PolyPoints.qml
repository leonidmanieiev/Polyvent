//шаблок для точек Политеха

import QtQuick 2.9
import QtLocation 5.9

MapQuickItem
{
    id: quick_item_template
    visible: true
    anchorPoint.x: pointer_image.width / 2
    anchorPoint.y: pointer_image.height
    sourceItem: Image
    {
        id: pointer_image
        source: "qrc:/resources/icons/poly_point_pointer.png"
    }
}
