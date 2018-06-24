#ifndef EVENTMODEL_H
#define EVENTMODEL_H

#include <QList>
#include <QVector>
#include <QStringRef>
#include <QSqlError>
#include <QSqlQuery>
#include <mutex>

#include "event.h"

class EventModel : public QObject
{
    Q_OBJECT
public:
    EventModel();
    //вернуть мероприятия по конкретной дате или все, если дата = null
    Q_INVOKABLE QList<QObject*> events_for_date(const QDate& date = QDate());
    //добавить или убрать мероприятие из избранного
    Q_INVOKABLE void update_favorite(const QString& url, bool set_to);
    //вернуть избранные мероприятия
    Q_INVOKABLE QList<QObject*> favorite_events();
    //добавить новое мероприятие в бд
    Q_INVOKABLE bool add_event(Event* event);
    //вернуть мероприятия, удовлетворяющие поиску
    Q_INVOKABLE QList<QObject*> events_satisfy_search(const QDate& from_date, const QDate& to_date,
                                                      const QString& search_text);
    //удаления уже прошедших мероприятий из бд
    Q_INVOKABLE void delete_passed_events();
private:
    //создать бд и отношение Event
    static void create_connection();
};

//вернуть sql запрос-условие для поиска по ключевым словам
QString get_query_key_part(QVector<QStringRef>& keys);

#endif // EVENTMODEL_H
