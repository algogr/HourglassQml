import QtQuick 1.0

// An analog clock that shows hours, minutes and seconds.
Rectangle {
    id: root
    width: 262 // acts as minimum width
    height: 262 // acts as minimum height

    // public:
    property int hours:   0
    property int minutes: 0
    property int seconds: 0

    // private:
    Item {
        id: impl

        Image {
            id: face
            source: "images/face.png"

            Image {
                id: shorthand
                source: "images/shorthand.png"
                smooth: true
                rotation: root.hours * 30
            }

            Image {
                id: longhand
                source: "images/longhand.png"
                smooth: true
                rotation: root.minutes * 6
            }

            Image {
                id: thinhand
                source: "images/thinhand.png"
                smooth: true
                rotation: root.seconds * 6
            }

            Image {
                id: center
                source: "images/knob.png"
            }
        }
    }
}
