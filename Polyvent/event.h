#ifndef EVENT_H
#define EVENT_H

#include <QDebug>
#include <QDate>
#include <QObject>
#include <QString>

class Event : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString name READ get_name WRITE set_name NOTIFY name_changed)
    Q_PROPERTY(QDate start_date READ get_start_date WRITE set_start_date NOTIFY start_date_changed)
    Q_PROPERTY(QString description READ get_description WRITE set_description NOTIFY description_changed)
    Q_PROPERTY(QString url READ get_url WRITE set_url NOTIFY url_changed)
    Q_PROPERTY(QString img_url READ get_img_url WRITE set_img_url NOTIFY img_url_changed)
    Q_PROPERTY(bool favorite READ get_favorite WRITE set_favorite NOTIFY favorite_changed)
public:
    explicit Event(QObject *parent = 0);

    Q_INVOKABLE QString get_name() const;
    Q_INVOKABLE void set_name(const QString& name);
    Q_INVOKABLE QDate get_start_date() const;
    Q_INVOKABLE void set_start_date(const QDate& start_date);
    Q_INVOKABLE QString get_description() const;
    Q_INVOKABLE void set_description(const QString& description);
    Q_INVOKABLE QString get_url() const;
    Q_INVOKABLE void set_url(const QString& url);
    Q_INVOKABLE QString get_img_url() const;
    Q_INVOKABLE void set_img_url(const QString& img_url);
    Q_INVOKABLE bool get_favorite() const;
    Q_INVOKABLE void set_favorite(bool favorite);
signals:
    void name_changed(const QString& name);
    void start_date_changed(const QDate& start_date);
    void description_changed(const QString& description);
    void url_changed(const QString& url);
    void img_url_changed(const QString& img_url);
    void favorite_changed(bool favorite);
private:
    QString _name;
    QDate _start_date;
    QString _description;
    QString _url;
    QString _img_url;
    bool _favorite;
};

#endif // EVENT_H
