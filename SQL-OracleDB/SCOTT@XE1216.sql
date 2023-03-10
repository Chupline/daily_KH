-- DML
-- 테이블에 새로운 행을 추가하는 INSERT문
SELECT * FROM DEPT01;
DESC DEPT01;
INSERT INTO DEPT01 VALUES(10, '총무부', '서울');
INSERT INTO DEPT01 (DEPTNO, DNAME) VALUES(20,'개발부');
INSERT INTO DEPT01 (DEPTNO, DNAME, LOC)VALUES (30, 'ACCOUNTING', '서울');
INSERT INTO DEPT01 VALUES (40, '영업부', NULL);

-- 서브 쿼리로 데이터 삽입하기
DROP TABLE DEPT02;
CREATE TABLE DEPT02
AS
SELECT * FROM DEPT WHERE 1=0;
SELECT * FROM DEPT02;

INSERT INTO DEPT02
-- VALUES();
SELECT * FROM DEPT;

-- INSERT ALL 명령문으로 다중 테이블에 다중행 입력하기
DESC EMP;
SELECT * FROM EMP
WHERE DEPTNO=20;
DROP TABLE EMP_HIR;
CREATE TABLE EMP_HIR
AS
SELECT EMPNO, ENAME, HIREDATE FROM EMP
WHERE 1=0;
SELECT * FROM EMP_HIR;
DROP TABLE EMP_MGR;

CREATE TABLE EMP_MGR
AS
SELECT EMPNO, ENAME, MGR FROM EMP
WHERE 1=0;

SELECT * FROM EMP_MGR;

INSERT ALL
INTO EMP_HIR VALUES(EMPNO, ENAME, HIREDATE)
INTO EMP_MGR VALUES(EMPNO, ENAME, MGR)
SELECT EMPNO, ENAME, HIREDATE, MGR
FROM EMP
WHERE DEPTNO=20;
SELECT * FROM EMP_HIR;
SELECT * FROM EMP_MGR;

-- INSERT ALL 명령에 조건(WHEN)으로 다중 테이블에 다중행 입력하기
DROP TABLE EMP_HIR02;
CREATE TABLE EMP_HIR02
AS
SELECT EMPNO, ENAME, HIREDATE FROM EMP
WHERE 1=0;
SELECT * FROM EMP_HIR02;

DROP TABLE EMP_SAL;
CREATE TABLE EMP_SAL
AS
SELECT EMPNO, ENAME, SAL FROM EMP
WHERE 1=0;
SELECT * FROM EMP_SAL;

INSERT ALL
WHEN HIREDATE > '1982/01/01' THEN
INTO EMP_HIR02 VALUES(EMPNO, ENAME, HIREDATE)
WHEN SAL > 2000 THEN
INTO EMP_SAL VALUES(EMPNO, ENAME, SAL)
SELECT EMPNO, ENAME, HIREDATE, SAL FROM EMP;
SELECT * FROM EMP_HIR02;
SELECT * FROM EMP_SAL;

-- UPDATE 문
-- 테이블의 모든 행 변경
DROP TABLE EMP01;
CREATE TABLE EMP01
AS
SELECT * FROM EMP;
SELECT * FROM EMP01
ORDER BY SAL;

UPDATE EMP01
SET DEPTNO=30;

UPDATE EMP01
SET SAL = SAL*1.1;
ROLLBACK;

UPDATE EMP01
SET HIREDATE=SYSDATE;
SELECT * FROM EMP01;

-- 테이블의 특정 행만 변경
DROP TABLE EMP01;
CREATE TABLE EMP01
AS
SELECT * FROM EMP;
SELECT * FROM EMP01;

UPDATE EMP01
SET DEPTNO=30
WHERE DEPTNO=10;
SELECT * FROM EMP01;

UPDATE EMP01
SET SAL=SAL*1.1
WHERE SAL < 3000;
SELECT * FROM EMP01;

UPDATE EMP01
SET HIREDATE = SYSDATE
WHERE SUBSTR(HIREDATE, 1, 2) = '87';
SELECT * FROM EMP01;

-- 테이블에서 2개 이상의 컬럼값 변경
DROP TABLE EMP01;
CREATE TABLE EMP01
AS
SELECT * FROM EMP;
SELECT * FROM EMP01;

UPDATE EMP01
SET DEPTNO=20, JOB='MANAGER'
WHERE ENAME='SCOTT';
SELECT * FROM EMP;

UPDATE EMP01
SET HIREDATE=SYSDATE, SAL=50, COMM=4000
WHERE ENAME='SCOTT';
SELECT * FROM EMP;

-- 서브 쿼리를 이용한 데이터 수정하기
UPDATE DEPT01
SET LOC = (SELECT LOC FROM DEPT WHERE DEPTNO=20);
SELECT * FROM DEPT01;

-- DELETE 문
-- DELETE문을 이용한 행 삭제
DELETE FROM DEPT01;
SELECT * FROM DEPT01;
ROLLBACK;

--조건을 제시하여 특정 행만 삭제하는 법
DELETE FROM DEPT01
WHERE DEPTNO=30;
SELECT * FROM DEPT01;

--서브 쿼리를 이용한 데이터 삭제
DELETE FROM DEPT01
WHERE DEPTNO = (SELECT DEPTNO FROM DEPT WHERE DNAME='RESERCH');
SELECT * FROM DEPT01;

-- MERGE : 합병
-- 기존에 존재하는 행이 있다면 새로운 값으로 갱신(UPDATE)되고, 존재하지 않으면 새로운 행으로 추가(INSERT)된다.
DROP TABLE EMP01;
CREATE TABLE EMP01
AS
SELECT * FROM EMP;
SELECT * FROM EMP01;

DROP TABLE EMP02;
CREATE TABLE EMP02
AS
SELECT * FROM EMP
WHERE JOB='MANAGER';
SELECT * FROM EMP02;

UPDATE EMP02
SET JOB='TEST';
SELECT * FROM EMP02;

INSERT INTO EMP02
VALUES(8000, 'SYJ', 'TOP', 7566, '2009/01/12', 1200, 10, 20);

MERGE INTO EMP01
USING EMP02
ON(EMP01.EMPNO=EMP02.EMPNO)
WHEN MATCHED THEN 
UPDATE SET
EMP01.ENAME=EMP02.ENAME,
EMP01.JOB=EMP02.JOB,
EMP01.MGR=EMP02.MGR,
EMP01.HIREDATE=EMP02.HIREDATE,
EMP01.SAL=EMP02.SAL,
EMP01.COMM=EMP02.COMM,
EMP01.DEPTNO=EMP02.DEPTNO
WHEN NOT MATCHED THEN
INSERT VALUES(EMP02.EMPNO, EMP02.ENAME, EMP02.JOB,
EMP02.MGR, EMP02.HIREDATE, EMP02.SAL,
EMP02.COMM, EMP02.DEPTNO);

SELECT * FROM EMP01;

DESC EMP01;
DESC EMP; --NOT NULL
--EMPNO : 제약조건(PRIMARY KEY = NOT NULL + UNIQUE, 기본키)
INSERT INTO EMP(EMPNO, ENAME) VALUES (7369, '홍길동');
--unique constraint (SCOTT.PK_EMP) violated 
--UPDATE를 사용해서 값을 변경한다.
---------------------------------------------------
-- 트랜잭션
DROP TABLE DEPT01;
CREATE TABLE DEPT01
AS
SELECT * FROM DEPT;
SELECT * FROM DEPT01;

-- CREATE문에 의한 자동 커밋
DROP TABLE DEPT02;
CREATE TABLE DEPT02
AS
SELECT * FROM DEPT;
SELECT * FROM DEPT02;

DELETE FROM DEPT02
WHERE DEPTNO=40;
ROLLBACK; 

CREATE TABLE DEPT03
AS
SELECT * FROM DEPT;
--DDL문은  AUTO COMMIT 수행한다.
--CREATE 하는 순간 롤백 되지않는다...

--DDL의 실패에 의한 자동 커밋
DROP TABLE DEPT03;
CREATE TABLE DEPT03
AS 
SELECT * FROM DEPT;

SELECT * FROM DEPT03;
ROLLBACK;

DELETE FROM DEPT03
WHERE DEPTNO=20;
ROLLBACK;
TRUNCATE TABLE DEPTPPP;

--SAVEPOINT
DROP TABLE DEPT01;
CREATE TABLE DEPT01
AS
SELECT * FROM DEPT;

DELETE FROM DEPT01
WHERE DEPTNO=40;
SELECT * FROM DEPT01;
COMMIT; -- DELETE 40

DELETE FROM DEPT01
WHERE DEPTNO=30;
SAVEPOINT C1; 

DELETE FROM DEPT01
WHERE DEPTNO=20;
SAVEPOINT C2;

DELETE FROM DEPT01
WHERE DEPTNO=10;
SELECT * FROM DEPT01;

ROLLBACK TO C2; 
ROLLBACK TO C1;
ROLLBACK;
--------------------------------------
-- 12강 

SELECT * FROM EMP01
WHERE ENAME='SCOTT';

DELETE FROM EMP01
WHERE ENAME='SCOTT';
-- CMD에서 있는것 처럼 보인다
-- CMD에서 
--UPDATE EMP01
--SET SAL = 200
--WHERE ENAME='SCOTT';
--수행하면 커서만 깜빡깜빡 하면서 LOCK 걸린상태가 된다.
ROLLBACK;

-- SET UNUSED
DROP TABLE EMP02;
CREATE TABLE EMP02
AS
SELECT * FROM EMP;

SELECT * FROM EMP02;

ALTER TABLE EMP02
SET UNUSED(COMM);

--DDL 명령의 롤백
DROP TABLE EMP01;
CREATE TABLE EMP01
AS
SELECT * FROM EMP;

SELECT * FROM EMP01;

DROP TABLE EMP02;
CREATE TABLE EMP02
AS
SELECT * FROM EMP01;

ALTER TABLE EMP01
DROP COLUMN JOB;

ROLLBACK;
DROP TABLE EMP01;
RENAME EMP02 TO EMP01;
SELECT * FROM EMP01;

-- TRUNCATE와 DELETE의 차이
-- 둘 다 테이블의 모든 행을 삭제한다. TRUNCATE = DELETE+COMMIT
