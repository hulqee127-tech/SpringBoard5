-- SQL 명령순서
-- FROM -> WHERE -> GROUP BY -> SELECT -> ORDER BY
-- WHERE 문법 안에 집계함수 사용불가

select * from tab;
-------------------------------------------------
select first_name || ' ' || last_name as name
from employees;
where last_name like '%nnell';
-------------------------------------------------
--부서번호가 60인 직원정보(번호, 이름, 이메일, 부서번호)
select employee_id , first_name || ' ' || last_name fullName, email, department_id depart 
from employees
where department_id = '60';
-------------------------------------------------
--부서번호가 90인 직원정보
select employee_id , first_name || ' ' || last_name fullName, email, department_id depart 
from employees
where department_id = '60';
-------------------------------------------------
--부서번호가 60, 90인 직원정보
select employee_id , first_name || ' ' || last_name fullName, email, department_id depart from employees
--where department_id = 60 or department_id = 90;
where department_id in (60,90);
-------------------------------------------------
-- 1. 월급이 12,000 이상인 직원의 번호, 이름, 이메일, 월급을 월급순으로 출력
select 
    employee_id, 
    first_name || ' ' || last_name fullName, 
    email, 
    to_char(salary,'999,999,999') salary
from 
    employees
where 
    salary >= 12000
order by 
    salary asc;
-------------------------------------------------
-- 2. 월급이 10,000 ~ 15,000 인 직원의 사번, 이름, 월급, 부서번호 출력
SELECT 
    employee_id, 
    first_name || ' ' || last_name fullName, 
    to_char(salary,'999,999,999') salary, 
    department_id
from 
    employees
where 
    salary between 10000 and 15000
order by
    salary desc;
-------------------------------------------------
-- 3. 직업ID 가 IT_PROG 인 직원 명단
select 
    employee_id, 
    first_name || ' ' || last_name fullName,
    job_id
from 
    employees
where 
    job_id='IT_PROG';
-------------------------------------------------
-- 4. 직원이름이 GRANT 인 직원을 찾으세요
-- upper() : 모두 대문자로
-- lower() : 모두 소문자로
-- initcat() : 첫글자만 대문자로
select 
    employee_id, 
    first_name || ' ' || last_name fullName, 
    job_id
from 
    employees
where 
    upper(last_name) like '%GRANT%';
-------------------------------------------------

-- 5. 사번, 이름, 월급, 10% 인상한 월급
select 
    employee_id, 
    first_name || ' ' || last_name fullName,
    salary,
    --((salary * 0.1)+salary) salarys
    (salary * 1.1) salarys
from 
    employees;
-------------------------------------------------
-- 6. 50번 부서의 직원명단, 월급, 부서번호
select 
    employee_id, 
    first_name || ' ' || last_name fullName, 
    salary, 
    department_id
from 
    employees
where 
    department_id in (50);
-------------------------------------------------
-- 7. 20,80,60,90번 부서의 직원명단, 월급, 부서번호
select 
    first_name || ' ' || last_name fullName, 
    salary, 
    department_id
from 
    employees
where 
    department_id in (20,60,80,90);
-------------------------------------------------
-- 8. 보너스 없는 직원명단
-- null 값은 is, is not null 로 비교한다 (= 로 비교 불가)
select 
    first_name || ' ' || last_name fullName, 
    salary,
    commission_pct
from 
    employees
where 
    commission_pct is null;
-------------------------------------------------
-- 9. last_name 세번째 네번째 글자가 LL 인것을 찾아라
select 
    first_name || ' ' || last_name fullName
from 
    employees
where 
    --substr(upper(last_name),3,1) = 'L' 
    --or substr(upper(last_name),4,1) = 'L';
    last_name like '__ll%';
-------------------------------------------------
----날짜
-- 2025-07-08  : 국제표준
-- 08/07/25    : 영국식  일/월/년
-- 07/08/25    : 미국식
alter session set nls_date_format = 'YYYY-MM-DD HH24:MI:SS'; 
select sysdate from dual;       -- 25/07/08 ==> 2025-07-08 15:14:51
select 7/2 from dual; -- 3.5
select 0/2 from dual; -- 0
select 2/0 from dual; -- ORA-01476:제수가 0 입니다.
select systimestamp from dual; -- 25/07/08 15:19:00.824000000 +09:00 -> nano second 까지 표시
select 7/2, round(123.456,2),round(123.456,-2), trunc(123.456,2),trunc(123.456,-2) from dual;
select sysdate-7 beforeweek, sysdate today, sysdate+7 afterweek from dual;
select last_day('2025-02-18') from dual;
select to_date('2025-12-25 00:00:00','YYYY-MM-DD HH24:MI:SS')-to_date(sysdate,'YYYY-MM-DD HH24:MI:SS') d from dual;
select sysdate, round(sysdate,'month'), trunc(sysdate,'month') from dual;
-------------------------------------------------
-- 10. 입사년월이 17년2월인 사원출력
select hire_Date , first_name || ' ' || last_name fullName
from employees
where 
    hire_Date
    between to_date('17-02-01 00:00:00','YY-MM-DD HH24:MI:SS')
    and to_date('17-02-28 23:59:59','YY-MM-DD HH24:MI:SS');
--where to_date(hire_Date,'YYMM') = to_date('1702','YYMM');

--> 풀이
select 
    employee_id,
    first_name || ' ' || last_name fullName,
    hire_date
from
    employees
where
    '2017-02-01' <= hire_date
and hire_date <= '2017-02-28';
-------------------------------------------------
-- 11. 17/02/07에 입사한 사람 출력
select * from employees
where hire_Date = '2017-02-07';
-------------------------------------------------
-- 12. 오늘 '25/07/08' 입사한사람
select * from employees
where hire_Date >= sysdate - 0.99999;
-------------------------------------------------
-- 13. 부서번호 80이 아닌 직원
select employee_id,
    first_name || ' ' || last_name fullName,
    hire_date,
    department_id
from employees
where department_id <> 80;
-------------------------------------------------
-- 화요일 입사자를 출력
select * from (
    select 
        a.hire_Date, 
        to_char(a.hire_Date,'day') , 
        a.first_name || ' ' || a.last_name fullName,
        row_number() over (order by a.hire_date desc) N
    from employees a
    where to_char(hire_date,'day') = '화요일'
    --and N between 11 and 13
    order by hire_date desc
) 
where N between 5 and 10;

--풀이
select 
    hire_Date, first_name || ' ' || last_name fullName,
    to_char(hire_date,'YYYY-MM-DD day')
from employees
where 
to_char(hire_date,'day') = '화요일';

-------------------------------------------------
-- 입사후 일주일이내인 직원명단
select hire_Date, to_date(sysdate,'YY-MM-DD HH24:MI:SS')-to_date(hire_date,'YY-MM-DD HH24:MI:SS') , first_name || ' ' || last_name fullName
from employees
where 
--(to_date(sysdate,'YY-MM-DD HH24:MI:SS')-to_date(hire_date,'YY-MM-DD HH24:MI:SS')) < 7;
hire_date between sysdate -7 and sysdate;
-------------------------------------------------
-- 08월 입사자의 사번, 이름, 입사일을 입사일 순으로

select hire_date, to_char(hire_date,'MM') c_date, employee_id, first_name || ' ' || last_name fullName
from employees
where to_char(hire_date,'MM') = '08'
order by hire_date asc;

--풀이
select
    employee_id,
    first_name || ' ' || last_name fullName,
    to_char(hire_date,'YYYY-MM-DD day')
from employees
where to_char(hire_date,'MM') = '08';