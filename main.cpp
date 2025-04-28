#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QTranslator>
#include <QLibraryInfo>
#include <QDir>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    // Загружаем системные переводы Qt
    QTranslator qtTranslator;
    if (qtTranslator.load("qt_" + QLocale::system().name(),
                         QLibraryInfo::path(QLibraryInfo::TranslationsPath))) {
        app.installTranslator(&qtTranslator);
    }

    // Загружаем переводы приложения
    QTranslator appTranslator;
    if (appTranslator.load("translations_" + QLocale::system().name(),
                          ":/translations")) {
        app.installTranslator(&appTranslator);
    }

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/Main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
