/*
    DCL(Data Control Language) : 데이터 제어 언어
        - 테이터베이스, 데이터베이스 객체에 대한 접근 권한을 제어(부여, 회수) 하는 언어
        
        - GRANT(권한 부여), REVOKE(권한 회수)
        
        - 권한의 종류 : 시스템 권한, 객체 권한
*/

/*
    1. 시스템 권한
    - 사용자에게 객체 생성/삭제, 데이터베이스 접속등에 관련된 권한을 말함.
    
    [작성법]
        GRANT 권한1, 권한2, ...
        TO 사용자명(계정명);
        
        REVOKE 권한1, 권한2, ...
        FROM 사용자명;
*/

-- 시스템 권한 종류 
/*
    CRETAE SESSION   : 데이터베이스 접속 권한
    CREATE TABLE     : 테이블 생성 권한
    CREATE VIEW      : 뷰 생성 권한
    CREATE SEQUENCE  : 시퀀스 생성 권한
    CREATE PROCEDURE : 함수(프로시져) 생성 권한
    CREATE USER      : 사용자(계정) 생성 권한
    DROP USER        : 사용자(계정) 삭제 권한
    DROP ANY TABLE   : 임의 테이블 삭제 권한
*/

/*
    계정의 종류
    1) 관리자 계정 : 데이터베이스의 생성과 관리를 담당하는 계정
                    모든 권한과 책임을 가지는 계정.(SYS(찐), SYSTEM(부))
    
    2) 사용자 계정 : 데이터베이스에 대하여
                    질의, 갱신, 보고서 작성 등의 작업을 수행할 수 있는 계정으로
                    업무에 필요한 최소한의 권한만 가지는 것을 원칙으로 한다.
*/

-- SQL DEVELOPER(sys)
-- 테스트용 계정 생성(sample)
CREATE USER sample IDENTIFIED BY sample;
-- User SAMPLE이(가) 생성되었습니다.

-- SQLPLUS에서 sample 계정으로 로그인 시도
-- ORA-01045: user SAMPLE lacks CREATE SESSION privilege; logon denied
-- CREATE SESSION 권한이 없어서 로그인 실패

-- SQL DEVELOPER(sys)
-- sample 계정에 DB접속 권한을 부여
GRANT CREATE SESSION
TO sample;

--  SQLPLUS(sample)
CREATE TABLE TEST(
    TID NUMBER PRIMARY KEY
);
-- ORA-01031: insufficient privileges
--> 테이블 생성 권한 없어서 에러 발생.

-- SQL DEVELOPER(sys)
-- sample 계정에 테이블 생성 권한 부여
GRANT CREATE TABLE TO sample;

-- SQLPLUS(sample)
-- 테이블 생성 권한(CREATE TABLE)이 부여된 상태에서 다시 테이블 생성
-- ORA-01950: no privileges on tablespace 'SYSTEM' 오류 발생

-- SQL DEVELOPER(sys)
-- sample 계정에 테이블 스페이스 할당량 부여
ALTER USER sample QUOTA 2M ON SYSTEM;

-- SQLPLUS(sample)
-- 다시 TEST 테이블 생성해보기 -> Table created.(테이블 생성 성공)

/***************
     ROLE : 사용자에게 허가할 수 있는 권한들의 집합
            ROLE을 이용하면 권한 부여/회수가 용이함.
     
     CONNET : 사용자가 DB에 접속 가능하도록 하는
              CREATE SESSION의 권한이 작성되어 있는 ROLE
              
     RESOURCE : CREATE 구문을 이용한 객체 생성 권한과
                INSERT, UPDATE, DELETE 구문을 사용할 수 있도록 하는
                권한을 모아둔 ROLE
*/

-- ROLE 테스트를 위해서 sample 계정 삭제 후 다시 생성

-- SQLPLUS(sample)
-- 삭제 전 접속 부터 해제
EXIT;
-- Disconnected from Oracle Database

-- SQL DEVELOPER(sys)
-- sample 계정 삭제
DROP USER sample CASCADE;

-- 다시 sample 계정 생성
CREATE USER sample IDENTIFIED BY sample;
-- User SAMPLE이(가) 생성되었습니다.

-- ROLE을 이용하여 sample 계정에 DB접속 권한 + 기본 자원 사용 권한 부여
GRANT CONNECT, RESOURCE TO sample;

-- SQLPLUS 다시 키고 sample로 로그인 후 TEST 테이블 다시 생성
--> 문제없이 접속, 테이블 생성이 진행 됨.

--------------------------------------------------------------------------------

-- 2. 객체 권한
/*
    - 특정 객체를 조작 할 수 있는 권한을 부여/회수
    
    [작성법]
    GRANT 권한종류[(컬럼명)] | ALL
    ON 객체명 | ROLE 이름 | PUBLIC
    TO 사용자명;
*/

-- SQLPLUS(sample)
-- sample 계정으로 kh계정에 있는 EMPLOYEE 테이블 조회하기
SELECT * FROM kh.EMPLOYEE;
-- ORA-00942: table or view does not exist
--> kh 께정에 EMPLOYEE 테이블에 대한 접근 권한이 없어서 오류 발생.

-- SQL DEVELOPER(kh)
-- sample 계정에게 kh계정의 EMPLOYEE 테이블을 조회할 수 있도록
-- 객체 권한 부여 진행

-- 객체 권한 종류
/*
   권한 종류         설정 객체
   SELECT              TABLE, VIEW, SEQUENCE
    INSERT              TABLE, VIEW
    UPDATE              TABLE, VIEW
    DELETE              TABLE, VIEW
    ALTER               TABLE, SEQUENCE
    REFERENCES          TABLE
    INDEX               TABLE
    EXECUTE             PROCEDURE
*/

GRANT SELECT ON kh.EMPLOYEE TO sample;

-- SQLPLUS(sample)
-- 다시 EMPLOYEE 조회
SELECT * FROM kh.EMPLOYEE;

-- SQL DEVELOPER(kh)
-- sample 꼐정에 부여했던 EMPLOYEE 테이블 SELECT 권한을 회수
REVOKE SELECT ON kh.EMPLOYEE FROM sample;
-- Revoke을(를) 성공했습니다.

-- 권한 회수 후 SQLPLUS(sample)에서 다시 kh.EMPLOYEE 조회해보기
-- ORA-00942: table or view does not exist

-- ROLE 권한 확인
SELECT grantee, privilege
    FROM DBA_SYS_PRIVS
    WHERE grantee IN('CONNECT' ,'RESOURCE');
    
-- 사용자에게 부여된 권한 확인
SELECT *
 FROM USER_ROLE_PRIVS;



