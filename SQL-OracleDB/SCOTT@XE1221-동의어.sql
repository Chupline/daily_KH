--<SYSTEM@XE>
--���Ǿ� ���� �� ����
DROP TABLE SYSTBL;
CREATE TABLE SYSTBL(
    ENAME VARCHAR2(20)
);

INSERT INTO SYSTBL VALUES('������');
SELECT * FROM SYSTBL;
-------------------------------------------------------
--<SCOTT@XE>
SELECT * FROM SYSTBL; --����Ȯ�� �Ұ�
SELECT * FROM SYSTEM.SYSTBL; --����Ȯ�� �Ұ�
-------------------------------------------------------
--<SYSTEM@XE>
GRANT SELECT ON SYSTBL TO SCOTT;
-------------------------------------------------------
--<SCOTT@XE>
SELECT * FROM SYSTBL; --����Ȯ�� �Ұ�
SELECT * FROM SYSTEM.SYSTBL; --����Ȯ�� ����
-------------------------------------------------------
--<SYSTEM@XE>
-- ��ü ���� �ο�
GRANT SELECT ON SYSTBL TO SCOTT;
GRANT  CREATE SYNONYM TO SCOTT; --���Ǿ� ���Ѻο�
-------------------------------------------------------
--<SCOTT@XE>
-- ���Ǿ� �����ϱ�(�����ʿ�)
CREATE SYNONYM SYSTBL FOR SYSTEM.SYSTBL;
SELECT * FROM SYSTBL; --����Ȯ�� ����
SELECT * FROM SYSTEM.SYSTBL; --����Ȯ�� ����