//***https://github.com/bluetiger9/SmtpClient-for-Qt/blob/v1.1/SMTPEmail.pro****

#ifndef EMAIL_H
#define EMAIL_H

#include <QObject>

#include "smtp.h"
#include <src/SmtpMime>


class Email : public QObject
{
    Q_OBJECT

private:
    QString from,fromName,to,toName,body,title,footer,mailServer,user,password;
    QStringList attachments;
    int port;
public:
    explicit Email(QObject *parent = 0);

    Q_INVOKABLE QString getFrom() const;
    Q_INVOKABLE void setFrom(const QString &value);

    Q_INVOKABLE QString getTo() const;
    Q_INVOKABLE void setTo(const QString &value);

    Q_INVOKABLE QString getBody() const;
    Q_INVOKABLE void setBody(const QString &value);

    Q_INVOKABLE QString getTitle() const;
    Q_INVOKABLE void setTitle(const QString &value);

    Q_INVOKABLE QString getFooter() const;
    Q_INVOKABLE void setFooter(const QString &value);


    Q_INVOKABLE void send();



    Q_INVOKABLE QString getFromName() const;
    Q_INVOKABLE void setFromName(const QString &value);

    Q_INVOKABLE QString getToName() const;
    Q_INVOKABLE void setToName(const QString &value);

    Q_INVOKABLE int getPort() const;
    Q_INVOKABLE void setPort( int value);

    Q_INVOKABLE QString getMailServer() const;
    Q_INVOKABLE void setMailServer(const QString &value);

    Q_INVOKABLE QString getUser() const;
    Q_INVOKABLE void setUser(const QString &value);

    Q_INVOKABLE QString getPassword() const;
    Q_INVOKABLE void setPassword(const QString &value);

    Q_INVOKABLE QStringList getAttachments() const;
    Q_INVOKABLE void setAttachments(const QStringList &value);

    //Q_INVOKABLE void appendAttachment

signals:

public slots:
};

#endif // EMAIL_H
