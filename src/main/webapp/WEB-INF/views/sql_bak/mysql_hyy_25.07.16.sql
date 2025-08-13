create table hdb.board(
num int primary key auto_increment,
title varchar(300) not null,
content text,
writer varchar(60),
wdate datetime default now(),
hit int
);



use hdb;
use information_schema;

select * from board;

insert into board (title, content, writer,wdate,hit)
values ('board_1','content_1','writer_1',sysdate(),0);

insert into board (title, content, writer,wdate,hit)
values ('board_2','content_2','writer_2',sysdate(),0);
insert into board (title, content, writer,wdate,hit)
values ('board_3','content_3','writer_3',sysdate(),0);
insert into board (title, content, writer,wdate,hit)
values ('board_4','content_4','writer_4',sysdate(),0);
insert into board (title, content, writer,wdate,hit)
values ('board_5','content_5','writer_5',sysdate(),0);



delete from board where num in (4,5);

update board set content = 'CONTENT_3으로 변경' where num=3;
update board set wdate = now() where num=3;



commit;