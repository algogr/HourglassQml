#ifndef PDFGENERATOR_H
#define PDFGENERATOR_H

#include <QObject>

class pdfGenerator : public QObject
{
    Q_OBJECT
public:
    explicit pdfGenerator(QObject *parent = 0);

signals:

public slots:
};

#endif // PDFGENERATOR_H