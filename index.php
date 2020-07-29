<?php
require 'helpers.php';
require 'data.php';

$user_name = 'Даниил';

$page__title = 'readme: популярное';

$is_auth = rand(0, 1);

$page_content = include_template('main.php', ['posts' => $posts]);

print $layout_content = include_template('layout.php',
    ['user_name' => $user_name,
        'page_title' => $page__title,
        'is_auth' => $is_auth,
        'page_content' => $page_content
    ]);
