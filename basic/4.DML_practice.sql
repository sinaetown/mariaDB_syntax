-- INSERT Practice
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

-- UPDATE Practice
-- author 데이터 중 id가 4인 데이터를 email과 name을 변경
UPDATE author set email='abc@naver.com', name='abc' where id=4;

-- Delete Practice
-- post에 글쓴 적이 없는 author 데이터 1개 삭제
delete from author where id=5; 

-- post에 글쓴 적이 있는 author 데이터 1개 삭제 -> 에러 -> 조치 후 삭제

-- 연동이  되어있어서 에러남!
delete from author where id=3; 

-- 조치방법 1.
delete from post where author_id=3;
delete from author where id=3; 
-- 2. or just make it as NULL
update post set author_id=NULL where author_id=3;
delete from author where id=3; 

-- author 삭제해도 글은 그대로 유지시키는 연습 
insert into author(id, name, email) values 
(1, 'kim', 'abc@naver.com');
insert into author(id, name, email) values 
(2, 'amy', 'amy@naver.com');
insert into author(id, name, email) values 
(3, 'bob', 'bob@google.com');
insert into author(id, name, email) values 
(4, 'chris', 'chris@google.com');
insert into author(id, name, email) values 
(5, 'david', 'david@yahoo.com');

insert into post(id, title, contents, author_id) values
(1, 'hello', 'world', 2);
insert into post(id, title, contents, author_id) values
(2, 'good', 'morning', 3);
insert into post(id, title, contents) values
(3, 'happy', 'holiday');
insert into post(id, title, contents) values
(4, 'merry', 'christmas');
insert into post(id, title, contents) values
(5, 'thank', 'you');

-- 1 PRACTICE
UPDATE POST SET AUTHOR_ID=NULL WHERE AUTHOR_ID IS NOT NULL;
delete from author;
select * from post order by title, contents desc limit 3;

-- 2 PRACTICE
ALTER TABLE AUTHOR ADD COLUMN AGE TINYINT UNSIGNED;
SELECT * FROM AUTHOR;

ALTER TABLE POST ADD COLUM PRICE DECIMAL(10,3);

--3 ENUM PRACTICE
-- role 타입을 enum타입으로 변경하고
-- 'user', 'admin'으로 enum 타입 지정, not null로 설정,
-- 입력이 없을 시에는 'user'로 세팅되도록 default 설정
-- admin으로 데이터 세팅 후 insert
-- super-user 데이터로 insert
-- role 데이터 없이 insert
update author set role='admin' where id=1 or id=3;
insert into author(id, name, email, role) values (2, 'Drake', 'drake@gmail.com', 'user');

insert into author(id, name, email) values (3, 'Jake', 'jake@gmail.com');
alter table author modify column role enum('user', 'admin') not null default 'user';

-- 4 DATETIME PRACTICE
-- post 테이블에 DATETIME으로 created_time 칼럼 추가 및 default로 현재 시간 들어가도로 ㄱ설정
-- datetime(6) default current_timestamp(6)
-- 칼럼 추가 후 insert 테스트

alter table post add column created_time DATETIME(6) default current_timestamp(6);
insert into post(id, title, contents) values(6, 'hello', 'bye');

-- 5 Operator Practice
select * from post where id not in (1,2,4);
select * from post where id between 2 and 4;
select * from post where id >= 2 AND id <=4;
select * from post where id = 2 || id = 3 || id = 4;
select * from post where not (id < 2 OR id > 4);

-- LIKE Practice
select * from author where name like "%a%";
select * from author where name like "%e";
select * from author where name like "d%";

select * from author where name not like "%a%";
select * from author where name not like "%e";
select * from author where name not like "d%";


-- CONSTARINT 
-- 제약 조건 걸면 인덱스 자동 생성
-- 제약조건/인덱스 한 쪽만 삭제하면 다른 한 쪽도 자동 삭제

-- 방법 1.
-- 제약조건 걸기
alter table author moidfy column email varchar(255) unique;
-- 제약조건 확인
SELECT * FROM information_schema.table_constraints WHERE TABLE_NAME = 'author';
-- 인덱스 확인
show index from author;
-- index 삭제
alter table author drop index email; 

-- 방법 2.
alter table author add constraint author_unique unique(email);
-- 제약조건 확인
SELECT * FROM information_schema.table_constraints WHERE TABLE_NAME = 'author';
-- 인덱스 확인
show index from author;

-- FOREIGN KEY ON DELETE / ON UPDATE
foreign key(author_id) references author(id) on update cascade;
-- => 


----------------------------------------
select * from information_schema.key_column_usage where table_name = 'post';
alter table post drop foreign key post_ibfk_1; --기존의 fk 삭제
show index from post; --index 남아있어
alter table post drop index author_id; --index 삭제해주기
alter table post add constraint post_author_fk foreign key(author_id) references author(id) on update cascade;

-- author id를 update 했을 때 post에 author_id가 같이 바뀌었는지 확인
update author set id = 10 where id = 1;

----------------------------------------
-- CASE WHEN PRACTICE
-- ex) post테이블에서 id, title, contents, author_id의 경우, author_type이라는 이름으로 조회, author_id가 1인 경우 
select id, title, contents, 
case author_id
when 1 then 'First Author'
when 2 then 'Second Author'
else 'Others'
end
as author_type from post;

--ex) for checking null:
select id, title, contents, 
case
when author_id=1 then 'First Author'
when author_id=2 then 'Second Author'
when author_id is null then 'Anonymous'
else 'Others'
end
as author_type from post;

-- IF Practice
-- ex) null이 아니면 author_id 출력, null이면 anonymous 출력
select id, title, contents,ifnull(author_id, 'anonymous');

-- ex) if문 사용해서 만약 id가 1이면 first author, 그렇지 않으면 others
-- id, title, contents, author_type 순서대로 표현!
select id, title, contents,
if(author_id=1, 'first author', 'others') 
as author_type from post;

-- ex) 위에서 사용한 ifnull의 결과값을 동일하게 if문으로 출력
select id, title, contents, 
if (author_id is null, 'anonymous', author_id)
as author_type from post;