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
        onValueChanged: lottie.gotoAndStop(value)
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
                var where = checkBox.checked ? lottie.endFrame : 0
                lottie.gotoAndPlay(where)
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
            text: "Reverse:"
            anchors.verticalCenter: parent.verticalCenter
        }
        CheckBox {
            id: checkBox
            checked: lottie.direction === LottieAnimation.Reverse
            onCheckedChanged: {
                if (checked) {
                    lottie.direction = LottieAnimation.Reverse
                }
                else {
                    lottie.direction = LottieAnimation.Forward
                }
            }
        }
        Text {
            text: "Background:"
            anchors.verticalCenter: parent.verticalCenter
        }
        ComboBox {
            model: ["black", "white"]
            onCurrentTextChanged: changeBackgroundColor(currentText)
        }
    }
}
