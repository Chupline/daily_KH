-- jspexam 계정으로 로그인하여 아래 두 개의 테이블을 생성한다.
create table ITEM (
ITEM_ID int not null primary key,
NAME varchar(100)
) engine=InnoDB default character set = utf8;
create table ITEM_DETAIL (
ITEM_ID int not null primary key,
DETAIL varchar(200)
) engine=innodb default character set = utf8;
