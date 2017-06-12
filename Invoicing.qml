import QtQuick 2.6
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2


Pane {
    id: page

    property variant cusid: -1
    property variant custname
    property string hourspdf: "<table style=\"width:100%\"><tr><u><th>Ημερομηνία</th><th>Από</th><th>-</th><th>Έως</th><th>Διάρκεια(Λεπτά)</th><th>Αιτιολογία</th></u></tr>"
    property string  datestart
    property string  apo
    property string  eos
    property variant diffg
    property string pdfComment
    property bool selectallmode: false
    property bool clean : true

        Column {
            id:c1
            //spacing: 50
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.fill: parent
            spacing: 45

            ListView{
                property int taskid
                property bool forinv: false
                property bool ci: ListView.isCurrentItem

                id: list
                width: c1.width
                height: c1.height*4/6
                model:taskModel2
                delegate:Rectangle
                {


                    property bool ci: test.ListView.isCurrentItem
                    id:test
                    border.width:1

                    height: 50
                    width: parent.width
                    //border.width:1
                Row{
                    spacing: 25
                    CheckBox{
                        id:inv
                        checked: invoice


                        onClicked: {
                            clean=false
                            var invoiceindex=taskModel2.index(index,8)

                            if (checked===true)
                            {
                                console.log(start_time)
                                taskModel2.setData(invoiceindex,1)
                                taskModel2.submitAll()

                                var d1=new Date(start_time)
                                var d2=new Date(end_time)
                                var diff=(d2-d1)/3600000
                                if (taskcatid==1)
                                {
                                    h1.text=(parseFloat(h1.text)+diff).toFixed(2)
                                }
                                if (taskcatid==2)
                                {
                                    h2.text=(parseFloat(h2.text)+diff).toFixed(2)
                                }
                                if (taskcatid==3)
                                {
                                    h3.text=(parseFloat(h3.text)+diff).toFixed(2)
                                }
                                if (taskcatid==4)
                                {
                                    h4.text=(parseFloat(h4.text)+diff).toFixed(2)
                                }
                            }


                            if (checked===false)
                            {
                                //invcheckstate[index]=false
                                taskModel2.setData(invoiceindex,0)
                                taskModel2.submitAll()
                                if (taskcatid==1)
                                {
                                    h1.text=(parseFloat(h1.text)-diff).toFixed(2)
                                }
                                if (taskcatid==2)
                                {
                                    h2.text=(parseFloat(h2.text)-diff).toFixed(2)
                                }
                                if (taskcatid==3)
                                {
                                    h3.text=(parseFloat(h3.text)-diff).toFixed(2)
                                }
                                if (taskcatid==4)
                                {
                                    h4.text=(parseFloat(h4.text)-diff).toFixed(2)
                                }
                            }
                            toth.text=(parseFloat(h1.text)+parseFloat(h2.text)+parseFloat(h3.text)+parseFloat(h4.text)).toFixed(2)
                            totv.text=(parseFloat(h1.text)*parseFloat(p1.text)+parseFloat(h2.text)*parseFloat(p2.text)+parseFloat(h3.text)*parseFloat(p3.text)+parseFloat(h4.text)*parseFloat(p4.text)).toFixed(2)





                        }

                    }

                    Label {
                        id:lblid
                        visible: true
                        font.bold: true
                        font.pixelSize: 25
                        text:invoice
                    }

                    Label {
                        id:lblcatid

                        font.bold: true
                        font.pixelSize: 25
                        text:taskcatid
                    }
                    Label {
                        id:lbl
                        font.bold: true
                        font.pixelSize: 25
                        text:{
                                    var v= start_time
                                    var d=extractfromdate(v,1)
                                    var m=extractfromdate(v,2)
                                    var y=extractfromdate(v,3)
                                    d+"-"+m+"-"+y
                                    //console.log(taskModel2.rowCount())



                        }
                    }
                Label{
                    font.bold: true
                    font.pixelSize: 25
                    text:{
                        var v= start_time
                        var h=extractfromdate(v,4)
                        var m1=extractfromdate(v,5)
                        h+":"+m1





            }
                }

                Label{
                    font.bold: true
                    font.pixelSize: 25
                    text:{
                        var v= end_time
                        var h=extractfromdate(v,4)
                        var m1=extractfromdate(v,5)
                        h+":"+m1





            }
                }
                Label{
                    font.bold: true
                    font.pixelSize: 25
                    text: comment
                }
}



}
    onCurrentIndexChanged:
            {

    var idindex=taskModel2.index(currentIndex,0)
    var startimeindex=taskModel2.index(currentIndex,5)
    var endtimeindex=taskModel2.index(currentIndex,6)
    var commentindex=taskModel2.index(currentIndex,4)
    var starttime=taskModel2.data(startimeindex)
    var endtime=taskModel2.data(endtimeindex)
    console.log("cichanged"+taskModel2.data(commentindex))
    var v= new Date(starttime)
    var d=extractfromdate(v,1)
    var m=extractfromdate(v,2)
    var y=extractfromdate(v,3)
    var h=extractfromdate(v,4)
    var mn=extractfromdate(v,5)

    var v1= new Date(endtime)
    var h1=extractfromdate(v,4)
    var mn1=extractfromdate(v,5)

    diffg=parseFloat((v1-v)/3600000).toFixed(2)

    datestart=d+"-"+m+"-"+y
    apo=h+":"+mn
    eos=h1+":"+mn1
        pdfComment=taskModel2.data(commentindex)
        taskid=taskModel2.data(idindex)


//}
}


 }


Row{
    spacing: 25
    width:list.width
    Column{
        spacing: 15
        TextField{
            id:h1
            width: implicitWidth/2
            enabled: false
            text: "0"
            font.bold: true
            font.pixelSize: 20
            horizontalAlignment: Text.AlignRight
            onTextChanged: {
                if (isNaN(text))
                    text="0"
            }
        }
    TextField{
        id:p1
        width: implicitWidth/2
        text: "0"
        font.bold: true
        font.pixelSize: 20
        horizontalAlignment: Text.AlignRight
        onTextChanged: {
            if (isNaN(text))
                text="0"
            totv.text=(parseFloat(h1.text)*parseFloat(p1.text)+parseFloat(h2.text)*parseFloat(p2.text)+parseFloat(h3.text)*parseFloat(p3.text)+parseFloat(h4.text)*parseFloat(p4.text)).toFixed(2)
        }



    }
    }
    Column{
        spacing: 15
    TextField{
        id:h2
        width: implicitWidth/2
        enabled: false
        text: "0"
        font.bold: true
        font.pixelSize: 20
        horizontalAlignment: Text.AlignRight
        onTextChanged: {
            if (isNaN(text))
                text="0"
        }
    }
TextField{
    id:p2

    width: implicitWidth/2
    text: "0"
    font.bold: true
    font.pixelSize: 20
    horizontalAlignment: Text.AlignRight
    onTextChanged: {

            if (isNaN(text))
                text="0"
          totv.text=(parseFloat(h1.text)*parseFloat(p1.text)+parseFloat(h2.text)*parseFloat(p2.text)+parseFloat(h3.text)*parseFloat(p3.text)+parseFloat(h4.text)*parseFloat(p4.text)).toFixed(2)
    }
}
    }
    Column{
        spacing: 15
TextField{
    id:h3
    text: "0"
    enabled: false
    width: implicitWidth/2
    font.bold: true
    font.pixelSize: 20
    horizontalAlignment: Text.AlignRight
    onTextChanged: {
        if (isNaN(text))
            text="0"
    }
}
TextField{
    ToolTip{
        text: "JIM"
    }

id:p3
width: implicitWidth/2
text: "0"
horizontalAlignment: Text.AlignRight
font.bold: true
font.pixelSize: 20
onTextChanged: {


        if (isNaN(text))
            text="0"

    totv.text=(parseFloat(h1.text)*parseFloat(p1.text)+parseFloat(h2.text)*parseFloat(p2.text)+parseFloat(h3.text)*parseFloat(p3.text)+parseFloat(h4.text)*parseFloat(p4.text)).toFixed(2)
}
}
    }
    Column{
        spacing: 15
TextField{
    id:h4
    text: "0"
    enabled: false
    width: implicitWidth/2
    horizontalAlignment: Text.AlignRight
    font.bold: true
    font.pixelSize: 20
    onTextChanged: {
        if (isNaN(text))
            text="0"
    }
}
TextField{
id:p4
text: "0"
width: implicitWidth/2
horizontalAlignment: Text.AlignRight
font.bold: true
font.pixelSize: 20
onTextChanged: {

        if (isNaN(text))
            text="0"

    totv.text=(parseFloat(h1.text)*parseFloat(p1.text)+parseFloat(h2.text)*parseFloat(p2.text)+parseFloat(h3.text)*parseFloat(p3.text)+parseFloat(h4.text)*parseFloat(p4.text)).toFixed(2)
}
}
}

    Column{
        spacing: 15
TextField{
    id:toth
    text: "0"
    enabled: false
    width: implicitWidth/2
    horizontalAlignment: Text.AlignRight
    font.bold: true
    font.pixelSize: 25
    onTextChanged: {
        if (isNaN(text))
            text="0"
    }
}
TextField{
id:totv
text: "0"
width: implicitWidth/2
horizontalAlignment: Text.AlignRight
enabled: false
font.bold: true
font.pixelSize: 25
onTextChanged: {
    if (isNaN(text))
        text="0"
}
}

}


Button{
    id:btnok

        Image {
            anchors.fill: parent
            source: "qrc:images/check.png"
        }

        onReleased: {
            if(!clean)
            {
            var rowcount=fintradeModel.rowCount()
            fintradeModel.insertRow(rowcount);
            var ftrdateindex=fintradeModel.index(rowcount,1)
            var cusidindex=fintradeModel.index(rowcount,2)
            var idindex=fintradeModel.index(rowcount,0)
            fintradeModel.setData(ftrdateindex,new Date())
            fintradeModel.setData(cusidindex,cusid)

            fintradeModel.submitAll()
            var ftrid=fintradeModel.data(idindex)
            console.log("ftrid:"+ftrid)

            for (var i=0;i<list.count;++i)
            {
                list.currentIndex=i
                tasksTableModel2.setFilter("id="+list.taskid)
                var fidindex=tasksTableModel2.index(0,10)
                var invindex=taskModel2.index(i,8)

                if (taskModel2.data(invindex)==1)

                {

                //list.currentIndex=i

                hourspdf=hourspdf+"<tr><th>"+datestart+"</th><th>"+apo+"</th><th>-</th><th>"+eos+"</th><th>"+diffg+"</th><th>"+pdfComment+"</th></tr>"
                console.log("enabled:"+list.taskid)
                tasksTableModel2.setData(fidindex,ftrid)
                console.log("enabledftrid"+ftrid)
                tasksTableModel2.submitAll()
                //list.currentIndex=-1
                }
                list.currentIndex=-1

            }

            tasksTableModel2.setFilter("")
            taskModel2.setFilter("cusid="+cusid)
            customerModel.setFilter("")


            hourspdf=hourspdf+"</table>"

            pdfgen.setText(hourspdf)
            var attachments=[pdfgen.generatePDF()]


            taskEmail.setTo("rxa@algo.gr")
            taskEmail.setToName("Ρουλίτσα")
            taskEmail.setTitle("Invoice Details")
            taskEmail.setAttachments(attachments)
            var b1="Πελάτης:"+custname+"<br><br>"
            var b2="<B>"+invcomment.text+"</B><br><br>"
            var b3="'<B>Ώρες: "+toth.text+"</B><br><br>"
            var b4="<B>Αξία: "+totv.text+"</B><br><br>"

            taskEmail.setBody(b1+b2+b3+b4)
            taskEmail.send()
}

            stackView.pop("")





        }

}

Button{
    id:btncancel


    Image {
        anchors.fill: parent
        source: "qrc:images/black-x-png-27.png"
    }
    onReleased: {
        if (!clean)
        {
        for (var i=0;i<list.count;++i)
        {

           var invoiceindex=taskModel2.index(i,8)
           taskModel2.setData(invoiceindex,0)
           taskModel2.submitAll()

        }

        taskModel2.setFilter("")
        taskModel2.setFilter("cusid="+cusid)
        customerModel.setFilter("")
        aw.isininvoice=false

    }
        stackView.pop()
    }
}


Button{
    id:btnmarkall


    Image {
        anchors.fill: parent
        source: "qrc:images/select_all.png"
    }
    onReleased: {
        var st
        if (selectallmode)
            st=0
        else
            st=1


        for (var i=0;i<list.count;++i)
        {
           var invoiceindex=taskModel2.index(i,8)
           taskModel2.setData(invoiceindex,st)
           taskModel2.submitAll()

        }


        selectallmode=st

    }
}




}
TextField{
    id:invcomment
    placeholderText: "Invoice Comments"
    width: implicitWidth*3
    font.bold: true
    font.pixelSize: 15

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

        Component.onCompleted: {
            list.currentIndex=-1
            aw.isininvoice=true


        }


}
