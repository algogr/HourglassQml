import QtQuick 2.5

MouseArea
{
id: component
property string text
property Item content: Text { parent:null; text: component.text; }
property int interval: 750
anchors.fill: parent
hoverEnabled: true
propagateComposedEvents: true
preventStealing: true
acceptedButtons: Qt.NoButton
onExited: hide()
onCanceled: hide()
function hide()
{
if(ToolTipTimer.content == component.content)
ToolTipTimer.hide();
}
function show()
{
if(ToolTipTimer.content != component.content)
{
ToolTipTimer.interval = component.interval;
ToolTipTimer.content = component.content;
}
else
ToolTipTimer.start();
}
onContainsMouseChanged:
{
if(containsMouse)
show();
else
hide();
}
onPositionChanged:
{
hide();
if(containsMouse)
show();
}
}
