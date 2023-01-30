-- PL/SQL(Procedural Language extension to SQL) : ����Ŭ ��ü�� ����Ǿ� �ִ� ������ ���
--  ���� ������ �� �� �ִ�.
--  �� ó���� �� �� �ִ�.
--  �ݺ� ó���� �� �� �ִ�.

SET SERVEROUTPUT ON --������ִ� ������ ȭ�鿡 �����ֵ��� �����Ѵ�.
BEGIN -- BEGIN ~ ���๮ ~ END;
    DBMS_OUTPUT.PUT_LINE('HELLO_WORLD');
END; -- (;) :�� ������ ������ ������ �����ݷ� �ۼ�
/    -- (/) : ���ἱ��


-- ���� ����ϱ�
DECLARE 
    --���� �����
    VEMPNO NUMBER(4);
    VENAME VARCHAR2(20);
BEGIN 
    --�����
    VEMPNO := 7788;
    VENAME := 'SCOTT';
    DBMS_OUTPUT.PUT_LINE('��� / �̸�');
    DBMS_OUTPUT.PUT_LINE('----------');
    DBMS_OUTPUT.PUT_LINE(VEMPNO || '/' || VENAME);
END;
/
--����� �̸� �˻��ϱ�
DECLARE
    -- %TYPE �Ӽ����� �÷� ���� ���۷��� ���� ����
    VEMPNO EMP.EMPNO%TYPE;
    VENAME EMP.ENAME%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('��� / �̸�');
    DBMS_OUTPUT.PUT_LINE('-------------');
    SELECT EMPNO, ENAME INTO VEMPNO, VENAME
    FROM EMP
    WHERE ENAME='SCOTT';
    
    -- ���۷��� ������ ����� ���� ����Ѵ�.
    DBMS_OUTPUT.PUT_LINE(VEMPNO || ' / ' || VENAME);
END;
/

-- ���̺� Ÿ�� ����ϱ�
DECLARE
    --���̺� Ÿ���� ����. EX) JAVA�ΰ�� STRING[] ENAME �� ���� �迭 Ÿ��
    TYPE ENAME_TABLE_TYPE IS TABLE OF EMP.ENAME%TYPE
        INDEX BY BINARY_INTEGER;
    TYPE  JOB_TABLE_TYPE IS TABLE OF EMP.JOB%TYPE
        INDEX BY BINARY_INTEGER;
    --���̺� Ÿ������ ���� ����
    ENAME_TABLE ENAME_TABLE_TYPE;
    JOB_TABLE JOB_TABLE_TYPE;
    I BINARY_INTEGER := 0;
BEGIN
    FOR K IN(SELECT ENAME, JOB FROM EMP) LOOP
        I := I + 1;
        ENAME_TABLE(I) := K.ENAME;
        JOB_TABLE(I) := K.JOB;
    END LOOP;
    
    FOR J IN 1..I LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(ENAME_TABLE(J),12) || ' / ' || RPAD(JOB_TABLE(J),9));
    END LOOP;
END;
/

-- ���ڵ� Ÿ�� ����ϱ�
DECLARE
    -- ���ڵ� Ÿ���� ���� : �ڹ��� Ŭ����Ÿ��(�ٸ�Ÿ���� �ʵ带 ����)�� ���� ����
    TYPE EMP_RECORD_TYPE IS RECORD(
        V_EMPNO EMP.EMPNO%TYPE,
        V_ENAME EMP.ENAME%TYPE,
        V_JOB   EMP.JOB%TYPE,
        V_DEPTNO EMP.DEPTNO%TYPE);
    -- ���ڵ�� ���� ����
    EMP_RECORD EMP_RECORD_TYPE;
BEGIN
    SELECT EMPNO, ENAME, JOB, DEPTNO INTO EMP_RECORD
    FROM EMP
    WHERE ENAME=UPPER('SCOTT');
    
    DBMS_OUTPUT.PUT_LINE('�����ȣ : ' || TO_CHAR(EMP_RECORD.V_EMPNO));
    DBMS_OUTPUT.PUT_LINE('��   �� : ' || EMP_RECORD.V_ENAME);
    DBMS_OUTPUT.PUT_LINE('������ : ' || EMP_RECORD.V_JOB);
    DBMS_OUTPUT.PUT_LINE('�μ���ȣ : ' || TO_CHAR(EMP_RECORD.V_DEPTNO));
END;
/

-- IF ~ THEN ~ END IF
DECLARE
    VEMPNO NUMBER(4);
    VENAME VARCHAR2(20);
    VDEPTNO EMP.DEPTNO%TYPE;
    VDNAME VARCHAR2(20) := NULL;
BEGIN
    SELECT EMPNO, ENAME, DEPTNO INTO VEMPNO, VENAME, VDEPTNO
    FROM EMP
    WHERE EMPNO=7788;
    
    IF(VDEPTNO=10) THEN
        VDNAME := 'ACCOUNTING';
    END IF;
    IF(VDEPTNO=20) THEN
        VDNAME := 'RESEARCH';
    END IF;
    IF(VDEPTNO=30) THEN
        VDNAME := 'SALES';
    END IF;
    IF(VDEPTNO=40) THEN
        VDNAME := 'OPERATIONS';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('���    �̸�      �μ���');
    DBMS_OUTPUT.PUT_LINE(VEMPNO || '    ' || VENAME || '    ' || VDNAME);
END;
/

-- IF ~ THEN ~ELSIF ~ ELSE ~ END IF
DECLARE
    VEMP EMP%ROWTYPE; -- ������ ���ڵ� Ÿ��
    VDNAME VARCHAR2(14);
BEGIN
    DBMS_OUTPUT.PUT_LINE('���    �̸�      �μ���');
    DBMS_OUTPUT.PUT_LINE('-----------------------');
    SELECT * INTO VEMP
    FROM EMP
    WHERE ENAME='SCOTT';
    
    IF(VEMP.DEPTNO=10) THEN
        VDNAME := 'ACCOUNTING';
    ELSIF(VEMP.DEPTNO=20) THEN
        VDNAME := 'RESEARCH';
    ELSIF(VEMP.DEPTNO=30) THEN
        VDNAME := 'SALES';
    ELSE
        VDNAME := 'OERATIONS';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(VEMP.EMPNO||'   '||VEMP.ENAME||'    '||VDNAME);
END;
/

-- LOOP ~ END LOOP
DECLARE
    N NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE( N );
        N := N+1;
        IF N > 5 THEN
            EXIT;
        END IF;
    END LOOP;
END;
/

-- FOR LOOP
DECLARE
BEGIN
    FOR N IN 1..6 LOOP
        DBMS_OUTPUT.PUT_LINE( N );
    END LOOP;
END;
/

-- WHILE LOOP
DECLARE
    N NUMBER := 1;
BEGIN
    WHILE N<=7 LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        N := N+1;
    END LOOP;
END;
/