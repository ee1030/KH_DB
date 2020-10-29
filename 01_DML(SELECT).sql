-- SELECT (조회)
-- SELECT 구문의 조회 결과 집합 : RESULT SET

/*
SELECT * | 컬럼명[, 컬럼명, ...]
FROM 테이블명
WHERE 조건식;
*/

-- EMPLOYEE 테이블의 모든 사원 정보를 모두 조회
SELECT * FROM EMPLOYEE;

-- EMPLOYEE 테이블의 모든 사원의 사번, 이름 조회
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE;

-- EMPLOYEE 테이블의 모든 사원의 이름, 이메일, 전화번호 조회
SELECT EMP_NAME, EMAIL, PHONE
FROM EMPLOYEE;

-- JOB 테이블의 모든 정보 조회
SELECT * 
FROM JOB;

-- JOB 테이블의 직급명만 조회
SELECT JOB_NAME
FROM JOB;

-- DEPARTMENT 테이블의 모든 정보 조회
SELECT *
FROM DEPARTMENT;

-- EMPLOYEE 테이블의 이름, 이메일, 전화번호, 고용일 조회
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE
FROM EMPLOYEE;

-- EMPLOYEE 테이블의 고용일, 사원명, 월급 조회
SELECT HIRE_DATE, EMP_NAME, SALARY
FROM EMPLOYEE;

------------------------------------------------------------------------------

-- 컬럼 값 산술 연산
-- SELECT 시 컬럼명 부분에
-- 계산이 필요한 컬럼명 + 숫자, 연산자를 이용하여
-- 원하는 계산 결과를 조회할 수 있다.

-- EMPLOYEE 테이블에서 사원들의 이름, 급여, 연봉 조회
SELECT EMP_NAME, SALARY, SALARY*12
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 사원의 이름과, 보너스가 반영된 연봉을 조회
SELECT EMP_NAME, SALARY*12, (SALARY + SALARY*BONUS) * 12
FROM EMPLOYEE;
-- DB에서 산술 연산 시 NULL 값이 포함되어 있다면
-- 결과는 무조건 NULL이 나온다.

-- EMPLOYEE 테이블에서 사원의 이름, 고용일, 근무 일수 조회
SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE
FROM EMPLOYEE;

------------------------------------------------------------------------------

/* 컬럼 별칭

    컬럼명 별칭 / 컬럼명 AS 별칭     /     컬럼명 "별칭" / 컬럼명 AS "별칭"
       특수문자, 띄어쓰기X                     특수문자, 띄어쓰기 O
    
    
*/

-- EMPLOYEE 테이블에서 사원의 이름, 입사일, 근무 일수 조회
SELECT EMP_NAME AS 이름, HIRE_DATE 입사일, SYSDATE - HIRE_DATE "근무 일수"
FROM EMPLOYEE;

------------------------------------------------------------------------------

-- 리터럴
-- 임의로 지정한 문자열을 SELECT절에 사용하면
-- 테이블에 존재하는 데이터 처럼 사용할 수 있음.
-- 리터럴의 표기 기호는 ''(홀따옴표)
-- 리터럴은 result set의 모든 결과 행에 반복적으로 표시됨

-- EMPLOYEE 테이블에서
-- 사번, 사원명, 급여, 단위(데이터 : 원) 조회
SELECT EMP_ID, EMP_NAME, SALARY, '원' AS 단위
FROM EMPLOYEE;

-- DISTINCT
-- 컬럼에 포함된 중복 값을 한 번만 표시하고자 할 때 사용

-- EMPLOYEE 테이블에서 직원의 직급 코드를 조회
SELECT JOB_CODE FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 직원의 직급 코드를 조회
SELECT DISTINCT JOB_CODE FROM EMPLOYEE;

-- * DISTINCT 주의사항 
--   -> DISTINCT SELECT 구문 하나 당 한 번만 사용 가능

-- DISTINCT는 뒤쪽에 작성된 컬럼명을 모두 묶어서 중복값을 제거하여 출력
SELECT DISTINCT JOB_CODE, DEPT_CODE
FROM EMPLOYEE;

-- WHERE절 
-- 조회할 테이블에서 조건이 맞는 값을 가진 행을 골라내는 구문

-- WHERE절에는 TRUE, FALSE가 나올 수 있는
-- 비교 연산자가 사용됨.
-- >, <, >=, =<
-- = (같다), !=, ^=, <> (같지 않다)

-- EMPLOYEE 테이블에서
-- 부서코드가 'D9'인 직원의 사번, 이름, 부서코드 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- 급여가 4백만 이상인 사원의 이름, 급여 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY > 4000000;

-- EMPLOYEE 테이블에서 부서코드가 'D9'이 아닌 사원의
-- 이름, 부서코드 조회
SELECT EMP_NAME 이름, DEPT_CODE "부서 코드"
FROM EMPLOYEE
WHERE DEPT_CODE <> 'D9';

-- EMPLOYEE 테이블에서 퇴사한 사원의
-- 이름, 전화번호, 부서코드 조회
SELECT EMP_NAME 이름, PHONE 전화번호, DEPT_CODE 부서코드
FROM EMPLOYEE
WHERE ENT_YN = 'Y';