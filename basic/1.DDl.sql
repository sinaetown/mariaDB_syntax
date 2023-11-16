-- 데이터베이스 생성
CREATE DATABASE board;

-- 데이터베이스 선택
USE board;

-- --------------------------------------------

-- author 테이블 신규 생성
CREATE TABLE author(id INT, name VARCHAR(255), 
email VARCHAR(255), password VARCHAR(255), 
test1 VARCHAR(255), PRIMARY KEY (id));

-- 테이블 목록 조회
SHOW TABLES;

-- 테이블 COLUMN 조회
DESCRIBE author;

-- --------------------------------------------

-- post 테이블 신규 생성
CREATE TABLE posts(id INT PRIMARY KEY, 
title VARCHAR(255), content VARCHAR(255), 
author_id INT, FOREIGN KEY(author_id) REFERENCES author(id));

-- 테이블 목록 조회
SHOW TABLES;

-- 테이블 COLUMN 조회
DESCRIBE posts;

-- --------------------------------------------

-- 테이블 COLUMN 상세 조회
SHOW FULL COLUMNS FROM author;

-- 테이블 생성문 조회
SHOW CREATE TABLE posts;
-- CREATE TABLE `posts` (
--   `id` int(11) NOT NULL,
--   `title` varchar(255) DEFAULT NULL,
--   `content` varchar(255) DEFAULT NULL,
--   `author_id` int(11) DEFAULT NULL,
--   PRIMARY KEY (`id`),
--   KEY `author_id` (`author_id`),
--   CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci

-- 테이블 제약 조건 조회 (USE 안 하고 사용 가능)
SELECT * FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_NAME = 'posts';

-- 테이블 인덱스 조회
SHOW INDEX FROM posts;

-- --------------------------------------------

-- ALTER문
-- 테이블 이름 변경 -> ex) posts를 post로 
ALTER TABLE 테이블명 RENAME 새로운_테이블명;
-- ex) ALTER TABLE posts RENAME post;

-- 칼럼 추가 (ADD) -> role이라는 칼럼 추가
ALTER TABLE 테이블명 ADD COLUMN 칼럼명 타입 [제약 조건];
-- ex) ALTER TABLE author ADD COLUMN role VARCHAR(50);

-- 필드 타입 변경 (MODIFY) -> name 필드의 VARCHAR의 100으로 변경
ALTER TABLE 테이블명 MODIFY COLUMN 칼럼명 타입 [제약 조건];
-- ex) ALTER TABLE post MODIFY COLUMN name VARCHAR(100) NOT NULL;

-- 칼럼 이름 변경 -> content를 contents로
ALTER TABLE 테이블명 CHANGE COLUMN 기존칼럼명 새로운칼럼명 타입 [제약조건];
-- ALTER TABLE post CHANGE COLUMN content contents VARCHAR(255) NOT NULL;

-- 칼럼 삭제 -> test1 칼럼 삭제
ALTER TABLE 테이블명 DROP COLUMN 칼럼명;
-- ALTER TABLE author DROP COLUMN test1;