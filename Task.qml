
import QtQuick 2.6
import QtQuick.Controls 2.1
import Qt.labs.calendar 1.0

Pane {
    id: page

    property variant taskid: "0"
    property variant cusid: "0"
    property variant custemail
    property variant taskcatid
    property date taskDateStart: new Date()
    property date taskDateEnd: new Date()
        Column {
            spacing: 20
            anchors.horizontalCenter: parent.horizontalCenter
            ComboBox{
                id:custname1

                model:customerModel
                width:250
                textRole: "name"
                font.pixelSize: 25
                onCurrentTextChanged: {
                    var indexcustomer=customerModel.index(custname1.currentIndex,0)
                     cusid=customerModel.data(indexcustomer)


                }
            }



            TextField{
                id:startdate
                //inputMask: "DD-DD-DDDD"
                placeholderText: "Ημερομηνία"
                text: extractfromdate(taskDateStart,1)+"-"+extractfromdate(taskDateStart,2)+"-"+extractfromdate(taskDateStart,3)
                validator:
                    RegExpValidator{regExp: /^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$/
                }

                onPressAndHold: {
                    algocal.visible=true
                }


                }



            AlgoCalendar {
                   id: algocal
                   visible: false
                   z:3

                   onSeldateChanged: {

                       startdate.text=extractfromdate(seldate,1)+"-"+extractfromdate(seldate,2)+"-"+extractfromdate(seldate,3);
                   }


               }



            Label {
                width: parent.width
                wrapMode: Label.Wrap
                horizontalAlignment: Qt.AlignHCenter
                text: "Έναρξη"
            }
            Row{
                width: parent.width
                height: 50
                spacing: 20

            SpinBox {
                id: hour1
                editable: true
                from: 0
                to: 23
                stepSize: 1
                value: extractfromdate(taskDateStart,4)


                validator: IntValidator {
                        locale: hour1.locale.name
                        bottom: Math.min(hour1.from, hour1.to)
                        top: Math.max(hour1.from, hour1.to)
                    }
                textFromValue: function(value,locale)
                {
                    if (value<10)
                        return "0"+value
                    else
                        return value

                               }
                onValueChanged: {
                    var vdate=datefromstring(startdate.text)
                    taskDateStart=new Date(extractfromdate(vdate,31),extractfromdate(vdate,2),extractfromdate(vdate,1),hour1.value,minute1.value)
                }


            }
            SpinBox {
                id: minute1
                editable: true
                from: 0
                to: 59
                stepSize: 1
                value: extractfromdate(taskDateStart,5)
                validator: IntValidator {
                        locale: minute1.locale.name
                        bottom: Math.min(minute1.from, minute1.to)
                        top: Math.max(minute1.from, minute1.to)
                    }
                textFromValue: function(value,locale)
                {

                    if (value<10)
                        return "0"+value
                    else
                        return value

                               }
                onValueChanged: {
                    var vdate=datefromstring(startdate.text)
                    taskDateStart=new Date(extractfromdate(vdate,3),extractfromdate(vdate,2),extractfromdate(vdate,1),hour1.value,minute1.value)
                    console.log(taskDateStart)
                }
            }
            }


            Label {
                width: parent.width
                wrapMode: Label.Wrap
                horizontalAlignment: Qt.AlignHCenter
                text: "Λήξη"
            }
            Row{
                width: parent.width
                height: 50
                spacing: 20

            SpinBox {
                id: hour2
                editable: true
                from: 0
                to: 23
                stepSize: 1
                value: extractfromdate(taskDateEnd,4)
                validator: IntValidator {
                        locale: hour2.locale.name
                        bottom: Math.min(hour2.from, hour2.to)
                        top: Math.max(hour2.from, hour2.to)
                    }
                textFromValue: function(value,locale)
                {
                    if (value<10)
                        return "0"+value
                    else
                        return value

                               }
                onValueChanged: {
                    var vdate=datefromstring(startdate.text)
                    taskDateEnd=new Date(extractfromdate(vdate,3),extractfromdate(vdate,2),extractfromdate(vdate,1),hour2.value,minute2.value)
                }


            }
            SpinBox {
                id: minute2
                editable: true
                from: 0
                to: 59
                stepSize: 1
                value: extractfromdate(taskDateEnd,5)
                validator: IntValidator {
                        locale: minute2.locale.name
                        bottom: Math.min(minute2.from, minute2.to)
                        top: Math.max(minute2.from, minute2.to)
                    }
                textFromValue: function(value,locale)
                {
                    if (value<10)
                        return "0"+value
                    else
                        return value

                               }
                onValueChanged: {
                    var vdate=datefromstring(startdate.text)
                    taskDateEnd=new Date(extractfromdate(vdate,3),extractfromdate(vdate,2),extractfromdate(vdate,1),hour2.value,minute2.value)
                    console.log("7:"+taskDateEnd)
                }
            }
            }

            CheckBox {
                id:place
                text: "Εκτός"
                checked: false
            }

            ComboBox{
                id:taskcatcombo
                model:taskCategoriesModel
                width: 150
                textRole: "descr"
                font.pixelSize: 10
                onCurrentTextChanged: {
                    var indexcatid=taskCategoriesModel.index(currentIndex,0)
                    taskcatid=taskCategoriesModel.data(indexcatid)
                    console.log("catid="+taskcatid)

                }
            }



            Rectangle{
                width:  page.availableWidth/3
                height: page.availableHeight/10
                anchors.horizontalCenter: parent.horizontalCenter
                border.width: 1

            TextArea {


                id:comment
                wrapMode: TextArea.Wrap
                placeholderText: "Σχόλια"
                anchors.fill: parent
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
                        var rowcount=tasksTableModel.rowCount()
                        var row=0
                        if(taskid==0)
                        {
                            row=rowcount
                            tasksTableModel.insertRow(rowcount);
                        }


                        var indexcustomer=tasksTableModel.index(row,1)
                        var indexplace=tasksTableModel.index(row,2)
                        var indexcomment=tasksTableModel.index(row,4)
                        var indexstart=tasksTableModel.index(row,5)
                        var indexend=tasksTableModel.index(row,6)
                        var indexinvoice=tasksTableModel.index(row,8)
                        var indexcatid=tasksTableModel.index(row,9)

                        //var starttime= new Date(reverseString(startdate.text)+"T"+hour1.value+":"+minute1.value+":00Z")
                        var starttime= reverseStringtoDate(startdate.text)+" "+hour1.value+":"+minute1.value

                        //var endtime= new Date(reverseStringtoDate(startdate.text)+","+hour2.value+","+minute2.value)
                        var endtime= reverseStringtoDate(startdate.text)+" "+hour2.value+":"+minute2.value
                        console.log(endtime)

                        tasksTableModel.setData(indexcustomer,cusid)
                        tasksTableModel.setData(indexplace,place.checked)
                        tasksTableModel.setData(indexcomment,comment.text)
                        tasksTableModel.setData(indexstart,starttime)
                        tasksTableModel.setData(indexend,endtime)
                        tasksTableModel.setData(indexinvoice,0)
                        tasksTableModel.setData(indexcatid,taskcatid)
                        tasksTableModel.submitAll()

                        tasksTableModel.setFilter("")

                        taskModel.select()
                        viewModel.select()
                        stackView.pop()
                    }

            }

            Button{
                id:btncancel

                //text: "Cancel"
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
                visible: false

                //text: "Cancel"
                Image {
                    anchors.fill: parent
                    source: "qrc:images/Trash.png"
                }
                onReleased: {
                    tasksTableModel.removeRow(0)
                    tasksTableModel.setFilter("")
                    taskModel.select()
                    stackView.pop()
                }
            }

            Button{
                id:btnmail
                visible: false

                //text: "Cancel"
                Image {
                    anchors.fill: parent
                    source: "qrc:images/mail.png"
                }
                onReleased: {

                    taskEmail.setTo(custemail)
                    taskEmail.setToName(custemail)
                    taskEmail.setTitle("Task(s) completed!")
                    var b1="Ολοκληρώθηκαν οι κάτωθι εργασίες:<br><br>"
                    var b2="<B>"+comment.text+"</B><br><br>"
                    var b3="'<B>Έναρξη: "+startdate.text+" "+hour1.value.toString()+":"+minute1.value.toString()+"</B><br><br>"
                    var b4="<B>Λήξη: "+hour2.value.toString()+":"+minute2.value.toString()+"</B><br><br>"
                    var b5="<B>Διαρκεια: "+Math.round(((taskDateEnd-taskDateStart % 86400000) % 3600000) / 60000)+"'</B><br><br>"
                    var b6= place.checked=true?"<B>Οι εργασίες πραγματοποιήθηκαν στο χώρο σας</B><br><br>":"<B>Οι εργασίες πραγματοποιήθηκαν με απομακρυσμένη σύνδεση</B><br><br>"
                    taskEmail.setBody(b1+b2+b3+b4+b5+b6)
                    taskEmail.send()
                    stackView.pop()
                }
            }

            }


}

function extractfromdate(date,comp){
 var h=date
 var t
    if (comp==1)
         t=h.getDate();
    if (comp==2)
         t=h.getMonth()+1;
    if (comp==3)
         t=h.getFullYear()
    if (comp==4)
         t=h.getHours();
    if (comp==5)
         t=h.getMinutes();

    if (t<10)
        t="0"+t

    return t;


}

function reverseStringtoDate(str) {
    return str.split("-").reverse().join(",");
}

function datefromstring(str)
{
    var arrstr=str.split("-")
    var day=parseInt(arrstr[0])
    var month=parseInt(arrstr[1])
    var year=parseInt(arrstr[2])
    console.log("d:"+day)
    console.log("m:"+month)
    console.log("y:"+year)
    var cdate=new Date(year,month-1,day)
    console.log(cdate)
    return cdate
}

Component.onCompleted: {

    if (taskid>0)
    {
        btndel.visible=true
        btnmail.visible=true

        tasksTableModel.select()

        tasksTableModel.setFilter("id="+taskid)

        var placeindex=tasksTableModel.index(0,2)
        var commentindex=tasksTableModel.index(0,4)
        var startindex=tasksTableModel.index(0,5)
        var endindex=tasksTableModel.index(0,6)
        var customerindex=tasksTableModel.index(0,1)
        var taskcategoryindex=tasksTableModel.index(0,9)
        customerModel1.setFilter("id="+tasksTableModel.data(customerindex))
        var i=customerModel1.index(0,1)
        var j=customerModel1.index(0,2)
        var cusname=customerModel1.data(i);
        custemail=customerModel1.data(j)
        customerModel.setFilter("")
        taskDateStart=tasksTableModel.data(startindex)
        taskDateEnd=tasksTableModel.data(endindex)
        hour1.value=tasksTableModel.data(startindex).getHours()
        minute1.value=tasksTableModel.data(startindex).getMinutes()
        hour2.value=tasksTableModel.data(endindex).getHours()
        minute2.value=tasksTableModel.data(endindex).getMinutes()
        startdate.text=extractfromdate(tasksTableModel.data(startindex),1)+"-"+extractfromdate(tasksTableModel.data(startindex),2)+"-"+extractfromdate(tasksTableModel.data(startindex),3)

        taskCategoriesModel.setFilter("id="+tasksTableModel.data(taskcategoryindex))
        var k=taskCategoriesModel.index(0,1)
        var tcie=taskCategoriesModel.data(k);
        taskCategoriesModel.setFilter("")

        custname1.currentIndex=custname1.find(cusname,Qt.MatchExactly)
        taskcatcombo.currentIndex=taskcatcombo.find(tcie)





        place.checked=tasksTableModel.data(placeindex)
        comment.text=tasksTableModel.data(commentindex)


    }

}
}

