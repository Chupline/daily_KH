-- 시스템 권한(System Privileges)
-- 사용자 생성 : CREATE USER
CREATE USER USER10 IDENTIFIED BY USER10;

-- 사용자 비밀번호 변경
ALTER USER USER10 IDENTIFIED BY PWD;

-- 권한부여 : GRANT
GRANT CREATE SESSION TO USER10;
GRANT CREATE TABLE TO USER10;
GRANT UNLIMITED TABLESPACE TO USER10; --모든 테이블 스페이스에 할당량을 줄 수 있는 권한

-- 테이블 스페이스 확인하기
SELECT USERNAME, DEFAULT_TABLESPACE
FROM DBA_USERS
WHERE USERNAME IN('USER01','SCOTT');

-- 테이블 스페이스 변경하기
ALTER USER USER10 DEFAULT TABLESPACE USERS;
ALTER USER USER10 TEMPORARY TABLESPACE TEMP;

-- 테이블 스페이스 쿼터 할당하기
ALTER USER USER10
QUOTA 1000M ON USERS; --1GB 쿼터 할당

--WITH ADMIN OPTION
CREATE USER USER02 IDENTIFIED BY TIGER;
GRANT CREATE SESSION TO USER02 WITH ADMIN OPTION; --CREATE SESSION 권한의 DBA 관리자 권한부여

CREATE USER USER03 IDENTIFIED BY TIGER;
GRANT CREATE SESSION TO USER03;

-- 객체권한 부여
GRANT SELECT ON EMP TO USER01;
SELECT * FROM SCOTT.EMP;

SELECT * FROM USER_TAB_PRIVS_MADE; --자신이 부여한 객체권한
SELECT * FROM USER_TAB_PRIVS_RECD; --자신이 받은 객체권한

--객체 권한 제거
REVOKE SELECT ON EMP FROM SUER01;

--WITH GRANT OPTION
GRANT SELECT ON SCOTT.EMP TO USER02
WITH GRANT OPTION;