-- Author & Posts
-- Creating DB (schema) named 'board'
create database board;
use board;

-- Creating tables named 'author'
create table author(id INT, name VARCHAR(100) not null , 
email VARCHAR(255) not null, primary key(id));

-- Creating tables named 'post'
create table post(id INT, title VARCHAR(100) not null , contents VARCHAR(255), primary key(id), author_id INT, 
foreign key(author_id) references author(id));

-- When the key that foreign key references is...
-- Primary Key
create table src(id INT primary key, test_src INT);

create table dest(id INT, test_dest INT, 
foreign key(test_dest) references src(id));

-- Insert test cases:
insert into src(id, test_src) values (1, 2);
insert into dest(id, test_dest) values(1, 1);

-- When trying to exeucte this:
delete from src where id = 1;
-- DOESN'T WORK!
-- WHY? 
-- table test_dest column already references 'test_src' column in src table

-- Then what?
-- Execute this first
delete from dest where id = 1;
-- and then
delete from src where id = 1;
--WHY? 
-- remove the connection of the referenced key and the foreign key