pragma Singleton
import QtQuick 2.3
import QtQuick.Controls 1.2


MouseArea
{
id: component

parent: Application.rootItem // Expose the root Item for the QQuickViewinto c++ Application singleton
anchors.fill: parent
visible: false
z: 1000000
acceptedButtons: Qt.AllButtons

property Item content
property alias interval: timer_.interval
property alias running: timer_.running
onContentChanged:
{
if(content == null)
hide();
else
start();
}

onPressed : { hide(); mouse.accepted = false; }

function hide()
{
timer_.stop();
visible = false;
if(content) content.parent = null;
content = null;
}
function start()
{
timer_.restart();
}
function display()
{
if(!content) return;
content.parent = component;
var pos = Application.cursorPosition(); // Expose Q_INVOKABLE into Application singleton that do the following: return qquick_view->mapFromGlobal(QCursor::pos());
content.x = pos.x; content.y = pos.y;
visible = true;
}
Timer
{
id: timer_
running: component.content
interval: 750
onTriggered: component.display()
}
}
