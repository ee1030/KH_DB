/*
    DDL(Data Definition Language) : 데이터 정의 언어
    - 객체(OBJECT)를 만들고(CREATE), 수정(ALTER)하고, 삭제(DROP)하는 구문
    
    * ALTER
        - 객체를 수정하는 구문
        
        [테이블에 대한 작성법]
        ALTER TABLE 테이블명 수정할 내용;
        
        -> 수정할 내용
            -- 컬럼 추가/삭제
            -- 제약조건 추가/삭제
            -- 컬럼의 자료형 변경
            -- 컬럼의 DEFAULT값 변경
            -- 컬럼명, 제약조건명, 테이블명 변경
*/

-- 1. 컬럼 추가, 수정, 삭제
SELECT * FROM DEPT_COPY;

-- 1) 컬럼 추가(ADD)
ALTER TABLE DEPT_COPY
ADD (CNAME VARCHAR2(20));
-- Table DEPT_COPY이(가) 변경되었습니다.

SELECT * FROM DEPT_COPY;

-- 컬럼 추가 시 DEFAULT값 ㅈ정
ALTER TABLE DEPT_COPY
ADD (LNAME VARCHAR2(40) DEFAULT '한국');

SELECT * FROM DEPT_COPY;

-- 2) 컬럼 수정
ALTER TABLE DEPT_COPY
MODIFY DEPT_ID CHAR(3)
MODIFY DEPT_TITLE VARCHAR2(30)
MODIFY LOCATION_ID VARCHAR2(10)
MODIFY LNAME DEFAULT '미국';

-- 컬럼 수정 시 주의사항
--> 크기를 수정하려는 컬럼에 변경 예정 크기보다 큰 데이터가 있으면 수정되지 않음.

ALTER TABLE DEPT_COPY
MODIFY DEPT_TITLE VARCHAR2(10);
-- ORA-01441: cannot decrease column length because some value is too big


-- 3) 컬럼 삭제(DROP COLUMN 컬럼명)
-- 컬럼 값이 존재해도 컬럼은 삭제됨.
-- 삭제된 컬럼은 복구되지 않음(DDL은 바로 DB에 반영됨)
-- 모든 컬럼은 삭제할 수는 없음.(최소 한개 이상의 컬럼이 존재해야 테이블임)

CREATE TABLE DEPT_COPY2
AS SELECT * FROM DEPT_COPY;

ALTER TABLE DEPT_COPY2
DROP COLUMN DEPT_ID;

SELECT * FROM DEPT_COPY2;

ALTER TABLE DEPT_COPY2
DROP COLUMN LOCATION_ID;

ALTER TABLE DEPT_COPY2
DROP COLUMN CNAME;

ALTER TABLE DEPT_COPY2
DROP COLUMN LNAME;

SELECT * FROM DEPT_COPY2;

ALTER TABLE DEPT_COPY2
DROP COLUMN DEPT_TITLE;
-- ORA-12983: cannot drop all columns in a table

-- 컬럼 삭제 시 주의사항
   --> 컬럼 삭제 시 FK 제약조건이 설정된 컬럼은 삭제되지 않음.
   
--------------------------------------------------------------------------------
/*
    2. 제약조건 추가, 삭제
    
    1) 제약조건 추가(ADD, MODIFY(NOT NULL 추가 시))
    
    [작성법]
    ALTER TABLE 테이블명
    ADD CONSTRAINT 제약조건명 제약조건(컬럼명);
    
    (NOT NULL의 경우)
    ALTER TABLE 테이블명
    MODIFY 컬럼명 CONSTRAINT 제약조건명 NOT NULL;
*/

ALTER TABLE DEPT_COPY
ADD CONSTRAINT DC_ID_PK PRIMARY KEY(DEPT_ID);

ALTER TABLE DEPT_COPY
ADD CONSTRAINT DC_TITLE_UK UNIQUE(DEPT_TITLE)
MODIFY LNAME CONSTRAINT DC_LNAME_NN NOT NULL;
--> SQL DEVELOPER 에러임 실제 에러 아님

-- 기존 테이블에 FK 제약 조건 추가하기

-- EMPLOYEE - DEPARTMENT  FK 추가
ALTER TABLE EMPLOYEE
ADD CONSTRAINT EMP_DCODE_FK FOREIGN KEY(DEPT_CODE)
REFERENCES DEPARTMENT/*(DEPT_ID)*/;

-- EMPLOYEE - JOB
ALTER TABLE EMPLOYEE
ADD CONSTRAINT EMP_JCODE_FK FOREIGN KEY(JOB_CODE)
REFERENCES JOB/*(JOB_CODE)*/;

-- EMPLOYEE - SAL_GRADE
ALTER TABLE EMPLOYEE
ADD CONSTRAINT EMP_SLEV_FK FOREIGN KEY(SAL_LEVEL)
REFERENCES SAL_GRADE/*(SAL_LEVEL)*/;

-- DEPARTMENT - LOCATION
ALTER TABLE DEPARTMENT
ADD CONSTRAINT DEPT_LID_FK FOREIGN KEY(LOCATION_ID)
REFERENCES LOCATION/*(LOCAL_CODE)*/;

-- LOCATION - NATIONAL
ALTER TABLE LOCATION
ADD CONSTRAINT LO_NCODE_FK FOREIGN KEY(NATIONAL_CODE)
REFERENCES NATIONAL/*(NATIONAL_CODE)*/;





