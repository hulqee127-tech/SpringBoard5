select count(*) cnt from zipcode;

select * from zipcode order by num asc;

select ceil(52144/10) from dual;


select ceil(count(*) / 10) page_num
from zipcode
where seq between 1 and 101;

select * from (
select 
    NUM
    ,ZIPCODE
    ,SIDO
    ,GUGUN
    ,DONG
    ,BUNJI
    ,SEQ
--    , rank() over (order by num desc) n
--    ,rownum n
    ,row_number() over (order by num asc) n
from zipcode order by num asc --where dong like '%롯데%'
)
where n between 11 and 20 ;

-- mysql
--select 
--    NUM ,ZIPCODE ,SIDO ,GUGUN ,DONG ,BUNJI ,SEQ
--from zipcode
--limit 0, 10;

-- oracle ( offset : 기준점에서 얼마 만큼 떨어져 있는가....
--set timing on
select 
    NUM ,ZIPCODE ,SIDO ,GUGUN ,DONG ,BUNJI ,SEQ
from zipcode order by num asc
offset 30 rows fetch next 10 rows only;


-- 테이블만 복사
create table zipcode2 as
select * from zipcode
where 1=0;

-- 테스트용 샘플 데이터 추가 하기
truncate table zipcode2;
declare
    data1 varchar2(100) := '샘플동';
begin
    for i in 1 .. 10000 
    loop
        insert into zipcode2 (num, zipcode, sido, gugun, dong, bunji, seq)
        values (i, trim(to_char(i,'0000000')), '부산','부산진구',data1||i,null,i);
    end loop;
    commit;
end;
/

select * from zipcode2;
select count(*) from zipcode2;