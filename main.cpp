


#include <QGuiApplication>
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QSqlDatabase>
#include <QDebug>
#include <QDate>
#include "algosqlquerymodel.h"
#include "algosqlrelationaltablemodel.h"
#include "algosqltablemodel.h"
#include "email.h"
#include "simpledialer.h"
#include "pdfgenerator.h"


int main(int argc, char *argv[])
{

    QApplication app(argc, argv);

    QSqlDatabase db=QSqlDatabase::addDatabase("QMYSQL");
    db.setDatabaseName("hourglass");
    db.setHostName("localhost");
    db.setPort(3306);
    db.setUserName("root");
    db.setPassword("101264");
    qDebug()<<db.open();


    Email taskemail;
    SimpleDialer dialer;
    pdfGenerator pdf;



    AlgoSqlTableModel* cModel = new AlgoSqlTableModel(0,db);
    cModel->setTable("customers");
    cModel->select();
    cModel->sort(1,Qt::SortOrder::AscendingOrder);
    cModel->generateRoleNames();

    cModel->setFilter("active=1");
    cModel->select();

    AlgoSqlQueryModel* qModel=new AlgoSqlQueryModel();



    AlgoSqlTableModel* cModel1 = new AlgoSqlTableModel(0,db);
    cModel1->setTable("customers");
    cModel1->select();
    cModel1->sort(1,Qt::SortOrder::AscendingOrder);
    cModel1->generateRoleNames();

    cModel1->setFilter("active=1");

    cModel1->select();


    AlgoSqlTableModel* cModel2 = new AlgoSqlTableModel(0,db);
    cModel2->setTable("customers");
    cModel2->select();
    cModel2->sort(1,Qt::SortOrder::AscendingOrder);
    cModel2->generateRoleNames();



    cModel2->select();

    AlgoSqlTableModel* tkModel = new AlgoSqlTableModel(0,db);
    tkModel->setTable("taskcategories");
    tkModel->select();
    tkModel->generateRoleNames();

    AlgoSqlTableModel* tkModel1 = new AlgoSqlTableModel(0,db);
    tkModel1->setTable("taskcategories");
    tkModel1->select();
    tkModel1->generateRoleNames();



    AlgoSqlRelationalTableModel* tModel=new AlgoSqlRelationalTableModel(0,db);

    tModel->setTable("tasks");
    tModel->setRelation(1,QSqlRelation("customers","id","name"));
    tModel->setSort(5,Qt::SortOrder::DescendingOrder);
    tModel->select();
    tModel->generateRoleNames();


    AlgoSqlRelationalTableModel* tModel2=new AlgoSqlRelationalTableModel(0,db);

    tModel2->setTable("tasks");
    tModel2->setRelation(1,QSqlRelation("customers","id","name"));
    tModel2->setSort(5,Qt::SortOrder::DescendingOrder);
    tModel2->select();
    tModel2->generateRoleNames();




    AlgoSqlRelationalTableModel* fModel1=new AlgoSqlRelationalTableModel(0,db);

    fModel1->setTable("fintrade");
    fModel1->setRelation(2,QSqlRelation("customers","id","name"));
    fModel1->setSort(1,Qt::SortOrder::DescendingOrder);




    fModel1->select();
    fModel1->generateRoleNames();

    //qAssert(tModel->rowCount()!=0);

    //tmodel->setR
    //tModel->qxFetchAll();

    AlgoSqlTableModel* tiModel = new AlgoSqlTableModel(0,db);
    tiModel->setTable("tasks_improved");
    tiModel->select();
    tiModel->setFilter("");
    tiModel->generateRoleNames();

    AlgoSqlTableModel* vModel = new AlgoSqlTableModel(0,db);
    vModel->setTable("monthyearhours");
    QVariant pyear=QDate::currentDate().year()-1;
    QVariant cyear=QDate::currentDate().year();
    vModel->setHeaderData(2,Qt::Horizontal,pyear.toString());
    vModel->setHeaderData(3,Qt::Horizontal,cyear.toString());
    vModel->select();
    vModel->setFilter("");


    AlgoSqlTableModel* fModel = new AlgoSqlTableModel(0,db);
    fModel->setTable("fintrade");
    fModel->select();
    fModel->generateRoleNames();



    AlgoSqlTableModel* vModel1 = new AlgoSqlTableModel(0,db);
    vModel1->setTable("yearhours");
    QVariant p4=QDate::currentDate().year()-4;
    QVariant p3=QDate::currentDate().year()-3;
    QVariant p2=QDate::currentDate().year()-2;
    QVariant p1=QDate::currentDate().year()-1;
    QVariant p0=QDate::currentDate().year();
    vModel1->setHeaderData(1,Qt::Horizontal,p4.toString());
    vModel1->setHeaderData(2,Qt::Horizontal,p3.toString());
    vModel1->setHeaderData(3,Qt::Horizontal,p2.toString());
    vModel1->setHeaderData(4,Qt::Horizontal,p1.toString());
    vModel1->setHeaderData(5,Qt::Horizontal,p0.toString());
    vModel1->select();
    vModel1->setFilter("");






    AlgoSqlTableModel* ttmodel=new AlgoSqlTableModel(0,db);
    ttmodel->setTable("tasks");
    ttmodel->select();



    AlgoSqlTableModel* ttmodel2=new AlgoSqlTableModel(0,db);
    ttmodel2->setTable("tasks");
    ttmodel2->select();





    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("customerModel",cModel);
    engine.rootContext()->setContextProperty("fintradecusModel",fModel1);
    engine.rootContext()->setContextProperty("customerModel1",cModel1);
    engine.rootContext()->setContextProperty("customerModel2",cModel2);
    engine.rootContext()->setContextProperty("taskModel",tModel);
    engine.rootContext()->setContextProperty("taskModel2",tModel2);
    engine.rootContext()->setContextProperty("taskCategoriesModel",tkModel);
    engine.rootContext()->setContextProperty("taskCategoriesModel1",tkModel1);
    engine.rootContext()->setContextProperty("viewModel",vModel);


    engine.rootContext()->setContextProperty("viewModel1",vModel1);
    engine.rootContext()->setContextProperty("fintradeModel",fModel);
    engine.rootContext()->setContextProperty("tiModel",tiModel);
    engine.rootContext()->setContextProperty("tasksTableModel",ttmodel);
    engine.rootContext()->setContextProperty("tasksTableModel2",ttmodel2);
    engine.rootContext()->setContextProperty("taskEmail",&taskemail);
    engine.rootContext()->setContextProperty("dialer",&dialer);
    engine.rootContext()->setContextProperty("pdfgen",&pdf);
    engine.rootContext()->setContextProperty("querymodel",qModel);


    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));


    return app.exec();
}
