import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1
import QtCharts 2.0
import QtDataVisualization 1.0

ApplicationWindow {
  id: app

  width: 360
  height: 640

  //some actions

  property int durationOfMenuAnimation: 500
  property int menuWidth: app.width*0.85
  property int widthOfSeizure: 15
  property bool menuIsShown: Math.abs(menuView.x) < (menuWidth*0.5) ? true : false
  property real menuProgressOpening


  Rectangle {
    id: normalView
    x: 0
    y: 0
    width: parent.width
    height: parent.height
    color: "white"

    /*****( Menu bar )*****/
    Rectangle {
      id: menuBar
      z: 5
      anchors.top: parent.top
      anchors.topMargin: 0
      width: parent.width
      height: 50
      color: palette.darkPrimary
      Rectangle {
        id: menuButton
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        width: 1.2*height
        height: parent.height
        scale: maMenuBar.pressed ? 1.2 : 1
        color: "transparent"
        MenuIconLive {
          id: menuBackIcon
          scale: (parent.height/height)*0.65
          anchors.centerIn: parent
          value: menuProgressOpening
        }
        MouseArea {
          id: maMenuBar
          anchors.fill: parent
          onClicked: onMenu()
        }
        clip: true
      }
      Label {
        id: titleText
        anchors.left: menuButton.right
        anchors.verticalCenter: parent.verticalCenter
        text: appTitle
        font.pixelSize: 0.35*parent.height
        color: palette.text
      }
    } //menuBar
    Image {
      id: imgShadow
      anchors.top: menuBar.bottom
      anchors.left: parent.left
      anchors.right: parent.right
      height: 6
      z: 4
      source: "qrc:/images/shadow_title.png"
    }


    /*****( Menu )*****/
    Rectangle {
      id: menuView
      anchors.top: menuBar.bottom
      height: parent.height - menuBar.height
      width: menuWidth
      z: 3
      MainMenu {
        id: mainMenu
        anchors.fill: parent
        onMenuItemClicked: {
          onMenu()
          loader.source = page
        }
      }
      x: -menuWidth

      Behavior on x { NumberAnimation { duration: app.durationOfMenuAnimation; easing.type: Easing.OutQuad } }
      onXChanged: {
        menuProgressOpening = (1-Math.abs(menuView.x/menuWidth))
      }

      MouseArea {
        anchors.right: parent.right
        anchors.rightMargin: app.menuIsShown ? (menuWidth - app.width) : -widthOfSeizure
        anchors.top: parent.top
        width: app.menuIsShown ? (app.width - menuWidth) : widthOfSeizure
        height: parent.height
        drag {
          target: menuView
          axis: Drag.XAxis
          minimumX: -menuView.width
          maximumX: 0
        }
        onClicked: {
          if(app.menuIsShown) app.onMenu()
        }
        onReleased: {
          if( Math.abs(menuView.x) > 0.5*menuWidth ) {
            menuView.x = -menuWidth //close the menu
          } else {
            menuView.x = 0 //fully opened
          }
        }
      }
    } //menuView
    Image {
      id: imgShadowMenu
      anchors.top: menuBar.bottom
      anchors.bottom: menuView.bottom
      anchors.left: menuView.right
      width: 10
      z: 5
      source: "qrc:/images/shadow_long.png"
      visible: menuView.x != -menuWidth
    }
    Rectangle {
      id: curtainMenu
      z: 1
      anchors.fill: parent
      color: "black"
      opacity: app.menuProgressOpening*0.5
    }


    /*****( Main loader )*****/
    Loader {
      id: loader
      anchors.top: menuBar.bottom;
      anchors.left: parent.left
      anchors.right: parent.right
      anchors.bottom: parent.bottom

      //asynchronous: true
      onStatusChanged: {
        if( status == Loader.Loading ) {
          curtainLoading.visible = true
          titleText.text = appTitle
        } else if( status == Loader.Ready ) {
          curtainLoading.visible = false
        } else if( status == Loader.Error ) {
          curtainLoading.visible = false
        }
      }
      onLoaded: {
        titleText.text = item.title
      }
      Rectangle {
        id: curtainLoading
        anchors.fill: parent
        visible: false
        color: "white"
        opacity: 0.8
        BusyIndicator {
          anchors.centerIn: parent
        }
      }
    } //loader
  } //normalView
} //app
