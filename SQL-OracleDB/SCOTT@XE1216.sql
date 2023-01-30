-- DML
-- ���̺��� ���ο� ���� �߰��ϴ� INSERT��
SELECT * FROM DEPT01;
DESC DEPT01;
INSERT INTO DEPT01 VALUES(10, '�ѹ���', '����');
INSERT INTO DEPT01 (DEPTNO, DNAME) VALUES(20,'���ߺ�');
INSERT INTO DEPT01 (DEPTNO, DNAME, LOC)VALUES (30, 'ACCOUNTING', '����');
INSERT INTO DEPT01 VALUES (40, '������', NULL);

-- ���� ������ ������ �����ϱ�
DROP TABLE DEPT02;
CREATE TABLE DEPT02
AS
SELECT * FROM DEPT WHERE 1=0;
SELECT * FROM DEPT02;

INSERT INTO DEPT02
-- VALUES();
SELECT * FROM DEPT;

-- INSERT ALL ���ɹ����� ���� ���̺��� ������ �Է��ϱ�
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

-- INSERT ALL ���ɿ� ����(WHEN)���� ���� ���̺��� ������ �Է��ϱ�
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

-- UPDATE ��
-- ���̺��� ��� �� ����
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

-- ���̺��� Ư�� �ุ ����
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

-- ���̺����� 2�� �̻��� �÷��� ����
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

-- ���� ������ �̿��� ������ �����ϱ�
UPDATE DEPT01
SET LOC = (SELECT LOC FROM DEPT WHERE DEPTNO=20);
SELECT * FROM DEPT01;

-- DELETE ��
-- DELETE���� �̿��� �� ����
DELETE FROM DEPT01;
SELECT * FROM DEPT01;
ROLLBACK;

--������ �����Ͽ� Ư�� �ุ �����ϴ� ��
DELETE FROM DEPT01
WHERE DEPTNO=30;
SELECT * FROM DEPT01;

--���� ������ �̿��� ������ ����
DELETE FROM DEPT01
WHERE DEPTNO = (SELECT DEPTNO FROM DEPT WHERE DNAME='RESERCH');
SELECT * FROM DEPT01;

-- MERGE : �պ�
-- ������ �����ϴ� ���� �ִٸ� ���ο� ������ ����(UPDATE)�ǰ�, �������� ������ ���ο� ������ �߰�(INSERT)�ȴ�.
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
--EMPNO : ��������(PRIMARY KEY = NOT NULL + UNIQUE, �⺻Ű)
INSERT INTO EMP(EMPNO, ENAME) VALUES (7369, 'ȫ�浿');
--unique constraint (SCOTT.PK_EMP) violated 
--UPDATE�� ����ؼ� ���� �����Ѵ�.
---------------------------------------------------
-- Ʈ�����
DROP TABLE DEPT01;
CREATE TABLE DEPT01
AS
SELECT * FROM DEPT;
SELECT * FROM DEPT01;

-- CREATE���� ���� �ڵ� Ŀ��
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
--DDL����  AUTO COMMIT �����Ѵ�.
--CREATE �ϴ� ���� �ѹ� �����ʴ´�...

--DDL�� ���п� ���� �ڵ� Ŀ��
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
-- 12�� 

SELECT * FROM EMP01
WHERE ENAME='SCOTT';

DELETE FROM EMP01
WHERE ENAME='SCOTT';
-- CMD���� �ִ°� ó�� ���δ�
-- CMD���� 
--UPDATE EMP01
--SET SAL = 200
--WHERE ENAME='SCOTT';
--�����ϸ� Ŀ���� �������� �ϸ鼭 LOCK �ɸ����°� �ȴ�.
ROLLBACK;

-- SET UNUSED
DROP TABLE EMP02;
CREATE TABLE EMP02
AS
SELECT * FROM EMP;

SELECT * FROM EMP02;

ALTER TABLE EMP02
SET UNUSED(COMM);

--DDL ������ �ѹ�
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

-- TRUNCATE�� DELETE�� ����
-- �� �� ���̺��� ��� ���� �����Ѵ�. TRUNCATE = DELETE+COMMIT