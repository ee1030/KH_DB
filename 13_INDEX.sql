/* INDEX(인덱스)

    - SQL문의 검색 처리 속도를 향상시키기 위해서
      컬럼에 대해 생성하는 오라클 객체
      
    - 인덱스 내부 구조는 B* 트리 형식으로 구성되어 있음.
    
    * 인덱스의 장점
        - 이진트리 형식으로 구성되어 있어 자동 정렬 및 검색 속도가 향상됨.
        - 시스템에 걸리는 부하를 줄여 시스템 전체 성능이 향상.
        
    * 인덱스의 단점
        - 인덱스를 추가하기 위한 별도의 저장 공간이 필요함.
        - 인덱스를 생성하는데 시간이 걸림.
        - 데이터 변경 작업(DML)이 빈번하게 발생하는 경우에는
          오히려 성능 저하를 초래함.
*/

--------------------------------------------------------------------------------

/* 인덱스 생성 방법

CREATE [UNIQUE] INDEX 인덱스명
ON 테이블명(컬럼명 | 함수명 | 계산식, ...);

*/

-- 인덱스 구조
--> ROWID : DB 내 데이터 공유 주소
SELECT ROWID EMP_IDM, EMP_NAME
FROM EMPLOYEE;
-- AAAE5e AAB AAALC5 AAA
-- 1~6 : 데이터 오브젝트 번호
-- 7~9 : 파일 번호
-- 10~15 : BLOCK 번호
-- 16~18 : ROW 번호

-- 데이터베이스는 저장 순서가 지켜지지 않음.
--> 그래서 ORDER BY절을 사용한다.

-- 테이블 제약 조건 중 PK로 지정된 컬럼은 
-- 자동으로 INDEX가 생성된다. (★★★★★)

-- 인덱스 활용 방법

-- 1) 인덱스를 활용하지 않은 SELECT문
SELECT EMP_ID, EMP_NAME 
FROM EMPLOYEE; -- 0.002초

-- 2) 인덱스를 활용한 SELECT문
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID > 0;
--> WHERE절에 INDEX가 설정됨 컬럼이 포함되면 된다.
--> 데이터가 넘 없어서 속도차이가 안나보임

CREATE TABLE BOARD(
    BOARD_NO NUMBER PRIMARY KEY,
    BOARD_TITLE VARCHAR2(300) NOT NULL,
    BOARD_CONTENT CLOB NOT NULL,
    BOARD_COUNT NUMBER DEFAULT 0,
    BOARD_CREATE_DT DATE DEFAULT SYSDATE,
    BOARD_MODIFY_DT DATE DEFAULT SYSDATE,
    BOARD_STATUS CHAR(1) DEFAULT 'Y' CHECK(BOARD_STATUS IN ('Y','B','N')),
    BOARD_WRITER NUMBER NOT NULL,
    BOARD_CATEGORY NUMBER NOT NULL,
    BOARD_TYPE NUMBER NOT NULL
);

CREATE SEQUENCE SEQ_BNO
START WITH 1
INCREMENT BY 1
MAXVALUE 10000000
NOCYCLE
NOCACHE;

/* PL/SQL(Procedural Language extension to SQL)
    - 오라클 자체에 내장되어있는 절차적 언어
    - SQL 문장 내에서 변수의 정의, 조건처리(IF), 반복처리(FOR, WHILE, LOOP)등을
      지원하여, SQL의 단점을 보완한 언어
*/

BEGIN
    FOR N IN 1..1000000 LOOP
    
        INSERT INTO BOARD
        VALUES(SEQ_BNO.NEXTVAL, N || '번째 게시글',
                N || '번째 게시글의 내용입니다.',
                DEFAULT, DEFAULT, DEFAULT, DEFAULT,  1,
                CEIL(DBMS_RANDOM.VALUE(0,6))*10, 1);
    
    END LOOP;
    
    COMMIT;
END;
/





















