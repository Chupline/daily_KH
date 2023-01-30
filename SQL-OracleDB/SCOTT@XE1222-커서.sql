-- <Ŀ��>
-- Ŀ���� �̿��ؼ� �μ� ���̺��� ��� ������ ��ȸ�ϱ�

SET SERVEROUTPUT ON --ȭ�� ���
--LOOP
CREATE OR REPLACE PROCEDURE CURSOR_SAMPLE01
IS
    VDEPT DEPT%ROWTYPE;
    CURSOR C1 IS --Ŀ�� ����, ����
        SELECT * FROM DEPT;
BEGIN
    DBMS_OUTPUT.PUT_LINE('�μ���ȣ / �μ��� / ������');
    DBMS_OUTPUT.PUT_LINE('-------------------------');
    OPEN C1; --Ŀ�� ����

    LOOP --FETCH : ��� �¿��� �ο� ������ �����͸� �о� ���δ�.
        FETCH C1 INTO VDEPT.DEPTNO, VDEPT.DNAME, VDEPT.LOC; --Ŀ���κ��� �����͸� �о�ͼ� ���ú����� ����
        EXIT WHEN C1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(VDEPT.DEPTNO || ' / ' || VDEPT.DNAME || ' / ' ||VDEPT.LOC); --���
    END LOOP;
    CLOSE C1; --Ŀ�� �ݱ�
END;
/
EXECUTE CURSOR_SAMPLE01; 

--CURSOR FOR LOOP : CURSOR �ڵ� OPEN, CLOSE
CREATE OR REPLACE PROCEDURE CURSOR_SAMPLE02
IS
    VDEPT DEPT%ROWTYPE;
    CURSOR C1 IS --Ŀ�� ����, ����
        SELECT * FROM DEPT;
BEGIN
    DBMS_OUTPUT.PUT_LINE('�μ���ȣ / �μ��� / ������');
    DBMS_OUTPUT.PUT_LINE('-------------------------');
    
    FOR VDEPT IN C1 LOOP
        EXIT WHEN C1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(VDEPT.DEPTNO || ' / ' || VDEPT.DNAME || ' / ' ||VDEPT.LOC);
    END LOOP;
END;
/
EXECUTE CURSOR_SAMPLE02;


--���� 21-2 : �μ� ��ȣ�� �����Ͽ� �ش� �μ� �Ҽ� ����� ������ ����ϴ� SEL_EMP ���ν����� Ŀ���� ����Ͽ� �ۼ��϶�.
CREATE OR REPLACE PROCEDURE SEL_EMP(VDEPTNO EMP.DEPTNO%TYPE)
IS
    VEMP EMP%ROWTYPE;
    CURSOR C1 IS
        SELECT * FROM EMP
        WHERE DEPTNO=VDEPTNO;
BEGIN
    DBMS_OUTPUT.PUT_LINE('�����ȣ / ����� / ���� / �޿�');
    DBMS_OUTPUT.PUT_LINE('-----------------------------');
    
    FOR VEMP IN C1 LOOP
        EXIT WHEN C1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(VEMP.EMPNO || ' ' || VEMP.ENAME 
                             || ' ' ||VEMP.JOB || ' ' ||VEMP.SAL);
    END LOOP;
END;
/

EXECUTE SEL_EMP(20);
