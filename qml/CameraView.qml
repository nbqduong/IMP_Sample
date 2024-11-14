import QtQuick 2.15
import QtMultimedia 6.0
import QtQuick.Controls 2.15

import com.company.interface 1.0
Item {
    id: cameraUI
    anchors.horizontalCenter: parent.horizontalCenter
    width: 1920
    height: 920
    visible: true


    property string platformScreen: ""
    property int buttonsPanelLandscapeWidth: 328
    property int buttonsPanelPortraitHeight: 180
    property string currentState: "PhotoCapture" // Initial state
    property bool realTimeMode: false


        Interface{
            id: myInterface
        }


        // StateGroup to manage the different states
        Item {
            id: stateGroup
            states: [
                State {
                    name: "PhotoCapture"
                    when: cameraUI.currentState === "PhotoCapture"
                    StateChangeScript {
                        script: {
                            camera.start() // Start the camera when in PhotoCapture mode
                        }
                    }
                }
            ]

            // You can also trigger state changes here with a function, for example:
            function changeState(newState) {
                cameraUI.currentState = newState;
            }
        }

        // CaptureSession to manage Camera, ImageCapture, and MediaRecorder
        CaptureSession {
            id: captureSession
            camera: Camera {
                id: camera
            }
            imageCapture: ImageCapture {
                        id: imageCapture
                        onImageCaptured: {
                            console.log("Image captured:", fileName)
                        }
            }
            recorder: MediaRecorder {
                id: recorder
                // Optionally set resolution and frame rate if required
            }
            videoOutput: viewfinder
        }

        // VideoOutput to show the live camera feed
        VideoOutput {
            id: viewfinder
            visible: true
            anchors.fill: parent
        }

        Timer {
                id: timer
            }

            function delay(delayTime, cb) {
                timer.interval = delayTime;
                timer.repeat = false;
                timer.triggered.connect(cb);
                timer.start();
            }


        Button {
            text: "Capture Image"
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                var image_path = myInterface.getAppPath() +"image.jpg";
                console.log("Saving to file path:", myInterface.getAppPath() );
                imageCapture.captureToFile(myInterface.getAppPath() +"image.jpg");
                delay(1000, function() {
                            myInterface.setImage2Filter(myInterface.getAppPath() +"image.jpg")
                        })
                ;
            }
        }

        Button {
            id: filterButton
            text: "Realtime Edge Filter"
            anchors.top: parent.top
            x:600
            onClicked: {
                if(realTimeMode === false){
                    filterButton.text = "Normal camera"
                    filterF();
                    viewfinder.visible = false;
                    myImage.visible = true;
                    myTimer2.start();
                    myTimer2.repeat = true;
                }else{
                    filterButton.text = "Realtime Edge Filter"
                    viewfinder.visible = true;
                    myImage.visible = false;
                    myTimer2.stop();
                    myTimer2.repeat = false;
                }
                realTimeMode = !realTimeMode;

            }
        }

        Timer {
            id: myTimer2
            interval: 100  // Time in milliseconds (2000 ms = 2 seconds)
            running: false   // Start the timer automatically when the app loads
            repeat: false  // Trigger the function only once
            onTriggered: {
                filterF();  // Call the function when the timer triggers
            }
        }


        // Image element to show an image from a local file
        Image {
            id: myImage
            visible: false
            source: "file:///" + myInterface.getAppPath() + "edge_image.jpg"  // Path to your image file
            y: 30
            anchors.horizontalCenter: parent.horizontalCenter
            width: 1920
            height: 980
            fillMode: Image.PreserveAspectFit  // Preserve aspect ratio
        }

        function filterF(){

            var image_path = myInterface.getAppPath() +"image.jpg";
            var edge_image_path = myInterface.getAppPath() +"edge_image.jpg";

            console.log("Saving to file path:", image_path );
            imageCapture.captureToFile(image_path);
            delay(50, function() {
                        myInterface.setImage2Filter(image_path);
                        myInterface.edgeFilter();
                        myImage.source = "";
                        myImage.source = "file:///" + edge_image_path;
                    });
        }


}
