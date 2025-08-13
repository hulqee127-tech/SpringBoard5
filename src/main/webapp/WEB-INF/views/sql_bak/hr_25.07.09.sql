select * from (
select employee_id, row_number() over (order by employee_id asc) num 
from employees
)
where num between 11 and 20;

select * from employees
where rownum between 1 and 20;

select * 
from employees
where TABLE_NAME = 'employees'
and COLUMN_NAME not in ('JOB_ID');
-----------------------------------------------
-- 직원사번, 입사일
select employee_id, hire_date,to_char(hire_date,'YYYY-MM-DD D day')
from employees;

-----------------------------------------------
-- 2025년 07월 09일 10시 05분 04초 오전 수요일
select 
    to_char(sysdate,'YYYY-MM-DD HH:MI:SS AM DAY') 날짜,
    to_char(sysdate,'YYYY"년" MM"월 "DD"일" HH"시" MI"분" SS"초" AM DAY') 날짜2,
    to_char(sysdate,'YYYY"年" MM"月 "DD"日" HH"時" MI"分" SS"秒" AM DAY') 날짜3
from dual;

-----------------------------------------------
-- 년월일시분초오전오후 --年月日時分秒午前午後 -- 일월화수목금토 --日月火水木金土


/*
10	Administration
20	Marketing
30	Purchasing
40	Human Resources
50	Shipping
60	IT
70	Public Relations
80	Sales
90	Executive
100	Finance
*/
-- 사번, 이름, 부서명
select 
    employee_id,
    first_name || ' ' || last_name fullName,
    decode(department_id,10,'Administration',
                         20,'Marketing',
                         30,'Purchasing',
                         40,'Human Resources',
                         50,'Shipping',
                         60,'IT',
                         70,'Public Relations',
                         80,'Sales',
                         90,'Executive',
                         100,'Finance',department_id) as department_name
from employees;

-----------------------------------------------
-- 년월일시분초오전오후 --年月日時分秒午前午後 -- 일월화수목금토 --日月火水木金土
select
    to_char(sysdate,'YYYY') || '年 '
    || to_char(sysdate,'MM') || '月 '
    || to_char(sysdate,'DD') || '日 '
    || to_char(sysdate,'HH') || '時 '
    || to_char(sysdate,'MI') || '分 '
    || to_char(sysdate,'SS') || '秒'
    || decode(to_char(sysdate,'AM'),'오전',' 午前',
                                     '오후',' 午後')
    || decode(to_char(sysdate,'D'),'1',' 日',
                                   '2',' 月',
                                   '3',' 火',
                                   '4',' 水',
                                   '5',' 木',
                                   '6',' 金',
                                   '7',' 土') || '_曜日' dat
from dual;

-----------------------------------------------
-- if 를 사용한다
-- 1) NVL(), NVL2()
select 
    employee_id, 
    first_name || ' ' || last_name fullName,
    salary,
    nvl(commission_pct,0) bonus
--    ,nvl(commission_pct,'보너스없음') bonus   -- error
    ,decode(commission_pct,NULL,'보너스없음') bonus
from
    employees;
    
-- 2) NULLIF( expr1, expr2 )
-- 둘을 비교해서 같은면 NULL 같지않으면 expr1

-- 3) decode
-- decode (expr1, search1, result1, search2, result2,....,default) : IF문
-- decode는 expr 과 search1을 비교해 두 값이 같으면 result1을,
-- 같지 않으면 다시 search2와 비교해 값이 같으면 result2를 반환하고....
-- 이런식으로 계속 비교한 뒤 최종적으로 같은 값이 없으면 default 값을 반환한다.


-- 직원 명단, 직원의 월급, 보너스, 출력 연봉 출력
select
    employee_id 사번 ,
    decode(salary,null,'신입사원',salary) 직원월급,
    nvl(salary * commission_pct,0) 보너스,
    salary * 13 + nvl(salary * commission_pct,0) 연봉
from
    employees;
    
-- 4) case when
--  when score between 09 and 100 then 'a'
--  when 90 <= score and score <= 100 then 'a'

select
    employee_id 사번 ,
    first_name || ' ' || last_name 이름,
    case department_id
        when 90 then 'Sales'
        when 80 then 'executive'
        when 50 then 'shipping'
        when 60 then 'IT'
        else 'Other'
    end 부서명
from
    employees;
    
select
    employee_id 사번 ,
    first_name || ' ' || last_name 이름,
    case 
        when department_id = 90 then 'Sales'
        when department_id = 80 then 'executive'
        when department_id = 50 then 'shipping'
        when department_id = 60 then 'IT'
        else 'Other'
    end 부서명
from
    employees;
-----------------------------------------------

-- 집계 함수 : AGGREGATE 함수
-- 모든 집계 함수는 null 값은 포함하지 않는다
-- ~별 인원수
-- 집계함수 COUNT(), SUM(), AVG(), MIN(), MAX(), VARIANCE(expr)분산, STDDEV(expr)표준편차
-- 그룹핑 GROUP BY

select * from employees;            --전체명단
select count(*) from employees;     --직원의 인원수-109
select count(employee_id) from employees;
select count(department_id) from employees;
select * from employees where department_id is null;
select count(salary) from employees;  --월급 받는 사람 107
select sum(salary) from employees;  --전체직원의 월급의 합--691416
select avg(salary) from employees;  --전체직원의 월급의 평균--6461.831775700.....41
select 691416/109 from dual;
select 691416/107 from dual;--null 값은 계산에서 자동으로 제외됨.
select min(salary) from employees;  --최소 월급 2100
select max(salary) from employees;  --최대 월급 24000

-- 60번 부서의 평균 월급
select avg(salary) from employees
where department_id=60;

-- employees의 부서 수(중복 제거)
select distinct(department_id) from employees;
select count(distinct department_id) from employees;
select department_id, count(department_id) cnt
from employees
group by department_id;



-----------------------------------------------
--입사일에 해당되는 달의 첫번째 날짜와 마지막날짜를 출력
select hire_date,trunc(hire_date,'MM'),last_day(hire_date) from employees;
select
    employee_id 사번,
    to_char(hire_date,'YYYY-MM-DD') 입사일,
    to_char(trunc(hire_date,'MM'),'YYYY-MM-DD' ) 달의첫날,
    to_char(last_day(hire_date),'YYYY-MM-DD') 달의막날
from employees;

-- 직원이 근무하는 부서의 수
select count(distinct(department_id)) cnt from employees;
select 
    count(department_id) cnt
from departments
where manager_id is not null;

-- 직원수, 월급합, 월급평균, 최대월급, 최소월급
select 
count(employee_id) cnt, sum(salary) sum, round(avg(salary),3) avg, max(salary) max, min(salary) min from employees;

-- 부서 60번 부서 인원수 월급합, 월급평균
-- 부서 50, 60, 80
select 
count(employee_id) cnt, sum(salary) sum, round(avg(salary),2) avg
from employees
-- where department_id = 60;
--where department_id = 50 or department_id=60 or department_id=80;
where department_id in (50,60,80);

-- 직원이름, 부서번호, 부서명 - case when
/*
10	Administration
20	Marketing
30	Purchasing
40	Human Resources
50	Shipping
60	IT
70	Public Relations
80	Sales
90	Executive
100	Finance
110	Accounting
*/
select 
    first_name || '_' || last_name 이름,
    department_id 부서코드,
    case department_id
        when 10 then 'Administration'
        when 20 then 'Marketing'
        when 30 then 'Purchasing'
        when 40 then 'Human Resources'
        when 50 then 'Shipping'
        when 60 then 'IT'
        when 70 then 'Public Relations'
        when 80 then 'Sales'
        when 90 then 'Executive'
        when 100 then 'Finance'
        when 110 then 'Accounting'
        else 'Other'
    end 부서명
from employees;

-- 부서명 join
--select emp.first_name || '_' || emp.last_name 이름, dep.department_name 부서명
select dep.department_name 부서명, count(emp.employee_id) cnt
from employees emp, departments dep
where emp.department_id = dep.department_id
group by dep.department_name;

-----------------------------------------------
-- 부서별  인원수, 월급합
select department_id, count(employee_id) cnt, sum(salary)
from employees
group by department_id
order by department_id asc;


-- 부서별 인원수가 5명 이상인 부서번호
select department_id, count(employee_id) cnt, sum(salary)
from employees
group by department_id
having count(employee_id) >= 5
order by department_id asc;

-- 부서별 월급총계가 20000 이상인 부서번호
select department_id, count(employee_id) cnt, sum(salary) sals
from employees
group by department_id
having sum(salary) >= 20000
order by sals asc;

-- job_id별 인원수
select job_id, count(employee_id) cnt
from employees
group by job_id
order by job_id;

select job_id, count(employee_id) cnt
from employees
group by rollup(job_id) -- 총계 표시
order by job_id;

select job_id, count(employee_id) cnt
from employees
group by cube(job_id)
order by job_id;

-- 입사일기준 월별 인원수, 2017년 기준
select 
    to_char(hire_date,'YYYY-MM') dat
    , count(employee_id) cnt
from employees
where to_char(hire_date,'YYYY') = '2017'
group by to_char(hire_date,'YYYY-MM')
order by dat asc;

-- 부서별 최대월급이 14000 이상인 부서의 부서번호와 최대월급
select department_id, max(salary)
from employees
where salary >= 14000
group by department_id;

-- 부서별 모으고 같은 부서는 직업별 인원수, 월급 평균
select department_id, job_id, count(job_id) cnt, round(avg(salary),2)
from employees
group by rollup(department_id,job_id)
order by department_id asc;


-----------------------------------------------
/* SUBQUERY : QUERY 문 안에 QUERY 가 들어간다 */
-- IT 부서의 직원정보를 출력하시오
-- 1) IT 부서의 부서번호 : DEPARTMENTS --> 60
select department_id, department_name
from DEPARTMENTS
where department_name = 'IT';

-- 2) 60번 부서의 직원정보를 출력
select employee_id, first_name || '_' || last_name 이름, department_id
from employees
where department_id=60;

select employee_id, first_name || '_' || last_name 이름, department_id
from employees
where department_id=(
    select department_id
    from DEPARTMENTS
    where upper(department_name) = 'IT'
);

-- (60번 부서의 )평균월급보다 많은 월급을 받는 사람의 명단을 출력
select first_name || '_' || last_name 이름, salary
from employees
where salary >= (
select round(avg(salary),2)
from employees
) order by salary desc;

-- SALES 부서의 평균월급보다 많은 월급을 받는 사람의 명단을 출력
select employee_id , first_name || '_' || last_name 이름, salary
from employees
where salary >= (
    select round(avg(salary),2)
    from employees
    where department_id =  (
        select department_id
        from departments
        where upper(department_name)='SALES'
    )
)order by salary desc;