--------------------------------------------------------------------------------

-- INSERT PRACTICE

insert into author(id, name, email) values 
(1, 'kim', 'abc@naver.com');
insert into author(id, name, email, password, role, address) values 
(2, 'amy', 'amy@naver.com', '123', 'teacher', NULL);
insert into author(id, name, email, password, role, address) values 
(3, 'bob', 'bob@google.com', '456', 'doctor', NULL);
insert into author(id, name, email, password, role, address) values 
(4, 'chris', 'chris@google.com', '789', 'engineer', NULL);
insert into author(id, name, email, password, role, address) values 
(5, 'david', 'david@yahoo.com', '1011', 'scientist', NULL);
insert into author(id, name, email, password, role, address) values 
(6, 'eric', 'eric@yahoo.com', '1213', 'chef', NULL);

select * from author;

insert into post(id, title, contents, author_id) values
(1, 'hello', 'world', 2);
insert into post(id, title, contents, author_id) values
(2, 'good', 'morning', 3);
insert into post(id, title, contents, author_id) values
(3, 'happy', 'holiday', NULL);
-- NULL은 안 쳐도 됨! -> leave it as blank
insert into post(id, title, contents) values
(4, 'merry', 'christmas');
-- 에러 발생
insert into post(id, title, contents, author_id) values
(5, 'thank', 'you', 7);

select * from post;

--------------------------------------------------------------------------------

-- UPDATE PRACTICE

-- author 데이터 중 id가 4인 데이터를 email과 name을 변경
UPDATE author set email='abc@naver.com', name='abc' where id=4;

-- DELETE PRACTICE
-- post에 글쓴 적이 없는 author 데이터 1개 삭제
delete from author where id=5; 

-- post에 글쓴 적이 있는 author 데이터 1개 삭제 -> 에러 -> 조치 후 삭제
-- 연동이 되어있어서 에러남!
delete from author where id=3; 

-- 조치방법 1.
delete from post where author_id=3;
delete from author where id=3;

-- 조치방법 2. Make it as NULL
update post set author_id = NULL where author_id=3;
delete from author where id=3; 

-- author 삭제해도 글은 그대로 유지시키는 연습 
-- 1 PRACTICE
-- 조치방법 2 사용
DELETE FROM author;
UPDATE POST SET AUTHOR_ID = NULL WHERE AUTHOR_ID IS NOT NULL; 
SELECT * FROM post order by title, contents desc limit 3;

--------------------------------------------------------------------------------

-- 숫자타입 
ALTER TABLE AUTHOR ADD COLUMN AGE TINYINT UNSIGNED;
SELECT * FROM AUTHOR;
ALTER TABLE POST ADD COLUM PRICE DECIMAL(10,3);

--------------------------------------------------------------------------------

-- ENUM PRACTICE

-- 1) role column의 타입을 ENUM 타입으로 변경
-- 2) 'user', 'admin'으로 ENUM 타입 지정 & not null로 설정
-- 3) 입력이 없을 시에는 'user'로 세팅되도록 default 설정
alter table author modify column role enum('user', 'admin') not null default 'user';

-- TRY1) admin으로 데이터 세팅 후 insert
-- TRY2)super-user 데이터로 insert
-- TRY3) role 데이터 없이 insert
update author set role='admin' where id=1 or id=3;
insert into author(id, name, email, role) values (2, 'Drake', 'drake@gmail.com', 'user');
insert into author(id, name, email) values (3, 'Jake', 'jake@gmail.com');

--------------------------------------------------------------------------------

-- DATETIME PRACTICE

-- post 테이블에 DATETIME으로 created_time 칼럼 추가 및 default로 현재 시간 들어가도록 설정
-- 칼럼 추가 후 insert 테스트

alter table post add column created_time DATETIME(6) default current_timestamp(6);
insert into post(id, title, contents) values(6, 'hello', 'bye');

--------------------------------------------------------------------------------

-- OPERATOR PRACTICE

select * from post where id not in (1,2,4);
select * from post where id between 2 and 4;
select * from post where id >= 2 AND id <=4;
select * from post where id = 2 || id = 3 || id = 4;
select * from post where not (id < 2 OR id > 4);

--------------------------------------------------------------------------------

-- LIKE PRACTICE

select * from author where name like "%a%";
select * from author where name like "%e";
select * from author where name like "d%";

select * from author where name not like "%a%";
select * from author where name not like "%e";
select * from author where name not like "d%";

--------------------------------------------------------------------------------
-- CAST PRACTICE

SELECT CAST (20200101 AS DATE); 
-- 2020-01-01로 출력

SELECT CONVERT ('2020-01-01', DATE);
-- 2020-01-01로 출력

SELECT CONVERT ('2020-01-01', DATETIME);
-- 2020-01-01 00:00:00으로 출력

SELECT DATE_FORMAT('2020-01-01 15:12:30', '%Y-%m-%d');
-- 2020-01-01로 출력

SELECT * FROM author WHERE DATE_FORMAT(created_time, '%Y-%m-%d') = '2020-01-01';

--Try) now()를 활용해서 오늘 날짜에 생성된 데이터 출력하기
select * from post where date_format(created_time, "%Y-%m-%d") = date_format(now(),  "%Y-%m-%d");

--------------------------------------------------------------------------------

-- CONSTRAINT PRACTICE

-- 제약 조건 걸면 인덱스 자동 생성
-- 제약조건/인덱스 한 쪽만 삭제하면 다른 한 쪽도 자동 삭제

NOT NULL PRACTICE
--TRY) ALTER 문으로 post의 title를 NOT NULL 조건으로 바꾸기
ALTER TABLE post MODIFY COLUMN title VARCHAR(255) not null;

-- AUTO INCREMENT PRACTICE
--TRY) author, post 테이블의 id에 AUTO_INCREMENT로 바꾸기
ALTER TABLE post MODIFY COLUMN id INT AUTO_INCREMENT;

-- PRIMARY KEY PRACTICE
...

-- FOREIGN KEY PRACTICE

--ex)
ALTER TABLE post ADD CONSTRAINT
post_author_fk FOREIGN KEY(author_id) REFERENCES author(id) ON UPDATE cascade;

SELECT * FROM information_schema.key_column_usage WHERE table_name = 'post';
ALTER TABLE post DROP FOREIGN KEY post_ibfk_1; --기존의 fk 삭제
show index FROM post; --index 남아있어
ALTER TABLE post DROP INDEX author_id; --index 삭제해주기


-- 제약조건 걸기 modify나  add constraint 둘 중 하나 사용 가능
ALTER TABLE post ADD CONSTRAINT
post_author_fk FOREIGN KEY(author_id) REFERENCES author(id) ON UPDATE cascade;
-- OR
ALTER TABLE post ADD CONSTRAINT
second_fk FOREIGN KEY(author_id) REFERENCES author(id) ON DELETE SET NULL;

-- author id를 update 했을 때 post에 author_id가 같이 바뀌었는지 확인
UPDATE author SET id = 10 WHERE id = 1;

--------------------------------------------------------------------------------

-- UNIQUE PRACTICE

-- 방법 1 - MODIFY 사용.
-- 제약조건 걸기
ALTER TABLE author MODIFY COLUMN email VARCHAR(255) UNIQUE;
-- 제약조건 확인
SELECT * FROM information_schema.table_constraints WHERE TABLE_NAME = 'author';
-- 인덱스 확인
SHOW INDEX FROM author;
-- index 삭제
ALTER TABLE author DROP INDEX email; 

-- 방법 2 - ADD CONSTRAINT 사용.
ALTER TABLE author add constraint author_unique unique(email);
-- 제약조건 확인
SELECT * FROM information_schema.table_constraints WHERE TABLE_NAME = 'author';
-- 인덱스 확인
show index from author;

-- DEFAULT PRACTICE

ALTER TABLE author ADD create_at DATETIME DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE post ADD create_at DATETIME DEFAULT CURRENT_TIMESTAMP;

--------------------------------------------------------------------------------

-- CASE WHEN PRACTICE

-- TRY) post테이블에서 id, title, contents, author_id의 경우, author_type이라는 이름으로 조회, author_id가 1인 경우 
select id, title, contents, 
case author_id
when 1 then 'First Author'
when 2 then 'Second Author'
else 'Others'
end
as author_type from post;

-- TRY) for checking null:
select id, title, contents, 
case
when author_id=1 then 'First Author'
when author_id=2 then 'Second Author'
when author_id is null then 'Anonymous'
else 'Others'
end
as author_type from post;

--------------------------------------------------------------------------------

-- IF Practice

-- TRY1) null이 아니면 author_id 출력, null이면 anonymous 출력
select id, title, contents,ifnull(author_id, 'anonymous');

-- TRY2) if문 사용해서 만약 id가 1이면 first author, 그렇지 않으면 others
-- id, title, contents, author_type 순서대로 표현!
select id, title, contents,
if(author_id=1, 'first author', 'others') 
as author_type from post;

-- TRY3) TRY1에서 사용한 ifnull의 결과값을 동일하게 if문으로 출력
select id, title, contents, 
if (author_id is null, 'anonymous', author_id)
as author_type from post;

--------------------------------------------------------------------------------

-- TRANSCATION PRACTICE

-- ex1)
insert into author(id, name, email) values(2, 'test', 'test@naver,com');
insert into post(title, contents, author_id) values('hello', 'hello is', 10);
-- - 위 코드 실행후 commit하면 첫번째 쿼리만 확정
-- - 위 코드 실행후 rollback하면 모두 취소

-- ex2)
insert into author(id, name, email) values(1, 'test', 'test@naver,com');
commit;
insert into author(id, name, email) values(2, 'test2', 'test2@naver,com');
insert into post(title, contents, author_id) values('hello', 'hello is', 10);
-- - 첫번째 쿼리는 commit되어 확정
-- - 두번째 쿼리는 실행은 되나 세번째 쿼리 실행이후 rollback을 하게 되면 함께 rollback되므로, 하나의 논리적인 transaction으로 볼 수 있음
-- - 일반적으로는 사용자가 위와 같은 쿼리를 실행시킬수는 없으니, 프로그램에서 논리적인 트랜잭션을 지정하고, 전체 commit 또는 전체 rollback하는 명령을 실행

rollback;

--------------------------------------------------------------------------------

-- INNER JOIN PRACTICE
select * from author as a inner join post as p on a.id = p.author_id;

-- LEFT JOIN PRACTICE
select * from author as a left join post as p on a.id = p.author_id;
select a.name from author as a left join post as p on a.id = p.author_id where p.title = "PURPLE";

-- TRY1)
select a.name, p.title from author a inner join post p on a.id=p.author_id;

-- TRY2)
select a.name, p.title from author a left join post p on a.id=p.author_id;

-- TRY3)
select a.name, p.title from author a left join post p on a.id=p.author_id where a.age >= 25;

--------------------------------------------------------------------------------

-- SUBQUERY

-- BELOW ONES ARE THE SAME :/ 
SELECT a.* FROM author a INNER JOIN post p ON a.id = p.author_id;
SELECT a.* FROM author a WHERE a.ID IN (SELECT p.author_id FROM post p);

--------------------------------------------------------------------------------

-- GROUP BY

-- ex) POST의 PRICE에 적절한 값을 넣어놓고, AVG, MIN, MAX, SUM 구하기

SELECT ROUND(AVG(price),0) AS AVG_PRICE FROM POST; 
-- 소숫점 0번째 자리까지 반올림, NULL값은 아에 분모로도 세지 않음

SELECT MIN(PRICE) FROM POST;
SELECT MAX(PRICE) FROM POST;
SELECT SUM(PRICE) FROM POST;

-- ex) author_id별 count, price sum, pricea avg 구하기
SELECT AUTHOR_ID, COUNT(*) FROM POST GROUP BY AUTHOR_ID;
SELECT AUTHOR_ID, SUM(PRICE) FROM POST GROUP BY AUTHOR_ID;
SELECT AUTHOR_ID, ROUND(AVG(PRICE),1) FROM POST GROUP BY AUTHOR_ID;

-- TRY1) AUTHOR_ID별로 PRICE 평균값을 구하라. 단, 건 별로 30 이상인 데이터만 평균을 내서 출력하라.
SELECT AVG(PRICE), AUTHOR_ID FROM POST WHERE PRICE >= 30 GROUP BY AUTHOR_ID;

-- TRY2) AUTHOR_ID별로 PRICE 평균값을 구하되 그룹별 평균값이 30 이상인 것만 출력하라.
SELECT AVG(PRICE) AS AVG_PRICE, AUTHOR_ID FROM POST GROUP BY AUTHOR_ID HAVING AVG_PRICE >= 30;

-- TRY3) 1+2
SELECT AVG(PRICE) AS AVG_PRICE, AUTHOR_ID FROM POST WHERE PRICE >= 30 GROUP BY AUTHOR_ID HAVING AVG_PRICE >= 39;

--------------------------------------------------------------------------------

-- COUNT, AVG, MIN, MAX ,SUM

-- POST의 PRICE에 적절한 값을 넣어놓고,
-- AVG, MIN, MAX, SUM 구하기

SELECT COUNT(*) FROM POST;
SELECT ROUND(AVG(price),0) AS AVG_PRICE FROM POST; 
-- 소숫점 0번째 자리까지 반올림, NULL값은 아에 분모로도 세지 않음

SELECT MIN(PRICE) FROM POST;
SELECT MAX(PRICE) FROM POST;
SELECT SUM(PRICE) FROM POST;

--------------------------------------------------------------------------------

-- HAVING

-- AUTHOR_ID별로 PRICE 평균값을 구하라. 단, 건 별로 30 이상인 데이터만 평균을 내서 출력하라.
SELECT AVG(PRICE), AUTHOR_ID FROM POST WHERE PRICE >= 30 GROUP BY AUTHOR_ID;

-- AUTHOR_ID별로 PRICE 평균값을 구하되 그룹별 평균값이 30 이상인 것만 출력하라.
SELECT AVG(PRICE) AS AVG_PRICE, AUTHOR_ID FROM POST GROUP BY AUTHOR_ID HAVING AVG_PRICE >= 30;

-- 1+2
SELECT AVG(PRICE) AS AVG_PRICE, AUTHOR_ID FROM POST WHERE PRICE >= 30 GROUP BY AUTHOR_ID HAVING AVG_PRICE >= 39;

--------------------------------------------------------------------------------

-- WITH RECURSIVE

WITH RECURSIVE number_seq(HOUR) AS (
	SELECT 0
	UNION ALL
	SELECT HOUR + 1 FROM number_seq WHERE HOUR < 23;
)
SELECT HOUR, 0 AS COUNT FROM number_seq;

--------------------------------------------------------------------------------

-- INDEX PRACTICE

create index author_name on author(name);
create index name_with_email on author(name, email);
select * from author;
show index from author;
select * from author where name='Summer' and email='summer@gmail.com';

--------------------------------------------------------------------------------

-- 사용자 관리 PRACTICE

GRANT SELECT ON board.author TO 'userme'@'localhost';
GRANT INSERT ON board.author TO 'userme'@'localhost';
REVOKE INSERT ON board.author FROM 'userme'@'localhost';
FLUSH PRIVILEGES;
SHOW GRANTS FOR 'userme'@'localhost';

--------------------------------------------------------------------------------

-- VIEW PRACTICE

create view viewer as 
select name, email from author;

select * from viewer;

--------------------------------------------------------------------------------

-- PROCEDURE PRACTICE

-- TRY1)
DELIMITER //
CREATE PROCEDURE getUser(IN userId INT)
BEGIN
SELECT * FROM AUTHOR WHERE ID = USERID;
END//
DELIMITER;

-- TRY2)
USE BOARD;
DELIMITER // 
CREATE PROCEDURE insert_prac(IN t VARCHAR(255), IN c VARCHAR(255), IN id INT)
BEGIN
INSERT INTO post(title, contents, author_id) values (t, c, id);
END //
DELIMITER ;

CALL insert_prac("hellothere", "it's a test!", 4);

-- TRY3) PRINT
SELECT "HI" AS MESSAGE;

-- TRY4) IF
-- post 테이블에 if문 활용해서 고액 원고료 작가 조회
DELIMITER //
CREATE PROCEDURE postPriceChk(IN a_id INT)
BEGIN 
DECLARE avg_price INT DEFAULT 0;
SELECT AVG(PRICE) INTO avg_price from post
where author_id = a_id;
IF avg_price > 1000 THEN
SELECT "고액 원고료 작가입니다!" AS RESULT;
ELSE 
SELECT "고액 원고료 작가가 아닙니다!" AS RESULT;
END IF;
END //
DELIMITER ;

-- TRY5) WHILE
DELIMITER //
CREATE PROCEDURE adder()
BEGIN 
DECLARE cnt INT DEFAULT 0;
WHILE cnt < 100 DO
INSERT INTO post(title) values (concat("Minion Number ", cnt));
set cnt = cnt + 1;
END WHILE;
END //
DELIMITER ; 

--------------------------------------------------------------------------------

-- DB DUMP
-- from workbench to .sql file
mysqldump -u root -p --default-character-set=utf8mb4 board > dumpfile.sql

-- from .sql file to workbench 
mysql -u root -p board < dumpfile.sql

--------------------------------------------------------------------------------

-- LINUX

sudo apt-get -y upgrade
sudo apt-get install -y mariadb-server
sudo systemctl start mariadb
sudo systemctl enable mariadb
sudo mariadb -u root -p
create database board;
exit

git clone https://github.com/sinaetown/mariaDB_syntax.git
cd 이동할_폴더 (dumpfile있는 곳으로)
sudo mysql -u root -p board < dumpfile.sql

scp
파일전송관련 명령어도 사용가능
ex) scp [src] [dst]
ex) scp test.txt 127.0.0.1

--------------------------------------------------------------------------------

-- post_authors Practice
-- 한 포스트를 쓴 사람'들'의 이름 구하기

-- create author_address table
create table author_address(id INT, country VARCHAR(255), 
state_city VARCHAR(255), details VARCHAR(255), 
zip_code VARCHAR(255), phonenumber VARCHAR(255), 
foreign key(id) references author(id) on delete cascade, unique(author_id));

-- create post_authors
create table post_authors(id INT, post_id INT, author_id INT, primary key(id), 
foreign key(post_id) references post(id), 
foreign key(author_id) references author(id));

-- TEST CASE 
-- STEP 1. INSERT VALUES

insert into author(id, name, email) values(1, "Summer", "summer@gmail.com");
insert into author(id, name, email) values(2, "Tom", "tom@naver.com");
insert into author(id, name, email) values(3, "Penny", "penny@yahoo.com");

insert into post(id, title, contents) values(1, "Good", "Morning!");
insert into post(id, title, contents) values(2, "Happy", " Holidays!");
insert into post(id, title, contents) values(3, "Merry", "Christmas!");

insert into post_authors(id, post_id, author_id) values (1, 1, 1);
insert into post_authors(id, post_id, author_id) values (2, 1, 2);
insert into post_authors(id, post_id, author_id) values (3, 2, 3);
insert into post_authors(id, post_id, author_id) values (4, 3, 1);
insert into post_authors(id, post_id, author_id) values (5, 3, 2);
insert into post_authors(id, post_id, author_id) values (6, 3, 3);

-- STEP 2. TEST CASE
select post.title, author.name from post left join post_authors on post_id = post.id  
left join author on  post_authors.author_id = author.id;

-------------------------------------------------------------------------------

-- Ordersystem Practice

-- Create members table
create table members(id INT not null auto_increment, name VARCHAR(255) not null, 
email VARCHAR(255) not null, password VARCHAR(255) not null, 
role enum('user', 'admin', 'seller') default 'user', 
primary key(id));

-- Create item table
create table items(id INT not null auto_increment, product_name VARCHAR(255) not null, 
product_price decimal(10,3) not null, product_number BIGINT not null,
seller_id INT not null, foreign key(seller_id) references members(id),
primary key(id));  


-- Create orders table
create table orders(id INT not null auto_increment, member_id INT not null,
ordered_date DATETIME default current_timestamp,
primary key(id),
foreign key(member_id) references members(id));

-- Create orders_details table

create table orders_details(id INT not null auto_increment, order_id INT not null, item_id INT not null,
ordered_num INT NOT NULL, primary key(id),
foreign key(order_id) references orders(id),
foreign key(item_id) references items(id));

-- Insert into members

insert into members(id, name, email, password, role) values (1, "Summer", "summer@gmail.com", "summer123", 'admin');
insert into members(id, name, email, password, role) values (2, "Jake", "jake@gmail.com", "jake123", 'user');
insert into members(id, name, email, password) values (3, "Tom", "tom@naver.com", "tom123");
insert into members(id, name, email, password, role) values (4, "Kyle", "kyle@yahoo.com", "kyle123", 'user');
insert into members(id, name, email, password, role) values (5, "Ella", "ella@yahoo.com", "ella1223", 'seller');

-- Insert into items

insert into items(id, product_name, product_price, product_number, seller_id) 
values (1, "book", 13.2, 50, 1);

insert into items(id, product_name, product_price, product_number, seller_id) 
values (2, "laptop", 492.1, 10, 2);

insert into items(id, product_name, product_price, product_number, seller_id) 
values (3, "phone", 290.8, 20, 3);

insert into items(id, product_name, product_price, product_number, seller_id) 
values (4, "pear", 4.2, 300, 4);

insert into items(id, product_name, product_price, product_number, seller_id) 
values (5, "apple", 1.7, 450, 5);

-- Insert into orders

insert into orders(id, member_id) values (1, 1);
insert into orders(id, member_id) values (2, 2);
insert into orders(id, member_id) values (3, 2);
insert into orders(id, member_id) values (4, 1);
insert into orders(id, member_id) values (5, 2);

-- Insert into orders_details
insert into orders_details(id, order_id, item_id, ordered_num) 
values(1, 1, 1, 10);

insert into orders_details(id, order_id, item_id, ordered_num) 
values(2, 1, 2, 20);

insert into orders_details(id, order_id, item_id, ordered_num) 
values(3, 2, 1, 30);

-- Test Cases (Making Transactions)

-- 1) Seller 회원 가입 -> seller가 상품등록 (사과, 바나나)

insert into members(id, name, email, password, role) values (6, "Ed", "ed@gmail.com", "edd123", 'seller');
insert into items(id, product_name, product_price, product_number, seller_id) 
values ("LEGO", 5.1, 1, 6);
insert into items(id, product_name, product_price, product_number, seller_id) 
values (7, "toy gun", 18.33, 1, 6);


insert into members(id, name, email, password, role) values (7, "Sofia", "sofia@gmail.com", "sofia123", 'seller');
insert into items(product_name, product_price, product_number, seller_id) 
values ("shoes", 78.1, 1, 6);
insert into items(product_name, product_price, product_number, seller_id) 
values ("microphone", 400, 3, 9);

-- 2) customer 가 회원가입


-- 3) order테이블에 insert, orders_details에 insert, 재고 update