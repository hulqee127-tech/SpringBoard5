-- 부서명, 직원이름

/*
CREATE PROCEDURE GET_EMPINFO(  EMPID  NUMBER  )
begin
    select 
        d.department_name
        , e.first_name
        , e.last_name
        , e.phone_number
        , email
    from departments d left join employees e 
    on d.department_id = e.department_id
    where e.employee_id = 100
    return
end;
*/

-- ORACLE 의 부프로그램 : 프로그램의 조각
---- 1. PROCEDURE SUBROUTINE, 프로시져, 서브루틴
-------- 필요에 따라 0개 이상의 결과를 처리할 수 있다.
-------- RDB에서는 STORED PROCEDURE (저장 프로시져)
---- 2. FUNCTION : 함수
-------- 반드시 한개의 return 값을 가져야 한다.
----------------------------------------------------------------------
-- 107 번 직원의 이름과 월급 조회
select first_name, last_name, salary 
from employees
where employee_id=107;

-- ORACLE에 함수를 저장한다.(함수를 생성한다.)
CREATE PROCEDURE GET_EMPSAL(  IN_EMPID IN NUMBER  )
IS
    V_FNAME VARCHAR2(20);
    V_LNAME VARCHAR2(25);
    V_SAL NUMBER(8,2);
    BEGIN
        select first_name, last_name, salary 
        INTO V_FNAME, V_LNAME, V_SAL
        from employees
        where employee_id = IN_EMPID;
    DBMS_OUTPUT.PUT_LINE(V_FNAME);
    DBMS_OUTPUT.PUT_LINE(V_LNAME);
    DBMS_OUTPUT.PUT_LINE(V_SAL);
    end;
/

--------------------------------------------------------------------
SET SERVEROUTPUT on;    -- 먼저 선언 해주어야 '호출이 완료 되었습니다' 밑에 DATA 나타남.
call GET_EMPSAL(102);   -- 프로시져 호출

--------------------------------------------------------------------
-- 부서번호입력, 해당부서의 최고월급자의 이름, 월급출력
CREATE PROCEDURE GET_NAME_MAXSAL(
        IN_DEPTID IN NUMBER, 
        O_FNAME OUT VARCHAR2, 
        O_LNAME OUT VARCHAR2, 
        O_SAL OUT VARCHAR2  )
AS
    V_MAXSAL NUMBER(8,2);
    BEGIN
        select max(salary)
        INTO V_MAXSAL
        from employees
        where department_id = IN_DEPTID;
    
        select first_name, last_name, salary
        INTO O_FNAME, O_LNAME, O_SAL
        from employees
        where SALARY = V_MAXSAL
        and DEPARTMENT_id = IN_DEPTID;
    DBMS_OUTPUT.PUT_LINE(O_FNAME);
    DBMS_OUTPUT.PUT_LINE(O_LNAME);
    DBMS_OUTPUT.PUT_LINE(O_SAL);
    END;
/

SET SERVEROUTPUT on;
SET SERVEROUTPUT off;

VAR O_FNAME varchar2;
var O_LNAME varchar2;
var O_SAL varchar2;

call GET_NAME_MAXSAL (60, :O_FNAME, :O_LNAME, :O_SAL);
print O_FNAME;
print O_LNAME;
print O_SAL;



-- 90번 부서번호입력, 직원들 출력
CREATE OR REPLACE PROCEDURE GETEMPLIST (  IN_DEPTID NUMBER)
IS
    V_EID NUMBER(8,2);
    V_FNAME VARCHAR2(4000);
    V_LNAME VARCHAR2(4000);
    V_PHONE VARCHAR2(4000);
    BEGIN
        select employee_id, first_name, last_name, phone_number
        INTO V_EID, V_FNAME, V_LNAME, V_PHONE
        from employees
        where department_id = IN_DEPTID;
    DBMS_OUTPUT.PUT_LINE(V_EID);
    END;
/

EXEC GETEMPLIST(90);        -- EXEC : CALL 과 같은 실행 명령어
/*
오류 발생 행: 1:
ORA-01422: 실제 인출은 요구된 것보다 많은 수의 행을 추출합니다
ORA-06512: "HR.GETEMPLIST",  8행
ORA-06512:  1행
*/

-- SELECT INTO 는 1줄만 가능하다. ROW 가 1줄.
-- 해결 => 커서(CURSOR)를 이용함.

CREATE OR REPLACE PROCEDURE GET_EMPLIST(
        IN_DEPTID IN NUMBER ,
        O_CUR OUT SYS_REFCURSOR )
AS
    BEGIN
        OPEN O_CUR FOR
        select employee_id, first_name, last_name, phone_number
        from employees
        where department_id = IN_DEPTID;
    END;
/

VARIABLE O_CUR REFCURSOR;
exec GET_EMPLIST(50,:O_CUR);
PRINT O_CUR;
--=====================================================================
-- 객체(개체) 생성
