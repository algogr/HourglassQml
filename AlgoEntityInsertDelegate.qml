
import QtQuick 2.7
import QtQuick.Controls 1.4
import SqlQueryModel 1.0

Item {
    id: root
    width: parent.width
    //height: 58
    property alias dlgheight: root.height
    property alias name: textitem.text
    property alias color: textitem.color
    //property alias attr1: textedit.text
    property alias color1: textedit.color
    property alias teditvisible: textedit.visible
    property alias combovisible: combo.visible
    property variant combomodel
    property string combofield
    property string selecteddoy
    property string selectedvatstatus

    signal editclicked
    //signal doychanged(string doytext)
    Rectangle {
        anchors.fill: parent
        color: mainwindow.bgcolor
        //visible: mouse.pressed
    }

    Text {
        id: textitem
        //color: mainwindow.fgcolor
        font.pixelSize: parent.width/32
        width:parent.width/3
        text: modelData
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        //anchors.right: textitem1.left
        anchors.leftMargin: 30
    }
    Rectangle{
        id: textedit
        width:parent.width/2
        height: root.height
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: textitem.right
        border.width: 10
        border.color: mainwindow.bgcolor
        //anchors.right: img.left
        color:mainwindow.bgcolor
        anchors.leftMargin: 10
    TextEdit {
        id: texteditvalue
        anchors.leftMargin: 15
        //color: mainwindow.fgcolor
        font.pixelSize: parent.width/15
         anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.NoWrap
        onTextChanged: text_values()


    }
    ComboBox{
        id:combo
        //color:mainwindow.fgcolor
        //font.pixelSize: root.height/25
        //editable:true
        anchors.fill: parent
        anchors.leftMargin: 5
        anchors.topMargin: 5
        model:root.combomodel
        textRole: root.combofield
        onCurrentTextChanged: combo_values()
    }

    }

    SqlQueryModel{
        id:model
    }

    Component.onCompleted: {
        combo_values()

    }
    function combo_values()
    {
        if (modelData.relatedentity=="VatStatus")
        {

            customernew.vatstatuschanged(combo.currentText)

        }
        if (modelData.relatedentity=="Doy")
        {

            customernew.doychanged(combo.currentText)

        }
    }

    function text_values()
    {
        switch (modelData.fieldname)
        {
        case "name":
            customernew.name=texteditvalue.text
            break;
        case "title":
            customernew.title=texteditvalue.text
            break;
        case "address":
            customernew.address=texteditvalue.text
            break;
        case "district":
            customernew.district=texteditvalue.text
            break;
        case "city":
            customernew.city=texteditvalue.text
            break;
        case "afm":
            customernew.afm=texteditvalue.text
            break;
        case "occupation":
            customernew.occupation=texteditvalue.text
            break;
        case "tel1":
            customernew.tel1=texteditvalue.text
            break;
        case "tel2":
            customernew.tel2=texteditvalue.text
            break;
        case "fax":
            customernew.fax=texteditvalue.text
            break;
        case "email":
            customernew.email=texteditvalue.text
            break;
        case "comments":
            customernew.comments=texteditvalue.text
            break;
        }

    }

}
