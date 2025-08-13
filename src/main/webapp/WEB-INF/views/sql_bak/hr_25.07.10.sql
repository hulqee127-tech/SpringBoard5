-- 디파트먼트 아이디가 50인 직원 이름?
-- 디파트먼트가 아이디가 50인 직원이름, 디파트먼트이름
select a.first_name || '_' || a.last_name 이름 , job_id, b.department_name
from employees a, departments b
where a.department_id = b.department_id
and b.department_id=50;

select * from employees where department_id =50;

select * from locations;

select * from departments;

select a.employee_id, a.first_name || '_' || a.last_name 이름, b.manager_id, c.location_id, c.street_address
from employees a, departments b, locations c
where a.employee_id = b.manager_id
--and b.location_id = c.location_id
and b.department_id=50;
-----------------------------------------------
--3) OUTER JOIN
-- 모든 부서명 출력 : DEPARTMENTS 부서정보 27개 부서
-- 직원정보는 해당부서의 직원이 있으면 부서이름, 명단출력
--                       직원이 없으면 부서이름, '직원없음'
select 
    d.department_name 부서명,
    e.first_name||' '||e.last_name 부서직원이름
from
    departments d, employees e
where d.department_id = e.department_id(+);

-----------------------------------------------
-- 직원의 이름과 담당업무(JOB_TITLE)
select 
    e.first_name||' '||e.last_name 부서직원이름,
    j.job_title
from
    employees e, jobs j
where e.job_id = j.job_id;

-- 부서명, 부서위치(CITY, STREET,ADDRESS)


-- 직원명, 부서명, 부서위치(CITY, STREET,ADDRESS)

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
select first_name, last_name, hire_date, email, lower(job_id)
from employees
where lower(job_id) = 'it_prog';

---- SHIPPING 부서의 직원명단
-- 1) 부서명 SHIPPING의 부서번호 : 50
select department_id
from departments
where upper(department_name) = 'SHIPPING';

-- 2) 50번 부서의 직원 명단
select first_name, last_name, hire_Date
from employees
where department_id = 50;

---- SHIPPING 부서의 직원 명단 1) + 2)
-- SQL 문 안에 SQL 문이 들어 있으면 SUBQUERY
-- 반드시 () 안에서 표시된다
-- 두번물어 봐야 할때 사용
select first_name, last_name, hire_date
from employees
where department_id = (
    select department_id from departments where upper(department_name) = 'SHIPPING'
);
----------------------------------------------------------------------------
-- JOIN : 여러개의 다른 테이블에 있는 칼럼들을 가지고 와서 새로운 테이블을 만든다.
-- 직원이름, 부서명 -- 출력 줄수 : 109줄

-- ORACLE OLD 문법
-- 1) 카티션 프로덕트 == CROSS JOIN, 조건이 없는..
select first_name, last_name, department_name
from employees, departments;         -- 2943 : 109*27

select 109*27 from dual;

-- 2) INNER JOIN - 양쪽다 존재하는 데이터, 조건필수
select first_name, last_name, department_name
from employees, departments
where department_id = department_id;        -- ORA-00918:열의정의가 애매합니다.

select employees.employee_id, employees.first_name, employees.last_name, departments.department_name
from employees, departments
where employees.department_id = departments.department_id;      -- 106 : -3명(department_id 가 null)

select e.employee_id, e.first_name, e.last_name, d.department_name
from employees e, departments d
where e.department_id = d.department_id;        -- 106 위의 문법과 동일한 문법

-- 3) OUTER JOIN
-- 부서명, 부서직원이름
-- 모든 부서명 출력 : DEPARTMENTS 부서정보 27개
-- 직원정보는 해당부서의 직원이 있으면 부서이름, 명단출력
--                       직원이 없으면 부서이름에 '직원없음'
-- (+) : 자료가 없는 (NULL) 쪽에 붙혀 준다.
select d.department_name, e.first_name, e.last_name
from departments d, employees e
where d.department_id = e.department_id(+);
--> 122 : 106 (11개 부서) - 직원이 근무하는 부서
--> (+) : 16 (27-11) - 직원이 근무하지 않는 부서

-- LEFT OUTER JOIN : 기준이 왼쪽이다 (+) 가 없는 쪽이다.
-- 기준 칼럼은 모두 출력하고 반대쪽은 있으면 DATA 출력, 없으면 NULL 이다.
select 
    d.department_name
    , decode(e.first_name||' '||e.last_name,' ','직원없음',e.first_name||' '||e.last_name)
from departments d, employees e
where d.department_id = e.department_id(+);
--> 122 : 106 (11개 부서) - 직원이 근무하는 부서
--> (+) : 16 (27-11) - 직원이 근무하지 않는 부서

-- RIGHT OUTER JOIN : 이경우의 결과는 위와 동일하다(조건만 위치를 변경했다)
select 
    d.department_name
    , decode(e.first_name||' '||e.last_name,' ','직원없음',e.first_name||' '||e.last_name)
from departments d, employees e
where e.department_id(+) = d.department_id;

-- RIGHT OUTER JOIN
select 
    d.department_name
    , decode(e.first_name||' '||e.last_name,' ','직원없음',e.first_name||' '||e.last_name)
from departments d, employees e
where d.department_id(+) = e.department_id;

-- FULL OUTER JOIN : 문법이 없다.

------------------------------------------------------------------------------
-- 1) CROSS JOIN
select first_name, last_name, department_name
from employees cross join departments;      -- 2943 : 109 * 2

-- 2) (INNER) JOIN
select employee_id, first_name, last_name, department_name
from employees e inner join departments d on e.department_id = d.department_id;

-- 3) LEFT (OUTER) JOIN
select first_name, last_name, department_name
from employees e left outer join departments d on e.department_id = d.department_id;        -- 109

-- 4) RIGHT (OUTER) JOIN
select first_name, last_name, department_name
from employees e right join departments d on e.department_id = d.department_id;     -- 122

-- 5) FULL (OUTER) JOIN
select first_name, last_name, department_name
from employees e full join departments d on e.department_id = d.department_id;      -- 125

-- 직원이름, 담당업무(JOB_TITLE)
-- INNER JOIN : 양쪽다 존재하는 DATA
select e.first_name, e.last_name, j.job_title
from employees e, jobs j
where e.job_id = j.job_id
order by j.job_title asc;       --109

-- LEFT OUTER JOIN
select e.first_name, e.last_name, j.job_title
from employees e, jobs j
where e.job_id = j.job_id(+);       -- 109

-- RIGHT OUTER JOIN
select e.first_name, e.last_name, j.job_title
from employees e, jobs j
where e.job_id(+) = j.job_id;       --109

-- 부서명, 부서위치(CITY, STREET_ADDRESS)
-- INNER JOIN
select d.department_name, l.state_province, l.city, l.street_address
from departments d, locations l
where d.location_id = l.location_id;

-- LEFT JOIN

-- RIGHT JOIN

-- 직원명, 부서명, 부서위치(CITY, STREET_ADDRESS)