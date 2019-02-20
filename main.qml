import QtQuick 2.9
import Qt.labs.lottieqt 1.0
import QtQuick.Window 2.2

Window {
    visible: true
    width: 640
    height: 680
    title: qsTr("Qt Lottie Sampler")

    Rectangle {
        id: bgColor
        color: "#0becca"
        anchors.top: jfcom.bottom
        anchors.bottom: controller.top
        width: parent.width
        LottieAnimation {
            id: lottie
            anchors.centerIn: parent
            scale: Math.min(parent.height/height, parent.width/width)
            quality: LottieAnimation.HighQuality
        }
    }

    // This needs to appear above the animation, in case the animation fails.
    JsonFileComboManager {
        id: jfcom
        anchors.left: parent.left
        anchors.right: parent.right

        onFileSelected: {
            lottie.source = finder.directory + "/" + filename
        }
    }

    LottieController {
        id: controller
        anchors.bottom: parent.bottom
        width: parent.width
        height: 85
        lottie: lottie
        onChangeBackgroundColor: {
            bgColor.color = color
        }
    }
}
