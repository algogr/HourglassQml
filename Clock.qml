import QtQuick 2.6


// An analog clock that shows hours, minutes and seconds.
Rectangle {
    id: root
    //width: 20 // acts as minimum width
    //height: 20 // acts as minimum height

    // public:
    property int hours:   0
    property int minutes: 0
    property int seconds: 0
    property alias hourshand : shorthand.visible
    property alias minuteshand: longhand.visible
    property alias secondshand: thinhand.visible
    property bool active : false
    property alias faceimg: face.source



    // private:
    Item {
        id: impl
        anchors.fill: parent
        MouseArea {
            id: mousearea
            anchors.fill: parent

        }


        Image {
            id: face
            source: "images/face.png"
            scale: Image.PreserveAspectFit
            anchors.fill: parent


            Image {
                id: shorthand
                source: "images/shorthand.png"
                smooth: true
                rotation: (root.hours * 30)+(root.minutes *0.5)
                scale: Image.PreserveAspectFit
                anchors.fill: parent
            }

            Image {
                id: longhand
                source: "images/longhand.png"
                smooth: true
                rotation: root.minutes * 6
                scale: Image.PreserveAspectFit
                anchors.fill: parent
            }

            Image {
                id: thinhand
                source: "images/thinhand.png"
                smooth: true
                rotation: root.seconds * 6
                scale: Image.PreserveAspectFit
                anchors.fill: parent
            }

            Image {
                id: center
                source: "images/knob.png"
                scale: Image.PreserveAspectFit
                anchors.fill: parent
            }
        }

    }

}

