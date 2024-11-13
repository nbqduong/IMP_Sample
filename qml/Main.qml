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

    property bool viewMode : true


    StackView {
            id: stackView
            initialItem: "CameraView.qml"
            anchors.fill: parent
        }

    // Select view
    Button {
        text: "View Photo"
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: {
            if(viewMode){
                stackView.push("PhotoView.qml")
                viewMode = !viewMode
                text = "View Camera"
            }
            else{
                stackView.pop()
                viewMode = !viewMode
                text = "View Photo"
            }



        }
    }

}
