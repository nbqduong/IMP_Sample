import QtQuick 2.15
import QtMultimedia 6.0
import QtQuick.Controls 2.15

import com.company.interface 1.0
Item {
    visible: true
    width: 1920
    height: 920
    anchors.horizontalCenter: parent.horizontalCenter

    Interface{
        id: myInterface
    }

    // Image element to show an image from a local file
    Image {
        id: myImage
        source: "file:///" + myInterface.getAppPath() + "image.jpg"  // Path to your image file
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        width: 1920
        height: 980
        fillMode: Image.PreserveAspectFit  // Preserve aspect ratio
    }

    Button {
        text: "Gray filter"
        anchors.top: parent.top
        x: 1000
        onClicked: {
            myInterface.grayFilter();
            myImage.source = "file:///" + myInterface.getAppPath() + "grayscale_image.jpg"
        }
    }
    Button {
        text: "Edge filter"
        anchors.top: parent.top
        x:900
        onClicked: {
            myInterface.edgeFilter();
            myImage.source = "file:///" + myInterface.getAppPath() + "edge_image.jpg"
        }
    }
}
