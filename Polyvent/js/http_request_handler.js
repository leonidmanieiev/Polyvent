//вернуть общее количество мероприятий на странице http://www.spbstu.ru/media/announcements/ из html
function cnt_of_events_request(webview, callback)
{
    var events_cnt_request = "document.getElementsByClassName('event-box clearfix').length";
    webview.runJavaScript(events_cnt_request, function(cnt_of_event) { callback(cnt_of_event); });
}

//преобразовать дату-строку из (ru_RU d MMMM yyyy) в дату (d M yyyy)
function parse_date(str_date)
{
    var d_MM_yyyy = str_date.trim().split(' ');
    switch(d_MM_yyyy[1])
    {
        case "Января": d_MM_yyyy[1] = 0; break;
        case "Февраля": d_MM_yyyy[1] = 1; break;
        case "Марта": d_MM_yyyy[1] = 2; break;
        case "Апреля": d_MM_yyyy[1] = 3; break;
        case "Мая": d_MM_yyyy[1] = 4; break;
        case "Июня": d_MM_yyyy[1] = 5; break;
        case "Июля": d_MM_yyyy[1] = 6; break;
        case "Августа": d_MM_yyyy[1] = 7; break;
        case "Сентября": d_MM_yyyy[1] = 8; break;
        case "Октября": d_MM_yyyy[1] = 9; break;
        case "Ноября": d_MM_yyyy[1] = 10; break;
        case "Декабря": d_MM_yyyy[1] = 11; break;
        default: throw d_MM_yyyy[1].concat(" - invalid month");
    }

    return new Date(d_MM_yyyy[2], d_MM_yyyy[1], d_MM_yyyy[0]);
}

//вернуть дату мероприятия из html
function get_actual_date(webview, date_index, callback)
{
    var date_request = "document.getElementsByClassName('e-edge-start')["+date_index+"].innerHTML";
    webview.runJavaScript(date_request, function(str_date)
    {
        try
        {
            var date = parse_date(str_date);
            callback(date);
        } catch(err)
        {
            console.log(err);
        }
    });
}

//вернуть url мероприятия из html
function get_source_url(webview, url_index, callback)
{
    var url_request = "document.getElementsByClassName('event-fig')["+url_index+"].href";
    webview.runJavaScript(url_request, function(url) { callback(url); });
}

//вернуть url изображения из html
function get_img_url(webview, img_index, callback)
{
    var img_request = "document.getElementsByClassName('event-fig')["+img_index+"].children[0].currentSrc";
    webview.runJavaScript(img_request, function(img_url) { callback(img_url); });
}

//вернуть описание мероприятия из html
function get_desc(webview, desc_index, callback)
{
    var desc_request = "document.getElementsByClassName('event-snap')["+desc_index+"].textContent";
    webview.runJavaScript(desc_request, function(description) { callback(description); });
}

//вернуть название мероприятия из html
function get_title(webview, title_index, callback)
{
    var title_request = "document.getElementsByClassName('event-header')["+title_index+"].textContent";
    webview.runJavaScript(title_request, function(title) { callback(title); });
}

//обработка всех запросов для получения ногово мероприятия
function http_request_handler(loadRequest, webview, callback_url, callback_img_url,
                              callback_title, callback_date, callback_desc)
{
    if(loadRequest.status === WebView.LoadStartedStatus)
        return 1;
    else if(loadRequest.status === WebView.LoadFailedStatus)
        return -1;
    else if(loadRequest.status === WebView.LoadSucceededStatus)
    {
        cnt_of_events_request(webview, function(cnt_of_events)
        {
            for(var i = cnt_of_events-1; i >= 0; i--)
            {
                get_actual_date(webview, i, function(date) { callback_date(date); });
                get_title(webview, i, function(title) { callback_title(title); });
                get_source_url(webview, i, function(url) { callback_url(url); });
                get_img_url(webview, i, function(img_url) { callback_img_url(img_url); })
                get_desc(webview, i, function(desc) { callback_desc(desc, cnt_of_events); });
            }
        });
    }

    return 0;
}
