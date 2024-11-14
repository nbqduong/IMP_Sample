import QtQuick 2.15
import QtMultimedia 6.0
import QtQuick.Controls 2.15

import com.company.interface 1.0

Window {
    id: cameraUI
    width: 1920
    height: 1080
    color: "black"
    visible: true

    property int viewMode : 0


    Loader {
            id: viewLoader
            anchors.fill: parent
            source: "CameraView.qml"  // Initial view
        }

    // Select view buttons
        Button {
            id: button
            text: "View Camera"
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                if (viewMode !== 0) {
                    button.text = "View Photo"
                    viewLoader.source = "CameraView.qml"
                    viewMode = 0
                }
                else{
                    button.text = "View Camera"
                    viewLoader.source = "PhotoView.qml"
                    viewMode = 1
                }
            }
        }

}
