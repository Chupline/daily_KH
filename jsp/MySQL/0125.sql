-- drop table member;
create table member (
memberid varchar(10) not null primary key,
password varchar(10) not null,
name varchar(20) not null,
email varchar(80)
) engine=innodb default character set = utf8;

insert into member (memberid,password,name) values ('madvirus','1234','최범균');
insert into member values ('eral3','5678','최범균','madvirus@madvirus.net');

-- drop table member_etc;
create table member_etc (
memberid varchar(10) not null primary key,
birthday char(8)
) engine=innodb default character set = utf8;

-- drop table member_history;
create table member_history (
memberid varchar(10) not null primary key,
history long varchar
) engine=innodb default character set = utf8;

insert into member_history values ('madvirus',
concat(
'2015 스프링4 프로그래밍입문<br>',
'2013 Spring4.0 프로그래밍<br>',
'2012 객체 지향과 디자인 패턴<br>',
'2012 JSP 2.2 웹프로그래밍\n'
)
);
