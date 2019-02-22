import QtQuick 2.0
import QtQuick.Controls 2.3
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.3

import Qt.labs.lottieqt 1.0

RowLayout {
    id: root

    signal fileSelected(string filename);

    height: 80

    //    Button {
    //        Layout.alignment: Qt.AlignTop
    //        text: qsTr("Scan")

    //        onClicked: {
    //            finder.scan()
    //        }
    //    }
    Item {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Column {
            anchors.left: parent.left
            anchors.right: parent.right
            RowLayout {
                anchors.left: parent.left
                anchors.right: parent.right
                TextField {
                    Layout.fillWidth: true;
                    text: finder.directory
                    onTextChanged: {
                        finder.setDirectory(text)
                    }
                }
                Button {
                    text: qsTr("...")
                    onClicked: fileDialog.open()
                }
            }
            Item {
                width: parent.width
                height: parent.height/2
                Item {
                    anchors.left: parent.left
                    anchors.top: parent.top
                    height: parent.height
                    width: parent.width * 0.3
                    Text {
                        id: deleteText
                        anchors.centerIn: parent
                        text: qsTr("Delete")
                    }

                    LottieAnimation {
                        id: deleteAnimation
                        anchors.centerIn: parent
                        scale: 0.5
                        autoPlay: false
                        // Animation 'Error Cross' by Rodrigo Bernardi
                        // from https://lottiefiles.com/3932-error-cross
                        source: ":/3932-error-cross.json"
                        onFinished: {
                            deleteText.visible = true
                            gotoAndStop(0)
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            finder.deleteFile(comboBox.currentText)
                            deleteText.visible = false
                            deleteAnimation.gotoAndPlay(0)
                        }
                    }

                }

                ComboBox {
                    id: comboBox
                    anchors.right: parent.right
                    width: parent.width/1.5
                    model: finder.model
                    onCurrentTextChanged: {
                        root.fileSelected(currentText)
                    }
                    LottieAnimation {
                        id: tickAnimation
                        anchors.centerIn: parent
                        scale: 0.25
                        quality: LottieAnimation.HighQuality
                        autoPlay: false
                        loops: 1
                        // Animation 'Loading Checkmark' by Baris
                        // from https://lottiefiles.com/4319-first-lottie
                        source: ":/4319-first-lottie.json"
                        Connections {
                            target: finder
                            onModelChanged: {
                                tickAnimation.gotoAndPlay(0)
                                animationHideTimer.start()
                            }
                        }
                        Timer {
                            id: animationHideTimer
                            interval: 2200
                            onTriggered: tickAnimation.gotoAndStop(0)
                        }
                    }
                }
            }

        }
    }


FileDialog {
    id: fileDialog
    title: qsTr("Please select a directory")
    folder: finder.directory
    selectFolder: true
    selectMultiple: false
    onAccepted: {
        var dir = String(fileUrl)
        if (dir.startsWith("file://")) {
            dir = dir.slice(7)
        }
        finder.directory = dir
        finder.scan()
    }
}
}
