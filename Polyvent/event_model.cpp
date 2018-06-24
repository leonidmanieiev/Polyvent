#include "event_model.h"

std::once_flag conn_once_flag;

EventModel::EventModel()
{
    std::call_once(conn_once_flag, [](){ create_connection(); });
}

QList<QObject*> EventModel::events_for_date(const QDate& date)
{
    QSqlQuery query;
    if(date.isNull())
        query.prepare("SELECT * FROM Event ORDER BY start_date;");
    else
    {
        query.prepare("SELECT * FROM Event WHERE :start_date == start_date;");
        query.bindValue(":start_date", date.toString("yyyy-MM-dd"));
    }

    if (!query.exec())
        qDebug() << "Query failed: " << query.lastError();

    QList<QObject*> events;
    while(query.next())
    {
        Event *event = new Event(this);

        event->set_name(query.value("name").toString());
        event->set_start_date(query.value("start_date").toDate());
        event->set_description(query.value("description").toString());
        event->set_url(query.value("url").toString());
        event->set_img_url(query.value("img_url").toString());
        event->set_favorite(query.value("favorite").toBool());

        events.append(event);
    }

    return events;
}

void EventModel::update_favorite(const QString &url, bool set_to)
{
    QSqlQuery query;
    query.prepare("UPDATE Event SET favorite = :set_to WHERE url == :url;");
    query.bindValue(":set_to", set_to);
    query.bindValue(":url", url);

    if (!query.exec())
        qDebug() << "Query failed: " << query.lastError();
}

QList<QObject*> EventModel::favorite_events()
{
    QSqlQuery query;
    query.prepare("SELECT * FROM Event WHERE favorite == 1 ORDER BY start_date;");

    if (!query.exec())
        qDebug() << "Query failed: " << query.lastError();

    QList<QObject*> events;
    while(query.next())
    {
        Event *event = new Event(this);

        event->set_name(query.value("name").toString());
        event->set_start_date(query.value("start_date").toDate());
        event->set_description(query.value("description").toString());
        event->set_url(query.value("url").toString());
        event->set_img_url(query.value("img_url").toString());
        event->set_favorite(query.value("favorite").toBool());

        events.append(event);
    }
    return events;
}

QString get_query_key_part(QVector<QStringRef>& keys)
{
    QString query_key_part;

    if(keys.length())
    {
        query_key_part.append(" AND (");

        foreach(QStringRef key, keys)
            query_key_part.append("description LIKE '%"+key+"%' OR ");

        query_key_part.chop(4);
        query_key_part.append(")");
    }

    return query_key_part;
}

QList<QObject*> EventModel::events_satisfy_search(const QDate& from_date, const QDate& to_date,
                                                  const QString& search_text)
{
    QSqlQuery query;
    QVector<QStringRef> keys(search_text.splitRef(' ', QString::SkipEmptyParts));
    QString key_part(get_query_key_part(keys));

    if(to_date.isNull())
    {
        QString str_query("SELECT * FROM Event WHERE start_date >= :from_date"+key_part+
                          " ORDER BY start_date;");
        query.prepare(str_query);
        query.bindValue(":from_date", from_date.toString("yyyy-MM-dd"));
    }
    else
    {
        QString str_query("SELECT * FROM Event WHERE start_date BETWEEN :from_date AND :to_date"+
                          key_part+" ORDER BY start_date;");
        query.prepare(str_query);
        query.bindValue(":from_date", from_date.toString("yyyy-MM-dd"));
        query.bindValue(":to_date", to_date.toString("yyyy-MM-dd"));
    }

    if (!query.exec())
        qDebug() << "Query failed: " << query.lastError();

    QList<QObject*> events;
    while(query.next())
    {
        Event *event = new Event(this);

        event->set_name(query.value("name").toString());
        event->set_start_date(query.value("start_date").toDate());
        event->set_description(query.value("description").toString());
        event->set_url(query.value("url").toString());
        event->set_img_url(query.value("img_url").toString());
        event->set_favorite(query.value("favorite").toBool());

        events.append(event);
    }

    return events;
}

void EventModel::delete_passed_events()
{
    QSqlQuery query;
    query.prepare("DELETE FROM Event WHERE start_date < :curr_date;");
    query.bindValue(":curr_date", QDate::currentDate());

    if (!query.exec())
        qDebug() << "Query failed: " << query.lastError();
}

bool EventModel::add_event(Event* event)
{
    if(event->get_start_date() < QDate::currentDate())
        return false;

    QSqlQuery query;
    query.prepare("INSERT INTO Event values(:title, :start_date, :desc, :url, :img_url, 0);");
    query.bindValue(":title", event->get_name());
    query.bindValue(":start_date", event->get_start_date());
    query.bindValue(":desc", event->get_description());
    query.bindValue(":url", event->get_url());
    query.bindValue(":img_url", event->get_img_url());

    if (!query.exec())
    {
        qDebug() << "Query failed: " << query.lastError();
        return false;
    }

    return true;
}

void EventModel::create_connection()
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("event.db");

    if(!db.open())
    {
        qDebug() << "Database opens failed: " << db.lastError();
        return;
    }

    QSqlQuery query;
    query.prepare("CREATE TABLE `Event` (`name` TEXT NOT NULL UNIQUE, `start_date` DATE NOT NULL, "
                  "`description` TEXT, `url` TEXT NOT NULL UNIQUE, `img_url` TEXT NOT NULL UNIQUE, "
                  "`favorite` INT NOT NULL);");
    if (!query.exec())
        qDebug() << "Query failed: " << query.lastError();
}
