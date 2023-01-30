-- <INDEX : ����>
-- EMP.ENAME -> INDEXING -> ���� �˻��� ���� �ڷᱸ���� ����� ��.

-- �ε����� ���� - �˻� �ӵ��� ��������.
--             - �ý��ۿ� ���ϸ� �ٿ��� �ý����� ��ü ������ ����Ų��.
-- �ε����� ���� - �ε����� ���� �߰� ������ �ʿ��ϴ�.
--             - �ε����� �����ϴ� �� �ð��� �ɸ���.
--             - �������� ���� �۾�(INSERT/UPDATE/DELETE)�� ���� �Ͼ ���� ������ ������ ���ϵȴ�.

-- �ε��� ���� ��ȸ�ϱ�
SELECT INDEX_NAME, TABLE_NAME, COLUMN_NAME
FROM USER_IND_COLUMNS
WHERE TABLE_NAME IN('EMP','DEPT');

-- //��ȸ �ӵ� ��
--������̺� ����
DROP TABLE EMP01;
CREATE TABLE EMP01 
AS 
SELECT * FROM EMP;

SELECT TABLE_NAME, INDEX_NAME, COLUMN_NAME
FROM USER_IND_COLUMNS
WHERE TABLE_NAME IN ('EMP', 'EMP01');
--���̺� ��ü ������ ����
INSERT INTO EMP01 
SELECT * FROM EMP01;
-- �ε����� �ƴ� �÷����� �˻��ϱ�
SELECT COUNT(*) FROM EMP01; --19��
INSERT INTO EMP01(EMPNO, ENAME) VALUES (1111, 'SYJ');

SET TIMING ON
SELECT DISTINCT EMPNO, ENAME
FROM EMP01
WHERE ENAME='SYJ'; --19��, �ε����� ���ٸ� �����ɸ�

-- �ε��� �����ϱ�
-- �ε��� ����
CREATE INDEX IDX_EMP01_ENAME
ON EMP01(ENAME); 
-- �ε����� �˻�
SELECT DISTINCT EMPNO, ENAME
FROM EMP01
WHERE ENAME='SYJ'; --0.002��

-- �ε��� �����ϱ�
SELECT INDEX_NAME, TABLE_NAME, COLUMN_NAME
FROM USER_IND_COLUMNS
WHERE TABLE_NAME IN ('EMP01'); --�ε��� ��ȸ

DROP INDEX IDX_EMP01_ENAME; --�ε��� ����
