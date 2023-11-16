
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
insert into post(id, title, contents, author_id) values
(4, 'merry', 'christmas', NULL);
insert into post(id, title, contents, author_id) values
(5, 'thank', 'you', 7);

select * from post;