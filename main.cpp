#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include  <QQmlContext>
#include <QDir>
#include "test.h"


int main(int argc, char *argv[])
{
    qDebug() << "Current working directory:" << QDir::currentPath();
    //Register a type in QML
    qmlRegisterType<Test>("com.company.test",1,0,"Test");

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/Main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
                         if (!obj && url == objUrl)
                             QCoreApplication::exit(-1);
                     }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
