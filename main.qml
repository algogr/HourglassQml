import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import QtQuick.Controls.Universal 2.1
import Qt.labs.settings 1.0
import QtCharts 2.0
import QtDataVisualization 1.0

//import "/home/jim/workspace/AlgoComponents/" as AlgoComponents


ApplicationWindow {
    id:aw
    visible: true
    width: 1024
    height: 768
    title: qsTr("Hourglass")
    property string btrectbordercolor: "#8AF2A9"
    property string btrectcolorhover: "pink"
    property string btrectcolornohover: "purple"
    property bool isininvoice: false

    property int cusid: 0

    Shortcut {
        sequence: "Esc"
        enabled: stackView.depth > 1
        onActivated: {
            stackView.pop()
            listView.currentIndex = -1
        }
    }


    header: ToolBar {


        RowLayout {
            spacing: 20
            anchors.fill: parent

            ToolButton {
               id:tb
                contentItem: Image {
                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    source: stackView.depth > 1 ? "images/back.png" : "images/drawer.png"
                }
                onClicked: {
                    if (aw.isininvoice)
                    {
                        return;
                    }

                    if (stackView.depth > 1) {
                        stackView.pop()
                        listView.currentIndex = -1
                    } else {
                        drawer.open()
                    }
                }
            }

            Label {
                id: titleLabel
                text: listView.currentItem ? listView.currentItem.text : "HourGlass"
                font.pixelSize: 20
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }

            ToolButton {
                contentItem: Image {
                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    source: "images/menu.png"
                }
                onClicked: optionsMenu.open()

                Menu {
                    id: optionsMenu
                    x: parent.width - width
                    transformOrigin: Menu.TopRight

                    MenuItem {
                        text: "Settings"
                        onTriggered: settingsDialog.open()

                    }
                    MenuItem {
                        text: "About"
                        onTriggered: aboutDialog.open()
                    }
                }
            }
        }
    }
    Drawer {
        id: drawer
        width: Math.min(aw.width,aw.height) / 3 * 2
        height: aw.height
        dragMargin: stackView.depth > 1 ? 0 : undefined

        ListView {
            id: listView

            focus: true
            currentIndex: -1
            anchors.fill: parent

            delegate: ItemDelegate {
                width: parent.width
                text: model.title
                highlighted: ListView.isCurrentItem
                onClicked: {
                    listView.currentIndex = index
                    var t=model.paramname
                    var u=model.paramvalue
                    if(model.menuno==1)
                        stackView.push(model.source,{taskid:0}) //to push sikonei parameters
                    else
                        stackView.push(model.source) //to push sikonei parameters
                    drawer.close()
                }
            }

            model: ListModel {
                ListElement { title:"Task"; source: "qrc:/Task.qml";menuno:1 }
                ListElement { title: "Customer"; source: "qrc:/Customer.qml" }
                ListElement { title: "CheckBox"; source: "qrc:/pages/CheckBoxPage.qml" }
                ListElement { title: "ComboBox"; source: "qrc:/pages/ComboBoxPage.qml" }
                ListElement { title: "Dial"; source: "qrc:/pages/DialPage.qml" }
                ListElement { title: "Dialog"; source: "qrc:/pages/DialogPage.qml" }
                ListElement { title: "Delegates"; source: "qrc:/pages/DelegatePage.qml" }
                ListElement { title: "Frame"; source: "qrc:/pages/FramePage.qml" }
                ListElement { title: "GroupBox"; source: "qrc:/pages/GroupBoxPage.qml" }
                ListElement { title: "PageIndicator"; source: "qrc:/pages/PageIndicatorPage.qml" }
                ListElement { title: "ProgressBar"; source: "qrc:/pages/ProgressBarPage.qml" }
                ListElement { title: "RadioButton"; source: "qrc:/pages/RadioButtonPage.qml" }
                ListElement { title: "RangeSlider"; source: "qrc:/pages/RangeSliderPage.qml" }
                ListElement { title: "ScrollBar"; source: "qrc:/pages/ScrollBarPage.qml" }
                ListElement { title: "ScrollIndicator"; source: "qrc:/pages/ScrollIndicatorPage.qml" }
                ListElement { title: "Slider"; source: "qrc:/pages/SliderPage.qml" }
                ListElement { title: "SpinBox"; source: "qrc:/pages/SpinBoxPage.qml" }
                ListElement { title: "StackView"; source: "qrc:/pages/StackViewPage.qml" }
                ListElement { title: "SwipeView"; source: "qrc:/pages/SwipeViewPage.qml" }
                ListElement { title: "Switch"; source: "qrc:/pages/SwitchPage.qml" }
                ListElement { title: "TabBar"; source: "qrc:/pages/TabBarPage.qml" }
                ListElement { title: "TextArea"; source: "qrc:/pages/TextAreaPage.qml" }
                ListElement { title: "TextField"; source: "qrc:/pages/TextFieldPage.qml" }
                ListElement { title: "ToolTip"; source: "qrc:/pages/ToolTipPage.qml" }
                ListElement { title: "Tumbler"; source: "qrc:/pages/TumblerPage.qml" }
            }

            ScrollIndicator.vertical: ScrollIndicator { }
        }
    }

    StackView {
        id: stackView
        anchors.rightMargin: 0
        anchors.bottomMargin: -7
        anchors.leftMargin: 0
        anchors.topMargin: 7
        anchors.fill: parent



        initialItem: Pane {
            id: pane


        ColumnLayout{
            anchors.fill: parent

            Graph{
                id: graph
                Layout.fillWidth: true
                Layout.preferredHeight: stackView.availableHeight/3
            }


            TimeAudit{
                id: timeaud
                Layout.fillWidth: true
                Layout.preferredHeight: stackView.availableHeight/4



            }



            Tables{
                id: tables
                Layout.fillWidth: true
                Layout.preferredHeight: stackView.availableHeight/3
                Layout.minimumHeight: stackView.availableHeight/3
                onTaskmodelidChanged: {
                    console.log("la:"+viewModel.rowCount())
                    stackView.push("qrc:/Task.qml",{taskid:taskmodelid})
                }


                //}


            }




        }
        }

onDepthChanged: {

    if(depth==1)
        taskModel.setFilter("")
}

    }




}

