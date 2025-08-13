번호	숫자(6) 기본키 자동증가
이름	문자(30) 필수입력
아이디	문자(15) 필수입력
암호	문자(15) 필수입력
이메일	문자(320)
가입일  날짜	기본값 오늘


drop table tuser;

create table tuser(
id number(6) primary key,
name varchar2(30) not null,
userid varchar(15) not null unique,
passwd varchar(15) not null,
email varchar(320),
regdate date default sysdate
);

drop sequence seqid;
create sequence seqid;
select SEQID.currval from dual;

select id, name, userid, passwd, email, regdate from tuser;

insert into tuser (id, name, userid, passwd, email) 
values (seqid.nextval, 'id_1','name_1','passwd_1','email_1@email.com');
commit;

update tuser set name='name_1',userid='id_1',email='EMAIL_01@email.com'
where id=1;
commit;

delete from tuser where userid='id_1' and passwd='passwd_1';
commit;
