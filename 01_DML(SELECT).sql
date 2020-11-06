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

------------------------------------------------------------------------------

-- LIKE(★★★★★)

/*
비교하려는 값이 지정한 특정 패턴을 만족시키는 데이터를 조회할 때 사용

비교대상컬럼명 LIKE '문자 패턴'

와일드카드 '%', '_'

패턴 1) %
'김%' (김 으로 시작하는 값)
'%김' (김 으로 끝나는 값)
'%김%' (김 이라는 글자가 포함되는 값)

패턴 2) _ 언더바
'_' (한글자)
'__' (두글자)
'김__' (김 으로 시작하는 세글자)

    0101234[1]234
    PHONE LIKE '_______1%'

*/

-- EMPLOYEE 테이블에서
-- 성이 '전'씨인 사원의 사번, 이름, 부서코드 조회
SELECT EMP_ID 사번, EMP_NAME 이름, DEPT_CODE 부서코드
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';

-- EMPLOYEE 테이블에서
-- 이름에 '하'가 포함된 사원의 사번, 이름, 부서코드 조회
SELECT EMP_ID 사번, EMP_NAME 이름, DEPT_CODE 부서코드
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%';

-- EMPLOYEE 테이블에서
-- 전화번호 4번째 자리가 7로 시작하는 사원의
-- 사번, 이름, 전화번호를 조회
SELECT EMP_ID 사번, EMP_NAME 이름, PHONE 전화번호
FROM EMPLOYEE
WHERE PHONE LIKE '___7%';


-- ESCAPE OPTIONS
-- LIKE의 와일드카드 기호와, 검색하려는 기호가 동일할 경우
-- 검색기호를 인식 시키기 위해서 사용하는 구문

-- EMPLOYEE 테이블에서
-- EMAIL 중 '_' 기호 앞이 세글자인 사원의
-- 사번, 이름, 이메일 조회
SELECT EMP_ID 사번, EMP_NAME 이름, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___#_%' ESCAPE '#';

-- NOT LIKE
SELECT EMP_ID 사번, EMP_NAME 이름, EMAIL
FROM EMPLOYEE
WHERE EMAIL NOT LIKE '___#_%' ESCAPE '#';

-- EMPLOYEE 테이블에서
-- 성이 '김'씨가 아닌 사원의 모든 정보 조회
SELECT *
FROM EMPLOYEE
WHERE EMP_NAME NOT LIKE '김%';

-- EMPLOYEE 테이블에서
-- 이름 끝이 '연' 으로 끝나는 사원의 이름 조회
SELECT EMP_NAME 이름
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';

-- EMPLOYEE 테이블에서
-- 전화번호 처음 세자리가 010이 아닌 사원의 이름 조회, 전화번호 조회
SELECT EMP_NAME 이름, PHONE 전화번호
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

-- EMPLOYEE 테이블에서
-- 메일주소의 '_'의 앞이 네 글자 이면서 DEPT_CODE가 D9 또는 D6이고
-- 고용일이 90/01/01 ~ 00/12/01이고
-- 급여가 270만 이상인 사원의 전체 정보 조회
SELECT
    *
FROM
    employee
WHERE
    email LIKE '____#_%' ESCAPE '#'
    AND ( dept_code = 'D9'
          OR dept_code = 'D6' )
    AND hire_date BETWEEN '90/01/01' AND '00/12/01'
    AND salary >= 2700000;

------------------------------------------------------------------------------

-- IS NOT NULL : 컬럼값이 NULL이 아닌경우

-- EMPLOYEE 테이블에서
-- 보너스를 받지 않는 사원의 사번, 이름, 급여, 보너스 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;

-- EMPLOYEE 테이블에서
-- 사수(직속상관)이 없고, 부서코드도 없는 사원의
-- 사원명, 사수 사번, 부서코드 조회
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

-- IN
-- 비교하려는 컬럼값과 목록(괄호 내부)에 일치하는 값이 있다면 TRUE를 반환하는 연산자
-- 컬럼명 IN (A, B, C, D, ...)

-- EMPLOYEE 테이블에서
-- 부서코드가 D6, D8, D9인 사원의
-- 사번, 이름, 부서코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8' OR DEPT_CODE = 'D9';

-- IN 사용
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D6', 'D8', 'D9');

-- 연산자 우선순위

/*
1. 산술
2. 연결 ||
3. 비교 =, !=, ^=, <>, >, <, >=, <=
4. IS NULL, LIKE, IN
5. BETWEEN A AND B
6. NOT 
7. AND
8. OR
*/

------------------------------------------------------------------------------

-- ORDER BY 절(★★★★★)
    -- SELECT한 결과의 집합(RESULT SET)을 정렬할때 사용하는 구문
    -- SELECT 구문 제일 마지막 줄에 작성
    -- SELECT문 해석 순서 중에서도 제일 마지막
    
-- [작성법]

/*
SELECT 컬럼명, [컬럼명, ...]
FROM 테이블명
[WHERE 조건식]
[ORDER BY 컬럼명 | 별칭 | 컬럼 순서 정렬방법(오름차순, 내림차순) [NULLS FIRST | LAST]
*/

-- EMPLOYEE 테이블에서
-- 모든 사원의 이름, 급여, 부서코드를 이름 오름차순으로 출력
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
ORDER BY EMP_NAME /*ASC*/; -- 오름차순이 기본값이다.

SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
ORDER BY 1; -- 조회한 컬럼 중 첫번재(EMP_NAME)를 기준으로 정렬

-- EMP_NAME 내림차순
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
ORDER BY 1 DESC;

-- EMPLOYEE 테이블에서
-- 모든 사원의 이름, 연봉, 부서코드를
-- 부서코드 내림차순으로 정렬하여 조회
SELECT EMP_NAME, SALARY*12 연봉, DEPT_CODE
FROM EMPLOYEE
ORDER BY DEPT_CODE DESC NULLS LAST;

-- EMPLOYEE 테이블에서
-- 모든 사원의 이름, 연봉, 부서코드를
-- 연봉 내림차순으로 정렬하여 조회
SELECT EMP_NAME, SALARY*12 연봉, DEPT_CODE
FROM EMPLOYEE
ORDER BY 연봉 DESC NULLS LAST;

-- EMPLOYEE 테이블에서
-- 모든 사원의 이름, 연봉, 부서코드를
-- 연봉 내림차순으로 정렬하여 조회 단 연봉이 4천만 이상인 사람만
SELECT EMP_NAME, SALARY*12 연봉, DEPT_CODE
FROM EMPLOYEE
WHERE SALARY*12 /*연봉*/ >= 40000000 -- WHERE 절에는 별칭 사용이 불가하다.
ORDER BY 연봉 DESC NULLS LAST;



