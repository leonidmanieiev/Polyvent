#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtWebView/QtWebView>
#include <QUrl>
#include "event_model.h"
#include "event.h"


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    QtWebView::initialize();

    qmlRegisterType<EventModel>("org.qtproject.leoapp", 1, 0, "EventModel");
    qmlRegisterType<Event>("org.qtproject.leoapp", 1, 0, "Event");
    QQmlApplicationEngine engine(QUrl(QStringLiteral("qrc:/qml/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
