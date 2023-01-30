-- <INDEX : 색인>
-- EMP.ENAME -> INDEXING -> 빠른 검색을 위한 자료구조로 만드는 것.

-- 인덱스의 장점 - 검색 속도가 빨라진다.
--             - 시스템에 부하를 줄여서 시스템의 전체 성능을 향상시킨다.
-- 인덱스의 단점 - 인덱스를 위한 추가 공간이 필요하다.
--             - 인덱스를 생성하는 데 시간이 걸린다.
--             - 데이터의 변경 작업(INSERT/UPDATE/DELETE)이 자주 일어날 때는 오히려 성능이 저하된다.

-- 인덱스 정보 조회하기
SELECT INDEX_NAME, TABLE_NAME, COLUMN_NAME
FROM USER_IND_COLUMNS
WHERE TABLE_NAME IN('EMP','DEPT');

-- //조회 속도 비교
--사원테이블 복사
DROP TABLE EMP01;
CREATE TABLE EMP01 
AS 
SELECT * FROM EMP;

SELECT TABLE_NAME, INDEX_NAME, COLUMN_NAME
FROM USER_IND_COLUMNS
WHERE TABLE_NAME IN ('EMP', 'EMP01');
--테이블 자체 여러번 복사
INSERT INTO EMP01 
SELECT * FROM EMP01;
-- 인덱스가 아닌 컬럼으로 검색하기
SELECT COUNT(*) FROM EMP01; --19초
INSERT INTO EMP01(EMPNO, ENAME) VALUES (1111, 'SYJ');

SET TIMING ON
SELECT DISTINCT EMPNO, ENAME
FROM EMP01
WHERE ENAME='SYJ'; --19초, 인덱스가 없다면 오래걸림

-- 인덱스 설정하기
-- 인덱스 생성
CREATE INDEX IDX_EMP01_ENAME
ON EMP01(ENAME); 
-- 인덱스로 검색
SELECT DISTINCT EMPNO, ENAME
FROM EMP01
WHERE ENAME='SYJ'; --0.002초

-- 인덱스 제거하기
SELECT INDEX_NAME, TABLE_NAME, COLUMN_NAME
FROM USER_IND_COLUMNS
WHERE TABLE_NAME IN ('EMP01'); --인덱스 조회

DROP INDEX IDX_EMP01_ENAME; --인덱스 제거
