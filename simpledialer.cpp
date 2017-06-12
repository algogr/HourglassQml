#include "simpledialer.h"
#include <QProcess>
#include <QDebug>
SimpleDialer::SimpleDialer(QObject *parent) : QObject(parent)
{

}

void SimpleDialer::dial(const QString &phonenumber)
{
       QProcess process;
       QString command="jitsi sip:"+phonenumber+"@192.168.2.254";
       qDebug()<<command;

       process.start(command);
       process.waitForFinished(-1);
}
