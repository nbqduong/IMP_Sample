#ifndef TEST_H
#define TEST_H

#include <QObject>
#include <QDebug>
#include <QVariant>
#include <QRandomGenerator>
#include <qdir.h>

class Test : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString mData READ mData WRITE setmData NOTIFY mDataChanged)
public:
    explicit Test(QObject *parent = nullptr);

    // Getter for mData
    QString mData() const {
        return m_mData;
    }

    // Setter for mData
    void setmData(const QString &data) {
        if (m_mData != data) {
            m_mData = data;
            emit mDataChanged(); // Notify QML of the change
        }
    }

    Q_INVOKABLE void myFunc() ;

signals:
    void status(QVariant data);
    void mDataChanged();

public slots:
    void work(QVariant data) ;
private:
    QString m_mData{QDir::currentPath()};  // Backing field for mData
};

#endif // TEST_H
