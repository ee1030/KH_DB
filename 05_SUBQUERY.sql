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




