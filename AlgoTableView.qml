import QtQuick 2.0
import QtQuick.Controls 1.4

Item {
    TableView {
         id: view
        property bool caught: false

        model: taskModel
        width: parent.width
        height: parent.height*2/5-50
        //Drag.active: ma2.drag.active
        TableViewColumn {
            role: "start_time"
            title: "Start Time"
            width: 120
        }
        TableViewColumn {
            role: "end_time"
            title: "End Time"

            width: 120
        }
        TableViewColumn {
            role: "comment"
            title: "Comments"

            width: 120
        }


        TableViewColumn {


            role:"name"
            /*
            delegate: Text{
                text: {
                    var jim="I"

                    return jim
                    //var customer=taskModel.cusid(view.model.getModelValue(styleData.row,"cusid"))
                    //var cusid=view.model.getModelValue(styleData.row,"cusid")
                    //customer.qxFetchById_(cusid)
                    //return customer.getModelValue(0,"name")
                }

            }
            */
            title: "Customer"

            width: 120

        }




    }
}
