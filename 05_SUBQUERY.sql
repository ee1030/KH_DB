/*
    * SUNQUERY(서브쿼리)
    - 하나의 SQL문 안에 포함된 또다른 SQL(SELECT)문
    - 메인쿼리를 위해 보조하는 역할로 사용하는 쿼리문
*/

-- 서브쿼리 예시
-- 부서코드가 '노옹철' 사원과 같은 직원의
-- 사번, 이름, 부서코드 조회

-- 1) 노옹철의 부서코드 조회
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '노옹철'; --> 'D9'

-- 2) 부서코드가 'D9'인 직원들의 사번, 이름, 부서코드 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- 3) 1, 2번 SQL 한번에 작성하기
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '노옹철');
                    
-- 전 직원의 평균 급여보다 많은 급여를 받고 있는 직원의
-- 사번, 이름, 직급코드, 급여 조회

-- 1) 전 직원의 급여 평균
SELECT AVG(SALARY) FROM EMPLOYEE;

-- 2) 직원들 중 급여가 3047662
-- 이상인 사원의 사번, 이름, 직급코드, 급여 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3047662;

-- 3) 1, 2에 작성한 SQL문을 하나로 합치기
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= (SELECT FLOOR(AVG(SALARY)) FROM EMPLOYEE);
                 
--------------------------------------------------------------------------------

/*
    - 단일행 서브쿼리 : 서브쿼리의 조회 결과 행의 개수가 1 ( + 단일열)
    
    - 다중행 서브쿼리 : 서브쿼리의 조회 결과 행의 개수가 N개 일 때 ( + 단일열)
    
    - 다중열 서브쿼리 : 서브쿼리의 SELECT절에 나열된 항목 수가 여러개 일 때
    
    - 다중행 다중열 서브쿼리 : 서브쿼리의 조회 결과가 N행, N열일 때
    
    - 상관(상호연관) 서브쿼리 : 서브쿼리가 만든 결과값을 메인쿼리가 비교연산 할 때
                                메인쿼리의 결과 값이 변경되면
                                서브쿼리에 결과 값에도 영향을 미치는 서브쿼리
    
    - 스칼라 서브쿼리 : SELECT 절에 사용되는 서브쿼리(단일행 서브쿼리)
    
    - 인라인 뷰 : FROM절에 사용되는 서브쿼리
*/

--------------------------------------------------------------------------------

/*
    1. 단일행 서브쿼리(SINGLE ROW SUBQUERY)
    - 서브쿼리의 조회 결과 행의 개수가 1개인 서브쿼리
    - WHERE절에 사용 시 서브쿼리 앞에는 비교 연사자를 사용함.
    ( >, <, >=, <=, =, !=, <>, ^= )
*/

-- 예제 1-1
-- 전 직원의 급여 평균보다 많은 급여를 받는 직원의
-- 이름, 직급명, 부서명, 급여를 직급코드 내림차순으로 정렬하여 조회
SELECT EMP_NAME, JOB_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE
NATURAL JOIN JOB
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE)
ORDER BY JOB_CODE DESC;

-- 예제 1-2
-- 가장 적은 급여를 받는 직원의
-- 사번, 이름, 직급명, 부서명, 급여, 입사일 조회
SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE, SALARY, HIRE_DATE
FROM EMPLOYEE
NATURAL JOIN JOB
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE);
 
-- 예제 1-3
-- 노옹철 사원보다 급여를 많이 받는 사원의
-- 사번, 이름, 부서명, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
WHERE SALARY > (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME = '노옹철');

-- ** 서브쿼리는 WHERE절 뿐만 아니라
-- SELECT, FROM, HAVING절에 작성 가능함.

-- 예제 1-4
-- 부서별(부서 없는 사람 포함) 급여의 합계가
-- 가장 큰 부서의 부서명, 급여 합 조회

-- 1)부서별 급여 합 중 가장 큰 값을 조회
SELECT MAX(SUM(SALARY) )
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 2) 부서별 급여 합이 17700000원인 부서의 부서명과 급여 합 조회
SELECT DEPT_TITLE, SUM(SALARY) "급여 합"
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) = 17700000;

-- 1, 2 합치기
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY)) FROM EMPLOYEE GROUP BY DEPT_CODE);

--------------------------------------------------------------------------------
/*
    2. 다중행 서브쿼리(MULTI ROW SUBQUERY)
    - 서브쿼리의 조회 결과 행의 개수가 여러 개인 서브쿼리
    
    - ** 다중행 서브쿼리에는 일반 비교연산자를 사용할 수 없음.
        
        IN / NOT IN : 여러개의 결과 값중 하나라도 일치하는 값이 있다면 / 없다면
        
        > ANY, < ANY : 여러개의 결과값 중
                        하나라도 큰 / 작은 경우
                        -> 가장 작은 값보다 큰가? 
                            / 가장 큰 값보다 작은가?
                        
        > ALL, < ALL : 여러개의 결과값 중
                        모든 값보다 큰 / 작은 경우
                        -> 가장 큰 값보다 큰가? 
                            / 가장 작은값 보다 작은가
        
        EXISTS / NOT EXISTS : 값이 존재 하는가? / 존재하지 않는가?
*/

-- 예제 2-1
-- 부서별 최고 급여를 받는 직원의
-- 이름, 부서명, 직급명, 급여를 조회

-- 1) 각 부서별 최고 급여 조회
SELECT MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 2) 전체 사원 중 각 부서별 최고 급여와 일치하는 사원의
-- 이름, 부서명, 직급명, 급여를 조회
SELECT EMP_NAME, DEPT_TITLE, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
WHERE SALARY IN(2890000, 3660000, 8000000, 3760000, 3900000, 2490000, 2550000);



SELECT EMP_NAME, DEPT_TITLE, JOB_NAME, SALARY
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE)
WHERE SALARY IN(SELECT MAX(SALARY) FROM EMPLOYEE GROUP BY DEPT_CODE);

-- 예제 2-2
-- 모든 사원에 대해 관리자/직원을 구분하여
-- 사번, 이름, 부서명, 직급명, 구분(관리자/직원)을 조회

-- 1) 관리자에 해당하는 사번을 모두 조회
SELECT DISTINCT MANAGER_ID
FROM EMPLOYEE
WHERE MANAGER_ID IS NOT NULL;

-- 2) 관리자에 해당하는 직원의 
-- 사번, 이름, 부서명, 직급명, 구분(관리자/직원)을 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '관리자' 구분
FROM EMPLOYEE
NATURAL JOIN JOB
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
WHERE EMP_ID IN(SELECT DISTINCT MANAGER_ID
                FROM EMPLOYEE
                WHERE MANAGER_ID IS NOT NULL);

-- 3) 직원에 해당하는 사원의
-- 사번, 이름, 부서명, 직급명, 구분(관리자/직원)을 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '직원' 구분
FROM EMPLOYEE
NATURAL JOIN JOB
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
WHERE EMP_ID NOT IN(SELECT DISTINCT MANAGER_ID
                FROM EMPLOYEE
                WHERE MANAGER_ID IS NOT NULL);

-- 4) 2, 3 조회 결과를 하나로 합침

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '관리자' 구분
FROM EMPLOYEE
NATURAL JOIN JOB
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
WHERE EMP_ID IN(SELECT DISTINCT MANAGER_ID
                FROM EMPLOYEE
                WHERE MANAGER_ID IS NOT NULL)
UNION
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '직원' 구분
FROM EMPLOYEE
NATURAL JOIN JOB
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
WHERE EMP_ID NOT IN(SELECT DISTINCT MANAGER_ID
                FROM EMPLOYEE
                WHERE MANAGER_ID IS NOT NULL);

-- 5) SELECT절에 서브쿼리 사용한 형태
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME,
    CASE WHEN EMP_ID IN (SELECT DISTINCT MANAGER_ID
                         FROM EMPLOYEE
                         WHERE MANAGER_ID IS NOT NULL) THEN '관리자'
         ELSE '직원'
    END 구분
FROM EMPLOYEE
NATURAL JOIN JOB
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)





