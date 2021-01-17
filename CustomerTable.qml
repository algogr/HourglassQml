import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3


Item {
    id:root

    property variant taskmodelid: 0
    property variant cusid: 0

   TabView{
       id:view1

       width:  parent.width
       height: parent.height
       currentIndex: 0

       Tab{

               title: "Tasks"
               //anchors.fill: parent
               width:  parent.height
               height: parent.height-5

                   TableView {
                        id: view
                       property bool caught: false

                       model: taskModel
                       width: parent.width
                       height: parent.height
                       //Drag.active: ma2.drag.active
                       TableViewColumn {
                           id:starttime
                           role: "start_time"
                           title: "Start Time"
                           width: parent.width/5

                           delegate:
                               Label{
                                   text:{
                                       var v=   styleData.value
                                       var d=extractfromdate(v,1)
                                       var m=extractfromdate(v,2)
                                       var y=extractfromdate(v,3)
                                       var h=extractfromdate(v,4)
                                       var m1=extractfromdate(v,5)
                                       d+"-"+m+"-"+y+"  "+h+":"+m1


                                   }

                                   font.bold: true
                                   color: "green"


                               }


                       }
                       TableViewColumn {
                           id:endtime
                           role: "end_time"
                           title: "End Time"

                           width: parent.width/5

                           delegate:
                               Label{
                                   text:{
                                       var v=   styleData.value
                                       var d=extractfromdate(v,1)
                                       var m=extractfromdate(v,2)
                                       var y=extractfromdate(v,3)
                                       var h=extractfromdate(v,4)
                                       var m1=extractfromdate(v,5)
                                       d+"-"+m+"-"+y+"  "+h+":"+m1


                                   }

                                   font.bold: true
                                   color: "red"


                               }

                       }
                       TableViewColumn {
                           role: "comment"
                           title: "Comments"
                           width: parent.width*2/5

                           delegate:
                               Label{
                               text: styleData.value
                               font.bold: true



                           }

                       }


                       TableViewColumn {


                           role:"invoice"

                           title: "Invoice"

                           width: parent.width/5

                           delegate:
                               CheckBox{
                               checked: styleData.value



                           }

                       }


                       onDoubleClicked: {
                           var taskindex=taskModel.index(currentRow,0)
                           taskmodelid=taskModel.data(taskindex)
                       }

                   }
   }

       Tab{
           title: "Graphs"

           width:  parent.height
           height: parent.height-5
           ColumnLayout{
               anchors.fill: parent

              CustomerGraph{
                   id: graph
                   Layout.fillWidth: true
                   cusid: root.cusid
                   Layout.preferredHeight: stackView.availableHeight/3
               }

}

       }



       Tab{

               title: "Invoices"
               //anchors.fill: parent
               width:  parent.height
               height: parent.height-5
               Row{
                   width: parent.width
                   height: parent.height


                   TableView {
                        id: view2
                       property bool caught: false

                       model: fintradecusModel
                       width: parent.width/2
                       height: parent.height
                       //Drag.active: ma2.drag.active
                       TableViewColumn {
                           id:ftrdate
                           role: "ftrdate"
                           title: "Date"
                           width: parent.width/3

                           delegate:
                               Label{
                                   text:{
                                       var v=   styleData.value
                                       var d=extractfromdate(v,1)
                                       var m=extractfromdate(v,2)
                                       var y=extractfromdate(v,3)
                                       var h=extractfromdate(v,4)
                                       var m1=extractfromdate(v,5)
                                       d+"-"+m+"-"+y


                                   }

                                   font.bold: true
                                   color: "green"


                               }


                       }
                       TableViewColumn {
                           id: customer
                           role: "name"
                           title: "Customer"

                           width: parent.width/5

                           delegate:
                               Label{
                                   text:styleData.value
                                   font.bold: true
                                   color: "red"


                               }

                       }






                       onClicked: {
                           var idindex=fintradecusModel.index(currentRow,0)
                           var ftrid=fintradecusModel.data(idindex)
                           taskModel.setFilter("ftrid="+ftrid)
                       }



                   }


                   TableView {
                        id: view3
                       property bool caught: false

                       model: taskModel
                       width: parent.width/2
                       height: parent.height
                       //Drag.active: ma2.drag.active
                       TableViewColumn {
                           id:starttime1
                           role: "start_time"
                           title: "Start Time"
                           width: parent.width/5

                           delegate:
                               Label{
                                   text:{
                                       var v=   styleData.value
                                       var d=extractfromdate(v,1)
                                       var m=extractfromdate(v,2)
                                       var y=extractfromdate(v,3)
                                       var h=extractfromdate(v,4)
                                       var m1=extractfromdate(v,5)
                                       d+"-"+m+"-"+y+"  "+h+":"+m1


                                   }

                                   font.bold: true
                                   color: "green"


                               }


                       }
                       TableViewColumn {
                           id:endtime1
                           role: "end_time"
                           title: "End Time"

                           width: parent.width/5

                           delegate:
                               Label{
                                   text:{
                                       var v=   styleData.value
                                       var d=extractfromdate(v,1)
                                       var m=extractfromdate(v,2)
                                       var y=extractfromdate(v,3)
                                       var h=extractfromdate(v,4)
                                       var m1=extractfromdate(v,5)
                                       d+"-"+m+"-"+y+"  "+h+":"+m1


                                   }

                                   font.bold: true
                                   color: "red"


                               }

                       }
                       TableViewColumn {
                           role: "comment"
                           title: "Comments"
                           width: parent.width*3/5

                           delegate:
                               Label{
                               text: styleData.value
                               font.bold: true



                           }

                       }





                       onDoubleClicked: {
                           var taskindex=taskModel.index(currentRow,0)
                           taskmodelid=taskModel.data(taskindex)
                       }

                   }
}



   }


onCurrentIndexChanged: {
    if (currentIndex!=2)
    {
        taskModel.setFilter("cusid="+cusid)
    }
}

               }



   function extractfromdate(date,comp){
    var h=new Date(date)
    var t
       if (comp==1)
            t=h.getDate()
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





}
