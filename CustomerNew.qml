import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Item {
    property alias cusname: name.text
    Column{
        spacing: 5

        TextField{

            placeholderText: "Επωνυμία"
            id: name
            style: TextFieldStyle {
                    textColor: "black"
                    background: Rectangle {
                        radius: 2
                        implicitWidth: 500
                        implicitHeight: 24
                        border.color: "#333"
                        border.width: 1
                    }
                }

        }


        TextField{

            placeholderText: "Email Εργασιών"
            style: TextFieldStyle {
                    textColor: "black"
                    background: Rectangle {
                        radius: 2
                        implicitWidth: 200
                        implicitHeight: 24
                        border.color: "#333"
                        border.width: 1
                    }
                }

        }
        TextField{

            placeholderText: "Email Τιμολόγησης"
            style: TextFieldStyle {
                    textColor: "black"
                    background: Rectangle {
                        radius: 2
                        implicitWidth: 200
                        implicitHeight: 24
                        border.color: "#333"
                        border.width: 1
                    }
                }

        }

        TextField{

            placeholderText: "Τηλεφωνο"
            style: TextFieldStyle {
                    textColor: "black"
                    background: Rectangle {
                        radius: 2
                        implicitWidth: 200
                        implicitHeight: 24
                        border.color: "#333"
                        border.width: 1
                    }
                }

        }
    }
}
