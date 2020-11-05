<?php
require 'helpers.php';
require 'data.php';
require 'date.php';
session_start();

$user_name = 'Даниил';

$page__title = 'readme: популярное';

$is_auth = rand(0, 1);

//require_once 'connection.php'; // подключаем скрипт

$link = mysqli_connect("localhost", "root", "root", "readme");
mysqli_set_charset($link, "utf8");

if (!$link) {
    $error = mysqli_connect_error($link);
    print($error);
}
else {
    $query_types_content = "SELECT id, name, class FROM post_types";
    $result_types_content = mysqli_query ($link, $query_types_content);

    if ($result_types_content) {
        $types_content = mysqli_fetch_all ($result_types_content, MYSQLI_ASSOC);
    }

    $query_popular_posts = "SELECT title, content, publishedAt, user_id, image, video, link, login, types, avatar
                               FROM posts p
                               LEFT JOIN users u ON p.user_id = u.id
                               LEFT JOIN post_types pt ON p.post_type = pt.id
                               ORDER BY views DESC
                               LIMIT 6";
    $result_popular_posts = mysqli_query ($link, $query_popular_posts);

    if ($result_popular_posts) {
        $popular_posts = mysqli_fetch_all ($result_popular_posts, MYSQLI_ASSOC);
    }
}

// закрываем подключение

function time_delta($post_time){
    $end_ts = strtotime($post_time);
    $ts_diff = time() - $end_ts;

    if ($ts_diff <= 60) { /**менее 60 сек */
        return 'менее минуты назад';

    } elseif ($ts_diff <= SEC_IN_HOUR && $ts_diff > 60) { /**менее 60 минут*/

        return floor($ts_diff / 60).get_noun_plural_form(floor($ts_diff / 60),
                ' минуту назад',' минуты назад',' минут назад');
    } elseif ($ts_diff <= SEC_IN_DAY && $ts_diff > SEC_IN_HOUR) { /**менее 24 часов но более 60 минут*/

        return floor($ts_diff / SEC_IN_HOUR).get_noun_plural_form(floor($ts_diff / SEC_IN_HOUR),
                ' час назад',' часа назад',' часов назад');
    } elseif ($ts_diff <= SEC_IN_WEEK && $ts_diff > SEC_IN_DAY) { /**менее 7 дней, но больше 24 часов*/

        return floor($ts_diff / SEC_IN_DAY).get_noun_plural_form(floor($ts_diff / SEC_IN_DAY),
                ' день назад',' дня назад',' дней назад');
    } elseif ($ts_diff <= SEC_IN_MONTH && $ts_diff > SEC_IN_WEEK) { /**менее 5 недель, но больше 7 дней*/

        return floor($ts_diff / SEC_IN_WEEK).get_noun_plural_form(floor($ts_diff / SEC_IN_WEEK),
                ' неделю назад',' недели назад',' недель назад');
    } else {
        return floor($ts_diff / SEC_IN_MONTH).get_noun_plural_form(floor($ts_diff / SEC_IN_MONTH),
                ' месяц назад',' месяца назад',' месяцев назад');
    }

}
$page_content = include_template('/main.php', ['posts' => getPosts($connect, $ind), 'post__type' => getContent($connect), 'ind' => $ind]);

print $layout_content = include_template('layout.php',
    ['user_name' => $user_name,
        'page_title' => $page__title,
        'is_auth' => $is_auth,
        'page_content' => $page_content
    ]);
