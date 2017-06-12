#ifndef PDFGENERATOR_H
#define PDFGENERATOR_H

#include <QObject>
#include <QTextDocument>
#include <QPrinter>


class pdfGenerator : public QObject
{
    Q_OBJECT

private:
    QTextDocument textDoc;

public:
    explicit pdfGenerator(QObject *parent = 0);
    Q_INVOKABLE void setText(QString const &text);
    Q_INVOKABLE QString generatePDF();

signals:

public slots:
};

#endif // PDFGENERATOR_H
