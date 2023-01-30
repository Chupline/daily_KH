-- PL/SQL(Procedural Language extension to SQL) : 오라클 자체에 내장되어 있는 절차적 언어
--  변수 선언을 할 수 있다.
--  비교 처리를 할 수 있다.
--  반복 처리를 할 수 있다.

SET SERVEROUTPUT ON --출력해주는 내용을 화면에 보여주도록 설정한다.
BEGIN -- BEGIN ~ 실행문 ~ END;
    DBMS_OUTPUT.PUT_LINE('HELLO_WORLD');
END; -- (;) :한 문장이 종료할 때마다 세미콜론 작성
/    -- (/) : 종결선언


-- 변수 사용하기
DECLARE 
    --변수 선언부
    VEMPNO NUMBER(4);
    VENAME VARCHAR2(20);
BEGIN 
    --실행부
    VEMPNO := 7788;
    VENAME := 'SCOTT';
    DBMS_OUTPUT.PUT_LINE('사번 / 이름');
    DBMS_OUTPUT.PUT_LINE('----------');
    DBMS_OUTPUT.PUT_LINE(VEMPNO || '/' || VENAME);
END;
/
--사번과 이름 검색하기
DECLARE
    -- %TYPE 속성으로 컬럼 단위 레퍼런스 변수 선언
    VEMPNO EMP.EMPNO%TYPE;
    VENAME EMP.ENAME%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('사번 / 이름');
    DBMS_OUTPUT.PUT_LINE('-------------');
    SELECT EMPNO, ENAME INTO VEMPNO, VENAME
    FROM EMP
    WHERE ENAME='SCOTT';
    
    -- 레퍼런스 변수에 저장된 값을 출력한다.
    DBMS_OUTPUT.PUT_LINE(VEMPNO || ' / ' || VENAME);
END;
/

-- 테이블 타입 사용하기
DECLARE
    --테이블 타입을 정의. EX) JAVA인경우 STRING[] ENAME 과 같은 배열 타입
    TYPE ENAME_TABLE_TYPE IS TABLE OF EMP.ENAME%TYPE
        INDEX BY BINARY_INTEGER;
    TYPE  JOB_TABLE_TYPE IS TABLE OF EMP.JOB%TYPE
        INDEX BY BINARY_INTEGER;
    --테이블 타입으로 변수 선언
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

-- 레코드 타입 사용하기
DECLARE
    -- 레코드 타입을 정의 : 자바의 클래스타입(다른타입의 필드를 정의)과 같은 개념
    TYPE EMP_RECORD_TYPE IS RECORD(
        V_EMPNO EMP.EMPNO%TYPE,
        V_ENAME EMP.ENAME%TYPE,
        V_JOB   EMP.JOB%TYPE,
        V_DEPTNO EMP.DEPTNO%TYPE);
    -- 레코드로 변수 선언
    EMP_RECORD EMP_RECORD_TYPE;
BEGIN
    SELECT EMPNO, ENAME, JOB, DEPTNO INTO EMP_RECORD
    FROM EMP
    WHERE ENAME=UPPER('SCOTT');
    
    DBMS_OUTPUT.PUT_LINE('사원번호 : ' || TO_CHAR(EMP_RECORD.V_EMPNO));
    DBMS_OUTPUT.PUT_LINE('이   름 : ' || EMP_RECORD.V_ENAME);
    DBMS_OUTPUT.PUT_LINE('담당업무 : ' || EMP_RECORD.V_JOB);
    DBMS_OUTPUT.PUT_LINE('부서번호 : ' || TO_CHAR(EMP_RECORD.V_DEPTNO));
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
    
    DBMS_OUTPUT.PUT_LINE('사번    이름      부서명');
    DBMS_OUTPUT.PUT_LINE(VEMPNO || '    ' || VENAME || '    ' || VDNAME);
END;
/

-- IF ~ THEN ~ELSIF ~ ELSE ~ END IF
DECLARE
    VEMP EMP%ROWTYPE; -- 참조형 레코드 타입
    VDNAME VARCHAR2(14);
BEGIN
    DBMS_OUTPUT.PUT_LINE('사번    이름      부서명');
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