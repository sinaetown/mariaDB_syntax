ALTER TABLE post MODIFY column contents VARCHAR(3000);
ALTER TABLE author ADD COLUMN address VARCHAR(255);

SHOW CREATE TABLE post;
-- CREATE TABLE `post` (
--   `id` int(11) NOT NULL,
--   `title` varchar(255) DEFAULT NULL,
--   `contents` varchar(3000) DEFAULT NULL,
--   `author_id` int(11) DEFAULT NULL,
--   PRIMARY KEY (`id`),
--   KEY `author_id` (`author_id`),
--   CONSTRAINT `post_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci

DROP TABLE post;

