/*
    DML(Data Manipulation Language) : 데이터 조작 언어
    
    - 테이블에 값을 삽입(INSERT)하거나, 수정(UPDATE)하거나, 삭제(DELETE)하는 구문
    
    -- DML 수업 중 주의사항!!
       -> 혼자서 작성 다했다고 실행하지 말것!
       -> 절대 COMMIT, ROLLBACK 구문 마음대로 실행하지 말것!
       
    
*/

--------------------------------------------------------------------------------

/*
    1. INSERT
    - 테이블에 새로운 행을 추가하는 구문
    - 테이블의 행 개수가 증가함
    
    
    [작성법 1]
    INSERT INTO 테이블명(컬럼명1, 컬럼명2, 컬럼명3, ...)
    VALUES(데이터1, 데이터2, 데이터3, ...);
    
    -> 지정한 테이블에서 특정 컬럼을 선택하여 데이터 삽입(INSERT)하는 방법
        --> 선택이 안된 컬럼은 NULL 값이 들어가거나,
            설정되어있는 DEFAULT값이 들어감
*/

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, EMAIL,
                     PHONE, DEPT_CODE, JOB_CODE, SAL_LEVEL,
                     SALARY, BONUS, MANAGER_ID, HIRE_DATE, ENT_DATE, ENT_YN)
VALUES('900', '장채현', '901123-1080503', 'jang_ch@kh.or.kr',
       '01055569512', 'D1', 'J7', 'S3', 4300000, 0.2, '200', SYSDATE,
       NULL, DEFAULT);
       
SELECT * FROM EMPLOYEE WHERE EMP_NAME = '장채현';

/*
    [작성법 2]
    INSERT INTO 테이블명
    VALUES(데이터1, 데이터2, 데이터3, ...);
    
    --> 테이블에 모든 컬럼에 대한 값을 INSERT 할 때 사용하는 방법
        --> INSERT 구문에 컬럼 생략, VALUES에 컬럼 순서대로 데이터를 작성해야 함
*/

ROLLBACK;

INSERT INTO EMPLOYEE
VALUES('900', '장채현', '901123-1080503', 'jang_ch@kh.or.kr',
       '01055569512', 'D1', 'J7', 'S3', 4300000, 0.2, '200', SYSDATE,
        NULL, DEFAULT);
    
SELECT * FROM EMPLOYEE WHERE EMP_NAME = '장채현';

COMMIT;

-- INSERT시 VALUES 대신 서브쿼리 사용하기
CREATE TABLE EMP_01(
    EMP_ID VARCHAR2(3) PRIMARY KEY,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(20)
);

INSERT INTO EMP_01
    (SELECT EMP_ID, EMP_NAME, DEPT_TITLE
     FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID));

SELECT * FROM EMP_01;

COMMIT;

--------------------------------------------------------------------------------

/*
    2. INSERT ALL
    
    - 서로다른 테이블에 INSERT시 서브쿼리가 사용하는 테이블이 같은 경우
      두 개 이상의 테이블에 INSERT ALL을 이용하여 한 번에 삽입 가능한 구문.
      (단, 서브쿼리 조건절이 같아야함)
*/

-- INSERT ALL 예시1

-- 사번, 사원명, 부서코드, 입사일 컬럼을 가지는 테이블 EMP_DEPT를 생성하고
-- EMPLOYEE 테이블의 컬럼, 데이터 타입만 복사
CREATE TABLE EMP_DEPT
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
   FROM EMPLOYEE
   WHERE 1 = 0;
   --> 서브쿼리의 WHERE절 조건을 항상 FALSE가 되게 만들면
   -- 데이터는 복사되지 않고, 테이블의 컬럼, 데이터 타입만 복사가 됨.

SELECT * FROM EMP_DEPT;

-- 사번, 이름, 관리자번호 컬럼을 가지는 테이블 EMP_MANAGER를 생성하고
-- EMPLOYEE 테이블에서 컬럼명, 데이터 타입만 복사
CREATE TABLE EMP_MANAGER
AS SELECT EMP_ID, EMP_NAME, MANAGER_ID
   FROM EMPLOYEE
   WHERE 1=0;

SELECT * FROM EMP_MANAGER;

-- EMP_DEPT 테이블에
-- EMPLOYEE 테이블에서 부서코드가 'D1'인 사원의
-- 사번, 이름, 부서코드, 입사일 삽입.
INSERT INTO EMP_DEPT
(SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
 FROM EMPLOYEE
 WHERE DEPT_CODE = 'D1');


-- EMP_MANAGER 테이블에
-- EMPLOYEE 테이블에서 부서코드가 'D1'인 사원의
-- 사번, 이름, 관리자번호 삽입.
INSERT INTO EMP_MANAGER
(SELECT EMP_ID, EMP_NAME, MANAGER_ID
 FROM EMPLOYEE
 WHERE DEPT_CODE = 'D1');

ROLLBACK;

-- 서브쿼리에서 사용하는 테이블과 조건절 내용이 같으므로
-- INSERT ALL을 이용해서 한번에 삽입을 진행 할 수 있음
INSERT ALL 
    INTO EMP_DEPT VALUES(EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
    INTO EMP_MANAGER VALUES(EMP_ID, EMP_NAME, MANAGER_ID)
        SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
        FROM EMPLOYEE
        WHERE DEPT_CODE = 'D1';

-- INSERT ALL 예시2

-- EMPLOYEE테이블의 구조를 복사하여 사번, 이름, 입사일, 급여를 기록할 수 있는
-- 테이블 EMP_OLD와 EMP_NEW 생성
CREATE TABLE EMP_OLD
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
   FROM EMPLOYEE
   WHERE 1 = 0;
   
CREATE TABLE EMP_NEW
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
   FROM EMPLOYEE
   WHERE 1 = 0;

-- EMPLOYEE테이블의 입사일 기준으로 2000년 1월 1일 이전에 입사한 사원의 사번, 이름,
-- 입사일, 급여를 조회해서 EMP_OLD테이블에 삽입하고 그 후에 입사한 사원의 정보는 
-- EMP_NEW테이블에 삽입
INSERT ALL
WHEN HIRE_DATE < '2000/01/01' THEN
	INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
WHEN HIRE_DATE >= '2000/01/01' THEN
	INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
FROM EMPLOYEE;

SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;

COMMIT;

