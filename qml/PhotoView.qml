import QtQuick 2.15
import QtMultimedia 6.0
import QtQuick.Controls 2.15

import com.company.interface 1.0
Item {
    visible: true
    width: 640
    height: 450
    anchors.top: parent.top
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
        width: 640
        height: 400
        fillMode: Image.PreserveAspectFit  // Preserve aspect ratio
    }

    Button {
        text: "Gray filter"
        anchors.bottom: parent.bottom
        x: 100
        onClicked: {
            myInterface.grayFilter();
            myImage.source = "file:///" + myInterface.getAppPath() + "grayscale_image.jpg"
        }
    }
    Button {
        text: "Edge filter"
        anchors.bottom: parent.bottom
        x:300
        onClicked: {
            myInterface.edgeFilter();
            myImage.source = "file:///" + myInterface.getAppPath() + "edge_image.jpg"
        }
    }
}
