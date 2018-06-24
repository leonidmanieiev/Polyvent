#include "event.h"

Event::Event(QObject *parent) :
    QObject(parent), _favorite(0)
{
}

QString Event::get_name() const
{
    return _name;
}

void Event::set_name(const QString& name)
{
    if (name != _name)
    {
        _name = name;
        emit name_changed(_name);
    }
}

QDate Event::get_start_date() const
{
    return _start_date;
}

void Event::set_start_date(const QDate& start_date)
{
    if (start_date != _start_date)
    {
        _start_date = start_date;
        emit start_date_changed(_start_date);
    }
}

QString Event::get_description() const
{
    return _description;
}

void Event::set_description(const QString& description)
{
    if (description != _description)
    {
        _description = description;
        emit description_changed(_description);
    }
}

QString Event::get_url() const
{
    return _url;
}

void Event::set_url(const QString& url)
{
    if (url != _url)
    {
        _url = url;
        emit url_changed(_url);
    }
}

QString Event::get_img_url() const
{
    return _img_url;
}

void Event::set_img_url(const QString& img_url)
{
    if (img_url != _img_url)
    {
        _img_url = img_url;
        emit img_url_changed(_img_url);
    }
}

bool Event::get_favorite() const
{
    return _favorite;
}

void Event::set_favorite(bool favorite)
{
    if(favorite != _favorite)
    {
        _favorite = favorite;
        emit favorite_changed(_favorite);
    }
}
