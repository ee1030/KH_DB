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
VALUES(2, NULL, NULL, NULL, '남', '010-1111-2222', 'USER01@naver.com');
--> 제약조건 위배되서 오류남

INSERT INTO USER_NN 
VALUES(2, 'USER02', 'PASS02', NULL, '남', '010-1111-2222', 'USER01@naver.com');

--------------------------------------------------------------------------------

/* 2. UNIQUE 제약 조건
    - 컬럼 입력값에 대해서 중복을 제한하는 제약 조건.
    - 컬럼/테이블 레벨에서 제약 조건 설정 가능
    - 단, UNIQUE 제약 조건이 설정된 컬럼에는 NULL값 중복은 가능하다.
*/


-- USER_NN 테이블에 중복 데이터 삽입(성공? 실패?)
SELECT * FROM USER_NN;

INSERT INTO USER_NN
VALUES(1, 'USER01', 'PASS01', '김영주', '남', '010-1111-2222', 'USER01@naver.com');

-- 1) 컬럼 레벨로  UNIQUE 제약 조건 설정

-- UNIQUE 제약 조건 테이블 생성
CREATE TABLE USER_UK(
    USER_NO NUMBER,
    --USER_ID VARCHAR2(20) UNIQUE, -- 기본 컬럼레벨 제약조건 지정
    USER_ID VARCHAR2(20) CONSTRAINT USER_ID_UK UNIQUE,
                        --CONSTRAINT 제약조건명 제약조건
    USER_PWD VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER CHAR(3),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
);



-- 삽입을 순서대로 하나씩 진행
INSERT INTO USER_UK
VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@kh.or.kr');


INSERT INTO USER_UK
VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@kh.or.kr');
-- ORA-00001: unique constraint (KH.USER_ID_UK) violated
--> USER_ID 컬럼에 중복데이터가 삽입되어 UNIQUE 제약 조건을 위배

INSERT INTO USER_UK
VALUES(1, NULL, 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@kh.or.kr');
-- UNIQUE는 NULL 값 삽입 가능

INSERT INTO USER_UK
VALUES(1, NULL, 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@kh.or.kr');
-- UNIQUE는 NULL 값 중복 삽입도 가능

-- 삽입 결과 확인
SELECT  * FROM USER_UK; 


-- 오류 보고에 나타나는 SYS_C008635 같은 제약 조건명으로
-- 해당 제약 조건이 설정된 테이블명, 컬럼, 제약 조건 타입 조회 
SELECT UCC.TABLE_NAME, UCC.COLUMN_NAME, UC.CONSTRAINT_TYPE
FROM USER_CONSTRAINTS UC, USER_CONS_COLUMNS UCC
WHERE UCC.CONSTRAINT_NAME = UC.CONSTRAINT_NAME
AND UCC.CONSTRAINT_NAME = 'USER_ID_UK2';


--------------------------------------------

-- 2) 테이블 레벨에서 제약 조건 설정


/* [작성법]
	CREATE TABLE 테이블명(
        컬럼명 데이터타입, ...,
        [CONSTRAINT 제약조건명] 제약조건 (컬럼명)
    );
	
*/


CREATE TABLE USER_UK2(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER CHAR(3),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    --UNIQUE(USER_ID) -- 기본 테이블 레벨 제약조건 설정
    CONSTRAINT USER_ID_UK2 UNIQUE(USER_ID)
);


-- USER_UK2 테이블에 설정된 제약조건 조회
SELECT C1.TABLE_NAME,  COLUMN_NAME  ,SEARCH_CONDITION
FROM USER_CONSTRAINTS  C1 
JOIN USER_CONS_COLUMNS C2 USING(CONSTRAINT_NAME)
WHERE C1.TABLE_NAME = 'USER_UK2';


-- 데이터를 삽입하여 UNIQUE 제약 조건 확인
INSERT INTO USER_UK2
VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@kh.or.kr');

INSERT INTO USER_UK2
VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@kh.or.kr');
-- ORA-00001: unique constraint (KH.USER_ID_UK2) violated

SELECT * FROM USER_UK2;



--------------------------------------------

-- 3) UNIQUE 복합키
-- 두 개 이상의 컬럼을 묶어 하나의 UNIQUE 제약 조건을 설정함.
-- 설정된 컬럼의 데이터가 모두 일치해야 중복으로 판정됨.
-- 복합키는 테이블 레벨로만 작성할 수 있음

CREATE TABLE USER_UK3(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER CHAR(3),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    CONSTRAINT USER_NO_ID_UK UNIQUE(USER_NO, USER_ID)
);




INSERT INTO USER_UK3
VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@kh.or.kr');

INSERT INTO USER_UK3
VALUES(2, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@kh.or.kr');

INSERT INTO USER_UK3
VALUES(2, 'user02', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@kh.or.kr');

INSERT INTO USER_UK3
VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@kh.or.kr');
--> 여러 컬럼을 묶어서 UNIQUE 제약 조건이 설정되어 있으면 
-- 두 컬럼이 모두 중복되는 값일 경우에만 오류 발생

SELECT * FROM USER_UK3;


SELECT UC.TABLE_NAME, UCC.COLUMN_NAME, UCC.CONSTRAINT_NAME, UC.CONSTRAINT_TYPE
FROM USER_CONSTRAINTS UC
JOIN USER_CONS_COLUMNS UCC ON(UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME)
WHERE UCC.CONSTRAINT_NAME = 'USER_NO_ID_UK';
--> 두개의 UNIQUE 제약 조전이이 하나의 제약 조건명으로 되어있는 것 확인



------------------------------------------------------------------------------------------


-- 제약조건에 이름 설정
CREATE TABLE CONST_NAME(
  TEST_DATA1 VARCHAR2(20) CONSTRAINT NN_TEST_DATA1 NOT NULL, 
  TEST_DATA2 VARCHAR2(20) CONSTRAINT UK_TEST_DATA2 UNIQUE,
  TEST_DATA3 VARCHAR2(30),
  CONSTRAINT UK_TEST_DATA3 UNIQUE(TEST_DATA3)
);
-- TEST_DATA1 컬럼에 컬럼 레벨로 NOT_NULL 제약조건을 추가하고 제약 조건 명을 NN_TEST_DATA1으로 지정
-- TEST_DATA2 컬럼에 컬럼 레벨로 UNIQUE 제약조건을 추가하고 제약 조건 명을 UK_TEST_DATA2 지정
-- TEST_DATA3 컬럼에 테이블 레벨로 UNIQUE 제약조건을 추가하고 제약 조건 명을 UK_TEST_DATA3 지정

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'CONST_NAME';

SELECT * 
FROM USER_CONSTRAINTS C1
JOIN USER_CONS_COLUMNS C2 USING(CONSTRAINT_NAME)
WHERE C1.TABLE_NAME = 'CONS_NAME';


------------------------------------------------------------------------------------------


/* 3. PRIMARY KEY(기본키) 제약 조건 
    - 테이블에서 한 행의 정보를 찾기 위해 사용할 컬럼을 의미함.
      -> 테이블의 각 행에 대한 식별자(IDENTIFIER) 역할을 함.
      
    - NOT NULL + UNIQUE 제약조건의 의미를 가지고 있음.
    
    - 한 테이블 당 하나의 PK 제약조건을 설정할 수 있음
    
    - 컬럼 / 테이블 레벨로 제약 조건 설정 가능.
    
    - PK도 복합키 설정 가능

*/

-- 1) PRIMARY KEY가 설정된 테이블 생성

CREATE TABLE USER_PK(
  --USER_NO NUMBER PRIMARY KEY, -- 컬럼 레벨로 PK 설정
  --USER_NO NUMBER CONSTRAINT USER_PK_PK PRIMARY KEY, -- 컬럼 레벨로 PK 설정 + 이름 지정
  USER_NO NUMBER,
  USER_ID VARCHAR2(20) UNIQUE,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER CHAR(3),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50),
  --PRIMARY KEY(USER_NO) -- 테이블 레벨 PK 설정
  CONSTRAINT USER_PK_PK PRIMARY KEY(USER_NO)
);


-- 순서 대로 삽입 하면서 확인
INSERT INTO USER_PK
VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@kh.or.kr');

INSERT INTO USER_PK
VALUES(1, 'user02', 'pass02', '이순신', '남', '010-5678-9012', 'lee123@kh.or.kr');
-- ORA-00001: unique constraint (KH.USER_PK_PK) violated

INSERT INTO USER_PK
VALUES(NULL, 'user03', 'pass03', '유관순', '여', '010-9999-3131', 'yoo123@kh.or.kr');
-- ORA-01400: cannot insert NULL into ("KH"."USER_PK"."USER_NO")


-- PK_USER_NO 제약조건 확인
SELECT UC.TABLE_NAME, UCC.COLUMN_NAME, UC.CONSTRAINT_NAME, UC.CONSTRAINT_TYPE
FROM USER_CONSTRAINTS UC
JOIN USER_CONS_COLUMNS UCC ON(UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME)
WHERE UC.CONSTRAINT_NAME = 'USER_PK_PK';


--------------------------------------------

-- 2) PRIMARY KEY 복합키
--> 테이블 레벨로만 작성할 수 있음
CREATE TABLE USER_PK2(
  USER_NO NUMBER,
  USER_ID VARCHAR2(20),
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER CHAR(3),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50),
  CONSTRAINT USER_NO_ID_PK PRIMARY KEY(USER_NO, USER_ID) -- 복합키 설정
);

-- 순서 대로 삽입 하면서 확인
INSERT INTO USER_PK2
VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@kh.or.kr');

INSERT INTO USER_PK2
VALUES(1, 'user02', 'pass02', '이순신', '남', '010-5678-9012', 'lee123@kh.or.kr');

INSERT INTO USER_PK2
VALUES(2, 'user01', 'pass01', '유관순', '여', '010-9999-3131', 'yoo123@kh.or.kr');

INSERT INTO USER_PK2
VALUES(1, 'user01', 'pass01', '신사임당', '여', '010-9999-9999', 'sin123@kh.or.kr');
-- ORA-00001: unique constraint (KH.USER_NO_ID_PK) violated

SELECT * FROM USER_PK2;



------------------------------------------------------------------------------------------


/* 4. FOREIGN KEY(외부키 / 외래키) 제약조건 

    - 참조(REFERENCES)된 다른 테이블의 컬럼이 제공하는 값만 사용 할 수 있게 하는 제약조건
    
    - FOREIGN KEY 제약 조건에 의해서 테이블간의 관계(RELATIONSHIP)가 형성
    
    - 제공되는 값 외에는 NULL을 사용할 수 있음.
    
    -- 컬럼 레벨로 제약 조건 설정
    컬럼명 데이터타입 [CONSTRAINT 제약조건명] REFERENCES 참조테이블명[(참조컬럼명)][삭제옵션]
    
    -- 테이블 레벨로 제약 조건 설정
    [CONSTRAINT 제약조건명] FOREIGN KEY(적용컬럼명) REFERENCES 참조테이블명[(참조컬럼명)][삭제옵션]
    
    (★★★★★)
    참조할 수 있는 컬럼은 PK 또는 UNIQUE 제약 조건이 설정된 컬럼만 지정할 수 있다.

*/
-- 1) FOREIGN KEY 제약 조건 설정

-- FOREIGN KEY 제약조건 확인을 위한 테이블, 샘플데이터
CREATE TABLE USER_GRADE(
  GRADE_CODE NUMBER PRIMARY KEY,
  GRADE_NAME VARCHAR2(30) NOT NULL
);
INSERT INTO USER_GRADE VALUES (10, '일반회원');
INSERT INTO USER_GRADE VALUES (20, '우수회원');
INSERT INTO USER_GRADE VALUES (30, '특별회원');

SELECT * FROM USER_GRADE;


-- USER_GRADE테이블과 FOREIGN KEY 제약조건이 맺어진 테이블 생성
CREATE TABLE USER_FK(
  USER_NO NUMBER PRIMARY KEY,
  USER_ID VARCHAR2(20) UNIQUE,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER CHAR(3),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50),
  GRADE_CODE NUMBER
);



-- 순서 대로 삽입 하면서 확인
INSERT INTO USER_FK
VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@kh.or.kr', 10);

INSERT INTO USER_USED_FK
VALUES(2, 'user02', 'pass02', '이순신', '남', '010-5678-9012', 'lee123@kh.or.kr', 10);

INSERT INTO USER_USED_FK
VALUES(3, 'user03', 'pass03', '유관순', '여', '010-9999-3131', 'yoo123@kh.or.kr', 30);

INSERT INTO USER_USED_FK
VALUES(4, 'user04', 'pass04', '안중근', '남', '010-2222-1111', 'ahn123@kh.or.kr', null);

SELECT * FROM USER_USED_FK;

INSERT INTO USER_USED_FK
VALUES(5, 'user05', 'pass05', '윤봉길', '남', '010-6666-1234', 'yoon123@kh.or.kr', 50);



-- 설정된 제약조건 확인
SELECT UC.TABLE_NAME, UCC.COLUMN_NAME, UC.CONSTRAINT_NAME, UC.CONSTRAINT_TYPE
FROM USER_CONSTRAINTS UC
JOIN USER_CONS_COLUMNS UCC ON (UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME)
WHERE UC.CONSTRAINT_NAME = 'FK_GRADE_CODE';



--------------------------------------------


-- 2) FOREIGN KEY 삭제 옵션 
-- 부모테이블의 데이터 삭제시 자식 테이블의 데이터를 
-- 어떤식으로 처리할 지에 대한 내용을 설정할 수 있다.

-- 2-1) ON DELETE RESTRICTED(삭제 제한)로 기본 지정되어 있음
-- FOREIGN KEY로 지정된 컬럼에서 사용되고 있는 값일 경우
-- 제공하는 컬럼의 값은 삭제하지 못함

SELECT * FROM USER_GRADE;

DELETE FROM USER_GRADE WHERE GRADE_CODE = 10; -- 삭제 구문


COMMIT;


DELETE FROM USER_GRADE WHERE GRADE_CODE = 20;
-- GRADE_CODE 중 20은 외래키로 참조되고 있지 않으므로 삭제가 가능함.

SELECT * FROM USER_GRADE;

ROLLBACK;



---------------------


-- 2-2)ON DELETE SET NULL 



-- 삭제 조건 확인을 위한 테이블, 샘플 데이터
CREATE TABLE USER_GRADE2(
  GRADE_CODE NUMBER PRIMARY KEY,
  GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO USER_GRADE2
VALUES (10, '일반회원');
INSERT INTO USER_GRADE2
VALUES (20, '우수회원');
INSERT INTO USER_GRADE2
VALUES (30, '특별회원');

SELECT * FROM USER_GRADE2;


-- ON DELETE SET NULL 삭제 옵션을 추가한 테이블 생성
CREATE TABLE USER_FK2(
  USER_NO NUMBER PRIMARY KEY,
  USER_ID VARCHAR2(20) UNIQUE,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER CHAR(3),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50),
  GRADE_CODE NUMBER
 );

-- 샘플데이터 삽입
INSERT INTO USER_FK2
VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@kh.or.kr', 10);

INSERT INTO USER_FK2
VALUES(2, 'user02', 'pass02', '이순신', '남', '010-5678-9012', 'lee123@kh.or.kr', 10);

INSERT INTO USER_FK2
VALUES(3, 'user03', 'pass03', '유관순', '여', '010-9999-3131', 'yoo123@kh.or.kr', 30);

INSERT INTO USER_FK2
VALUES(4, 'user04', 'pass04', '안중근', '남', '010-2222-1111', 'ahn123@kh.or.kr', null);

COMMIT;




SELECT * FROM USER_GRADE2;
SELECT * FROM USER_USED_FK2;

-- USER_GRADE2 테이블에서 GRADE_COE =10 삭제
DELETE FROM USER_GRADE2
WHERE GRADE_CODE = 10;
--> ON DELETE SET NULL 옵션이 설정되어 있어 삭제가 이루어짐.


SELECT * FROM USER_GRADE2;
SELECT * FROM USER_USED_FK2;


ROLLBACK;



---------------------


-- 2-3) ON DELETE CASCADE



-- 삭제 조건 확인을 위한 테이블, 샘플 데이터
CREATE TABLE USER_GRADE3(
  GRADE_CODE NUMBER PRIMARY KEY,
  GRADE_NAME VARCHAR2(30) NOT NULL
);
INSERT INTO USER_GRADE3
VALUES (10, '일반회원');
INSERT INTO USER_GRADE3
VALUES (20, '우수회원');
INSERT INTO USER_GRADE3
VALUES (30, '특별회원');



-- ON DELETE CASCADE 삭제 옵션을 추가한 테이블 생성
CREATE TABLE USER_FK3(
  USER_NO NUMBER PRIMARY KEY,
  USER_ID VARCHAR2(20) UNIQUE,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER CHAR(3),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50),
  GRADE_CODE NUMBER
);


-- 샘플데이터 삽입
INSERT INTO USER_FK3
VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@kh.or.kr', 10);

INSERT INTO USER_FK3
VALUES(2, 'user02', 'pass02', '이순신', '남', '010-5678-9012', 'lee123@kh.or.kr', 10);

INSERT INTO USER_FK3
VALUES(3, 'user03', 'pass03', '유관순', '여', '010-9999-3131', 'yoo123@kh.or.kr', 30);

INSERT INTO USER_FK3
VALUES(4, 'user04', 'pass04', '안중근', '남', '010-2222-1111', 'ahn123@kh.or.kr', null);

COMMIT;


SELECT * FROM USER_GRADE3;
SELECT * FROM USER_USED_FK3;

SELECT * FROM USER_CONSTRAINTS;
SELECT * FROM SYS.USER_CONS_COLUMNS;

DELETE FROM USER_GRADE3
WHERE GRADE_CODE = 10;

SELECT * FROM USER_GRADE3;
SELECT * FROM USER_USED_FK3;
-- ON DELETE CASECADE 옵션으로 인해 참조키를 사용한 행이 삭제됨을 확인

ROLLBACK;



------------------------------------------------------------------------------------------


/* 5. CHECK 제약 조건 


*/

-- CHECK 제약조건이 설정된 테이블 생성 
CREATE TABLE USER_CHECK(
  USER_NO NUMBER PRIMARY KEY,
  USER_ID VARCHAR2(20) UNIQUE,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER CHAR(3) ,
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50)
);


-- 순서 대로 삽입 하면서 확인
INSERT INTO USER_USED_CHECK
VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@kh.or.kr');

INSERT INTO USER_USED_CHECK
VALUES(2, 'user02', 'pass02', '홍길동', '남자', '010-1234-5678', 'hong123@kh.or.kr');




---------------------


-- (참고) CHECK 제약 조건은 범위로도 설정 가능.
CREATE TABLE USER_CHECK2(
  TEST_NUMBER NUMBER,
  CONSTRAINT CK_TEST_NUMBER CHECK (TEST_NUMBER > 0)
);

INSERT INTO USER_CHECK2
VALUES (10);
INSERT INTO USER_CHECK2
VALUES (-10);
 

-- (참고) 복잡한 범위 설정 + 테이블 레벨로 CHECK 제약조건 추가
CREATE TABLE USER_CHECK3 (
    C_NAME VARCHAR2(15 CHAR),
    C_PRICE NUMBER,
    C_LEVEL CHAR(1),
    C_DATE DATE,
    CONSTRAINT TBCH3_NAME_PK PRIMARY KEY (C_NAME),
    CONSTRAINT TBCH3_PRICE_PK CHECK (C_PRICE >= 1 AND C_PRICE <= 99999),
    CONSTRAINT TBCH3_LEVEL_PK CHECK (C_LEVEL = 'A' OR C_LEVEL = 'B' OR C_LEVEL = 'C'),
    CONSTRAINT TBCH3_DATE_PK CHECK (C_DATE >= TO_DATE('2016/01/01', 'YYYY/MM/DD'))
);


------------------------------------------------------------------------------------------

-- [실습 문제]
-- 회원가입용 테이블 생성(USER_TEST)
-- 컬럼명 : USER_NO(회원번호) - 기본키(PK_USER_TEST), 
--         USER_ID(회원아이디) - 중복금지(UK_USER_ID),
--         USER_PWD(회원비밀번호) - NULL값 허용안함(NN_USER_PWD),
--         PNO(주민등록번호) - 중복금지(UK_PNO), NULL 허용안함(NN_PNO),
--         GENDER(성별) - '남' 혹은 '여'로 입력(CK_GENDER),
--         PHONE(연락처),
--         ADDRESS(주소),
--         STATUS(탈퇴여부) - NOT NULL(NN_STATUS), 'Y' 혹은 'N'으로 입력(CK_STATUS)
-- 각 컬럼의 제약조건에 이름 부여할 것
-- 5명 이상 INSERT할 것





