import QtQuick 2.0
import QtDataVisualization 1.0
import QtQuick.Controls 2.2
import QtCharts 2.0
import QtQml.Models 2.2

Item {
    property variant cusid: -1

    SwipeView {
        id: view
        currentIndex: 0
        anchors.fill: parent


            Pane {
                width: view.width
                height: view.height



        ChartView{
            id: dataView
            anchors.fill:parent
           property alias barmax: axisy.max

            ComboBox{
                id:chartcombo
                model:taskCategoriesModel1
                textRole: "descr"
                currentIndex: -1
                font.pixelSize: 10
                onCurrentIndexChanged: {
                    if (currentIndex !=-1)
                    {

                        firstgraph()


                    }
                }
            }

                ValueAxis{
                    id:axisy
                    min:0
                    //max:10
                }

                BarSeries {
                    id:bar
                    visible: true
                    axisX: BarCategoryAxis
                    {
                        id:baraxis
                        categories:["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]



                    }
                    axisY: axisy



                VBarModelMapper {
                    id:modelmapper
                    model: querymodel
                    // QAbstractItemModel derived implementation
                    firstBarSetColumn: 1
                    lastBarSetColumn: 3
                    firstRow: 0


                    }



}

        }
            }



            Pane {
                width: view.width
                height: view.height



        ChartView{
            id: dataView1
            anchors.fill:parent
            property alias barmax1: axisy1.max
            ValueAxis{
                id:axisy1
                min:0
                //max:10
            }





                BarSeries {
                    id:bar1
                    visible: true
                    axisX: BarCategoryAxis
                    {
                        id:baraxis1
                        categories:[new Date().getFullYear()-4,new Date().getFullYear()-3,new Date().getFullYear()-2,new Date().getFullYear()-1,new Date().getFullYear()]



                    }

                    axisY:axisy1



                VBarModelMapper {
                    id:modelmapper1
                    model: querymodel

                    // QAbstractItemModel derived implementation
                    firstBarSetColumn: 1
                    lastBarSetColumn: 5
                    firstRow: 0

                    }



}

        }
            }
onCurrentIndexChanged: {
    if(currentIndex===0)
        firstgraph()
    else
        seconfdgraph()

}

}
    PageIndicator {
        count: view.count
        currentIndex: view.currentIndex
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }

    onCusidChanged: {
        chartcombo.currentIndex=0
        console.log("cusid="+cusid)
    }
    function firstgraph()
    {

        querymodel.setQuery("SELECT YEAR(starttime),MONTH(starttime) AS tmonth,SUM(duration)
        from tasks_improved where year(starttime)>=year(curdate())-2 and cusid="+cusid+
        " and taskcatid="+(chartcombo.currentIndex+1) +" group by YEAR(starttime),month(starttime)
        order by sum(duration) desc")
        var maxindex=querymodel.index(0,2)
        var max=(querymodel.data(maxindex))/60



        querymodel.setQuery("SELECT MONTH(`tasks_improved`.`starttime`) AS `tmonth`,\
        (SUM((CASE WHEN (YEAR(`tasks_improved`.`starttime`) = (YEAR(CURDATE()) - 2)) \
        THEN `tasks_improved`.`DURATION` ELSE 0 END)) / 60) AS `p2`,(SUM((CASE WHEN \
        (YEAR(`tasks_improved`.`starttime`) = (YEAR(CURDATE())-1)) THEN `tasks_improved`.\
        `DURATION` ELSE 0 END)) / 60) AS `p1`,\
        (SUM((CASE WHEN (YEAR(`tasks_improved`.`starttime`) = YEAR(CURDATE())) \
        THEN `tasks_improved`.`DURATION` ELSE 0 END)) / 60) AS `p0` \
        FROM `tasks_improved`  WHERE ((YEAR(`tasks_improved`.`starttime`) >= (YEAR(CURDATE()) - 2)) \
        AND (`tasks_improved`.`taskcatid` ="+(chartcombo.currentIndex+1)+") and cusid="+cusid+") GROUP BY MONTH(`tasks_improved`.`starttime`) ");
        var yr=new Date().getFullYear()
        querymodel.setHeaderData(1,Qt.Horizontal,(yr-2).toString())
        querymodel.setHeaderData(2,Qt.Horizontal,(yr-1).toString())
        querymodel.setHeaderData(3,Qt.Horizontal,(yr).toString())
        dataView.barmax=max

        baraxis.categories=[]
        for (var j=0;j<querymodel.rowCount();++j)
        {
            var ind=querymodel.index(j,0)
            var vl=querymodel.data(ind)
            baraxis.categories[j]=vl
            console.log("f:"+j)
            //baraxis.categories=["Jan1","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
        }
    }


    function seconfdgraph()
    {

        querymodel.setQuery("SELECT YEAR(starttime),IFNULL((SUM(duration)),0)
        from tasks_improved where year(starttime)>=year(curdate())-4 and cusid="+cusid+
        " and taskcatid="+(chartcombo.currentIndex+1) +" group by YEAR(starttime)
        order by sum(duration) desc")
        var maxindex=querymodel.index(0,1)
        var max=(querymodel.data(maxindex))/60
        console.log("secondgrapgh:"+max)


        querymodel.setQuery("SELECT year(`tasks_improved`.`starttime`) AS `tyear`,
        ifnull((SUM((CASE WHEN (YEAR(`tasks_improved`.`starttime`) = (YEAR(CURDATE()) - 4))
        THEN `tasks_improved`.`DURATION` ELSE 0 END)) / 60),0) AS `p4`,ifnull((SUM((CASE WHEN (YEAR(`tasks_improved`.`starttime`)
         = (YEAR(CURDATE()) - 3))
        THEN `tasks_improved`.`DURATION` ELSE 0 END)) / 60),0) AS `p3`,
        ifnull((SUM((CASE WHEN (YEAR(`tasks_improved`.`starttime`) = (YEAR(CURDATE()) - 2))
        THEN `tasks_improved`.`DURATION` ELSE 0 END)) / 60),0) AS `p2`,
        ifnull((SUM((CASE WHEN
        (YEAR(`tasks_improved`.`starttime`) = (YEAR(CURDATE())-1)) THEN `tasks_improved`.
        `DURATION` ELSE 0 END)) / 60),0) AS `p1`,
        ifnull((SUM((CASE WHEN (YEAR(`tasks_improved`.`starttime`) = YEAR(CURDATE()))
        THEN `tasks_improved`.`DURATION` ELSE 0 END)) / 60),0) AS `p0`
        FROM `tasks_improved`  WHERE ((YEAR(`tasks_improved`.`starttime`) >= (YEAR(CURDATE()) - 4))
        AND (`tasks_improved`.`taskcatid` = "+(chartcombo.currentIndex+1)+") and cusid="+cusid+") GROUP BY YEAR(`tasks_improved`.`starttime`)");

        dataView1.barmax1=max
        baraxis1.categories=[]
        for (var j=0;j<querymodel.rowCount();++j)
        {
            var ind=querymodel.index(j,0)
            var vl=querymodel.data(ind)
            baraxis1.categories[j]=vl
            console.log("f:"+j)
            //baraxis.categories=["Jan1","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
        }
    }

}



