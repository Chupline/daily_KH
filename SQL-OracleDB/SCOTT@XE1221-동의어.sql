--<SYSTEM@XE>
--동의어 생성 및 제거
DROP TABLE SYSTBL;
CREATE TABLE SYSTBL(
    ENAME VARCHAR2(20)
);

INSERT INTO SYSTBL VALUES('전수빈');
SELECT * FROM SYSTBL;
-------------------------------------------------------
--<SCOTT@XE>
SELECT * FROM SYSTBL; --생성확인 불가
SELECT * FROM SYSTEM.SYSTBL; --생성확인 불가
-------------------------------------------------------
--<SYSTEM@XE>
GRANT SELECT ON SYSTBL TO SCOTT;
-------------------------------------------------------
--<SCOTT@XE>
SELECT * FROM SYSTBL; --생성확인 불가
SELECT * FROM SYSTEM.SYSTBL; --생성확인 가능
-------------------------------------------------------
--<SYSTEM@XE>
-- 객체 권한 부여
GRANT SELECT ON SYSTBL TO SCOTT;
GRANT  CREATE SYNONYM TO SCOTT; --동의어 권한부여
-------------------------------------------------------
--<SCOTT@XE>
-- 동의어 생성하기(권한필요)
CREATE SYNONYM SYSTBL FOR SYSTEM.SYSTBL;
SELECT * FROM SYSTBL; --생성확인 가능
SELECT * FROM SYSTEM.SYSTBL; --생성확인 가능