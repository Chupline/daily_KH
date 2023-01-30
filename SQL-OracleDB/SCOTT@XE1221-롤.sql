-- <<ROLE>>
-- < 권한(Privilages) : DB에 저장된 정보를 '공유'하면서 정보 '보안'이 이루어지도록 하기 위함 >
-- 시스템 권한 : CREATE USER, CREATE TABLE, CREATE VIEW, ... 80개
-- 객체 권한 : 스키마의 객체(TABLE, VIEW, SEQUENCE)에 접근(DML)을 제어하기 위함
-- < 역할(Role): 권한의 집합체 >
--사용자 생성하기
--CREATE USER USER_NAME IDENTIFIED BY PASSWORD;
--권한부여 
--GRANT CREATE SESSION, CREATE TABLE TO USER_NAME;
--REVOKE CREATE TABLE FROM USER_NAME;
--객체권한
--스키마(SCHEMA) : 객체를 소유한 사용자명을 의미
--객체권한 부여
--GRANT SELECT ON SCOTT.EMP TO USER_NAME
-------------------------------------------------------

-- <ORACLE / SYSTEM@XE>
--사용자(USER04/PWD)생성
CREATE USER USER04 IDENTIFIED BY PWD;
-- ROLE부여
GRANT CONNECT, RESOURCE TO USER04;
-------------------------------------------------------
-- <CMD>
SQLPLUS USER04/PWD
CREATE TABLE EMP01(
EMPNO NUMBER(4)
);

--롤 관련 데이터 딕셔너리
--데이터 딕셔너리를 통해서 부여된 권한에 대한 정보를 확인할 수 있다.
SELECT * FROM USER_ROLE_PRIVS;
-------------------------------------------------------
-- <ORACLE / SYSTEM@XE>
-- 사용자 롤 정의
CREATE ROLE MROLE;
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW TO MROLE;

CREATE USER USER05 IDENTIFIED BY PWD; --USER05/PWD생성
GRANT MROLE TO USER05;
-------------------------------------------------------
-- <CMD>
QUIT
SQLPLUS USER05/PWD --접속가능
-------------------------------------------------------
--<ORACLE / SYSTEM@XE>
REVOKE MROLE FROM USER05; --권한 뺏어옴
-------------------------------------------------------
--<CMD>
QUIT
SQLPLUS USER05/PWD --접속 불가능






