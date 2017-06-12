import QtQuick 2.0
import QtQuick.Controls 1.4

Item {
    id: cal
    property date seldate: new Date()

    Calendar{
       visibleYear: extractfromdate(3)
       visibleMonth: extractfromdate(2)
       selectedDate: seldate

       onPressAndHold:function pressAndHold(date) {
           seldate=date;
           cal.visible=false
       }

       onDoubleClicked: function onDoubleClicked(date){
           seldate=date;
           cal.visible=false

       }




       function extractfromdate(comp){
        var h=new Date()
           if (comp==1)
                return h.getDate();
           if (comp==2)
                return h.getMonth();
           if (comp==3)
                return h.getFullYear()
           if (comp==4)
                return h.getHours();
           if (comp==5)
                return h.getMinutes();

       }
    }

}
