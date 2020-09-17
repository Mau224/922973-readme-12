INSERT INTO post_types (name , class)
VALUES
    ('Текст', 'text'),
    ('Цитата', 'quote'),
    ('Фото', 'photo'),
    ('Видео', 'video'),
    ('Ссылка', 'link');

INSERT INTO users (email, login, password, avatar)
VALUES
    ('name_email1@gmail.com', 'Cаша', 'password1', 'userpic-larisa-small.jpg'),
    ('name_email2@gmail.com', 'Федя', 'password2', 'userpic.jpg'),
    ('name_email3@gmail.com', 'Толя', 'password3', 'userpic-mark.jpg');

INSERT INTO posts (title, content, user_id, image, video, link, views, types)
VALUES
    ('Цитата', 'Мы в жизни любим только раз, а после ищем лишь похожих', 1, NULL, NULL, NULL, 7, 2),
    ('Игра престолов', 'Не могу дождаться начала финального сезона своего любимого сериала!', 2, NULL, NULL, NULL, 5, 2),
    ('Наконец, обработал фотки!', NULL, 3, 'rock-medium.jpg', NULL, NULL, 5, 2),
    ('Моя мечта', NULL, 4, NULL, 'coast-medium.jpg', NULL, 8, 4),
    ('Лучшие курсы', 'Лучшие курсs', 5, NULL, NULL, 'www.htmlacademy.ru', 1, 5);

INSERT INTO comments (content, user_id, post_id)
VALUES
    ('Комментарий1 к цитате', 1, 1),
    ('Комментарий2 к цитате', 2, 1),
    ('Комментарий3 к цитате', 3, 1),
    ('Комментарий1 к игре престолов', 1, 2),
    ('Комментарий2 к игре престолов', 2, 2),
    ('Комментарий2 к игре престолов', 3, 2),
    ('Комментарий1 к обработке фото', 1, 3),
    ('Комментарий2 к обработке фото', 2, 3),
    ('Комментарий3 к обработке фото', 3, 3),
    ('Комментарий1 к мечте', 1, 4),
    ('Комментарий2 к мечте', 2, 4),
    ('Комментарий2 к мечте', 3, 4),
    ('Комментарий1 к лучшим курсам', 1, 5),
    ('Комментарий2 к лучшим курсам', 2, 5),
    ('Комментарий2 к лучшим курсам', 3, 5);

INSERT INTO likes (user_id, post_id)
VALUES
    (1, 1),
    (3, 1),
    (2, 1),
    (3, 2),
    (2, 2),
    (1, 3),
    (2, 4),
    (3, 5);

INSERT INTO subscriptions (user_id, subscription_id)
VALUES
    (2, 1),
    (1, 2),
    (3, 1),
    (3, 2),
    (1, 3),
    (1, 2);

