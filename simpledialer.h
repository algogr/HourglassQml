#ifndef SIMPLEDIALER_H
#define SIMPLEDIALER_H

#include <QObject>

class SimpleDialer : public QObject
{
    Q_OBJECT
public:
    explicit SimpleDialer(QObject *parent = 0);

signals:

public slots:
};

#endif // SIMPLEDIALER_H