select * from employees;
select department_id from employees;        -- 109개
select count(department_id) cnt from employees; -- 106개(null 빠져서..)
select department_id, count(department_id) cnt from employees group by department_id;

-- 최소 월급을 받는 사람의 명단을 출력하라.
-- 1) 최소 월급 도출
select min(salary) from employees;

-- 2) 1) 월급을 받는 사람의 이름을 출력하라.
select first_name||' '||last_name FullName
from employees
where salary = (select min(salary) from employees);

-- IT부서의 최소월급
select min(salary) from employees where department_id=60;

-- IT부서의 최소월급을 받는 사람의 명단(이름)을 출력하라.
select first_name||' '||last_name FullName
from employees
where salary = (select min(salary) from employees where department_id=60);

-- 같은거
select first_name||' '||last_name FullName
from employees
where salary = (
    select min(salary) from employees where department_id=(
        select department_id from departments where department_name='IT'
    )
);

-------------------------------------------------
-- 직원이름, 담당업무
select 
    e.first_name||' '||e.last_name FullName
    , j.job_title
from employees e, jobs j
where e.job_id = j.job_id;


-- 사번, 업무시작일, 업무종료일, 담당업무, 부서번호
select
    employee_id
    , to_char(start_date,'YYYY-MM-DD')
    , to_char(end_date,'YYYY-MM-DD')
    , job_id
    , department_id
from job_history
union
select employee_id
    , to_char(hire_date,'YYYY-MM-DD')
    , '근무중'
    , job_id
    , department_id
from employees
order by employee_id;
-- 0) view - SQL문을 테이블 처럼 사용하는 기술
-- 1) inline view - 중요 : 임시존재, from 위에 있는 괄호는 INLINE VIEW / 내부에 order by 가용가능, 그외 SUBQUERY / 내부에 order by 사용X
select * from (
    select
        employee_id
        , first_name||' '||last_name
        , email||'@green.com'
        , phone_number
    from employees
) T
where t.employee_id in (100,101,102)
;
-- 2) view 생성
CREATE OR REPLACE FORCE NONEDITIONABLE VIEW "HR"."VIEW_T" ("사번", "이름", "이메일", "전화") AS 
  select
    employee_id 사번
    , first_name||' '||last_name 이름
    , email||'@green.com' 이메일
    , phone_number 전화
from employees;

-- 3) with
with a as (
select
    employee_id 사번
    , first_name||' '||last_name 이름
    , email||'@green.com' 이메일
    , phone_number 전화
from employees
)
select * from a;

---------------------------------------
select empid, sdate, edate, jobid, deptid from(
    select
        employee_id empid
        , to_char(start_date,'YYYY-MM-DD') sdate
        , to_char(end_date,'YYYY-MM-DD') edate
        , job_id jobid
        , department_id deptid
    from job_history
    union
    select employee_id empid
        , to_char(hire_date,'YYYY-MM-DD') sdate
        , '근무중' edate
        , job_id jobid
        , department_id deptid
    from employees
) T
where  substr(t.sdate,1,4) = '2015';

---------------------------
-- cross 조인 - 카티션 프로적트 : 조건없는 조인
select d.department_name, e.first_name, e.last_name
from departments d, employees e;
-- 등가조인 : EQUI JOIN - 조건에 = 사용하는 조인
-- 1) INNER JOIN : 양쪽 다 존재하는 DATA, null 제외
-- 부서명, 직원이름, 부서이름순으로 출력하되, 같은 부서는 first_name 순으로 출력하라.
select d.department_name, e.first_name, e.last_name
from departments d, employees e
where d.department_id = e.department_id
order by d.department_name asc, e.first_name asc;       --106

select d.department_name, e.first_name, e.last_name
from departments d  inner join employees e
on d.department_id = e.department_id
order by d.department_name asc, e.first_name asc;       --106 위의 것과 같은것.


select count(department_id) from employees;
select count(distinct department_id) from employees;
select count(department_id)  from departments;
-- 2) OUTER JOIN
-- LEFT OUTER JOIN : 모든 부서(기준, 왼쪽)를 출력하라.
select d.department_name, e.first_name, e.last_name
from departments d, employees e
where d.department_id = e.department_id(+)      -- +의 의미는 NULL을 의미. +문법은 한쪽에만 사용가능.
order by d.department_id;       -- 122


select d.department_name, e.first_name, e.last_name
from departments d LEFT OUTER JOIN employees e
on d.department_id = e.department_id
order by d.department_id;       -- 122 위의 것과 같은것.


-- RIGHT OUTER JOIN : 모든 부서(기준, 오른쪽)를 출력하라.
select d.department_name, e.first_name, e.last_name
from departments d, employees e
where d.department_id(+) = e.department_id
order by d.department_id;       --109

select d.department_name, e.first_name, e.last_name
from departments d RIGHT OUTER JOIN employees e
on d.department_id = e.department_id
order by d.department_id;

-- FULL OUTER JOIN
select d.department_name, e.first_name, e.last_name
from departments d FULL OUTER JOIN employees e
on d.department_id = e.department_id
order by d.department_id;       --125

-- self 조인
-- 직원번호, 직속상사번호
select employee_id, manager_id
from employees;

-- 직원이름, 직속상사이름, 상사정보 : e1, 직원정보 : e02
select e2.first_name, e2.last_name, e1.first_name, e1.last_name
from employees e1, employees e2
where e1.employee_id = e2.manager_id
--where e2.employee_id = e1.manager_id
order by e1.employee_id;

--------------------------------------------------
-- 계층형 쿼리 CASCADING
-- 계층형 쿼리 - 계층구조 hireachy
-- LEVEL : 계층형 쿼리의 레벨을 구하는 예약어
-- 직원번호, 직원명, 레벨, 부서명
select
    e.employee_id
    , lpad(' ',3*(LEVEL-1))||e.first_name||' '||e.last_name
    , LEVEL
    ,d.department_name
from employees e, departments d
where e.department_id = d.department_id
--start with e.manager_id=100
start with e.manager_id is null
connect by prior e.employee_id = e.manager_id;
-- start with : 시작점
-- connect by prior - 연결조건
-- level : 계층형구조에서만 사용하는 의사칼럼으로 자동으로 레벨을 부여

-- not equi join : 비등가 조인
/*
직원등급
월급
20,000초과 : S
15,001 ~ 20,000 : A
10,001 ~ 15,000 : B
 5,001 ~ 10,000 : C
 3,001 ~  5,000 : D
     0 ~  3,000 : E
*/
select 
    employee_id 사번
    , first_name||' '||last_name 이름
    , salary 월급
    , case
        when salary > 20000 then 'S'
        when salary between 15001 and 20000 then 'A'
        when salary between 10001 and 15000 then 'B'
        when salary between 5001  and 10000 then 'C'
        when salary between 3001  and  5000 then 'D'
        when salary between    0  and  3000 then 'E'
      end 등급
from employees;

---- table 생성
create table SALGRADE(
GRADE VARCHAR2(1) PRIMARY KEY   -- INSERT 시 중복방지, NULL 방지
,LOSAL NUMBER(11)
,HISAL NUMBER(11)
);

insert into salgrade (GRADE, LOSAL, HISAL) values ('S',20001,99999999999);
insert into salgrade (GRADE, LOSAL, HISAL) values ('A',15001,20000);
insert into salgrade (GRADE, LOSAL, HISAL) values ('B',10001,15000);
insert into salgrade (GRADE, LOSAL, HISAL) values ('C',5001,10000);
insert into salgrade (GRADE, LOSAL, HISAL) values ('D',3001,5000);
insert into salgrade (GRADE, LOSAL, HISAL) values ('E',0,3000);
commit;


select 
    e.employee_id 직원번호
    , e.first_name||' '||e.last_name 이름
    , e.salary 월급
    , sg.grade 등급
from employees e, salgrade sg
where e.salary between sg.losal and sg.hisal 
order by e.employee_id asc;

--------------------------------------------------
--분석함수
--1. ROW_NUMBER()
--2. RANK()
--3. DENSE_RANK()
--4. NTILE()
--5. LIST_AGG()

--1. ROW_NUMBER() : 줄번호
-- 자료를 10개만 출력 - 페이징 기법 : DATABASE 에서 자료를 10개만 조회한다.
select employee_id, first_name, last_name, salary
from employees
order by salary desc
NULLS LAST;

-- 1) OLD 문법 ROWNUM - 의사컬럼  -- 정렬 할 때 순서가 바뀌는 이슈가 있으므로 사용하기가 어렵다.
select ROWNUM, employee_id, first_name, last_name, salary
from employees e
where ROWNUM between 1 and 10
--where ROWNUM between 11 and 20;  -- 이건 안됨.
order by salary desc NULLS LAST;

-- 2) ANSI 문법 : ROW_NUMBER() -- ORALCE / MySQL 에서 사용한다.
select * from (
    select 
        ROW_NUMBER() over (order by salary desc NULLS LAST) as RN
        , employee_id, first_name, last_name, salary
    from employees
) T
where T.RN between 1 and 10;

--MySQL 페이징 => select * from TABLE_NAME LIMIT 1,10; --> ROW_NUMBER() 보다 속도가 빠름.
-- 3) OFFSET : ORACLE 12C 부터 가능 해짐. 세상 좋아 졌네 ㅋㅋ
select *
from employees
order by salary desc NULLS LAST
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;      -- 인덱스가 0부터 시작!! 확인완료!!!!!

--2. RANK() : 석차  -- 공동 등수는 표시 안됨. 1,2,2,4.....
-- 월급순으로 석차를 출력
select employee_id, first_name, last_name, salary, RANK() over (order by salary desc NULLS LAST)
from employees;

--3. DENSE_RANK() : 석차 -- 공동 등수 표시됨. 1,2,2,3,4,5,6,6,7......
-- 월급순으로 석차를 출력
select * from (
    select employee_id, first_name, last_name, salary, DENSE_RANK() over (order by salary desc NULLS LAST) RN
    from employees
) T
where T.RN between 1 and 10;

--4. NTILE() : 그룹으로 분류
--5. LIST_AGG() : 
select department_id from employees;
select distinct(department_id) from employees;
select listagg(distinct department_id, ',') from employees;
select listagg(distinct department_id, ',') within group(order by department_id desc) from employees;