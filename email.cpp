#include "email.h"



QString Email::getFrom() const
{
    return from;
}

void Email::setFrom(const QString &value)
{
    from = value;
}

QString Email::getTo() const
{
    return to;
}

void Email::setTo(const QString &value)
{
    to = value;
}

QString Email::getBody() const
{
    return body;
}

void Email::setBody(const QString &value)
{
    body = value;
}

QString Email::getTitle() const
{
    return title;
}

void Email::setTitle(const QString &value)
{
    title = value;
}

QString Email::getFooter() const
{
    return footer;
}

void Email::setFooter(const QString &value)
{
    footer = value;
}

void Email::send()
{
    QStringList to1;



    SmtpClient smtp(getMailServer(),getPort(),SmtpClient::TcpConnection);
    smtp.setUser(getUser());
    smtp.setPassword(getPassword());


    MimeMessage message;
    //qDebug()<<getFrom()<<getFromName()<<getTo()<<getToName()<<getTitle()<<getBody();
    message.setSender(new EmailAddress(getFrom(),getFromName()));
    message.addRecipient(new EmailAddress(getTo(),getToName()));

    message.setSubject(getTitle());
    MimeHtml text;
    text.setText(getBody());
    message.addPart(&text);
    for (int i=0;i<attachments.size();i++)
    {
        message.addPart(new MimeAttachment(new QFile(attachments.at(i))));
    }
    smtp.connectToHost();
    smtp.login();
    smtp.sendMail(message);
    smtp.quit();


}



QString Email::getFromName() const
{
    return fromName;
}

void Email::setFromName(const QString &value)
{
    fromName = value;
}

QString Email::getToName() const
{
    return toName;
}

void Email::setToName(const QString &value)
{
    toName = value;
}

int Email::getPort() const
{
    return port;
}

void Email::setPort(int value)
{
    port = value;
}

QString Email::getMailServer() const
{
    return mailServer;
}

void Email::setMailServer(const QString &value)
{
    mailServer = value;
}

QString Email::getUser() const
{
    return user;
}

void Email::setUser(const QString &value)
{
    user = value;
}

QString Email::getPassword() const
{
    return password;
}

void Email::setPassword(const QString &value)
{
    password = value;
}

QStringList Email::getAttachments() const
{
    return attachments;
}

void Email::setAttachments(const QStringList &value)
{
    attachments = value;
}

Email::Email(QObject *parent) : QObject(parent)
{
    setMailServer("localhost");
    setPort(25);

    setUser("");
    setPassword("");

    setFrom("jimpar@algo.gr");
    setFromName("Dimitris Paraschou");



}

