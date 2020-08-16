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


                        <!--содержимое для поста-видео-->
                        <div class="post-video__block">
                            <div class="post-video__preview">
                                <?=embed_youtube_cover(/* вставьте ссылку на видео */); ?>
                                <img src="img/coast-medium.jpg" alt="Превью к видео" width="360" height="188">
                            </div>
                            <a href="post-details.html" class="post-video__play-big button">
                                <svg class="post-video__play-big-icon" width="14" height="14">
                                    <use xlink:href="#icon-video-play-big"></use>
                                </svg>
                                <span class="visually-hidden">Запустить проигрыватель</span>
                            </a>
                        </div>
                    <?php  elseif ($val['type'] == 'post-text') : ?>
                    <!--содержимое для поста-текста-->
                    <?php
                    function filltext ($text, $length = 300)
                    {
                        if (mb_strlen($text) <= $length) {
                            return '<p>' . $text . '</p>';
                        } else {
                            $text = explode(' ', $text);
                            $length_word = 0;
                            foreach ($text as $word) {
                                $length_word += (mb_strlen($word)) + 1;
                                if ($length_word > 300) {
                                    break;
                                } else {
                                    $text_sup[]= $word;
                                }
                            }
                            return '<p>' . implode(' ', $text_sup) . '...</p><a class="post-text__more-link" href="#">Читать далее</a>';
                        }
                    }
                    ?>

                    <p><?=filltext($val['content']);?></p>

                </div>
                <footer class="post__footer">
                    <div class="post__author">
                        <a class="post__author-link" href="#" title="Автор">
                            <div class="post__avatar-wrapper">
                                <!--укажите путь к файлу аватара-->
                                <img class="post__author-avatar" src="img/<?=$val['avatar'];?>" alt="Аватар пользователя">
                            </div>
                            <div class="post__info">
                                <b class="post__author-name"><?=$val['author'];?></b>
                                <time class="post__time" datetime="">дата</time>
                            </div>
                        </a>
                    </div>
                    <div class="post__indicators">
                        <div class="post__buttons">
                            <a class="post__indicator post__indicator--likes button" href="#" title="Лайк">
                                <svg class="post__indicator-icon" width="20" height="17">
                                    <use xlink:href="#icon-heart"></use>
                                </svg>
                                <svg class="post__indicator-icon post__indicator-icon--like-active" width="20" height="17">
                                    <use xlink:href="#icon-heart-active"></use>
                                </svg>
                                <span>0</span>
                                <span class="visually-hidden">количество лайков</span>
                            </a>
                            <a class="post__indicator post__indicator--comments button" href="#" title="Комментарии">
                                <svg class="post__indicator-icon" width="19" height="17">
                                    <use xlink:href="#icon-comment"></use>
                                </svg>
                                <span>0</span>
                                <span class="visually-hidden">количество комментариев</span>
                            </a>
                        </div>
                    </div>
                </footer>
            </article>
                <?php endif; ?>
            <?php endforeach; ?>
        </div>
    </div>
</section>

print $layout_content = include_template('layout.php',
    ['user_name' => $user_name,
        'page_title' => $page__title,
        'is_auth' => $is_auth,
        'page_content' => $page_content
    ]);
