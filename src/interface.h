#ifndef INTERFACE_H
#define INTERFACE_H

#include <QObject>
#include <QQmlEngine>
#include <qdir.h>
#include "filter.h"
#include <memory>

using std::unique_ptr;

class InterFace : public QObject
{
    Q_OBJECT
    QML_ELEMENT

public:
    InterFace();
    Q_INVOKABLE QString getAppPath(){return appPath;}
    Q_INVOKABLE void setImage2Filter(QString image);

signals:
    void imageChange();

public slots:
    void grayFilter();
    void edgeFilter();

private:
    unique_ptr<filter> currentFilter;
    QString appPath;
    QString currentImage;

    void applyFilter();

};

#endif // INTERFACE_H
