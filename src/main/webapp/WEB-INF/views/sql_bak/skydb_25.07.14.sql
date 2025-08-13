/*
-- 계정생성
-- sky / 1234
Microsoft Windows [Version 10.0.19045.5965]
(c) Microsoft Corporation. All rights reserved.

C:\Users\GGG>sqlplus /nolog

SQL*Plus: Release 21.0.0.0.0 - Production on 월 7월 14 14:30:32 2025
Version 21.3.0.0.0

Copyright (c) 1982, 2021, Oracle.  All rights reserved.

SQL> conn /as sysdba
연결되었습니다.
SQL>
SQL> show user;
USER은 "SYS"입니다
SQL>
SQL>
SQL> ALTER SESSION SET "_ORACLE_SCRIPT"=true;

세션이 변경되었습니다.

SQL>
SQL> CREATE USER sky IDENTIFIED BY 1234;

사용자가 생성되었습니다.

SQL>
SQL> GRANT CONNECT, RESOURCE TO sky;

권한이 부여되었습니다.

SQL> ALTER USER sky DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;

사용자가 변경되었습니다.

SQL> conn sky/1234
연결되었습니다.
SQL>
SQL> show user;
USER은 "SKY"입니다
SQL>
SQL> select * from tab;

선택된 레코드가 없습니다.

SQL>
*/
-------------------------------------------------------------------------------
-- sky에서 hr 계정의 data를 가져온다.
-- 1. (SQL-PLUS에서) hr로 로그인한다.---- 커맨드창에서 
-- 2. hr에서 sky에게 select 할 수 있는 권한을 부여한다.
---- GRANT SELECT ON EMPLOYEES TO sky;
----> 권한이 부여되었습니다.
-- GRANT SELECT, INSERT, UPDATE, DELETE ON EMPLOYEES TO SKY; -- 권한을 줄 수 있다.
-- 3. sky로 로그인한다.---- conn sky/1234
-- 4. sky 에서 hr 의 employees 를 조회
select * from hr.employees;     -- 조회 성공
select * from hr.departments;   -- 조회 불가
--------------------------------------------------
-- ORACLE 의 TABLE 복사하기
-- hr 의 employees 테이블을 sky로 복사하여 가져온다.
-- [1] 테이블 생성
-- 1. 테이블 복사
---- 대상 : 테이블 구조, 데이터 (제약조건의 일부만 복사 (NOT NULL))
---- 1) 구조, 데이터 ALL 복사, 제약조건은 일부만 복사
CREATE TABLE EMP1
    AS
        SELECT * FROM HR.EMPLOYEES;
        
---- 2) 구조, 데이터 복사, 50번, 80번 부서만 복사
CREATE TABLE EMP2
    AS
        SELECT * FROM HR.EMPLOYEES
        where DEPARTMENT_ID IN (50,80);
        
---- 3) 구조만 복사, DATA 빼고
CREATE TABLE EMP3
    AS
        SELECT * FROM HR.EMPLOYEES
        where 1 = 0;
        
---- 4) 구조만 복사된 TABLE EMP3 에 DATA만 추가
CREATE TABLE EMP4
    AS
        SELECT * FROM HR.EMPLOYEES
        where 1 = 0;
        
---- DATA만 추가
INSERT INTO EMP4
    SELECT * FROM HR.EMPLOYEES;
COMMIT;

---- 5) 일부칼럼만 복사해서 새로운 테이블 생성
CREATE TABLE EMP5
    AS
        SELECT EMPLOYEE_ID EMPID,
            FIRST_NAME||' '||LAST_NAME ENAME,
            SALARY SAL,
            SALARY * COMMISSION_PNT COMM,
            MANAGER_ID DEPTID
        FROM HR.EMPLOYEES;
        
-- 2. SQLDEVELOPER 메뉴에서 TABLE을 생성
--== HTH 계정
--== 테이블 메뉴 클릭 -> 새 테이블 클릭 -> TABLE1 생성
--== EMPID NUMBER(6,0) No
--== ENAME VARCHAR2(30 BYTE) No
--== TEL VARCHAR2(20 BYTE) Yes
--== EMAIL VARCHAR2(320 BYTE) Yes

-- 3. SQL SCRIPT로 테이블 생성
CREATE TABLE TABLE2(
    EMPID NUMBER(6,0) NOT NULL PRIMARY KEY
    , ENAME VARCHAR2(30 BYTE) NOT NULL
    , TEL VARCHAR2(20 BYTE) NULL
    , EMAIL VARCHAR2(320 BYTE)
);

-- [2] 테이블 제거 - 영구적으로 구조와 데이터가 제거된다.
-- DTOP TABLE EMP1;
-- drop 되는 테이블이 부모테이블일 경우 자식을 먼저 지워야 삭제가능

-- hr에서 DROP TABLE DEPARTMENTS;
-- DROP TABLE DEPARTMENTS -- 삭제안됨
-- 오류보고
-- ORA-02449 : 외래 키에 의해 참조되는 고유/기본 키가 테이블에 있습니다.
-- 02449.00000 - "unique/primary key in table referenced by foreign keys"
-- drop table 테이블명 casdade;  -- relationship 에 상관없이 삭제 가능

-- [3] 구조(테이블) 변경
-- 1. 칼럼추가
ALTER TABLE EMP5
ADD (LOC VARCHAR2(6));  --추가된 DATA : Null
-- 변경사항 확인은 새로 고침하라

-- 2. 칼럼제거
ALTER TABLE EMP5
DROP COLUMN LOC;

-- 3. 테이블 이름 변경
RENAME EMP4 TO NEWEMP;

-- 4. 칼럼속성변경 --크기는 늘리거나 줄인다.
ALTER TABLE EMP5
MODIFY (ENAME VARCHAR2(60));    --46 --> 60
--===========================================================================
-- 성적처리 TABLE
-- 업무
-- 학생 : 학번, 이름, 전화, 입학일
-- 성적 : 학번, 국어, 영어, 수학, 총점, 평균, 석차, 결과
-- 과목은 변경될 수 있다.

-- TABLE 생성
-- 학생   : 학번(PK), 이름,     전화,    입학일
-- STUDENT  STID      STNAME    PHONE    INDATE

-- 성적 : 일련번호(PK), 교과목,  점수,  학번(FK)
-- SCROES   SCID        SUBJECT  SCORE   STID
--===========================================================================
-- 제약조건 (CONSTRAINS) - 무경설 제약조건
-- TABLE 에 저장될 데이터에 조건을 부여하여 잘못된 DATA 입력되는 것을 방지
-- 1. 주식별자 설정 : 기본키
---- PRIMARY KEY : NOT NULL + UNIQUE 기본 적용
---- CREATE TABLE 명령안에 한번만 사용가능
-- 2. NOT NULL / NULL : 필수입력, 컬럼단위 제약조건
-- 3. UNIQUE : 중복방지
-- 4. CHECK : 값의 범위지정, DOMAIN 제약조건
-- 5. FOREIGN KEY : 외래키 제약조건
--===========================================================================
-- 학생   : 학번(PK), 이름,     전화,    입학일
-- STUDENT  STID      STNAME    PHONE    INDATE


create table STUDENT(
    STID NUMBER(6) PRIMARY KEY,     -- 학번 숫자(6) 기본키,
    STNAME VARCHAR2(30) NOT NULL,   -- 이름 문자(30) 필수입력,
    PHONE VARCHAR(20) UNIQUE,       -- 전화 문자(20) 중복방지,
    INDATE DATE DEFAULT SYSDATE     -- 입학일 날짜 기본값(SYSDATE)
);


insert into student (stid, stname, phone, indate) values (1,'가나','010',SYSDATE);
insert into student values (2,'나나','011',SYSDATE);
insert into student (stid, stname, phone) values (3,'가나','012');
insert into student (stid, stname, phone) values (4,'라나','013');
insert into student (stid, stname, phone) values (5,'라나','014');
insert into student (stid, stname, phone)
              values ( null,  '사나', '015'); --ORA-01400: NULL을 ("SKY"."STUDENT"."STID") 안에 삽입할 수 없습니다
insert into student (stid, stname, phone, indate)
              values ( 1,  '가나', '010', SYSDATE);   --ORA-00001: 무결성 제약 조건(SKY.SYS_C008358)에 위배됩니다
insert into student (stid, stname, phone, indate)
              values ( 6,  null, '016', SYSDATE);   --ORA-01400: NULL을 ("SKY"."STUDENT"."STNAME") 안에 삽입할 수 없습니다
insert into student (stid, stname, phone, indate)
              values ( 7,  '하나', null, SYSDATE);    -- 정상입력
commit;
--===========================================================================
-- 성적 : 일련번호(PK), 교과목,  점수,  학번(FK)
-- SCROES   SCID        SUBJECT  SCORE   STID
drop table SCORES;

create table SCORES(
    SCID NUMBER(6) ,                                  -- 일련번호 숫자(6) 기본키 자동입력,
    SUBJECT VARCHAR2(60) NOT NULL,                    -- 교과목 문자(30) 필수입력,
    SCORE NUMBER(3) CHECK (SCORE BETWEEN 0 AND 100),  -- 점수 숫자(3) 범위(0~100),
    STID NUMBER(6),                                   -- 학번 숫자(6) STUDENT TABLE 학번을 가져온다 FK
    CONSTRAINT SCID_PK
        PRIMARY KEY (SCID,SUBJECT),
    CONSTRAINT STID_FK
        FOREIGN KEY (STID)
        REFERENCES STUDENT(STID)
);

ALTER TABLE SCORES
ADD (STID NUMBER(6));

insert into SCORES (SCID, SUBJECT, SCORE, STID) values (1,'국어',100,1);
insert into SCORES values (2,'영어',100,1);
insert into SCORES values (3,'수학',100,1);
insert into SCORES values (4,'국어',100,2);
insert into SCORES values (5,'수학',80,2);
insert into SCORES values (6,'국어',70,4);
insert into SCORES values (7,'영어',80,4);
insert into SCORES values (8,'수학',85,4);
insert into SCORES values (9,'국어',805,5);   -- ORA-02290: 체크 제약조건(SKY.SYS_C008371)이 위배되었습니다
insert into SCORES values (10,'영어',100,6);  -- ORA-02291: 무결성 제약조건(SKY.STID_FK)이 위배되었습니다- 부모 키가 없습니다
commit;
--=======================================================================
-- 1. INSERT --> 한줄 추가 / COMMIT 필수
---- 1) INSERT INTO SCORES (SCID, SUBJECT, SCORE, STID)
--                  VALUES (1,'제목',100,1);

---- 2) INSERT INTO EMP4 -- 여러줄 추가
--                  SELECT * FROM HR.EMPLOYEES;

---- 3) INSERT ALL -- INSERT 문 여러개를 한번에 실행
---- INSERT ALL
--      INTO ex7_3 VALUES (103,'강감찬')
--      INTO ex7_3 VALUES (104,'연개소문')
--   SELECT * FROM DUAL;

-- 2. DELETE -- 줄(DATA) 을 삭제한다. / 조건이 없으면 전부 삭제한다. / COMMIT 필수!
---- DELETE FROM (테이블명) where (조건)

-- 3. UPDATE -- 줄의 변화(데이터의 변화)는 없고 정보만 수정 / COMMIT 필수!
---- UPDATE MYMEMBER SET TEL = '010-0000-0000', EMAIL = 'sky@green.com' WHERE EMPID = 10;(조건필수! - 조건이 없는 경우 DELETE 와 마찬가지로 전체를 의미한다.)