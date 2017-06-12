#ifndef SIMPLEDIALER_H
#define SIMPLEDIALER_H

#include <QObject>

class SimpleDialer : public QObject
{
    Q_OBJECT
public:
    explicit SimpleDialer(QObject *parent = 0);
    Q_INVOKABLE void dial(const QString &phonenumber);

signals:

public slots:
};



#endif // SIMPLEDIALER_H
