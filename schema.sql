CREATE DATABASE IF NOT EXISTS `267983-readme-12`
    DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;

USE `267983-readme-12`;

CREATE TABLE IF NOT EXISTS user (
    id INT NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY,
    registrationAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    email VARCHAR(128) NOT NULL UNIQUE,
    login VARCHAR(128) NOT NULL UNIQUE,
    password VARCHAR(128) NOT NULL,
    avatar VARCHAR(255),
    INDEX (email, login)
);

CREATE TABLE post_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30) UNIQUE,
    class VARCHAR(10) UNIQUE
);

CREATE TABLE IF NOT EXISTS post (
    id INT NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY,
    publishedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    title VARCHAR(255) NOT NULL UNIQUE,
    content TEXT NOT NULL,
    user_id INT NOT NULL,
    image VARCHAR(255),
    video VARCHAR(255),
    link VARCHAR(255),
    views INT NOT NULL DEFAULT 0,
    types INT NOT NULL,
    UNIQUE INDEX (id, title),
    INDEX (user_id),
    post_type_id INT REFERENCES post_types (id)
);

CREATE TABLE IF NOT EXISTS hashtag (
   id INT NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY,
   name VARCHAR(255) NOT NULL,
   UNIQUE INDEX (id)
);

CREATE TABLE IF NOT EXISTS post_hashtag (
    post_id INT NOT NULL ,
    hashtag_id INT NOT NULL,
    INDEX (post_id, hashtag_id),
    FOREIGN KEY (hashtag_id) REFERENCES hashtag(id)
);

CREATE TABLE IF NOT EXISTS comment (
   id INT NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY,
   publishedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
   content TEXT NOT NULL,
   user_id INT NOT NULL,
   post_id INT NOT NULL,
   UNIQUE INDEX (id),
   INDEX (user_id, post_id),
   FOREIGN KEY (user_id) REFERENCES user(id),
   FOREIGN KEY (post_id) REFERENCES post(id)
);

CREATE TABLE IF NOT EXISTS `like` (
  user_id INT NOT NULL,
  post_id INT NOT NULL,
  INDEX (user_id, post_id),
  FOREIGN KEY (user_id) REFERENCES user(id),
  FOREIGN KEY (post_id) REFERENCES post(id)
);

CREATE TABLE IF NOT EXISTS subscription (
    user_id INT NOT NULL,
    subscription_id INT NOT NULL,
    INDEX (user_id, subscription_id),
    FOREIGN KEY (user_id) REFERENCES user(id),
    FOREIGN KEY (subscription_id) REFERENCES user(id)
);

CREATE TABLE IF NOT EXISTS message (
   id INT NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY,
   publishedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
   content TEXT NOT NULL,
   sender_id INT NOT NULL,
   recipient_id INT NOT NULL,
   UNIQUE INDEX (id),
   INDEX (sender_id, recipient_id),
   FOREIGN KEY (sender_id) REFERENCES user(id),
   FOREIGN KEY (recipient_id) REFERENCES user(id)
);



/* Получить список постов с сортировкой по популярности и вместе с именами авторов и типом контента */
SELECT  p.publishedAt,
        p.title,
        p.content,
        p.image,
        p.video,
        p.link,
        p.views
FROM post AS p
         LEFT JOIN user AS u ON p.user_id = u.id
ORDER BY p.views DESC, p.id ASC;

/* Получить список постов для конкретного пользователя */
SELECT  p.publishedAt,
        p.title,
        p.content,
        p.image,
        p.video,
        p.link,
        p.views
FROM post AS p
WHERE p.user_id = 1;

/* Получить список комментариев для одного поста (1), в комментариях должен быть логин пользователя */
SELECT  c.publishedAt AS comment_date,
        c.content AS comment,
        u.login AS user_login
FROM comment AS c
         INNER JOIN user AS u ON c.user_id = u.id
WHERE c.post_id = 1
