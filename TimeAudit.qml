import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Controls.Universal 2.1
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4




Item {
   property bool caught: false
   property date starttime
   property date endtime
   property variant now: new Date()
   property variant cusid
   property variant cusemail
   property variant  cusphone
    property variant taskcatid
   property alias cusname: custname.currentText

    Rectangle{
        anchors.fill: parent
        border.width: 1
        border.color: "orange"



        RowLayout{
            anchors.fill: parent
            anchors.margins: 5
            spacing: 50


            ColumnLayout{
               //anchors.fill: parent
                spacing: 10
                width: parent.width/3

                CheckBox{
                    id:place
                    checked: false
                    text: "Εκτός"
                    //font.pixelSize:  25



                }
                RowLayout{
                        width:parent.width
                Button{
                    id:btnphone
                    visible: true
                    Layout.preferredWidth: 50

                    //text: "Cancel"
                    Image {
                        anchors.fill: parent
                        source: "qrc:images/phone.png"
                    }
                    onReleased: {

                        dialer.dial(cusphone)

                    }
                }
                ComboBox{
                    id:taskcatcombo
                    model:taskCategoriesModel
                    Layout.preferredWidth: 150
                    currentIndex: -1
                    textRole: "descr"
                    font.pixelSize: 10
                    onCurrentTextChanged: {
                        var indexcatid=taskCategoriesModel.index(currentIndex,0)
                        taskcatid=taskCategoriesModel.data(indexcatid)
                        console.log("catid="+taskcatid)

                    }
                }
                }

                ComboBox{
                    id:custname

                    model:customerModel
                    Layout.preferredWidth: 250
                    Layout.preferredHeight: 50
                    currentIndex: -1

                    textRole: "name"
                    font.pixelSize: 25
                    onCurrentTextChanged: {
                        var indexcustomer=customerModel.index(custname.currentIndex,0)
                         cusid=customerModel.data(indexcustomer)
                        var indexmail=customerModel.index(custname.currentIndex,2)
                         cusemail=customerModel.data(indexmail)
                        var indexphone=customerModel.index(custname.currentIndex,5)
                        cusphone=customerModel.data(indexphone)


                        var taskcategoryindex=customerModel.index(custname.currentIndex,6)

                        taskCategoriesModel.setFilter("id="+customerModel.data(taskcategoryindex))
                        var k=taskCategoriesModel.index(0,1)
                        var tcie=taskCategoriesModel.data(k);
                        taskCategoriesModel.setFilter("")
                        place.checked=false
                        taskcatcombo.currentIndex=taskcatcombo.find(tcie)
                    }
                }

            }

            Clock {
                id: clock
                Layout.preferredWidth: 150
                Layout.preferredHeight:  150
                hours: now.getHours()
                minutes: now.getMinutes()
                seconds: now.getSeconds()

                MouseArea {
                    id:ma1
                    anchors.fill: parent
                    //enabled: false






                        onDoubleClicked:

                         {http://www.frontpages.gr/
                            if (custname.currentIndex==-1)
                                return

                            if (clock.active){

                                clock.hourshand=true
                                clock.faceimg="images/face.png"
                                clock.active=false

                                now = new Date()
                                timetext.text=""
                                endtime=new Date();


                            if(mail.checked)
                            {
                                var startminutes=starttime.getMinutes()<10?"0"+starttime.getMinutes():(starttime.getMinutes())
                                var endminutes=endtime.getMinutes()<10?"0"+endtime.getMinutes():(endtime.getMinutes())
                                taskEmail.setTo(cusemail)
                                taskEmail.setToName(cusemail)
                                taskEmail.setTitle("Task(s) completed!")
                                var b1="Ολοκληρώθηκαν οι κάτωθι εργασίες:<br><br>"
                                var b2="<B>"+commenttext.text+"</B><br><br>"
                                var b3="'<B>Έναρξη: "+starttime.getDate()+"-"+(starttime.getMonth()+1)+"-"+starttime.getFullYear()+" " +starttime.getHours()+":"+startminutes+"</B><br><br>"
                                var b4="<B>Λήξη: "+endtime.getHours()+":"+endminutes+"</B><br><br>"
                                var b5="<B>Διαρκεια: "+Math.round(((endtime-starttime % 86400000) % 3600000) / 60000)+"'</B><br><br>"
                                var b6= place.checked===true?"<B>Οι εργασίες πραγματοποιήθηκαν στο χώρο σας</B><br><br>":"<B>Οι εργασίες πραγματοποιήθηκαν με απομακρυσμένη σύνδεση</B><br><br>"
                                taskEmail.setBody(b1+b2+b3+b4+b5+b6)
                                taskEmail.send()

                             }

                                var rowcount=tasksTableModel.rowCount()

                                tasksTableModel.insertRow(rowcount);

                                var indexcustomer=tasksTableModel.index(rowcount,1)
                                var indexplace=tasksTableModel.index(rowcount,2)
                                var indexcomment=tasksTableModel.index(rowcount,4)
                                var indexstart=tasksTableModel.index(rowcount,5)
                                var indexend=tasksTableModel.index(rowcount,6)
                                var indexinvoice=tasksTableModel.index(rowcount,8)
                                var indexcatid=tasksTableModel.index(rowcount,9)



                                var tod=new Date()
                                tasksTableModel.setData(indexcustomer,cusid)
                                tasksTableModel.setData(indexplace,place.checked)
                                tasksTableModel.setData(indexcomment,commenttext.text)
                                tasksTableModel.setData(indexstart,starttime)
                                tasksTableModel.setData(indexend,endtime)
                                tasksTableModel.setData(indexinvoice,0)
                                if(taskcatid)
                                {
                                    tasksTableModel.setData(indexcatid,taskcatid)
                                }
                                else
                                {
                                    tasksTableModel.setData(indexcatid,1)
                                }

                                tasksTableModel.submitAll()
                                 console.log("catid="+taskcatid)


                                taskModel.select()
                                viewModel.select()
                                custname.enabled=true


                            }
                            else
                            {
                                clock.faceimg="images/face1.png"
                                clock.hourshand=false
                                clock.active=true
                                clock.seconds=0;
                                starttime=new Date()
                                custname.enabled=false
                            }

                        }




                }

                Timer {
                    id: clockUpdater
                    interval: 1000 // update clock every second
                    running: true
                    repeat: true

                    onTriggered: {
                        if(clock.active)
                        {

                            clock.seconds+=1
                            clock.minutes=clock.seconds/60
                            var diff=new Date()-starttime
                            var hours=Math.floor(diff/3600000)

                            var minutes=Math.floor(diff/60000)

                            var seconds=Math.floor(diff/1000)

                            if (hours<10)
                            {
                                hours="0"+hours
                            }
                            if (hours>0)
                            {
                                minutes=minutes-(hours*60)
                            }

                            if (minutes<10)
                            {
                                minutes="0"+minutes
                            }

                            if (minutes>0)
                            {
                                seconds=seconds-(minutes*60)
                            }


                            if (seconds<10)
                            {
                                seconds="0"+seconds
                            }


                            timetext.text=hours+":"+minutes+":"+seconds

                        }
                        else
                        {

                        now = new Date()
                        clock.hours= Math.round(now.getHours())
                        clock.minutes= now.getMinutes()
                        clock.seconds= now.getSeconds()

                        }
                    }
                }





            }

            ColumnLayout{
                Layout.fillHeight: true
                spacing:25
                Rectangle{
                    Layout.preferredWidth: 150
                    Layout.preferredHeight: 40
                    border.width: 1
                TextArea {
                    id:commenttext
                    anchors.fill: parent
                    focus: true
                    wrapMode: Text.WordWrap
                    text: ""



                }
                }




                Text{
                    id:timetext
                    text:"00:00"
                    Layout.preferredWidth: 50
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 25

                }

                CheckBox{
                    id:mail
                    text:"AutoEmail"
                    checked: true
                }

            }
        }
}
}



