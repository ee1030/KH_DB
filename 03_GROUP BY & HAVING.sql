/*
    SELCCT문 해석 순서
    
    5 : SELECT 컬럼명 AS 별칭, 계산식, 함수식
    1 : FROM 참조할 테이블명
         + JOIN
    2 : WHERE 컬럼명 | 함수식 | 결과가 TRUE/FALSE
    3 : GROUP BY 그룹을 묶을 컬럼명
    4 : HAVING 그룹함수식 비교연산자 비교값
    6 : ORDER BY 컬럼명 | 컬럼순서 | 별칭 정렬방식 [NULLS FIRST|LAST]
*/

--------------------------------------------------------------------------------

-- GROUP BY

-- 부서별 급여 합 조회
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

/*
    GROUP BY절 : 같은 값들이 여러개 기록된 컬럼을 가지고
                 같은 컬럼값을 하나의 그룹으로 묶는 구문.
                 
    GROUP BY 컬럼명 | 함수식[, 컬럼명 | 함수식, ...]
    
    - GROUP BY로 나눠진 그룹 수 만큼 그룹 함수 결과가 조회됨.
    
    ** GROUP BY사용 시
    SELECT 절에는 GROUP BY에 작성된 컬럼명 또는 그룹함수만 작성 가능함
*/

-- EMPLOYEE 테이블에서
-- 부서코드, 부서별 급여함, 부서별 급여 평균, 부서별 인원 수
-- 부서코드 순으로 조회
SELECT DEPT_CODE, SUM(SALARY) "급여 합",
    FLOOR(AVG(SALARY)) "급여 평균",
    COUNT(*) "인원 수"
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- EMPLOYEE 테이블에서
-- 부서별로 보너스를 받는 사원의 수를
-- 부서 역순으로 조회
SELECT DEPT_CODE, COUNT(BONUS)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE DESC NULLS LAST;

-- EMPLOYEE 테이블에서
-- 각 성별의 급여 평균, 급여 합, 인원 수를
-- 인원 수 내림차순으로 조회
SELECT DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남자', '2', '여자') 성별,
FLOOR(AVG(SALARY)) "급여 평균", SUM(SALARY) "급여 합", COUNT(*) "인원 수"
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남자', '2', '여자')
ORDER BY 4 DESC;

--------------------------------------------------------------------------------

-- WHERE절과 GROUP BY절 혼합사용
-- - WHERE절이 해석 우선순위가 더 높음!
     --> 각 컬럼값에 대한 조건을 만들 때 사용하는게 WHERE절이다.

-- EMPLOYEE 테이블에서 부서코드가 'D5', 'D6'인 부서의 급여 평균 조회
SELECT DEPT_CODE, FLOOR(AVG(SALARY))
FROM EMPLOYEE
WHERE DEPT_CODE IN('D5', 'D6')
GROUP BY DEPT_CODE;

-- EMPLOYEE 테이블에서
-- 직급 코드별 2000년도 부터 입사한 입사자들의 급여 합을
-- 직급코드 오름차순으로 조회
SELECT JOB_CODE "직급 코드", SUM(SALARY)"급여 합"
FROM EMPLOYEE
WHERE EXTRACT(YEAR FROM HIRE_DATE) >= 2000
-- WHERE HIRE_DATE >= TO_DATE('20000101', 'YYYYMMDD')
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

--------------------------------------------------------------------------------

-- 여러 컬럼을 묶어서 그룹으로 지정하는 경우

-- EMPLOYEE 테이블에서
-- 부서별로 특정 직급코드의 인원 수와 급여 합을
-- 부서코드 오름차순, 직급코드 내림차순으로 조회
SELECT DEPT_CODE, JOB_CODE, COUNT(*) "인원 수", SUM(SALARY) "급여 함"
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY DEPT_CODE, JOB_CODE DESC;

-- ** GROUP BY절에 작성되지 않은 컬럼은 SELECT절에 작성할 수 없다~~!~!~!~!~!

-- EMPLPYEE 테이블에서 부서 별로 급여 등급이 같은 직원의 수를
-- 부서코드별 급여 등급 오름차순으로 정렬

SELECT DEPT_CODE, SAL_LEVEL, COUNT(*) "인원 수"
FROM EMPLOYEE
GROUP BY DEPT_CODE, SAL_LEVEL
ORDER BY DEPT_CODE, SAL_LEVEL;

--------------------------------------------------------------------------------

/*
    HAVING 절 : 그룹에 대한 조건을 설정할 때 사용하는 구문
    
    HAVING 컬럼명 | 함수식
*/

-- EMPLOYEE 테이블에서 부서별 급여 평균이 3백만 이상인 부서를
-- 부서코드 오름차순으로 조회
SELECT DEPT_CODE, FLOOR(AVG(SALARY)) "부서 급여 평균"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING FLOOR(AVG(SALARY)) >= 3000000
ORDER BY DEPT_CODE;

-- EMPLOYEE 테이블에서 부서별 급여 합이 9백만 초과인 부서를
-- 부서코드 오름차순으로 조회
SELECT DEPT_CODE, TO_CHAR(SUM(SALARY), 'L999,999,999') "급여 합"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) > 9000000
ORDER BY DEPT_CODE;

-- 1. EMPLOYEE 테이블에서 각 부서별 가장 높은 급여, 가장 낮은 급여를 조회하여
-- 부서 코드 오름차순으로 정렬하세요.
SELECT DEPT_CODE, MAX(SALARY) "최고 급여", MIN(SALARY) "최소 급여"
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;


-- 2. EMPLOYEE 테이블에서 각 직급별 보너스를 받는 사원의 수를 조회하여
-- 직급코드 오름차순으로 정렬하세요
SELECT JOB_CODE, COUNT(BONUS) "사원 수"
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-- 3. EMPLOYEE 테이블에서 
-- 부서별 70년대생의 급여 평균이 300만 이상인 부서를 조회하여
-- 부서 코드 오름차순으로 정렬하세요
SELECT DEPT_CODE, TO_CHAR(FLOOR(AVG(SALARY)), 'L999,999,999') "급여 평균"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 1, 2) BETWEEN 70 AND 79
GROUP BY DEPT_CODE
HAVING FLOOR(AVG(SALARY)) >= 3000000
ORDER BY DEPT_CODE;

--------------------------------------------------------------------------------

-- 집계함수
-- 그룹 별 산출 결과를 계산하는 함수
-- GROUP BY절에만 작성 가능한 함수

-- EMPLOYEE 테이블에서 직급별 급여 합을
-- 직급 코드 오름차순으로 조회
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-- 모든 직원의 급여 합 조회
SELECT SUM(SALARY) FROM EMPLOYEE;

-- ROLLUP 집계 함수 : 
-- 그룹별 '중간 집계'와 '전체 집계'를 계산하여 결과를 행에 자동 추가해주는 함수

SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE)
ORDER BY JOB_CODE;

-- EMPLOYEE 테이블에서
-- 각 부서에 소속된 직급별 급여 합을 조회.
-- 단, 부서별 급여 합,
-- 직급별 급여 합,
-- 전체 급여 합 결과를 추가
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY 1;

