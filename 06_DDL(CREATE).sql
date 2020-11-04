/*
    DDL(Data Definition Language) : 데이터 정의 언어(★★★★★)
    
    - 객체(OBJECT)를 만들고, 수정(ALTER), 삭제(DROP)하는 등
      데이터 전체 구조를 정의하는 언어로
      주로 DB관리자 설계자가 사용함.
      
      
    - 오라클에서 말하는 객체 :
        TABLE, VIEW, SEQUENCE, INDEX, PACKAGE, TRIGGER,
        PROCEDURE, FUNCTION, SYNONYM(동의어), USER
        
--------------------------------------------------------------------------------

    CREATE
    - 테이블이나 뷰, 인덱스 등 다양한 데이터베이스 객체를 생성하는 구문
    
    - 1. 테이블 생성하기
    
    - 테이블(TABLE)이란?(★★★)
      -- 행과(ROW)과 열(COLUMN)로 구성되는 데이터베이스의 가장 기본적인 객체
      -- 데이터베이스 내에서 모든 데이터는 테이블을 통해 저장된다.

    - 테이블 생성 SQL구문 작성법
    
      CREATE TABLE 테이블명(
        컬럼명 데이터타입(크기 | 자리수),
        컬럼명 데이터타입(크기 | 자리수),
        ...
      );
    
*/

-- CHAR : 고정길이 문자 자료형 (2000BYTE)
          --> 지정된 바이트보다 적은양의 데이터가 저장되어도
          -- 남은 용량을 반환하지 않음

-- VARCHAR : 가변길이 문자 자료형 (2000BYTE)
             --> 지정된 바이트보다 적은 양의 데이터가 저장된 경우
             -- 남은 크기(용량) 반환
             
-- VARCHAR2 : 4000 BYTE 가변길이 문자 자료형

-- 문자형 데이터를 30바이트까지 저장할 수 있는 MEMBER_ID 컬럼

CREATE TABLE MEMBER(
    MEMBER_ID VARCHAR2(30), 
    MEMBER_PWD VARCHAR2(30),
    MEMBER_NAME VARCHAR2(20),
    MEMBER_SSN CHAR(14),
    ENROLL_DATE DATE DEFAULT SYSDATE
);
-- DEFAULT SYSDATE : 입력되는 값이 없거나, DEFAULT가 입력 된 경우 현재 시간 기록

-- MEMBER TABLE 생성 확인
SELECT * FROM MEMBER;

-- 2. 컬럼에 코멘트(주석) 달기
-- [작성법]
-- COMMENT ON COLUMN 테이블명.컬럼명 IS '주석내용';
COMMENT ON COLUMN MEMBER.MEMBER_ID IS '회원아이디';
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS '회원비밀번호';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS '회원이름';
COMMENT ON COLUMN MEMBER.MEMBER_SSN IS '주민등록번호';
COMMENT ON COLUMN MEMBER.ENROLL_DATE IS '가입일자';

-- 사용자가 생성한 테이블 확인
SELECT * FROM USER_TABLES;

-- 딕셔너리 뷰(Dictionary View)
-- USER_TABLES : 사용자가 작성한 테이블을 확인하는 뷰(가상의 테이블)


/*
    Data Dictionary(데이터 딕셔너리)(★★★★★)
    
    - 자원을 효율적으로 관리하기 위한 다양한 정보를 저장하는 시스템 테이블.
    
    - 데이터 딕셔너리는 사용자가 테이블을 생성하거나 사용자를 변경하는 등의
      작업을 할 때 데이터베이스 서버에 의해서 자동으로 갱신되는 테이블이다.
*/

SELECT USERNAME FROM DBA_USERS;
-- DBA_USERS : 데이터베이스에 존재하는 모든 사용자(USER) 정보를 조회하는 딕셔너리 뷰
-- (SYS AS SYSDBA 계정으로만 가능)

SELECT * FROM USER_TAB_COLUMNS
WHERE TABLE_NAME = 'MEMBER';
-- USER_TAB_COLUMNS : 테이블, 뷰, 클러스터의 컬럼과 관련된 정보를 조회하는 딕셔너리 뷰

DESC MEMBER;
-- DESC문 : 테이블의 구조를 표시하는 구문

-- MEMBER 테이블에 샘플 데이터 삽입
INSERT INTO MEMBER VALUES('MEM01', '123ABC', '고길동', '000101-3345678', DEFAULT);

-- 데이터 삽입 확인
SELECT * FROM MEMBER;

COMMIT;
-- 테이블 조작 내용(DML)을 실제 DB에 반영하는 TCL 구문

-- 가입일 -> SYSDATE를 활용
INSERT INTO MEMBER VALUES ('MEM02', 'QWER1234', '김영희', '971208-2123456', SYSDATE); 

-- 가입일 -> DEFAULT 활용(테이블 생성 시 정의된 값이 반영됨)
INSERT INTO MEMBER VALUES ('MEM03', 'ZZ9786', '박철수', '900314-1122334',  DEFAULT); -- DEFAULT

-- 가입일 -> INSERT 시 미작성 하는 경우 -> DEAFULT 값이 반영됨
INSERT INTO MEMBER(MEMBER_ID, MEMBER_PWD, MEMBER_NAME, MEMBER_SSN)
VALUES ('MEM4', 'ASDQWE','이지연', '851011-2345678');

COMMIT;

SELECT * FROM MEMBER;

-- 주문등록번호, 전화번호 등 숫자가 포함된 데이터의 컬럼을 문자열로 하는 이유
CREATE TABLE MEMBER2(
    MEMBER_ID VARCHAR2(30), 
    MEMBER_PWD VARCHAR2(30),
    MEMBER_NAME VARCHAR2(20),
    MEMBER_SSN NUMBER,
    ENROLL_DATE DATE DEFAULT SYSDATE
);

INSERT INTO MEMBER2 VALUES ('MEM02', 'QWER1234', '김영희', 0712082123456, SYSDATE); 

SELECT * FROM MEMBER2;
-- 주민등록번호 제일 앞 0이 사라지는 문제가 발생함.
    --> 이를 해결하기 위해 문자 데이터 타입을 사용함.

--------------------------------------------------------------------------------

/*
    제약 조건(CONSTRAINTS)
    
    - 사용자가 원하는 조건의 데이터만 유지하기 위해서 특정 컬럼에 설정하는 제약
    - 테이블 작성 시 각 컬럼에 대해 값 기록에 대한 제약 조건을 설정 가능.
    
    제약 조건의 목적 
    - 데이터 무결성 보장.(중복 데이터X, NULL X)
    - 입력 데이터에 문제가 없는 자동 검사.
    - 데이터의 수정/삭제 가능 여부

    제약 조건의 종류
    - PRIMARY KEY
    - NOT NULL
    - UNIQUE
    - CHECK
    - FOERIGN KEY
*/

-- 제약 조건 확인 방법
SELECT * FROM USER_CONSTRAINTS;
-- USER_CONSTRAINTS : 사용자가 작성한 제약 조건을 확인하는 딕셔너리 뷰

SELECT * FROM USER_CONS_COLUMNS;
-- USER_CONS_COLUMNS : 제약 조건이 설정된 컬럼을 확인하는 딕셔너리 뷰

--------------------------------------------------------------------------------

-- 1. NOT NULL 제약 조건
-- 해당 컬럼에 반드시 값이 기록되어야 하는 경우 사용하는 제약 조건
-- 데이터 삽입/수정 시 NULL 값을 허용하지 않도록
-- 컬럼 레벨에서 지정함.

-- NOT NULL 제약조건이 없는 경우
CREATE TABLE USER_NOT_NN(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(20),
    USER_NAME VARCHAR2(30),
    GENDER CHAR(3),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
);

INSERT INTO USER_NOT_NN 
VALUES(1, 'USER01', 'PASS01', '김영주', '남', '010-1111-2222', 'USER01@naver.com');

INSERT INTO USER_NOT_NN 
VALUES(2, NULL, NULL, NULL, '남', '010-1111-2222', 'USER01@naver.com');

SELECT * FROM USER_NOT_NN;

-- NOT NULL 제약조건이 설정된 경우
-- ★★★★★★★★★★(쥰내 중요) NOT NULL 제약조건은 테이블 생성 시 컬럼 레벨로만 지정 가능함
CREATE TABLE USER_NN(
    USER_NO NUMBER NOT NULL,
    USER_ID VARCHAR2(20) NOT NULL,
    USER_PWD VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER CHAR(3),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50) NOT NULL
);

-- 작성한 제약조건 확인
SELECT C1.TABLE_NAME, COLUMN_NAME, SEARCH_CONDITION
FROM USER_CONSTRAINTS C1
JOIN USER_CONS_COLUMNS C2 USING(CONSTRAINT_NAME)
WHERE C1.TABLE_NAME = 'USER_NN';

INSERT INTO USER_NN 
VALUES(1, 'USER01', 'PASS01', '김영주', '남', '010-1111-2222', 'USER01@naver.com');

INSERT INTO USER_NN 
VALUES(2, 'USER02', 'PASS02', NULL, '남', '010-1111-2222', 'USER01@naver.com');







