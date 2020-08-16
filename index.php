<?php
require 'helpers.php';
require 'data.php';
require 'date.php';
session_start();

$user_name = 'Даниил';

$page__title = 'readme: популярное';

$is_auth = rand(0, 1);


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
$page_content = include_template('main.php', ['posts' => $posts]);

print $layout_content = include_template('layout.php',
    ['user_name' => $user_name,
        'page_title' => $page__title,
        'is_auth' => $is_auth,
        'page_content' => $page_content
    ]);
