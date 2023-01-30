-- ����ȯ �Լ� : TO_NUMBER, TO_CHAR, TO_DATE
-- 1. DATE -> VARCHAR2 (��¥->����)
SELECT SYSDATE FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YY-MM-DD HH24:MI:SS') FROM DUAL;

-- 2. NUMBER -> VARCHAR2 (����->����)
SELECT ENAME, SAL FROM EMP;
SELECT ENAME, TO_CHAR(SAL, 'L999,999') FROM EMP; --'L' : LOCALE�� ���

-- 3. NUMBER -> DATE (����->��¥)
SELECT ENAME, HIREDATE FROM EMP;
SELECT ENAME, HIREDATE FROM EMP 
--WHERE HIREDATE='1981/02/20'; --���ڿ�
WHERE HIREDATE = TO_DATE(19810220, 'YYYY-MM-DD');

-- 4. VARCHAR2 -> NUMBER (����->����)
SELECT TO_NUMBER('20,000', '99,999') - TO_NUMBER('10,000','99,999') FROM DUAL;
----------------------------------------------------------------------------------------------
--�׷� ������ ���� ������

-- SUM : �հ�
SELECT SUM(SAL) FROM EMP;
SELECT SUM(COMM) FROM EMP; --NULL���� �����ϰ� �հ踦 ���Ѵ�.

-- AVG : ���
SELECT AVG(SAL) FROM EMP;
SELECT AVG(COMM) FROM EMP; --NULL���� �����ϰ� ����� ���Ѵ�.

-- MAX, MIN : �ִ�, �ּ�
SELECT MAX(SAL), MIN(SAL) FROM EMP;
SELECT SAL FROM EMP;
SELECT ENAME, MAX(SAL) FROM EMP; --ORA-00937: not a single-group group function

-- COUNT : ROW ����
SELECT COUNT(*), COUNT(COMM) FROM EMP;
SELECT COUNT(JOB)"������" FROM EMP; 
SELECT COUNT(DISTINCT JOB)"������" FROM EMP; --�ߺ� ����
------------------------------------------------------------------------------------------------
-- SELECT (�÷�)
-- FROM (���̺�) 
-- WHERE (����)
-- ORDER BY (����)
-- GROUP BY (�׷���)

-- GROUP BY ��
SELECT DEPTNO, AVG(SAL)
FROM EMP
GROUP BY DEPTNO; --�׷����Ͽ� ��� �� ���Ҷ� ����

SELECT DEPTNO, MAX(SAL), MIN(SAL)
FROM EMP
WHERE SAL>=800
GROUP BY DEPTNO
ORDER BY DEPTNO ASC;

-- HAVING �� : GROUP�� ���� ����
SELECT DEPTNO, AVG(SAL)
FROM EMP
WHERE SAL>=800
GROUP BY DEPTNO
HAVING AVG(SAL) >= 2000
ORDER BY DEPTNO; 
---------------------------------------------------------------------------------
-- ���� ������
DROP TABLE EXP_GOODS_ASIA;
CREATE TABLE EXP_GOODS_ASIA (
COUNTRY VARCHAR2(10),
SEQ NUMBER,
GOODS VARCHAR2(80));
INSERT INTO EXP_GOODS_ASIA VALUES ('�ѱ�', 1, '�������� ������');
INSERT INTO EXP_GOODS_ASIA VALUES ('�ѱ�', 2, '�ڵ���');
INSERT INTO EXP_GOODS_ASIA VALUES ('�ѱ�', 3, '��������ȸ��');
INSERT INTO EXP_GOODS_ASIA VALUES ('�ѱ�', 4, '����');
INSERT INTO EXP_GOODS_ASIA VALUES ('�ѱ�', 5, 'LCD');
INSERT INTO EXP_GOODS_ASIA VALUES ('�ѱ�', 6, '�ڵ�����ǰ');
INSERT INTO EXP_GOODS_ASIA VALUES ('�ѱ�', 7, '�޴���ȭ');
INSERT INTO EXP_GOODS_ASIA VALUES ('�ѱ�', 8, 'ȯ��źȭ����');
INSERT INTO EXP_GOODS_ASIA VALUES ('�ѱ�', 9, '�����۽ű� ���÷��� �μ�ǰ');
INSERT INTO EXP_GOODS_ASIA VALUES ('�ѱ�', 10, 'ö �Ǵ� ���ձݰ�');
INSERT INTO EXP_GOODS_ASIA VALUES ('�Ϻ�', 1, '�ڵ���');
INSERT INTO EXP_GOODS_ASIA VALUES ('�Ϻ�', 2, '�ڵ�����ǰ');
INSERT INTO EXP_GOODS_ASIA VALUES ('�Ϻ�', 3, '��������ȸ��');
INSERT INTO EXP_GOODS_ASIA VALUES ('�Ϻ�', 4, '����');
INSERT INTO EXP_GOODS_ASIA VALUES ('�Ϻ�', 5, '�ݵ�ü������');
INSERT INTO EXP_GOODS_ASIA VALUES ('�Ϻ�', 6, 'ȭ����');
INSERT INTO EXP_GOODS_ASIA VALUES ('�Ϻ�', 7, '�������� ������');
INSERT INTO EXP_GOODS_ASIA VALUES ('�Ϻ�', 8, '�Ǽ����');
INSERT INTO EXP_GOODS_ASIA VALUES ('�Ϻ�', 9, '���̿���, Ʈ��������');
INSERT INTO EXP_GOODS_ASIA VALUES ('�Ϻ�', 10, '����');
COMMIT;
SELECT COUNT(*) FROM EXP_GOODS_ASIA;

SELECT GOODS
FROM EXP_GOODS_ASIA
WHERE COUNTRY = '�ѱ�'
ORDER BY SEQ;

SELECT GOODS
FROM EXP_GOODS_ASIA
WHERE COUNTRY = '�Ϻ�'
ORDER BY SEQ;

-- UNION : ������ (A u B) : �ߺ��� �����ϰ� ���Ѵ�
SELECT GOODS
FROM EXP_GOODS_ASIA
WHERE COUNTRY = '�ѱ�' 
--UNION --������ 1.�ߺ�����
--UNION ALL --������ 2.�ߺ�����
--INTERSECT --������
MINUS --������
SELECT GOODS
FROM EXP_GOODS_ASIA
WHERE COUNTRY = '�Ϻ�';
------------------------------------------------------------------------
SELECT * FROM EMP;
SELECT * FROM DEPT;

SELECT DEPTNO FROM EMP
WHERE ENAME='SMITH';
SELECT DNAME FROM DEPT
WHERE DEPTNO=20;

-- JOIN
SELECT *
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO AND
EMP.ENAME = 'SMITH';

-- ORACLE CROSS JOIN
SELECT * 
FROM EMP, DEPT;

SELECT * FROM DEPT;
COMMIT;

DELETE FROM DEPT
WHERE DEPTNO=50;

-- ORACLE EQUIT JOIN
SELECT *
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;

SELECT E.ENAME, D.DNAME, E.DEPTNO, D.DEPTNO
FROM EMP E, DEPT D -- ���̺��� ��Ī�� �ο���
WHERE E.DEPTNO = D.DEPTNO
AND E.ENAME='SCOTT';

-- Non_Equi Join
SELECT * FROM SALGRADE;

SELECT E.ENAME, E.SAL, S.GRADE
FROM EMP E, SALGRADE S
--WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL; 
WHERE E.SAL >= S.LOSAL AND E.SAL <= S.HISAL; -- =BETWEEN S.LOSAL AND S.HISA

-- Self Join
SELECT EMPNO, ENAME, MGR FROM EMP;

SELECT E.ENAME"�����", M.ENAME"����"
FROM EMP E, EMP M
WHERE E.MGR = M.EMPNO;
------------------------------------
--����03
SELECT E.ENAME, E.JOB
FROM EMP E, EMP M
WHERE E.MGR = M.EMPNO 
AND M.ENAME='KING';

SELECT C.ENAME 
FROM EMP E, EMP C
WHERE E.DEPTNO = C.DEPTNO
AND E.ENAME = 'SCOTT'
AND C.ENAME <> 'SCOTT'
ORDER BY C.ENAME ASC;
---------------------------------------
--OTHER JOIN : ���� ���ǿ� �������� ���Ͽ����� �ش� �ο츦 ��Ÿ����ȣ �� �� ����Ѵ�.
SELECT * FROM EMP;
SELECT E.ENAME, M.ENAME
FROM EMP E, EMP M
WHERE E.MGR = M.EMPNO(+);

-- ANSI CROSS JOIN = ORACLE CROSS JOIN
SELECT *
--FROM EMP, DEPT; --ORACLE������ ����ϴ� CROSS JOIN
FROM EMP CROSS JOIN DEPT; --ANSI(�ٸ� DB���� ����ϴ� CROSS JOIN)

-- ANSI INNER JOIN = OREACLE EQUI JOIN
SELECT E.ENAME, D.DNAME
--FROM EMP E, DEPT D --ORACLE������ ����� EQUI JOIN
--WHERE E.DEPTNO = D.DEPTNO;
FROM EMP E INNER JOIN DEPT D --ANSI INNER JOIN
--ON E.DEPTNO = D.DEPTNO; --���ǹ��1
USING(DEPTNO); --���ǹ��2

-- ANSI NATURAL JOIN : �ڵ������� ��� �÷��� ������� ���� �÷��� �����Ͽ� ���������� ���ι��� ����
SELECT E.ENAME, D.DNAME
FROM EMP E NATURAL JOIN DEPT D;

-- ANSI OUTER JOIN
DROP TABLE DEPT01;
CREATE TABLE DEPT01(
DEPTNO NUMBER(2),
DNAME VARCHAR2(14)
);
INSERT INTO DEPT01 VALUES(10,'ACCOUNTING');
INSERT INTO DEPT01 VALUES(20,'RESEARCH');
SELECT * FROM DEPT01;
DROP TABLE DEPT02;
CREATE TABLE DEPT02(
DEPTNO NUMBER(2),
DNAME VARCHAR2(14)
);
INSERT INTO DEPT02 VALUES(10,'ACCOUNTING');
INSERT INTO DEPT02 VALUES(30,'SALES');
SELECT * FROM DEPT02;
-- ANSI Left Outer Join
SELECT *
FROM DEPT01 LEFT OUTER JOIN DEPT02
ON DEPT01.DEPTNO = DEPT02.DEPTNO;
-- ANSI Right Outer Join
SELECT *
FROM DEPT01 RIGHT OUTER JOIN DEPT02
USING(DEPTNO);
-- ANSI Full Outer Join
SELECT *
FROM DEPT01 FULL OUTER JOIN DEPT02
USING(DEPTNO);

----------------------------------------------------
--����7-2
SELECT * FROM EMP;
SELECT E.ENAME, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND E.JOB='MANAGER';

SELECT E.ENAME, D.DNAME
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
AND E.JOB='MANAGER';

SELECT E.ENAME, D.DNAME
FROM EMP E NATURAL JOIN DEPT D
WHERE E.JOB='MANAGER';

SELECT C.ENAME, C.JOB
FROM EMP E, EMP C
WHERE E.ENAME='SMITH'
AND E.JOB=C.JOB
AND C.ENAME!='SMITH';