import QtQuick 2.0
import QtQuick.Controls 2.0
SwipeView {
    id: swipeView
    anchors.fill: parent
    currentIndex: tabBar.currentIndex

    Item{
        Column{
            width: parent.width*3/4
            height: parent.height
            id:dndcolumn
            property int dropareax: 0
            property int dropareay: 0
            property int dragstartx: 0
            property int dragstarty: 0
            property int dragsourceheight:0
            property int globalz: 0



            Rectangle{
                id: mainView
                width: parent.width
                height: parent.height*2/5


                ChartView{
                    id: dataView
                    anchors.bottom: parent.bottom
                    width: parent.width
                    height: parent.height



                    BarSeries {
                        id:testChart

                        //anchors.top: parent.top
                        //width: dataView.width
                        //height: dataView.height
                        //theme: themeIsabelle
                        //shadowQuality: AbstractGraph3D.ShadowQualitySoftLow
                        /*
            axisX: BarCategoryAxis { categories: ["2007", "2008", "2009", "2010", "2011", "2012" ] }
                    BarSet { label: "Bob"; values: [2, 2, 3, 4, 5, 6] }
                    BarSet { label: "Susan"; values: [5, 1, 2, 4, 1, 7] }
                    BarSet { label: "James"; values: [3, 5, 8, 13, 5, 8] }
*/



                        VBarModelMapper {
                            model: viewModel

                            // QAbstractItemModel derived implementation
                            firstBarSetColumn: 2
                            lastBarSetColumn: 2
                            firstRow: 1
                        }


                        /*

                ItemModelBarDataProxy{
                    itemModel: seriesdata.model
                    rowRole: "xPos"
                    columnRole: "yPos"
                    valueRole: "zPos"
                }
*/
                    }
                }




            }



            Rectangle{
                id: timeaudit
                property bool caught: false
                property date starttime
                property date endtime
                width: parent.width
                height: parent.height*1/5
                border.color: "orange"
                border.width: 1



                Rectangle{
                    width:parent.width*2/5
                    height:parent.height-5
                    anchors.verticalCenter: parent.verticalCenter


/*

                        AlgoComponents.AlgoComboBox{
                            id:combo
                            anchors.top:parent.top
                            anchors.left:parent.left
                            anchors.leftMargin:25
                            comboboxModel: ["Εντός","Εκτός"]
                            fontFamily:"Sans Serif"
                            fontBold:false
                        }

*/







                    Text{
                        id:custname

                        //anchors.fill: parent
                        anchors.bottom: parent.bottom
                        width: parent.width
                        height: parent.height/2
                        anchors.leftMargin: 25

                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pixelSize: 25
                    }
                }

                Rectangle {
                    id: clockrect
                    border.width: 5
                    border.color: "black"
                    width:  parent.height
                    height: parent.height-5
                    x:parent.width*2/5
                    anchors.verticalCenter: parent.verticalCenter









                    property variant now: new Date()

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
                                var diff=new Date-timeaudit.starttime
                                var hours=Math.round(diff/3600000)
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

                            clockrect.now = new Date()
                            clock.hours= Math.round(clockrect.now.getHours())
                            clock.minutes= clockrect.now.getMinutes()
                            clock.seconds= clockrect.now.getSeconds()

                            }
                        }
                    }
                    Clock {
                        id: clock
                        anchors.centerIn: parent
                        anchors.fill:parent
                        hours: clockrect.now.getHours()
                        minutes: clockrect.now.getMinutes()
                        seconds: clockrect.now.getSeconds()



                    }


                    MouseArea {
                        id:ma1
                        anchors.fill: parent
                        //enabled: false






                            onDoubleClicked:

                             {

                                if (clock.active){

                                    clock.hourshand=true
                                    clock.faceimg="images/face.png"
                                    clock.active=false

                                    clockrect.now = new Date()
                                    timetext.text=""
                                    timeaudit.endtime=new Date();

                                    var rowcount=tasksTableModel.rowCount()

                                    tasksTableModel.insertRow(rowcount);

                                    var indexcustomer=tasksTableModel.index(rowcount,1)
                                    var indexplace=tasksTableModel.index(rowcount,2)
                                    var indexcomment=tasksTableModel.index(rowcount,4)
                                    var indexstart=tasksTableModel.index(rowcount,5)
                                    var indexend=tasksTableModel.index(rowcount,6)
                                    var indexinvoice=tasksTableModel.index(rowcount,8)



                                    var tod=new Date()
                                    tasksTableModel.setData(indexcustomer,cusid)
                                    tasksTableModel.setData(indexplace,combo.curIndex)
                                    tasksTableModel.setData(indexcomment,commenttext.text)
                                    tasksTableModel.setData(indexstart,timeaudit.starttime)
                                    tasksTableModel.setData(indexend,timeaudit.endtime)
                                    tasksTableModel.setData(indexinvoice,0)
                                    tasksTableModel.submitAll()


                                    taskModel.select()



                                }
                                else
                                {
                                    clock.faceimg="images/face1.png"
                                    clock.hourshand=false
                                    clock.active=true
                                    clock.seconds=0;
                                    timeaudit.starttime=new Date()
                                }

                            }



                    }


                }

                Rectangle{
                    width:parent.width*2/5
                    height:parent.height-5
                    x:parent.width*3/5
                    anchors.verticalCenter: parent.verticalCenter
                    Rectangle{
                        anchors.top: parent.top
                        width: parent.width-50
                        height: parent.height/2
                        anchors.leftMargin: 25
                        anchors.rightMargin: 25
                        anchors.left: parent.left
                        anchors.right: parent.right
                        border.color: "black"
                        border.width: 1



                    TextInput{
                        id: commenttext
                        anchors.fill: parent
                        color: "#151515";
                        selectionColor: "green"
                        font.pixelSize: 16;
                        font.bold: true
                        width: parent.width-16
                        maximumLength: 55
                        anchors.centerIn: parent
                        focus: true
                        wrapMode: Text.WordWrap

                    }
                    }


                    Text{
                        id:timetext
                        //anchors.fill: parent
                        anchors.bottom: parent.bottom
                        width: parent.width
                        height: parent.height/2
                        anchors.leftMargin: 25

                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pixelSize: 25

                    }
                }







            }

TabBar{
id:view1

width:  parent.height
height: parent.height-5
currentIndex: 0

TabButton{

        //title: "Today"
        //anchors.fill: parent
        width:  parent.height
        height: parent.height-5

           AlgoTableView{
                id:tbView
            }

}




        }






    }


    }



    Item {

            //width: parent.width

            //anchors.fill: parent
         Row{
             //anchors.fill:parent
             //spacing: 216
        Label {
            text: qsTr("Second page")
           width: 10
           height: 10
        }
        Label {
            id: lb2
            text: qsTr("Second 2 page")
            width: 10
            height: 10

        }
        /*

            AlgoComboBox{
                id: jim
                anchors.left: lb2.right
                //Layout.fillHeight: true

            }
            */


        }
    }
}
