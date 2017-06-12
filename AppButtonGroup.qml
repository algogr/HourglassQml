import QtQuick 2.0
import QtQuick.Controls 1.4
Item {
    Row{
        id: buttongroup
        height:parent.height/5
        width:parent.width
        spacing: 5

        Button{
            id:bn1
            height:width
            width:parent.width/3
            tooltip: "Νέος Πελάτης"
            Rectangle{
                id: rect1

                anchors.fill: parent
                color: btrectcolornohover



            Image{
                anchors.fill: parent
                anchors.margins: 2
                source:"images/new_customer.png"
                fillMode: Image.PreserveAspectFit




            }
            }
            onHoveredChanged: {
                    if(bn1.hovered)
                        rect1.color=btrectcolorhover
                    else
                        rect1.color=btrectcolornohover




            }
            onClicked: {
                console.log("Clicked")
            }






        }

        Button{
            id:bn2
            height:width
            width:parent.width/3
            tooltip: "Προβολή Πελάτη"
            Rectangle{
                id: rect2

                anchors.fill: parent
                color: btrectcolornohover



            Image{
                anchors.fill: parent
                anchors.margins: 2
                source:"images/view_customer.png"
                fillMode: Image.PreserveAspectFit




            }
            }
            onHoveredChanged: {
                    if(bn2.hovered)
                        rect2.color=btrectcolorhover
                    else
                        rect2.color=btrectcolornohover




            }
            onClicked: {
                console.log("Clicked")
            }






        }







    }

}
