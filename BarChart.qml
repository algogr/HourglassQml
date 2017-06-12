import QtQuick 2.1
import QtQuick.Layouts 1.0
import QtDataVisualization 1.0
import "."

Item {
    property int widthb: mainView.width
    property int heightb: mainView.height

    Rectangle{
        id: mainView

        Item{
            id: dataView
            anchors.bottom: parent.bottom
            Bars3D{
                id:barGraph
                width: dataView.width
                height: dataView.height
                theme: themeIsabelle
                shadowQuality: AbstractGraph3D.ShadowQualitySoftLow
            }
            Theme3D {
                id: themeIsabelle
                type: Theme3D.ThemeIsabelle
                font.family: "Lucida Handwriting"
                font.pointSize: 40
            }

        }

        Data {
            id:seriesData
        }

    }


}
