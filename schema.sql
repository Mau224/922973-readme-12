CREATE DATABASE IF NOT EXISTS `267983-readme-12`
DEFAULT CHARACTER SET utf8
DEFAULT COLLATE utf8_general_ci;

USE `267983-readme-12`;



CREATE TABLE IF NOT EXISTS users (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `email` VARCHAR(128) NOT NULL UNIQUE,
    `name` VARCHAR(128) NOT NULL UNIQUE,
    `password` char(30) NOT NULL,
    `avatar` VARCHAR(255),
    `registration_date` DATETIME DEFAULT CURRENT_TIMESTAMP
    );

CREATE TABLE IF NOT EXISTS posts (
     `id` INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
     `post_header` VARCHAR(255),
     `post_content` TEXT,
--       `user_id` INT UNSIGNED NOT NULL,
     `content_type_name` INT UNSIGNED NOT NULL, -- in `content__type`
     `image` TEXT,
     `video` TEXT,
     `website_link` TEXT,
     `views_quantity` INT UNSIGNED DEFAULT 0,
--      `hashtag_id` INT UNSIGNED,
     `creation_date` DATETIME DEFAULT CURRENT_TIMESTAMP
    );

CREATE TABLE IF NOT EXISTS comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    `comment_content` TEXT,
--     `user_id` INT UNSIGNED NOT NULL,
--     `post_id` INT UNSIGNED NOT NULL,
    `creation_date` DATETIME DEFAULT CURRENT_TIMESTAMP
    );

CREATE TABLE IF NOT EXISTS likes (
      id INT AUTO_INCREMENT PRIMARY KEY,
--       `user_id` INT UNSIGNED NOT NULL,
      `count` INT
--       `post_id` INT UNSIGNED NOT NULL
    );

CREATE TABLE IF NOT EXISTS subscriptions (
    `from_id` INT UNSIGNED NOT NULL,
    `to_id` INT UNSIGNED NOT NULL
    );

CREATE TABLE IF NOT EXISTS message (
    `id` INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `dt_add` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `content` TEXT
--     `sender_id` INT UNSIGNED NOT NULL,
--     `recipient_id` INT UNSIGNED NOT NULL
);

CREATE TABLE IF NOT EXISTS `hashtags` (
  `id` INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `hashtag_name` VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS `content_types` (
   `id` INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
   `content_type_name` ENUM('Текст', 'Цитата', 'Картинка', 'Видео', 'Ссылка'),
   `icon_class_name` ENUM('photo', 'video', 'text', 'quote', 'link')
);
