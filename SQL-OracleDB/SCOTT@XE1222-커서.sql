-- <커서>
-- 커서를 이용해서 부서 테이블의 모든 내용을 조회하기

SET SERVEROUTPUT ON --화면 출력
--LOOP
CREATE OR REPLACE PROCEDURE CURSOR_SAMPLE01
IS
    VDEPT DEPT%ROWTYPE;
    CURSOR C1 IS --커서 선언, 정의
        SELECT * FROM DEPT;
BEGIN
    DBMS_OUTPUT.PUT_LINE('부서번호 / 부서명 / 지역명');
    DBMS_OUTPUT.PUT_LINE('-------------------------');
    OPEN C1; --커서 열기

    LOOP --FETCH : 결과 셋에서 로우 단위로 데이터를 읽어 들인다.
        FETCH C1 INTO VDEPT.DEPTNO, VDEPT.DNAME, VDEPT.LOC; --커서로부터 데이터를 읽어와서 로컬변수에 저장
        EXIT WHEN C1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(VDEPT.DEPTNO || ' / ' || VDEPT.DNAME || ' / ' ||VDEPT.LOC); --출력
    END LOOP;
    CLOSE C1; --커서 닫기
END;
/
EXECUTE CURSOR_SAMPLE01; 

--CURSOR FOR LOOP : CURSOR 자동 OPEN, CLOSE
CREATE OR REPLACE PROCEDURE CURSOR_SAMPLE02
IS
    VDEPT DEPT%ROWTYPE;
    CURSOR C1 IS --커서 선언, 정의
        SELECT * FROM DEPT;
BEGIN
    DBMS_OUTPUT.PUT_LINE('부서번호 / 부서명 / 지역명');
    DBMS_OUTPUT.PUT_LINE('-------------------------');
    
    FOR VDEPT IN C1 LOOP
        EXIT WHEN C1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(VDEPT.DEPTNO || ' / ' || VDEPT.DNAME || ' / ' ||VDEPT.LOC);
    END LOOP;
END;
/
EXECUTE CURSOR_SAMPLE02;


--과제 21-2 : 부서 번호를 전달하여 해당 부서 소속 사원의 정보를 출력하는 SEL_EMP 프로시저를 커서를 사용하여 작성하라.
CREATE OR REPLACE PROCEDURE SEL_EMP(VDEPTNO EMP.DEPTNO%TYPE)
IS
    VEMP EMP%ROWTYPE;
    CURSOR C1 IS
        SELECT * FROM EMP
        WHERE DEPTNO=VDEPTNO;
BEGIN
    DBMS_OUTPUT.PUT_LINE('사원번호 / 사원명 / 직급 / 급여');
    DBMS_OUTPUT.PUT_LINE('-----------------------------');
    
    FOR VEMP IN C1 LOOP
        EXIT WHEN C1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(VEMP.EMPNO || ' ' || VEMP.ENAME 
                             || ' ' ||VEMP.JOB || ' ' ||VEMP.SAL);
    END LOOP;
END;
/

EXECUTE SEL_EMP(20);
