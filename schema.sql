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
     `post_author_id` INT UNSIGNED NOT NULL,
     `post_content_type_id` INT UNSIGNED NOT NULL,
     `image` TEXT,
     `video` TEXT,
     `website_link` TEXT,
     `views_quantity` INT UNSIGNED DEFAULT 0,
     `post_hashtag_id` INT UNSIGNED,
     `creation_date` DATETIME DEFAULT CURRENT_TIMESTAMP,

     CONSTRAINT `post_author`
     FOREIGN KEY (`post_author_id`) REFERENCES `users` (`id`)
     ON UPDATE CASCADE
     ON DELETE CASCADE,

    CONSTRAINT `post_content_type`
     FOREIGN KEY (`post_content_type_id`) REFERENCES `content_types` (`id`)
         ON UPDATE CASCADE
         ON DELETE CASCADE,

    CONSTRAINT `post_hashtag`
     FOREIGN KEY (`post_hashtag_id`) REFERENCES `hashtags` (`id`)
         ON UPDATE CASCADE
         ON DELETE CASCADE
    );

CREATE TABLE IF NOT EXISTS comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    `comment_content` TEXT,
    `comment_author_id` INT UNSIGNED NOT NULL,
    `comment_post_id` INT UNSIGNED NOT NULL,
    `creation_date` DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT `comment_author`
    FOREIGN KEY (`comment_author_id`) REFERENCES `users` (`id`)
    ON UPDATE CASCADE
    ON DELETE CASCADE,

    CONSTRAINT `comment_post`
        FOREIGN KEY (`comment_post_id`) REFERENCES `posts` (`id`)
            ON UPDATE CASCADE
            ON DELETE CASCADE
    );

CREATE TABLE IF NOT EXISTS likes (
      `like_author_id` INT UNSIGNED NOT NULL,
      `like_post_id` INT UNSIGNED NOT NULL,


      CONSTRAINT `like_author`
          FOREIGN KEY (`like_author_id`) REFERENCES `users` (`id`)
              ON UPDATE CASCADE
              ON DELETE CASCADE,

      CONSTRAINT `like_post`
          FOREIGN KEY (`like_post_id`) REFERENCES `posts` (`id`)
              ON UPDATE CASCADE
              ON DELETE CASCADE

    );

CREATE TABLE IF NOT EXISTS subs (
    `subs_from_id` INT UNSIGNED NOT NULL,
    `subs_to_id` INT UNSIGNED NOT NULL,

    CONSTRAINT `subs_from`
    FOREIGN KEY (`subs_from_id`) REFERENCES `users` (`id`)
    ON UPDATE CASCADE
    ON DELETE CASCADE,

    CONSTRAINT `subs_to`
        FOREIGN KEY (`subs_to_id`) REFERENCES `users` (`id`)
            ON UPDATE CASCADE
            ON DELETE CASCADE
    );

CREATE TABLE IF NOT EXISTS message (
    `id` INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    dt_add TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    content TEXT,
    `sender_id` INT UNSIGNED NOT NULL,
    `recipient_id` INT UNSIGNED NOT NULL,

    CONSTRAINT `sender`
    FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`)
    ON UPDATE CASCADE
    ON DELETE CASCADE,

    CONSTRAINT `recipient`
        FOREIGN KEY (`recipient_id`) REFERENCES `users` (`id`)
            ON UPDATE CASCADE
            ON DELETE CASCADE
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
