import QtQuick 2.0
import QtQuick.Controls 2.5
import Qt.labs.lottieqt 1.0

Item {

    Rectangle {
        anchors.fill: parent
        color: "#c0c0c0"
    }

    signal changeBackgroundColor(string color)
    property LottieAnimation lottie

    Slider {
        id: slider
        anchors.top: parent.top
        width: parent.width
        from: lottie.startFrame
        to: lottie.endFrame
        onValueChanged: lottie.gotoAndStop(Math.round(value))
        // Current version of QtLottie doesn't expose the frame number.
        // set the slider straight back to 0. TODO connect it up better
        // to move with the animation.
        Connections {
            target: lottie
            onSourceChanged: {
                slider.value = 0
            }
        }
    }

    Row {
        width: parent.width
        height: 40
        anchors.top: slider.bottom
        spacing: 10

        Button {
            width: 50
            text: "\u25B6"
            onClicked: {
                lottie.gotoAndPlay(0)
            }
        }
        Button {
            width: 50
            text: "\u25A0"
            onClicked: lottie.stop()
        }

        Text {
            text: "Frame Rate:"
            anchors.verticalCenter: parent.verticalCenter
        }
        TextField {
            width: 50
            validator: IntValidator { bottom: 1; top: 120 }
            text: lottie.frameRate
            onTextEdited: lottie.frameRate = text
        }
        Text {
            text: "Background:"
            anchors.verticalCenter: parent.verticalCenter
        }
        ComboBox {
            model: ["black", "white"]
            onCurrentTextChanged: changeBackgroundColor(currentText)
        }
        Text {
            visible: 0 !== slider.value
            text: qsTr("Frame: ") + Math.round(slider.value) + "/" + lottie.endFrame
        }
    }
}
