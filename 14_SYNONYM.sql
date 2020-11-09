/* SYNONYM(동의어)
    - 다른 DB가 가진 객체에 대한 별명 또는 줄임말.
    - 여러 사용자가 테이블을 공유할 경우
      다른 사용자가 테이블에 접근하는 방법을 간단하게 만드는 객체
    
    [작성법] 
    CREATE SYNONYM 별명(줄임말)
    FOR 사용자명.객체명;
*/

-- 1. 비공개 동의어
-- 객체에 대한 접근 권한을 부여받은 사용자가 정의한 동의어로
-- 해당 사용자만 사용 가능하다.

-- SQL DEVELOPER(kh)
-- sample 계정에 kh의 BOARD 테이블 조회 권한 부여.
GRANT SELECT ON kh.BOARD TO sample;

-- SQLPLUS(sample)
-- kh.BOARD 테이블 조회
SELECT * FROM kh.BOARD
WHERE ROWNUM <= 100;

-- SQLPLUS(sample)
-- sample 계정이 kh.BOARD 테이블을 동의어로 KB SYNONYM 객체를 생성
CREATE SYNONYM KB FOR kh.BOARD;
-- ORA-01031: insufficient privileges(SYNONYM 생성권한이 없음)

-- SQL DEVELOPER(sys as sysdba)
-- sample 계정에 SYNONYM 생성 권한을 부여
GRANT CREATE SYNONYM TO sample;

-- SQLPLUS(sample)에서 SYNONYM 생성 구문 다시 실행.
CREATE SYNONYM KB FOR kh.BOARD;
-- Synonym create.

-- KB로 조회 가능한지 확인
SELECT * FROM KB
WHERE ROWNUM <= 100; -- 조회성공

-- KB SYNONYM 삭제
DROP SYNONYM KB;
-- Synonym dropped.

-- 다시 KB SYNONYM 생성 후 SYS 계정으로 KB 조회
SELECT * FROM KB
WHERE ROWNUM <= 100;
-- ORA-00942: table or view does not exist
--> 관리자여도 비공개 동의어는 접근 할 수 없다.

SELECT * FROM kh.BOARD
WHERE ROWNUM <= 100;
--> 관리자는 모든 객체 접근 권한이 있기 때문에
-- 별도 GRANT 없이도 사용자명.객체명으로 접근 가능

--------------------------------------------------------------------------------

-- 2. 공개 동의어
-- 모든 권한을 주는 사용자(DBA)가 정의한 동의어로
-- 지정된 동의어는 모든 사용자가 사용할 수 있음.
-- 대표적인 예시 : DUAL

-- SQL DEVELOPER(sys as sysdba)
-- kh 계정의 DEPARTMENT 테이블의 공개 동의어를 DEPT로 지정
CREATE PUBLIC SYNONYM DEPT FOR kh.DEPARTMENT;
-- SYNONYM DEPT이(가) 생성되었습니다.

-- 기존 동의어 없이 조회하는 경우
SELECT * FROM kh.DEPARTMENT;

-- 동의어 지정 후(sys as sysdba)
SELECT * FROM DEPT;

-- SQLPLUS(sampe에서 조회)
SELECT * FROM DEPT;
-- ORA-00942: table or view does not exist
--> SELECT 권한 없어서 조회 불가

-- SQL DEVELOPER(kh)
-- sample 계정에 kh.DEPARTMENT 테이블 조회 권한 부여
GRANT SELECT ON kh.DEPARTMENT TO sample;
-- Grant을(를) 성공했습니다.

--> SQLPLUS(sample)에서 다시 DEPT조회 --> 조회 성공





