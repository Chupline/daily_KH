-- <트리거>

-- 단순 메세지를 출력하는 트리거(TRIGGER)
SET SERVEROUTPUT ON;
-- 1. 사원테이블 생성
DROP TABLE EMP01;
CREATE TABLE EMP01 (
    EMPNO NUMBER(4) PRIMARY KEY,
    ENAME VARCHAR2(20),
    JOB VARCHAR2(20)
);

-- 2. 트리서 작성
CREATE OR REPLACE TRIGGER TRG_01
    AFTER INSERT 
    ON EMP01    --EMP01에 행이 추가되면 실행문을 실행
BEGIN
    DBMS_OUTPUT.PUT_LINE('신입사원이 입사했습니다.');
END;
/

-- 3. 사원테이블 데이터 추가
INSERT INTO EMP01
VALUES(1, '전원지', '화가');

SELECT * FROM EMP01;


--급여정보를 자동으로 추가하는 트리거
--1. 급여를 저장할 테이블을 생성한다.
DROP TABLE SAL01;
CREATE TABLE SAL01(
    SALNO NUMBER(4) PRIMARY KEY,
    SAL NUMBER(7,2),
    EMPNO NUMBER(4) REFERENCES EMP01(EMPNO)
);

--2. 급여번호를 자동 생성하는 시퀀스를 정의하고 이 시퀀스로부터 일련번호를 얻어 급여번호에 부여한다.
CREATE SEQUENCE SAL01_SALNO_SEQ;

--3. 트리거 생성한다.
CREATE OR REPLACE TRIGGER TRG_02
    AFTER INSERT 
    ON EMP01
    FOR EACH ROW
BEGIN
    INSERT INTO SAL01 --INSERT가 발생 -> SAL테이블에 데이터를 새로 저장
    VALUES(SAL01_SALNO_SEQ.NEXTVAL, 100, :NEW.EMPNO);
    --:NEW는 새로 입력 ROW(데이터)
    --:OLD는 이전 ROW(데이터)
END;
/

--4. 사원 테이블에 로우를 추가합니다
INSERT INTO EMP01 VALUES(2, '전수빈', '프로그래머');
SELECT * FROM EMP01;
SELECT * FROM SAL01;
INSERT INTO EMP01 VALUES(3, '김종현', '교수');
SELECT * FROM EMP01;
SELECT * FROM SAL01;


-- 급여 정보를 자동으로 삭제하는 트리거
-- 1. 사원 테이블의 로우를 삭제한다.
DELETE FROM EMP01 WHERE EMPNO=2; -- SQL Error 발생한다. 자식테이블이 참조하고 있기 때문에 
                                 -- 자식테이블을 먼저 삭제하고 부모테이블을 삭제한다.
-- 2. 트리거를 작성한다.
CREATE OR REPLACE TRIGGER TRG_03
    AFTER DELETE ON EMP01 
    FOR EACH ROW
BEGIN
    DELETE FROM SAL01 WHERE EMPNO=:OLD.EMPNO;
END;
/

-- 3. 사원 테이블의 로우를 삭제한다.
DELETE FROM EMP01 WHERE EMPNO=2;
SELECT * FROM EMP01;
SELECT * FROM SAL01;

