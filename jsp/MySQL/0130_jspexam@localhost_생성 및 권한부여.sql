-- jsp chap 14강 jspexam@localhost 생성
create database chap14 default character set utf8;
create user 'jspexam'@'localhost' identified by 'jsppw';
grant all privileges on chap14.* to 'jspexam'@'localhost';
create user 'jspexam'@'%' identified by 'jsppw';
grant all privileges on chap14.* to 'jspexam'@'%';

-- jsp ddl 21강 jspexam@board에 모든 권한 부여
create database board default character set utf8;
-- create user 'jspexam'@'localhost' identified by 'jsppw';
-- create user 'jspexam'@'%' identified by 'jsppw';
GRANT ALL PRIVILEGES ON board.* TO 'jspexam'@'localhost';
GRANT ALL PRIVILEGES ON board.* TO 'jspexam'@'%';
