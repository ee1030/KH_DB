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
WHERE DEPT_CODE != 'D9';

-- EMPLOYEE 테이블에서 퇴사한 사원의
-- 이름, 전화번호, 부서코드 조회
SELECT EMP_NAME 이름, PHONE 전화번호, DEPT_CODE 부서코드
FROM EMPLOYEE
WHERE ENT_YN = 'N';


-- 1. EMPLOYEE 테이블에서 SAL_LEVEL이 S1인 사원의
-- 이름, 월급 고용일, 연락처 조회
SELECT EMP_NAME 이름, SALARY 월급, HIRE_DATE 고용일, PHONE 연락처
FROM EMPLOYEE
WHERE SAL_LEVEL = 'S1';

-- 2. EMPLOYEE 테이블에서 월급이 3000000이상인 사원의
-- 이름, 월금, 고용일 조회
SELECT EMP_NAME 이름, SALARY 월급, HIRE_DATE 고용일
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- 3. EMPLOYEE 테이블에서 연봉이 5천만원 미만인 사원의
-- 이름, 월급, 연봉, 고용일 조회
SELECT EMP_NAME 이름, SALARY 월급, SALARY*12 연봉, HIRE_DATE 고용일
FROM EMPLOYEE
WHERE SALARY*12 < 50000000;

------------------------------------------------------------------------------

-- 논리 연산자(AND / OR)
-- 여러가지 조건이 있을 경우 사용하는 연산자

-- EMPLOYEE 테이블에서
-- 부서코드가 'D6'이고
-- 급여를 200만 이상 받는 직원의
-- 사번, 이름, 부서코드, 급여 조회
SELECT EMP_ID 사번, EMP_NAME 이름, DEPT_CODE 부서코드, SALARY 급여
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' AND SALARY >= 2000000;

-- EMPLOYEE 테이블에서
-- 급여를 350만 이상 600만 이하로 받는 직원의
-- 사번 이름 급여 부서코드 직급코드 조회
SELECT EMP_ID 사번, EMP_NAME 이름,SALARY 급여, DEPT_CODE 부서코드, JOB_CODE 직급코드
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000;

-- EMPLOYEE 테이블에
-- 부서코드가 D5 또는 D9인 사원 중
-- 고용일이 2002년 1월 1일보다 빠른 사원
-- 사번, 이름, 부서코드, 고용일 조회
SELECT EMP_ID 사번, EMP_NAME 이름, DEPT_CODE 부서코드, HIRE_DATE 고용일
FROM EMPLOYEE
WHERE (DEPT_CODE = 'D5' OR DEPT_CODE = 'D9') AND HIRE_DATE < '02/01/01';

-- BETWEEN A AND B
-- >> A 이상 B 이하
-- EMPLOYEE 테이블에서
-- 급여를 350만 이상 600만 이하로 받는 사원의
-- 사번, 이름, 급여, 부서코드, 직급코드 조회
SELECT EMP_ID 사번, EMP_NAME 이름, SALARY 급여, DEPT_CODE 부서코드, JOB_CODE 직급코드
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;

-- NOT (논리 부정 연산자)
-- EMPLOYEE 테이블에서
-- 급여를 350만 미만 600만 초과로 받는 사원의
-- 사번, 이름, 급여, 부서코드, 직급코드 조회

SELECT EMP_ID 사번, EMP_NAME 이름, SALARY 급여, DEPT_CODE 부서코드, JOB_CODE 직급코드
FROM EMPLOYEE
WHERE SALARY NOT BETWEEN 3500000 AND 6000000;

-- EMPLOYEE 테이블에서
-- 입사일이 '90/01/01' ~ '99/12/31'인
-- 사원의 이름, 입사일 조회
SELECT EMP_NAME 이름, HIRE_DATE 입사일
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '99/12/31';

-- NOT 연습
SELECT EMP_NAME 이름, HIRE_DATE 입사일
FROM EMPLOYEE
WHERE NOT HIRE_DATE BETWEEN '90/01/01' AND '99/12/31';

-- 연결 연산자( || )
-- 여러 컬럼을 하나의 컬럼처럼 연결하거나
-- 컬럼 + 리터럴의 형태를 만들 수 있는 연산자

-- EMPLOYEE 테이블에서 사번, 이름, 급여를 연결해서 조회
SELECT EMP_ID || EMP_NAME || SALARY 합체
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서
-- 모든 사원의 이름, 급여 조회
-- 단, 급여 뒤에 '(원)' 단위 붙여서 조회
SELECT EMP_NAME 이름, SALARY || '(원)' 급여
FROM EMPLOYEE;

