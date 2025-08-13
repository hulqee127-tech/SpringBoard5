--update 우리반명단 set 이름='바보서주성' where 번호 = 11;

select 번호, 이름, count(이메일) cnt from 우리반명단 group by 번호, 이름 order by cnt desc;

select 번호, 이름, 전화, 이메일, 가입일
from 우리반명단
where 이름 like '김%' 
or 이름 like '박%' 
or 이름 like '윤%'
order by 이름 asc;

select * from 우리반명단
where 이메일 not like '%naver%';

select * from 우리반명단
where 전화 like '%39%5%'