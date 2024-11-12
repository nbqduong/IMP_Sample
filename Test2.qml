import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.3

Item {
    width: 200
    height: 200
    Rectangle {
        width: 200
        height: 200
        color: "lightblue"
    }
    Component.onCompleted: {

    }
    MouseArea{
                    id : redRectMouseAreaId
                    anchors.fill: parent
                    onClicked: {
                        test.myFunc();
                    }
    }


}


