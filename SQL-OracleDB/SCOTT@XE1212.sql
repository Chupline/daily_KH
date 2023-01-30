-- SELECT : 데이터 검색
SELECT * FROM DEPT; -- 데이터 조회
SELECT DNAME FROM DEPT; -- 특정 칼럼 데이터 조회
SELECT DEPTNO,LOC FROM DEPT;

-- DML(Data Manipulation Language) : 데이터를 조작하는 역할
-- INSERT : 데이터 입력 / UPDATE : 데이터 수정 / DELETE : 데이터 삭제
INSERT INTO DEPT VALUES(50, '총무부', '서울');  -- NEW 데이터 입력
UPDATE DEPT SET LOC='부산' WHERE DNAME='총무부'; -- 데이터 수정
DELETE FROM DEPT WHERE DEPTNO=50; -- 데이터 삭제 (DEPT에서 DEPTNO=50삭제)
SELECT * FROM DEPT;

-- TCL(Transaction Control Language)
-- TCL은 데이터의 일관성을 유지하면서 안정적으로 데이터를 복구시키기 위해서 사용한다.
-- COMMIT : 변경된 내용을 영구 저장 
-- ROLLBACK : 변경되기 이전 상태로 되돌린다. 
-- SAVEPOINT : 특정 위치까지를 저장 혹은 이전 상태로 되돌리 수 있도록 트랜잭션 중에 저장점을 만든다.

-- DDL(Data Definition Language)
-- DDL은 데이터베이스 객체들을 생성 또는 변경, 제거할 때 사용한다.
-- 객체란 테이블, 인덱스, 뷰, 트리거 등 SQL문을 수행하는 대상이 된다.
-- CREATE (테이블 생성)
CREATE TABLE DEPT01 ( 
DEPTNO NUMBER(4),
DNAME VARCHAR2(10),
LOC VARCHAR2(9)
);
-- ALTER (테이블 변경)
ALTER TABLE DEPT01 MODIFY(DNAME VARCHAR2(30));
-- RENAME (테이블 이름 변경)
RENAME DEPT01 TO DEPT02;
-- DELETE (테이블 데이터 내용 삭제, 데이터만 삭제하여 저장공간등 유지)
DELETE TALBE DEPT02;
-- TRUNCATE (테이블 데이터 내용 삭제, 테이블 초기화)
TRUNCATE TABLE DEPT02;

DESC DEPT02; --테이블 구조 확인
DESCRIBE DEPT02;

-- DCL(Data Control Language): DCL은 특정 사용자에게 권한을 부여하거나 제거하기 위해서 사용하는 명령어
-- GRANT : 데이터베이스에 대한 일련의 권한 부여
-- REVOKE : 데이터베이스에 대한 일련의 권한 취소
--GRANT CREATE SESSION TO ORAUSER01;
--REVOKE CREATE SESSION FROM ORAUSER01;
------------------------------------------------------------------------------------------------
SHOW USER;
-- 데이터 딕셔너리 TAB
-- TAB은 TABLE의 약자로서 SCOTT 사용자가 소유하고 있는 테이블의 정보를 알려주는 데이터 딕셔너리이다.
SELECT * FROM TAB; 

-- DESC(DESCRIBE) : 데이터를 조회하기 위한 테이블 구조를 확인하는 명령어
SELECT * FROM DEPT01;
DESC DEPT01;
DESC EMP;
INSERT INTO DEPT01 VALUES(NULL, '개발부', '서울');
INSERT INTO DEPT01 VALUES(50, '개발부', '서울');
SELECT * FROM DEPT01;
TRUNCATE TABLE DEPT01;

-- 데이터타입 : NUMBER, DATE, VARCHAR2, CHAR
-- BOOLEAN 타입은 없으나 비슷하게 CHAR타입으로 만들수 있다.
CREATE TABLE ITEMS(
    ITEM_NO NUMBER(3), --숫자 3자리
    ISACTIVE CHAR(1) CHECK(ISACTIVE IN('T','F')) --제약조건 :  NOT BULL, PRIMARY KET, FOREIGN KEY, UNIQUE KEY
);

SELECT * FROM ITEMS;
INSERT INTO ITEMS VALUES(101, 'Y');
INSERT INTO ITEMS VALUES(101, 'N');
--INSERT INTO ITEMS VALUES(102, 'F');

-- 2.4 데이터를 조회하기 위한 SELECT문
-- 형식 : SELECT * (CLOUMN_NAME)FROM TABLE_NAME;
SELECT * FROM DEPT; --DEPT의 모든 칼럼
SELECT * FROM EMP;  --EMP의 모든 칼럼
DESC EMP; --EMP의 구조 확인
DESCRIBE EMP;
SELECT EMPNO, ENAME FROM EMP; --EMP의 EMPNO과 ENAME만 조회

-- 2.5 산술 연산자
SELECT ENAME, SAL, SAL*12, COMM, SAL*12+COMM FROM EMP; --산술연산자를 활용하여 조회, NULL값을 산술연산자와 더하면 NULL값이 나온다.

-- 2.6 NULL은 미확정, 알 수 없는 값을 의미한다.
-- NVL(Null VaLue)함수는 NULL을 0 또는 다른 값으로 변환 할 수 있다.
-- NVL(COMM,0): COMM이 NULL이라면 0으로 처
SELECT ENAME, SAL, SAL*12, COMM, SAL*12+NVL(COMM,0) FROM EMP;

-- 2.7 컬럼 이름에 별칭 지정하기
SELECT ENAME, SAL, SAL*12, COMM, SAL*12+NVL(COMM,0) AS ANNSAL FROM EMP; --AL*12+NVL(COMM,0)이름을 ANNSAL로 변경
SELECT ENAME, SAL, SAL*12, COMM, SAL*12+NVL(COMM,0) AS "A N N S A L" FROM EMP; --AL*12+NVL(COMM,0)이름을 A N N S A L로 변경
SELECT ENAME, SAL, SAL*12, COMM, SAL*12+NVL(COMM,0) AS 연봉 FROM EMP; --AL*12+NVL(COMM,0)이름을 연봉으로 변경

-- 2.8 Concatenation 연산자 : 연결
-- 여러 개의 컬럼을 연결할 때 사용하는데 Concatenation 연산자로 "||" 수직바를 사용한다.
SELECT ENAME, JOB FROM EMP;
SELECT ENAME || ' IS A ' || JOB FROM EMP;

-- 2.9 DISTINCT 연산자 :
-- 동일한 데이터 값들이 중복되지 않도록, 즉 한 번씩만 출력되도록 하기 위해서 사용한다.
SELECT * FROM EMP; 
SELECT DEPTNO FROM EMP; --EMP에서 DEPTNO만 조회
SELECT DISTINCT DEPTNO FROM EMP --EMP에서 DEPTNO를 중복된것