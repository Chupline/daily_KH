-- <Ʈ����>

-- �ܼ� �޼����� ����ϴ� Ʈ����(TRIGGER)
SET SERVEROUTPUT ON;
-- 1. ������̺� ����
DROP TABLE EMP01;
CREATE TABLE EMP01 (
    EMPNO NUMBER(4) PRIMARY KEY,
    ENAME VARCHAR2(20),
    JOB VARCHAR2(20)
);

-- 2. Ʈ���� �ۼ�
CREATE OR REPLACE TRIGGER TRG_01
    AFTER INSERT 
    ON EMP01    --EMP01�� ���� �߰��Ǹ� ���๮�� ����
BEGIN
    DBMS_OUTPUT.PUT_LINE('���Ի���� �Ի��߽��ϴ�.');
END;
/

-- 3. ������̺� ������ �߰�
INSERT INTO EMP01
VALUES(1, '������', 'ȭ��');

SELECT * FROM EMP01;


--�޿������� �ڵ����� �߰��ϴ� Ʈ����
--1. �޿��� ������ ���̺��� �����Ѵ�.
DROP TABLE SAL01;
CREATE TABLE SAL01(
    SALNO NUMBER(4) PRIMARY KEY,
    SAL NUMBER(7,2),
    EMPNO NUMBER(4) REFERENCES EMP01(EMPNO)
);

--2. �޿���ȣ�� �ڵ� �����ϴ� �������� �����ϰ� �� �������κ��� �Ϸù�ȣ�� ��� �޿���ȣ�� �ο��Ѵ�.
CREATE SEQUENCE SAL01_SALNO_SEQ;

--3. Ʈ���� �����Ѵ�.
CREATE OR REPLACE TRIGGER TRG_02
    AFTER INSERT 
    ON EMP01
    FOR EACH ROW
BEGIN
    INSERT INTO SAL01 --INSERT�� �߻� -> SAL���̺� �����͸� ���� ����
    VALUES(SAL01_SALNO_SEQ.NEXTVAL, 100, :NEW.EMPNO);
    --:NEW�� ���� �Է� ROW(������)
    --:OLD�� ���� ROW(������)
END;
/

--4. ��� ���̺� �ο츦 �߰��մϴ�
INSERT INTO EMP01 VALUES(2, '������', '���α׷���');
SELECT * FROM EMP01;
SELECT * FROM SAL01;
INSERT INTO EMP01 VALUES(3, '������', '����');
SELECT * FROM EMP01;
SELECT * FROM SAL01;


-- �޿� ������ �ڵ����� �����ϴ� Ʈ����
-- 1. ��� ���̺��� �ο츦 �����Ѵ�.
DELETE FROM EMP01 WHERE EMPNO=2; -- SQL Error �߻��Ѵ�. �ڽ����̺��� �����ϰ� �ֱ� ������ 
                                 -- �ڽ����̺��� ���� �����ϰ� �θ����̺��� �����Ѵ�.
-- 2. Ʈ���Ÿ� �ۼ��Ѵ�.
CREATE OR REPLACE TRIGGER TRG_03
    AFTER DELETE ON EMP01 
    FOR EACH ROW
BEGIN
    DELETE FROM SAL01 WHERE EMPNO=:OLD.EMPNO;
END;
/

-- 3. ��� ���̺��� �ο츦 �����Ѵ�.
DELETE FROM EMP01 WHERE EMPNO=2;
SELECT * FROM EMP01;
SELECT * FROM SAL01;

