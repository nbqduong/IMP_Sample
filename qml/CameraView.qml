import QtQuick 2.15
import QtMultimedia 6.0
import QtQuick.Controls 2.15

import com.company.interface 1.0
Item {
    id: cameraUI
    anchors.horizontalCenter: parent.horizontalCenter
    width: 1920
    height: 980
    visible: true


        property string platformScreen: ""
        property int buttonsPanelLandscapeWidth: 328
        property int buttonsPanelPortraitHeight: 180
        property string currentState: "PhotoCapture" // Initial state


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
            anchors.bottom: parent.bottom
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
}
