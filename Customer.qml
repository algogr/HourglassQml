import QtQuick 2.6
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2


Pane {
    id: page

    property variant cusid: "-1"
    property variant taskcatid
    property variant cusname

        Column {
            id:c1
            spacing: 20
            anchors.horizontalCenter: parent.horizontalCenter

            ComboBox{
                id:custname1

                width:  page.availableWidth/3
                height: page.availableHeight/15

                model:customerModel2
                editable: true
                currentIndex: -1

                textRole: "name"
                font.pixelSize: 25
                onCurrentTextChanged: {

                    if (custname1.currentIndex>-1)
                    {

                        btndel.visible=true
                        btninv.visible=true
                        var indexcustomer=customerModel2.index(custname1.currentIndex,0)
                        cusid=customerModel2.data(indexcustomer)
                        tables.cusid=cusid
                        console.log("customercusid:"+cusid)
                        console.log("tablescusid:"+tables.cusid)
                        cusname=custname1.currentText
                        taskModel.setFilter("cusid="+cusid)
                        fintradecusModel.setFilter("cusid="+cusid)
                        var indexname=customerModel2.index(custname1.currentIndex,1)
                        var indexphone=customerModel2.index(currentIndex,5)
                        var indexemail1=customerModel2.index(currentIndex,2)
                        var indexemail2=customerModel2.index(currentIndex,3)
                        var indexactive=customerModel2.index(currentIndex,4)

                        phone.text=customerModel2.data(indexphone)
                        email1.text=customerModel2.data(indexemail1)
                        email2.text=customerModel2.data(indexemail2)
                        active.checked=customerModel2.data(indexactive)

                        var taskcategoryindex=customerModel2.index(custname1.currentIndex,6)

                        taskCategoriesModel1.setFilter("id="+customerModel2.data(taskcategoryindex))
                        var k=taskCategoriesModel1.index(0,1)
                        var tcie=taskCategoriesModel1.data(k);
                        taskCategoriesModel1.setFilter("")

                        taskcatcombo.currentIndex=taskcatcombo.find(tcie)




                    }



                }
            }




            CheckBox {
                id:active
                text: "Active"
                checked: true


            }

            Rectangle{
                width:  page.availableWidth/3
                height: page.availableHeight/20
                anchors.horizontalCenter: parent.horizontalCenter
                border.width: 1

            TextArea {


                id:phone
                wrapMode: TextArea.Wrap
                placeholderText: "Phone"
                anchors.fill: parent

            }
            }




            Rectangle{
                width:  page.availableWidth/3
                height: page.availableHeight/20
                anchors.horizontalCenter: parent.horizontalCenter
                border.width: 1

            TextArea {


                id:email1
                wrapMode: TextArea.Wrap
                placeholderText: "Email"
                anchors.fill: parent

            }
            }

            Rectangle{
                width:  page.availableWidth/3
                height: page.availableHeight/20
                anchors.horizontalCenter: parent.horizontalCenter
                border.width: 1

            TextArea {


                id:email2
                wrapMode: TextArea.Wrap
                placeholderText: "Extra Email"
                anchors.fill: parent

            }
            }

            ComboBox{
                id:taskcatcombo
                model:taskCategoriesModel1
                width: 150
                textRole: "descr"
                font.pixelSize: 10
                onCurrentTextChanged: {
                    var indexcatid=taskCategoriesModel1.index(currentIndex,0)
                    taskcatid=taskCategoriesModel1.data(indexcatid)




                }
            }



            Row{
                spacing: 25
            Button{
                id:btnok

                    Image {
                        anchors.fill: parent
                        source: "qrc:images/check.png"
                    }

                    onReleased: {
                        var cusname=custname1.editText
                        var rowcount=customerModel2.rowCount()
                        var row=custname1.currentIndex
                        if(row==-1)
                        {
                            row=rowcount
                            customerModel2.insertRow(rowcount);
                        }

                        var indexname=customerModel2.index(row,1)
                        var indexphone=customerModel2.index(row,5)
                        var indexemail1=customerModel2.index(row,2)
                        var indexemail2=customerModel2.index(row,3)
                        var indexactive=customerModel2.index(row,4)
                        var indexcatid=customerModel2.index(row,6)


                        console.log(taskcatid)
                        customerModel2.setData(indexname,cusname)
                        customerModel2.setData(indexphone,phone.text)
                        customerModel2.setData(indexemail1,email1.text)
                        customerModel2.setData(indexemail2,email2.text)
                        customerModel2.setData(indexactive,active.checked)
                        customerModel2.setData(indexcatid,taskcatid)


                        customerModel2.submitAll()


                        customerModel2.select()
                        customerModel.select()
                        customerModel1.select()
                        stackView.pop()
                    }

            }

            Button{
                id:btncancel


                Image {
                    anchors.fill: parent
                    source: "qrc:images/black-x-png-27.png"
                }
                onReleased: {
                    stackView.pop()
                }
            }

            Button{
                id:btndel
                visible: falseTechDistrict.qml

                //text: "Cancel"
                Image {
                    anchors.fill: parent
                    source: "qrc:images/Trash.png"
                }
                onReleased: {
                    md.visible=true
                    //customerModel2.removeRTechDistrict.qmlow(0)
                    //customerModel2.setFilter("")
                    //customerModel2.select()
                    //stackView.pop()
                }
            }

            Button{
                id:btninv
                visible: false

                //text: "Cancel"
                Image {
                    anchors.fill: parent
                    source: "qrc:images/invoice.png"
                }
                onReleased: {

                    taskModel2.select()
                    taskModel2.setFilter("invoice=0 and cusid="+cusid)
                    stackView.push("qrc:/Invoicing.qml",{cusid:cusid,custname:cusname})

                }
            }


            MessageDialog{
                id: md


                visible: false
                title:"Customer Deletion"
                modality: Qt.WindowModal
                icon: StandardIcon.Question
                text:"Current customer is going to be deleted. Is thw what you want?"
                standardButtons: StandardButton.Yes | StandardButton.No
                onYes: {
                    console.log("YES")
                    customerModel2.removeRow(0)
                    customerModel2.submitAll()
                    customerModel2.setFilter("")
                    customerModel2.select()
                    customerModel.select()
                    stackView.pop()

                }
            }


            }






    }

        CustomerTable{
            id: tables
            width: page.width-50
            height: page.height/3
            anchors.top: c1.bottom
            cusid: cusid
            onCusidChanged: {

            }

onTaskmodelidChanged: {
                stackView.push("qrc:/Task.qml",{taskid:taskmodelid})
            }



            //}


        }


Component.onCompleted: {
    custname1.currentIndex=-1

    taskModel.setFilter("cusid=-1")

    // console.log("CI:"+custname1.currentIndex)

}

onActiveFocusChanged: {
    //taskModel.setFilter("")
    //console.log("To midenisa")
}
}

