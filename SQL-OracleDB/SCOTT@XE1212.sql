-- SELECT : ������ �˻�
SELECT * FROM DEPT; -- ������ ��ȸ
SELECT DNAME FROM DEPT; -- Ư�� Į�� ������ ��ȸ
SELECT DEPTNO,LOC FROM DEPT;

-- DML(Data Manipulation Language) : �����͸� �����ϴ� ����
-- INSERT : ������ �Է� / UPDATE : ������ ���� / DELETE : ������ ����
INSERT INTO DEPT VALUES(50, '�ѹ���', '����');  -- NEW ������ �Է�
UPDATE DEPT SET LOC='�λ�' WHERE DNAME='�ѹ���'; -- ������ ����
DELETE FROM DEPT WHERE DEPTNO=50; -- ������ ���� (DEPT���� DEPTNO=50����)
SELECT * FROM DEPT;

-- TCL(Transaction Control Language)
-- TCL�� �������� �ϰ����� �����ϸ鼭 ���������� �����͸� ������Ű�� ���ؼ� ����Ѵ�.
-- COMMIT : ����� ������ ���� ���� 
-- ROLLBACK : ����Ǳ� ���� ���·� �ǵ�����. 
-- SAVEPOINT : Ư�� ��ġ������ ���� Ȥ�� ���� ���·� �ǵ��� �� �ֵ��� Ʈ����� �߿� �������� �����.

-- DDL(Data Definition Language)
-- DDL�� �����ͺ��̽� ��ü���� ���� �Ǵ� ����, ������ �� ����Ѵ�.
-- ��ü�� ���̺�, �ε���, ��, Ʈ���� �� SQL���� �����ϴ� ����� �ȴ�.
-- CREATE (���̺� ����)
CREATE TABLE DEPT01 ( 
DEPTNO NUMBER(4),
DNAME VARCHAR2(10),
LOC VARCHAR2(9)
);
-- ALTER (���̺� ����)
ALTER TABLE DEPT01 MODIFY(DNAME VARCHAR2(30));
-- RENAME (���̺� �̸� ����)
RENAME DEPT01 TO DEPT02;
-- DELETE (���̺� ������ ���� ����, �����͸� �����Ͽ� ��������� ����)
DELETE TALBE DEPT02;
-- TRUNCATE (���̺� ������ ���� ����, ���̺� �ʱ�ȭ)
TRUNCATE TABLE DEPT02;

DESC DEPT02; --���̺� ���� Ȯ��
DESCRIBE DEPT02;

-- DCL(Data Control Language): DCL�� Ư�� ����ڿ��� ������ �ο��ϰų� �����ϱ� ���ؼ� ����ϴ� ��ɾ�
-- GRANT : �����ͺ��̽��� ���� �Ϸ��� ���� �ο�
-- REVOKE : �����ͺ��̽��� ���� �Ϸ��� ���� ���
--GRANT CREATE SESSION TO ORAUSER01;
--REVOKE CREATE SESSION FROM ORAUSER01;
------------------------------------------------------------------------------------------------
SHOW USER;
-- ������ ��ųʸ� TAB
-- TAB�� TABLE�� ���ڷμ� SCOTT ����ڰ� �����ϰ� �ִ� ���̺��� ������ �˷��ִ� ������ ��ųʸ��̴�.
SELECT * FROM TAB; 

-- DESC(DESCRIBE) : �����͸� ��ȸ�ϱ� ���� ���̺� ������ Ȯ���ϴ� ��ɾ�
SELECT * FROM DEPT01;
DESC DEPT01;
DESC EMP;
INSERT INTO DEPT01 VALUES(NULL, '���ߺ�', '����');
INSERT INTO DEPT01 VALUES(50, '���ߺ�', '����');
SELECT * FROM DEPT01;
TRUNCATE TABLE DEPT01;

-- ������Ÿ�� : NUMBER, DATE, VARCHAR2, CHAR
-- BOOLEAN Ÿ���� ������ ����ϰ� CHARŸ������ ����� �ִ�.
CREATE TABLE ITEMS(
    ITEM_NO NUMBER(3), --���� 3�ڸ�
    ISACTIVE CHAR(1) CHECK(ISACTIVE IN('T','F')) --�������� :  NOT BULL, PRIMARY KET, FOREIGN KEY, UNIQUE KEY
);

SELECT * FROM ITEMS;
INSERT INTO ITEMS VALUES(101, 'Y');
INSERT INTO ITEMS VALUES(101, 'N');
--INSERT INTO ITEMS VALUES(102, 'F');

-- 2.4 �����͸� ��ȸ�ϱ� ���� SELECT��
-- ���� : SELECT * (CLOUMN_NAME)FROM TABLE_NAME;
SELECT * FROM DEPT; --DEPT�� ��� Į��
SELECT * FROM EMP;  --EMP�� ��� Į��
DESC EMP; --EMP�� ���� Ȯ��
DESCRIBE EMP;
SELECT EMPNO, ENAME FROM EMP; --EMP�� EMPNO�� ENAME�� ��ȸ

-- 2.5 ��� ������
SELECT ENAME, SAL, SAL*12, COMM, SAL*12+COMM FROM EMP; --��������ڸ� Ȱ���Ͽ� ��ȸ, NULL���� ��������ڿ� ���ϸ� NULL���� ���´�.

-- 2.6 NULL�� ��Ȯ��, �� �� ���� ���� �ǹ��Ѵ�.
-- NVL(Null VaLue)�Լ��� NULL�� 0 �Ǵ� �ٸ� ������ ��ȯ �� �� �ִ�.
-- NVL(COMM,0): COMM�� NULL�̶�� 0���� ó
SELECT ENAME, SAL, SAL*12, COMM, SAL*12+NVL(COMM,0) FROM EMP;

-- 2.7 �÷� �̸��� ��Ī �����ϱ�
SELECT ENAME, SAL, SAL*12, COMM, SAL*12+NVL(COMM,0) AS ANNSAL FROM EMP; --AL*12+NVL(COMM,0)�̸��� ANNSAL�� ����
SELECT ENAME, SAL, SAL*12, COMM, SAL*12+NVL(COMM,0) AS "A N N S A L" FROM EMP; --AL*12+NVL(COMM,0)�̸��� A N N S A L�� ����
SELECT ENAME, SAL, SAL*12, COMM, SAL*12+NVL(COMM,0) AS ���� FROM EMP; --AL*12+NVL(COMM,0)�̸��� �������� ����

-- 2.8 Concatenation ������ : ����
-- ���� ���� �÷��� ������ �� ����ϴµ� Concatenation �����ڷ� "||" �����ٸ� ����Ѵ�.
SELECT ENAME, JOB FROM EMP;
SELECT ENAME || ' IS A ' || JOB FROM EMP;

-- 2.9 DISTINCT ������ :
-- ������ ������ ������ �ߺ����� �ʵ���, �� �� ������ ��µǵ��� �ϱ� ���ؼ� ����Ѵ�.
SELECT * FROM EMP; 
SELECT DEPTNO FROM EMP; --EMP���� DEPTNO�� ��ȸ
SELECT DISTINCT DEPTNO FROM EMP --EMP���� DEPTNO�� �ߺ��Ȱ�