import QtQuick 2.0

Item {
    property int dwidth: 10
    property int dheight: 10
    property string dbgcolor: "blue"
    property string dbgcoloronhover: "white"
    property string dtext: ""
    signal dblClicked
    width:dwidth
    height: dheight
    id:root


    Rectangle{
        //anchors.fill:parent
        height:parent.height
        width:parent.width
        color: mousearea.containsMouse? dbgcoloronhover:dbgcolor

        Text{
            height:parent.height
            width:parent.width
            text:dtext
            font.pixelSize: 15
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            //anchors.horizontalCenter: parent.horizontalCenter
            //anchors.verticalCenter: parent.verticalCenter
        }
        MouseArea{
            id: mousearea
            //anchors.fill: parent
            height:parent.height
            width:parent.width
            hoverEnabled: true
            onDoubleClicked: root.dblClicked
        }

    }
}
