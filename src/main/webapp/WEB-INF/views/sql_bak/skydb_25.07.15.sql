-- 다이어그램 생성
---->파일 - data modeler - 임포트 - 데이터 딕셔너리 - 접속이름 - 스키마선택 - 테이블선택

-- 4000바이트 이상 -> CLOB(2기가), BLOB(4기가)


select * from student;
select * from scores;
commit;

insert into student (stid, stname, phone, indate) values ( 11,  '히나', '0111', SYSDATE);

-- DATA 제거
-- 1. DROP TABLE SCORES;        -- 구조까지 모두 삭제
drop table scores;
delete from student;
drop table student;
-- 2. TRUNCATE TABLE SCORES;    -- 구조만 남기고 삭제 : 속도 빠름
truncate table scores;
-- 3. DELETE FROM SCORES;   -- 한줄씩 삭제 수행
delete from scores;
rollback;

delete from student;
delete from student where stid=1;   -- ORA-02292: 무결성 제약조건(SKY.STID_FK)이 위배되었습니다- 자식 레코드가 발견되었습니다
delete from student where stid=11;  -- 정상삭제


-- 외래키 관계에서는 자식테이블의 DATA를 지우고 부모테이블의 DATA를 삭제 해야 한다.
delete from scores where stid=1;    -- 자식 테이블 DATA 먼저 삭제
delete from student where stid=1;   -- 부모 테이블 DATA 삭제
--===========================================================================
-- 4번학생의 국어 점수를 100점으로 수정
update scores set score=100 where scid=6;-- and stid=4 and subject='국어';

select * from student;
select * from scores;
-- 학번, 이름, 점수(국어)
select a.stid, a.stname, b.subject, b.score
from student a, scores b
where a.stid = b.stid
and b.subject = '국어';
  
--  학번, 이름, 총점, 평균
select a.stid, a.stname , sum(b.score), round(avg(b.score),2)
from student a, scores b
where a.stid = b.stid
--and a.stid=2
group by a.stid,a.stname;

-- 모든 학생의  학번, 이름, 총점, 평균
---- 점수가 NULL 인 학생은 미응시
select a.stid, a.stname , sum(b.score), round(avg(b.score),2)
from student a left outer join scores b
on a.stid = b.stid
--and a.stid=2
group by a.stid,a.stname
order by a.stid asc;

select a.stid, a.stname , decode(sum(b.score),NULL,'미응시',sum(b.score)) 총점, decode(round(avg(b.score),2),null,'미응시',round(avg(b.score),2)) 평균
from student a left outer join scores b
on a.stid = b.stid
--and a.stid=2
group by a.stid,a.stname;
--order by a.stid asc;


  
-- 모든 학생의  학번, 이름, 총점, 평균, 등급, 석차
--select stid, stname, 총점, 평균, 등급, rownum 석차 from (
select a.stid stid, a.stname stname, sum(b.score) 총점, round(avg(b.score),2) 평균,
    case
        when round(avg(b.score),2) >= 90 then 'A'
        when round(avg(b.score),2) >= 80 then 'B'
        when round(avg(b.score),2) >= 70 then 'C'
        when round(avg(b.score),2) >= 60 then 'D'
        else '미응시'
    end 등급,
    rank() over(order by sum(score) desc nulls last) 석차
--from student a, scores b
--where a.stid = b.stid
from student a left outer join scores b
on a.stid = b.stid
--and a.stid=2
group by a.stid,a.stname;
--)order by 석차;
  
----  학번, 이름, 국어, 영어,수학,총점,평균
select 
    a.stid
  , a.stname
  , listagg(b.score,',')
  , 
from student a, scores b
where a.stid=1
and a.stid = b.stid
group by a.stid, a.stname;

--풀이
-- 1) 오라클 10g 의 방식
select 
    sc.stid
  , sum(decode(sc.subject,'국어',sc.score)) 국어
  , sum(decode(sc.subject,'영어',sc.score)) 영어
  , sum(decode(sc.subject,'수학',sc.score)) 수학
from scores sc
group by sc.stid;

select 
    st.stid
  , st.stname
  , decode(sum(decode(sc.subject,'국어',sc.score)),null,'미응시',sum(decode(sc.subject,'국어',sc.score))) 국어
  , decode(sum(decode(sc.subject,'영어',sc.score)),null,'미응시',sum(decode(sc.subject,'영어',sc.score))) 영어
  , decode(sum(decode(sc.subject,'수학',sc.score)),null,'미응시',sum(decode(sc.subject,'수학',sc.score))) 수학
  , decode(sum (sc.score),null,'미응시',sum (sc.score)) 총점
  , decode(round(avg (sc.score),2),null,'미응시',round(avg (sc.score),2)) 평균
  , case
        when round(avg(sc.score),2) >= 90 then 'A'
        when round(avg(sc.score),2) >= 80 then 'B'
        when round(avg(sc.score),2) >= 70 then 'C'
        when round(avg(sc.score),2) >= 60 then 'D'
        else '미응시'
    end 등급
from scores sc, student st
where sc.stid(+) = st.stid
group by st.stid, st.stname;

--  학번, 이름, 국어, 영어,수학,총점,평균,등급,석차
---- 미응시자는 '미응시'로 출력
---- 등급 : 비등가 조인으로 해결
create table scoregrade(
    grade varchar2(1) primary key,
    loscore number(7,3),
    hiscore number(7,3)
);

insert into scoregrade values ('A',90,100);
insert into scoregrade values ('B',80,89.999);
insert into scoregrade values ('C',70,79.999);
insert into scoregrade values ('D',60,69.999);
insert into scoregrade values ('E',0,59.999);
commit;

select * from scoregrade;

select t.학번, t.이름, t.국어, t.영어, t.수학, t.총점, t.평균, 
    sg.grade 등급, rank() over(order by t.총점 asc) 석차
from
(
    select
        st.stid 학번,
        st.stname 이름,
        sum(decode(sc.subject,'국어',sc.score)) 국어,
        sum(decode(sc.subject,'영어',sc.score)) 영어,
        sum(decode(sc.subject,'수학',sc.score)) 수학,
        sum(sc.score) 총점,
        round(avg(sc.score),3) 평균
    from scores sc, student st
    where sc.stid(+) = st.stid
    group by st.stid, st.stname
) t left join scoregrade sg
on t.평균 between sg.loscore and sg.hiscore;
--order by t.학번 asc;



-- 2) 오라클 11G PIVOT 문법 사용 / 통계를 생성 - 일반적으로 집계함수와 같이 사용.
-- 학번, 이름, 국어, 영어,수학,총점,평균,등급

1) 학번, 이름, 국어, 영어,수학
select * from (
    select stid, subject, score
    from scores
)
pivot(
    sum(score)
        for subject
            in('국어' as 국어, '영어' as 영어, '수학' as 수학)
);

2) 학번, 이름, 국어, 영어, 수학, 총점, 평균, 학점, 석차
SELECT   ST.STID  학번,  ST.STNAME  이름, T.국어, T.영어, T.수학, 
          ( NVL(T.국어,0) + NVL(T.영어,0) + NVL(T.수학,0) )                   총점, 
          ROUND(( NVL(T.국어,0) + NVL(T.영어,0) + NVL(T.수학,0) ) / 3, 3)     평균,
          SG.GRADE                                                            학점, 
          RANK() OVER (ORDER BY ( NVL(T.국어,0) + NVL(T.영어,0) + NVL(T.수학,0) )  DESC NULLS LAST) 석차
  FROM    
  (
      SELECT  *  FROM (
            SELECT   STID, SUBJECT, SCORE
             FROM    SCORES
         )
         PIVOT
         (
            SUM(SCORE)
              FOR  SUBJECT
                IN('국어' AS 국어, '영어' AS 영어, '수학' AS 수학) 
         )          
  )  T  RIGHT JOIN   STUDENT     ST   ON  T.STID = ST.STID
        LEFT  JOIN   SCOREGRADE  SG   
          ON   (NVL(T.국어,0) + NVL(T.영어,0) + NVL(T.수학,0)) / 3 
               BETWEEN SG.LOSCORE  AND SG.HISCORE;
               
--=====================================================================
-- 시퀀스 : 번호 자동 증가(번호 자동 생성기)
create table table4(
id number(6) primary key,
title varchar2(1000),
memo varchar2(4000)
);

create sequence SEQ_ID;
create sequence SEQ_ID_1;

insert into table4 values (SEQ_ID_1.nextval,'insert_title_1','insert_meme_1');
insert into table3 values (SEQ_ID.nextval,'insert_title_2','insert_meme_2');
insert into table3 values (SEQ_ID.nextval,'insert_title_3','insert_meme_3');
commit;

select * from table3 order by id desc;
select * from table4 order by id desc;

delete from table4;
where id in (4,5,6);


insert into table4 values ((select max(ID)+1 from table4),'3','4');
insert into table4 values ((select NVL(MAX(id),0)+1 from table4),'3','4');

-- 인덱스 : 검색 속도를 빠르게 만드는 객체 
-- 인덱스가 생성된 컬럼을 where 문에 사용해야 효과있다.
create index IDX_NAME on EMP1 (FIRST_NAME);
create index IDX_NAME on EMP1 (FIRST_NAME||' '||LAST_NAME);



-- 트리거 : TRIGGER - 방아쇠
회원정보가 추가되면 로그에 기록을 남기는 작업을 해야할때
   
   상황 
  1)  INSERT 회원정보
  2)  INSERT 로그기록
   두번실행
  
   자동화 
  1)  INSERT 회원정보 -> 트리거가  INSERT 로그기록 호출해서 실행
  
   단점 : 로직추적이 쉽지 않다 
          트리거를 남발하지 말라.
          
 https://docs.oracle.com/database/121/TDDDG/tdddg_triggers.htm#BABDAGJJ  


---------------------------------------------------------------- 
--트랜잭션 ( TRANSACTION )
송금
  1) 내걔좌 금액   -
  2) 상대계좌 금액 +
 
  
  1) UPDATE  TABLE1 
    SET   내계좌   = 내계좌 - 100;
    
  2) UPDATE  TABLE1 
    SET   샹대계좌 = 상대계좌 + 100;  
 
 두 동작을 하나의 트랜잭션으로 묶어주면 
  COMMIT을 만나기 전에는 DB에 저장되지 않으므로 
  송금실패시 DATA 가 잘못되는일이 없다
    
  BEGIN TRANS
  1) UPDATE  TABLE1 
      SET   내계좌   = 내계좌 - 100;
    
  2) UPDATE  TABLE1 
      SET   샹대계좌 = 상대계좌 + 100;  
    
    COMMIT; -- ROLLBACK;
  END


--LOCK
delete from table4;
commit;

