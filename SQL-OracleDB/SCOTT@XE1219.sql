-- 제약 조건 확인하기
-- CONSTRAINT_NAME은 제약 조건 명이다.
-- CONSTRAINT_TYPE는 제약 조건 유형을 저장하는 컬럼이다.
--P : PRIMARY KEY
--R : FOREIGN KEY
--U : UNIQUE
--C : CHECK, NOT NULL
SELECT * FROM DEPT;
INSERT INTO DEPT VALUES(10,'TEST','SEOUL'); --unique constraint (SCOTT.PK_DEPT) violated
DESC DEPT;

DESC USER_CONSTRAINTS;
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
FROM USER_CONSTRAINTS
WHERE TABLE_NAME='DEPT';

-- NOT NULL 제약 조건을 설정하지 않고 테이블 생성하기
DROP TABLE EMP01;
CREATE TABLE EMP01(
    EMPNO NUMBER(4),
    ENAME VARCHAR2(10),
    JOB VARCHAR2(9),
    DEPTNO NUMBER(2)
);
SELECT * FROM EMP01;
INSERT INTO EMP01 VALUES(NULL,NULL,'SALESMAN',30);

-- NOT NULL 제약 조건을 설정하여 테이블 생성하기
DROP TABLE EMP02;
CREATE TABLE EMP02(
    EMPNO NUMBER(4) NOT NULL,
    ENAME VARCHAR2(10) NOT NULL,
    JOB VARCHAR2(9),
    DEPTNO NUMBER(2)
);
SELECT * FROM EMP02;
INSERT INTO EMP02 VALUES(NULL,NULL,'SALESMAN',30); --cannot insert NULL into ("SCOTT"."EMP02"."EMPNO")
INSERT INTO EMP02 VALUES(1,'홍길동','SALESMAN',30);

--UNIQUE 제약조건을 설정하여 테이블 생성하기
DROP TABLE EMP03;
CREATE TABLE EMP03(
    EMPNO NUMBER(4) CONSTRAINT EMP03_EMP_UQ UNIQUE, --컬럼 레벨 방식(오류에서 식별)
    ENAME VARCHAR2(10) NOT NULL,
    JOB VARCHAR2(9),
    DEPTNO NUMBER(2)
);
SELECT * FROM EMP03;
INSERT INTO EMP03 VALUES(7499, 'ALLEN', 'SALESMAN', 30);
INSERT INTO EMP03 VALUES(7499, 'JONES', 'MANAGER', 30) ; --unique constraint (SCOTT.SYS_C007008) violated
INSERT INTO EMP03 VALUES(NULL, 'JONES', 'MANAGER', 20); --NULL은 가능
INSERT INTO EMP03 VALUES(NULL, 'JONES2', 'MANAGER', 20);
INSERT INTO EMP03 VALUES(NULL, 'JONES3', 'MANAGER', 20);

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
FROM USER_CONSTRAINTS
WHERE TABLE_NAME='EMP03';

-- PRIMARY KEY(기본키) 제약 조건 설정하기
-- PK = UNIQUE + NOT NULL
DROP TABLE EMP05;
CREATE TABLE EMP05(
    EMPNO NUMBER(4) CONSTRAINT EMP05_EMPNO_PK PRIMARY KEY,
    ENAME VARCHAR2(10) CONSTRAINT EMP05_EMPNO_NN NOT NULL,
    JOB VARCHAR2(9),
    DEPTNO NUMBER(2)
);
INSERT INTO EMP05 VALUES(7499,'ALLEN','SALESMAN',30);
SELECT * FROM EMP05;
INSERT INTO EMP05 VALUES(7499,'JONES','MANAGER',20); --unique constraint (SCOTT.EMP05_EMPNO_PK) violated
INSERT INTO EMP05 VALUES(NULL,'JONES','MANAGER',20); --cannot insert NULL into ("SCOTT"."EMP05"."EMPNO")

-- EMP, DEPT 테이블의 제약조건 확인
SELECT TABLE_NAME, CONSTRAINT_TYPE, CONSTRAINT_NAME, R_CONSTRAINT_NAME
FROM USER_CONSTRAINTS
WHERE TABLE_NAME IN('DEPT','EMP');

-- 참조 무결성을 위한 FOREIGN KEY 제약 조건
DROP TABLE EMP06;
CREATE TABLE EMP06(
    EMPNO NUMBER(4) CONSTRAINT EMP06_EMPNO_PK PRIMARY KEY,
    ENAME VARCHAR2(10) CONSTRAINT EMP06_ENAME_NN NOT NULL,
    JOB VARCHAR2(9),
    DEPTNO NUMBER(2) CONSTRAINT EMP06_DEPTNO_FK REFERENCES DEPT(DEPTNO)
);
INSERT INTO EMP06 VALUES(7499,'ALLEN','SALESMAN',30);
SELECT * FROM EMP06;
INSERT INTO EMP06 VALUES(7498,'JONES','MANAGER',50);--integrity constraint (SCOTT.EMP06_DEPTNO_FK) violated - parent key not found

-- CHECK 제약 조건 설정하기
DROP TABLE EMP07;
CREATE TABLE EMP07(
    EMPNO NUMBER(4) CONSTRAINT EMP07_EMPNO_PK PRIMARY KEY,
    ENAME VARCHAR2(10) CONSTRAINT EMP07_ENAME_NN NOT NULL,
    SAL NUMBER(7,2) CONSTRAINT EMP07_SAL_CK CHECK(SAL BETWEEN 500 AND 5000),
    GENDER VARCHAR2(1) CONSTRAINT EMP07_GENDER_CK CHECK(GENDER IN ('M','F'))
);
INSERT INTO EMP07 VALUES(7499,'ALLEN',500,'M');
INSERT INTO EMP07 VALUES(7498,'JONES',700,'A'); --check constraint (SCOTT.EMP07_GENDER_CK) violated

SELECT TABLE_NAME, CONSTRAINT_TYPE, CONSTRAINT_NAME, SEARCH_CONDITION
FROM USER_CONSTRAINTS
WHERE TABLE_NAME='EMP07';

-- DEFAULT 제약 조건 설정하기
DROP TABLE DEPT01;
CREATE TABLE DEPT01(
    DEPTNO NUMBER(2) PRIMARY KEY,
    DNAME VARCHAR2(14),
    LOC VARCHAR2(13) DEFAULT 'SEOUEL'
);
INSERT INTO DEPT01 (DEPTNO, DNAME) VALUES (10, 'ACCOUNTING');
INSERT INTO DEPT01 VALUES(20,'RESERACH', 'BUSAN');
SELECT * FROM DEPT01;   

-- 컬럼 레벨로 제약조건을 지정하기
DROP TABLE EMP01;
CREATE TABLE EMP01 (
    EMPNO NUMBER(4) PRIMARY KEY,
    ENAME VARCHAR2(10) NOT NULL,
    JOB VARCHAR2(9) UNIQUE,
    DEPTNO NUMBER(4) REFERENCES DEPT(DEPTNO)
);
-- 테이블 레벨로 제약조건 지정하기
DROP TABLE EMP02;
CREATE TABLE EMP02 (
    EMPNO NUMBER(4),
    ENAME VARCHAR2(10) NOT NULL,
    JOB VARCHAR2(9),
    DEPTNO NUMBER(4),
    PRIMARY KEY(EMPNO),
    UNIQUE(JOB),
    FOREIGN KEY(DEPTNO) REFERENCES DEPT(DEPTNO)
);

-- CASCADE 옵션으로 제약조건 연속적으로 비활성하기
--DROP TABLE DEPT01 CASCADE CONSTRAINTS;
DROP TABLE DEPT01;
CREATE TABLE DEPT01
AS
SELECT * FROM DEPT;
DESC DEPT;
SELECT * FROM DEPT01;
DESC DEPT01;

ALTER TABLE DEPT01 
ADD CONSTRAINT DEPT01_DEPT_PK PRIMARY KEY(DEPTNO); --테이블 레벨 방식

--
DROP TABLE EMP01;
CREATE TABLE EMP01
AS 
SELECT * FROM EMP WHERE 1=0;
SELECT * FROM EMP01;
DESC EMP01;

ALTER TABLE EMP01
--ADD CONSTRAINT EMP01_DEPTNO_FK FOREIGN KEY(DEPTNO) REFERENCES DEPT01(DEPTNO); --EMP01의 DEPTNO가 DEPT의 DEPTNO를 참조
ADD CONSTRAINT EMP01_DEPTNO_FK FOREIGN KEY(DEPTNO) REFERENCES DEPT01(DEPTNO)
ON DELETE CASCADE; --EMP01의 DEPTNO가 DEPT의 DEPTNO를 참조하지만 지울때 부모도 같이 지울 수 있는 제약 조건

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME, R_CONSTRAINT_NAME, STATUS
FROM USER_CONSTRAINTS
WHERE TABLE_NAME IN('DEPT01','EMP01');

SELECT * FROM DEPT01;
SELECT * FROM EMP01; --EMP01의DEPTNO가 DEPT의 DEPTNO를 참조하고있다.
INSERT INTO EMP01 (DEPTNO) VALUES (20);
DELETE FROM DEPT01
WHERE DEPTNO=20; --integrity constraint (SCOTT.EMP01_DEPTNO_FK) violated - child record found         
                 --EMP01이 DEPT의 DEPTNO를 참조하고 있어 지울 수 없다.
                 --ON DELETE CASCADE가 있다면 부모와 함께 지운다.
DELETE FROM EMP01;
DELETE FROM DEPT01
WHERE DEPTNO=10;

DROP TABLE DEPT01;
DROP TABLE DEPT01 CASCADE CONSTRAINTS;
SELECT * FROM DEPT01;
SELECT * FROM EMP01;

SELECT * FROM EMP;
SELECT EMPNO, ENAME FROM EMP;
SELECT * FROM EMP
WHERE DEPTNO=10;

-- 뷰의 기본 테이블 생성하기
DROP TABLE DEPT_COPY;
CREATE TABLE DEPT_COPY
AS
SELECT * FROM DEPT;
SELECT * FROM DEPT_COPY; --뷰의 기본테이블

CREATE TABLE EMP_COPY
AS
SELECT * FROM EMP;
SELECT * FROM EMP_COPY; --뷰의 기본테이블

--뷰 정의하기
DROP VIEW EMP_VIEW30;
CREATE VIEW EMP_VIEW30
AS
SELECT EMPNO, ENAME, DEPTNO FROM EMP_COPY 
WHERE DEPTNO=30; --권한이 없는 경우 SYSTEM에서 GRANT CREATE VIEW TO SCOTT;
DESC EMP_VIEW30
SELECT * FROM EMP_VIEW30;

-- 단순 뷰의 컬럼에 별칭 부여하기
CREATE OR REPLACE
VIEW EMP_VIEW(사원번호, 사원명, 부서번호)
AS
SELECT EMPNO, ENAME, DEPTNO
FROM EMP_COPY;

SELECT * FROM EMP_VIEW
WHERE 부서번호=30;

-- 복합 뷰 만들기
CREATE OR REPLACE
VIEW EMP_VIEW_DEPT
AS
SELECT E.EMPNO, E.ENAME, E.SAL, E.DEPTNO, D.DNAME, D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
ORDER BY EMPNO DESC;

SELECT * FROM EMP_VIEW_DEPT;

