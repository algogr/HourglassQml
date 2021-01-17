#include "pdfgenerator.h"
#include <QDebug>

pdfGenerator::pdfGenerator(QObject *parent) : QObject(parent)
{

}

void pdfGenerator::setText(const QString &text)
{
    textDoc.setHtml(text);

}
QString pdfGenerator::generatePDF(QString const &name)
{
       QPrinter printer;
       QString pdfPath="/home/jim/Downloads/tmp/"+name+".pdf";
       printer.setOutputFileName(pdfPath);
       printer.setOutputFormat(QPrinter::PdfFormat);
       textDoc.print(&printer);
       printer.newPage();
       return pdfPath;

}
