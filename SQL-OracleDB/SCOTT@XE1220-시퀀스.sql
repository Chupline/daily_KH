SELECT * FROM EMP;
-- <SEQUENCE>
-- SEQUENCE(순서) : 오직 PK값으로 이용하기 위해 사용한다.
-- 1 2 3 4 5 6 7 8 ...
-- 가 나 다 라 마 바 ...
-- PK  = NOT + UNIQUE
-- 시퀀스는 테이블 내의 유일한 숫자를 자동으로 생성하는 자동 번호 발생기

-- SEQUENCE 생성
CREATE SEQUENCE DEPT_DEPTNO_SQ
INCREMENT BY 10
START WITH 10;

-- SEQUENCE 조회
DESC USER_SEQUENCES;
SELECT SEQUENCE_NAME, MIN_VALUE, MAX_VALUE, INCREMENT_BY, CYCLE_FLAG
FROM USER_SEQUENCES;

-- SEQUENCE 값 확인 : CURRVAL, NEXTVAL
SELECT DEPT_DEPTNO_SQ.NEXTVAL FROM DUAL;
SELECT DEPT_DEPTNO_SQ.CURRVAL FROM DUAL;

-- SEQUENCE 실무
CREATE SEQUENCE EMP_SEQ
START WITH 1
INCREMENT BY 1
MAXVALUE 100000;

DROP TABLE EMP01;
CREATE TABLE EMP01(
    EMPNO NUMBER(4) PRIMARY KEY,
    ENAME VARCHAR2(10), --ORACLE 문자열 자료형
--  ENAME VARCHAR(10),  --ANSI 문자열 자료형 VARCHAR = VARCHAR2 동일
    HIREDATE DATE
);

INSERT INTO EMP01 VALUES (EMP_SEQ.NEXTVAL, 'JULIA', SYSDATE);
SELECT * FROM EMP01;

-- SEQUENCE 삭제
SELECT SEQUENCE_NAME, MAX_VALUE, INCREMENT_BY, CYCLE_FLAG
FROM USER_SEQUENCES; --시퀀스 조회

DROP SEQUENCE DEPT_DEPTNO_SQ; --시퀀스 삭제

-- SEQUENCE의 수정
ALTER SEQUENCE EMP_SEQ
MAXVALUE 100;

-- 과제-15-01
--1. 최소값 1, 최대값 99999999, 1000부터 시작해서 1씩 증가하는 ORDERS_SEQ 라는 시퀀스를 만들어보자.
CREATE SEQUENCE ORDERS_SEQ 
MINVALUE 1
MAXVALUE 99999999
INCREMENT BY 1
START WITH 1000;

SELECT ORDERS_SEQ.NEXTVAL FROM DUAL;
SELECT ORDERS_SEQ.CURRVAL FROM DUAL;