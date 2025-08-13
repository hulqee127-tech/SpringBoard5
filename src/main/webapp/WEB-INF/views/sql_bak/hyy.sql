select md5('1234') from dual; -- 안됨
SELECT RAWTOHEX(DBMS_CRYPTO.HASH(TO_CLOB(TO_CHAR(1234)), 2)) p from dual;
SELECT RAWTOHEX(DBMS_CRYPTO.HASH(TO_CLOB(TO_CHAR('1234')), 1)) from dual;
SELECT RAWTOHEX(DBMS_CRYPTO.HASH(TO_CLOB(TO_CHAR('1234')), 3)) from dual;

select count(*) cnt from test_user where upper(id)='hyy';
select * from test_user;
update test_user set del_flag='Y' where id='hyy1';
select * from test_user where upper(id)='HYY1';
delete from test_user;
drop table TEST_USER;
commit;

insert into 
test_user 
values (
    (select NVL(MAX(SEQ),0)+1 seq from TEST_USER),
    'test1'
    ,(SELECT RAWTOHEX(DBMS_CRYPTO.HASH(TO_CLOB(TO_CHAR(1234)), 2)) p from dual)
    ,sysdate
    ,'N'
);