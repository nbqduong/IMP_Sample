#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "test2.h"
#include "test.h"
#include  <QQmlContext>
#include <QDir>
// #include <opencv2/opencv.hpp>
// using namespace cv;


int main(int argc, char *argv[])
{
    qDebug() << "Current working directory:" << QDir::currentPath();
    //Register a type in QML
    qmlRegisterType<Test>("com.company.test",1,0,"Test");
    bark();

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/QMLDir/Main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
                         if (!obj && url == objUrl)
                             QCoreApplication::exit(-1);
                     }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
