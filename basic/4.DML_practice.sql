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


UPDATE POST SET AUTHOR_ID=NULL WHERE AUTHOR_ID IS NOT NULL;
delete from author;
select * from post order by title, contents desc limit 3;