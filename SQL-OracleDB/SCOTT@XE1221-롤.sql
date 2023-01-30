-- <<ROLE>>
-- < ����(Privilages) : DB�� ����� ������ '����'�ϸ鼭 ���� '����'�� �̷�������� �ϱ� ���� >
-- �ý��� ���� : CREATE USER, CREATE TABLE, CREATE VIEW, ... 80��
-- ��ü ���� : ��Ű���� ��ü(TABLE, VIEW, SEQUENCE)�� ����(DML)�� �����ϱ� ����
-- < ����(Role): ������ ����ü >
--����� �����ϱ�
--CREATE USER USER_NAME IDENTIFIED BY PASSWORD;
--���Ѻο� 
--GRANT CREATE SESSION, CREATE TABLE TO USER_NAME;
--REVOKE CREATE TABLE FROM USER_NAME;
--��ü����
--��Ű��(SCHEMA) : ��ü�� ������ ����ڸ��� �ǹ�
--��ü���� �ο�
--GRANT SELECT ON SCOTT.EMP TO USER_NAME
-------------------------------------------------------

-- <ORACLE / SYSTEM@XE>
--�����(USER04/PWD)����
CREATE USER USER04 IDENTIFIED BY PWD;
-- ROLE�ο�
GRANT CONNECT, RESOURCE TO USER04;
-------------------------------------------------------
-- <CMD>
SQLPLUS USER04/PWD
CREATE TABLE EMP01(
EMPNO NUMBER(4)
);

--�� ���� ������ ��ųʸ�
--������ ��ųʸ��� ���ؼ� �ο��� ���ѿ� ���� ������ Ȯ���� �� �ִ�.
SELECT * FROM USER_ROLE_PRIVS;
-------------------------------------------------------
-- <ORACLE / SYSTEM@XE>
-- ����� �� ����
CREATE ROLE MROLE;
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW TO MROLE;

CREATE USER USER05 IDENTIFIED BY PWD; --USER05/PWD����
GRANT MROLE TO USER05;
-------------------------------------------------------
-- <CMD>
QUIT
SQLPLUS USER05/PWD --���Ӱ���
-------------------------------------------------------
--<ORACLE / SYSTEM@XE>
REVOKE MROLE FROM USER05; --���� �����
-------------------------------------------------------
--<CMD>
QUIT
SQLPLUS USER05/PWD --���� �Ұ���






