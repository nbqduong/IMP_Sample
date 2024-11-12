import QtQuick 2.15
import QtMultimedia 6.0
import QtQuick.Controls 2.15

import com.company.test 1.0

Window {
    id: cameraUI
    width: 800
    height: 480
    color: "black"
    visible: true

    property string platformScreen: ""
    property int buttonsPanelLandscapeWidth: 328
    property int buttonsPanelPortraitHeight: 180
    property string currentState: "PhotoCapture" // Initial state

    Test{
        id: test
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
            },
            State {
                name: "PhotoPreview"
                when: cameraUI.currentState === "PhotoPreview"
                // Logic for photo preview
            },
            State {
                name: "VideoCapture"
                when: cameraUI.currentState === "VideoCapture"
                StateChangeScript {
                    script: {
                        camera.start() // Start camera for video capture
                    }
                }
            },
            State {
                name: "VideoPreview"
                when: cameraUI.currentState === "VideoPreview"
                StateChangeScript {
                    script: {
                        camera.stop() // Stop camera for video preview
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
        visible: (cameraUI.currentState === "PhotoCapture" || cameraUI.currentState === "VideoCapture")
        anchors.fill: parent
    }

    // Control Layout for the buttons (Mobile or Desktop UI)
    Item {
        id: controlLayout
        width: cameraUI.width
        height: cameraUI.height

        readonly property bool isMobile: Qt.platform.os === "android" || Qt.platform.os === "ios"
        readonly property bool isLandscape: Screen.desktopAvailableWidth >= Screen.desktopAvailableHeight

        property int buttonsWidth: controlLayout.state === "MobilePortrait" ? Screen.desktopAvailableWidth / 3.4 : 114

        states: [
            State {
                name: "MobileLandscape"
                when: controlLayout.isMobile && controlLayout.isLandscape
            },
            State {
                name: "MobilePortrait"
                when: controlLayout.isMobile && !controlLayout.isLandscape
            },
            State {
                name: "Other"
                when: !controlLayout.isMobile
            }
        ]

        onStateChanged: {
            console.log("State: " + controlLayout.state)
        }

        // Rectangle for buttons or other controls at the bottom of the window
        Rectangle {
            width: controlLayout.buttonsWidth
            height: controlLayout.isMobile ? cameraUI.height / 5 : 60
            color: "grey"
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    // Button to capture the image
    Button {
        text: "Capture Image"
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: {

                    console.log("Saving to file path:", test.mData);

                    imageCapture.captureToFile(test.mData);

        }
    }

}
