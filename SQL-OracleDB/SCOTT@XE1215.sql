-- ORACLE OUTER JOIN
SELECT E.ENAME, M.ENAME
FROM EMP E, EMP M
WHERE E.MGR = M.EMPNO(+);

-- ANSI OUTER JOIN : ���ι��� ���ʿ� �ִ� ���̺��� ��� ����� ������ ��
-- ������ ���̺��� �����͸� ��Ī�ϰ�, ��Ī�Ǵ� �����Ͱ� ���� ��� NULL�� ǥ���Ѵ�.
SELECT E.ENAME, M.ENAME
FROM EMP E LEFT OUTER JOIN EMP M
ON E.MGR = M.EMPNO;
---------------------------------------------------------------------------------------------
-- 8��

-- ���� ����
SELECT DNAME
FROM DEPT
WHERE DEPTNO = ( SELECT DEPTNO
                 FROM EMP
                 WHERE ENAME='SCOTT');                 
SELECT DNAME
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO
AND EMP.ENAME='SCOTT';

-- ������ ���� ����
SELECT ENAME, SAL
FROM EMP
WHERE SAL > (SELECT AVG(SAL)
             FROM EMP);
             
-- ������ ���� ���� : IN, ANY, SOM, ALL, EXIST

-- IN ������ : ���� ������ ��� ��� �߿��� �ϳ��� ��ġ�ϸ� ���̴�.
SELECT ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO IN (SELECT DISTINCT DEPTNO
                 FROM EMP
                 WHERE SAL >= 3000);
-- ALL ������ : ���� ������ �˻� ����� ��� ���� ��ġ�ϸ� ���̴�.
SELECT ENAME, SAL
FROM EMP
WHERE SAL > ALL(SELECT SAL
                FROM EMP
                WHERE DEPTNO=30); --DEPNO=30 �� ���� ū ��(2850)�� ��
-- ANY ������ : ���� ������ �˻� ����� �ϳ� �̻� ��ġ�ϸ� ���̴�.
SELECT ENAME, SAL
FROM EMP
WHERE SAL > ANY (SELECT SAL
                 FROM EMP
                 WHERE DEPTNO=30); --DEPTNO=30 �� ���� ������(950)�� ��
-- EXISTS ������ : ���� ������ ������� �ϳ��̻� �����ϸ� ���� ���ǽ��� ��� TRUE,
-- �������� ������ ��� FALSE�� �Ǵ� ������
SELECT *
FROM EMP
WHERE 1=1;

SELECT *
FROM EMP
WHERE EXISTS (SELECT DNAME
              FROM DEPT
              WHERE DEPTNO=10); --�������� ���� ���̸� ���� �����ش�
    
SELECT * FROM EMP;
--����8-2------------------------------
UPDATE EMP SET SAL =2850
WHERE ENAME='SMITH';

SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE (DEPTNO, SAL) IN(SELECT DEPTNO, MAX(SAL)
                    FROM EMP
                    GROUP BY DEPTNO)
ORDER BY DEPTNO ASC;
--------------------------------------
-- DDL : CREATE, ALTER, RENAME, TRUNCATE, DROP
-- DML : INSERT, UPDATE, DELETE, SELECT

--CREATE��
CREATE TABLE EX2_1 (
    COLUMN1 CHAR(10),
    COLUMN2 VARCHAR2(10),
    COLUMN3 VARCHAR2(10),
    COLUMN4 NUMBER
);
DESC EX2_1;
-- ���̺� ����
DROP TABLE EMP01 CASCADE CONSTRAINTS;
CREATE TABLE EMP01(
    EMPNO NUMBER(4),
    ENAME VARCHAR2(20),
    SAL NUMBER(7, 2)
);

SELECT * FROM EMP01;
DESC EMP01

-- ���� ������ ���̺� �����ϱ�
CREATE TABLE EMP02
AS
SELECT * FROM EMP;
DESC EMP02;
SELECT * FROM EMP02; --���簡 ��

-- Ư���� �÷����� ������ ���� ���̺� �����ϱ�
CREATE TABLE EMP03
AS
SELECT EMPNO, ENAME FROM EMP; --EMPNO, ENAME ���̺�����ϸ鼭 ����
SELECT * FROM EMP03;

-- ���ϴ� ��(ROW)���� ������ ���� ���̺� �����ϱ�
CREATE TABLE EMP05
AS
SELECT * FROM EMP
WHERE DEPTNO=10; --DEPT10 �κи� ���̺� �����ϸ鼭 ����

-- ���̺� ������ ����
CREATE TABLE EMP06
AS
SELECT * FROM EMP
WHERE 1=0;

-- ALTER TABLE
-- TABLE�� COLUMN�߰�
DESC EMP01;
ALTER TABLE EMP01
ADD(JOB VARCHAR2(9));

--���� �÷� �Ӽ� �����ϱ�
ALTER TABLE EMP01
MODIFY(JOB VARCHAR2(30));
DESC EMP01

--���� �÷� �����ϱ�
ALTER TABLE EMP01
DROP COLUMN JOB;
DESC EMP01  

--SET UNUSED �ɼ� �����ϱ�
ALTER TABLE EMP02
SET UNUSED(JOB);
SELECT * FROM EMP02;
DESC EMP02;
ALTER TABLE EMP02
DROP UNUSED COLUMNS;

-- DROP TABLE : ���̺� ����
DROP TABLE EMP01;
DROP TABLE EMP02;
DROP TABLE EMP01 CASCADE CONSTRAINTS;
SELECT * FROM EMP01;

SELECT * FROM EMP03;  
DELETE FROM EMP03;    --DML : DELETE �� ROLLBACK�ϸ� ������ �ȴ�. 
ROLLBACK;
TRUNCATE TABLE EMP03; --DDL : TRUNCATE �� ROLLBACK�ϸ� ������ �ȵȴ�. (TRUNCATE = DELETE+COMMIT)

-- RENAME TABLE : ���̺� �� ����
RENAME EMP03 TO TEST;
SELECT * FROM TEST;

--��Ű��(SCHEMA)= USER(�� ��ü��)

-- USER_ ������ ��ųʸ�

DESC USER_TABLES;

SELECT TABLE_NAME FROM USER_TABLES
ORDER BY TABLE_NAME ASC;

SELECT * FROM DEPT;
SELECT * FROM SYSTEM.HELP; --���� �ٸ� ������ ���̺� ���ӵ����ʴ´�.

-- ALL_ ������ ��ųʸ�
DESC ALL_TABLES;
SELECT OWNER, TABLE_NAME FROM ALL_TABLES;

--SYS(SUPER)
--SYSTEM(DBA)

SHOW USER;
SELECT TABLE_NAME, OWNER FROM DBA_TABLES;


-----------------------------------------------
-- DML : INSERT, UPDATE, DELETE
-- INSERT��
DESC DEPT01;
ALTER TABLE DEPT01
ADD(LOC VARCHAR2(10));

INSERT INTO DEPT01 VALUES(10, 'ACCOUNTIN', 'NEW YOR');
SELECT * FROM DEPT01;
INSERT INTO DEPT01 VALUES(30, 'DEVELOPMENT', NULL);
INSERT INTO DEPT01(DEPTNO,DNAME) VALUES(40, 'SALES');

DROP TABLE DEPT01;
CREATE TABLE DEPT01
AS
SELECT * FROM DEPT WHERE 1=0;
SELECT * FROM DEPT01;