#include "algosqlrelationaltablemodel.h"
#include <QSqlRecord>
#include <QDebug>


AlgoSqlRelationalTableModel::AlgoSqlRelationalTableModel(QObject *parent, QSqlDatabase db):QSqlRelationalTableModel(parent,db)
{

}

AlgoSqlRelationalTableModel::~AlgoSqlRelationalTableModel()
{

}

QVariant AlgoSqlRelationalTableModel::data(const QModelIndex &index, int role) const
{
    if(index.row() >= rowCount())
        {
            return QString("");
        }
        if(role < Qt::UserRole)
        {
            return QSqlRelationalTableModel::data(index, role);
        }
        else
        {
            // search for relationships
            for (int i = 0; i < columnCount(); i++)
            {
                if (this->relation(i).isValid())
                {

                    return record(index.row()).value(QString(roles.value(role)));
                }
            }
        // if no valid relationship was found
        return QSqlRelationalTableModel::data(this->index(index.row(), role - Qt::UserRole - 1), Qt::DisplayRole);

                    }
}

void AlgoSqlRelationalTableModel::generateRoleNames()
{

    roles.clear();

        int nbCols = this->columnCount();

        for (int i = 0; i < nbCols; i++)
        {
            roles[Qt::UserRole + i + 1] = QVariant(this->headerData(i, Qt::Horizontal).toString()).toByteArray();
        }


}

void AlgoSqlRelationalTableModel::setSort(int column, Qt::SortOrder order)
{
    QSqlRelationalTableModel::setSort(column,order);
}

void AlgoSqlRelationalTableModel::setFilter(const QString &filter)
{

    QSqlRelationalTableModel::setFilter(filter);
}

QVariantMap AlgoSqlRelationalTableModel::get( int rowNumber ) const
{
    QVariantMap map;
    QHash<int,QByteArray> roleName = roleNames();
    foreach (int i, roleName.keys())
    {
        // For each attribute (role) get its value and insert it into the map
        // where the map's key is the attributes string reference

        // The data() method returns the value for the requested attribute
        // where i is the attributes enum value.
        // The index() method returns a QModelIndex which is a further
        // abstraction layer (will talk about that in a later post)
        map[roleName.value(i)] = data( index( rowNumber,0 ), i );
    }
    return map;
}

