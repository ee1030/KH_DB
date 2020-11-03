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
ORDER BY 1;

-- 예제 2-3
-- 대리 직급의 직원들 중에서 과장 직급의 최소 급여보다 많이 받는 직원의
-- 사번, 이름, 직급, 급여를 조회

-- 1) 직급이 '대리'인 직원의 사번, 이름, 직급명, 급여 조회
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
NATURAL JOIN JOB
WHERE JOB_NAME = '대리';

-- 2) 직급이 과장인 직원들의 급여 조회
SELECT SALARY
FROM EMPLOYEE
NATURAL JOIN JOB
WHERE JOB_NAME = '과장';

-- 3) MIN을 이용하여 조회
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
NATURAL JOIN JOB
WHERE JOB_NAME = '대리'
AND SALARY > (SELECT MIN(SALARY)
              FROM EMPLOYEE
              NATURAL JOIN JOB
              WHERE JOB_NAME = '과장');

-- 4) > ANY를 이용하여 과장 중 가장 적은 급여보다 초과해서 받는 대리
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
NATURAL JOIN JOB
WHERE JOB_NAME = '대리'
AND SALARY > ANY (SELECT SALARY
              FROM EMPLOYEE
              NATURAL JOIN JOB
              WHERE JOB_NAME = '과장');

-- 예제 2-4
-- 차장 직급을 가진 직원들 중 가장 많이 받는 차장 보다
-- 더 많이 받는 과장의 사번, 이름, 직급, 급여 조회
-- (> ALL, < ALL)
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
NATURAL JOIN JOB
WHERE JOB_NAME = '과장'
AND SALARY > ALL (SELECT SALARY
                  FROM EMPLOYEE
                  NATURAL JOIN JOB
                  WHERE JOB_NAME = '차장');

-- 서브쿼리 응용 예제

-- LOCATION 테이블에서 NATIONAL_CODE가 KO인 경우의 LOCAL_CODE와
-- DEPARTMENT 테이블의 LOCATION_ID와 동일한 DEPT_ID가 
-- EMPLOYEE테이블의 DEPT_CODE와 동일한 사원을 구하시오.

-- 1) LOCATION 테이블에서 NATIONAL_CODE가 KO인 경우의 LOCAL_CODE
SELECT LOCAL_CODE
FROM LOCATION
WHERE NATIONAL_CODE = 'KO';

-- 2) DEPARTMENT 테이블의 LOCATION_ID와 동일한 DEPT_ID
SELECT DEPT_ID
FROM DEPARTMENT
WHERE LOCATION_ID = (SELECT LOCAL_CODE
                     FROM LOCATION
                     WHERE NATIONAL_CODE = 'KO');
                     

-- 3) EMPLOYEE 테이블의 DEPT_CODE와 동일한 사원정보 조회                     
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE IN (SELECT DEPT_ID
                    FROM DEPARTMENT
                    WHERE LOCATION_ID = (SELECT LOCAL_CODE
                                         FROM LOCATION
                                         WHERE NATIONAL_CODE = 'KO'));
                                         --> 다중행 서브쿼리

--------------------------------------------------------------------------------

/*
    3. 다중열 서브쿼리(MULTI COLUMN SUBQUERY)
    - 서브쿼리 SELECT절에 나열된 컬럼 수가 여러 개인 서브쿼리
*/

-- 퇴사한 여직원과 같은 부서, 같은 직급에 해당하는
-- 사원의 이름, 직급, 부서, 입사일을 조회

-- 1) 퇴사한 여직원의 이름, 부서코드, 직급코드 조회
SELECT EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE ENT_YN = 'Y'
AND SUBSTR(EMP_NO, 8, 1) = '2';

-- 2) 퇴사한 직원과 같은 부서, 같은 직급
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE 
    -- 같은 부서 
    DEPT_CODE = (SELECT DEPT_CODE
                 FROM EMPLOYEE
                 WHERE ENT_YN = 'Y'
                 AND SUBSTR(EMP_NO, 8, 1) = '2')
AND
    -- 같은 직급
    JOB_CODE = (SELECT JOB_CODE
                 FROM EMPLOYEE
                 WHERE ENT_YN = 'Y'
                 AND SUBSTR(EMP_NO, 8, 1) = '2')
AND 
    ENT_YN != 'Y';

-- 3) 다중열 서브쿼리로 작성
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE
                                 FROM EMPLOYEE
                                 WHERE ENT_YN = 'Y'
                                 AND SUBSTR(EMP_NO, 8, 1) = '2')
AND ENT_YN != 'Y';

--------------------------------------------------------------------------------

-- 4. 다중행 다중열 서브쿼리

-- 본인 직급의 평균 급여를 받고 있는 직원의
-- 사번, 이름, 직급코드, 급여를 조회
-- 단, 급여와 급여 평균은 만원 단위까지만 계산. (TRUNC(컬럼명, -4))

-- 1) 급여를 200, 600만 받는 직원을 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY IN (2000000, 6000000);

-- 2) 직급별 평균 급여(만원 단위까지만 계산)
SELECT JOB_CODE, TRUNC(AVG(SALARY), -4)
FROM EMPLOYEE
GROUP BY JOB_CODE; --> 서브쿼리

-- 3) 1, 2 쿼리를 하나로 합침
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN 
                (SELECT JOB_CODE, TRUNC(AVG(SALARY), -4)
                 FROM EMPLOYEE
                 GROUP BY JOB_CODE);

-- 각 부서별 최고 급여를 받는 사원을 조회하시오(단, 부서별 오름차순 정렬 하시오)
-- 사번, 사원명, 부서코드, 급여
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE (NVL(DEPT_CODE, 0), SALARY) IN 
                    (SELECT NVL(DEPT_CODE, 0), MAX(SALARY)
                     FROM EMPLOYEE
                     GROUP BY DEPT_CODE)
ORDER BY DEPT_CODE;
-- 다중열 서브쿼리 연산시 NULL 데이터가 하나라도 있으면 조회되지 않음.

--------------------------------------------------------------------------------

-- 5. 상관 서브쿼리(상호연관 서브쿼리)
-- 상관 쿼리는 메인 쿼리가 사용하는 테이블 값을 서브 쿼리가 이용해서 결과를 만듦.
-- 메인쿼리의 테이블 값이 변경되면 서브쿼리 결과 값도 변경되는 구조.

-- ** 상관쿼리는 먼저 메인쿼리의 한 행을 조회하고
-- 해당 행이 서브쿼리의 조건을 충족하는지 확인하여 SELECT를 진행함.

-- 예제 5-1.
-- 관리자가 EMPLOYEE 테이블에 있는 직원의 사번, 이름, 부서명, 관리자 번호 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, MANAGER_ID
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
-- EXISTS : 서브쿼리에 해당하는 행이 적어도 1개 이상 존재할 경우 충족되는 SELECT가 실행
WHERE EXISTS (SELECT EMP_ID
              FROM EMPLOYEE M
              WHERE E.MANAGER_ID = M.EMP_ID);
              
-- 예제 5-2.
-- 직급별 급여 평균보다 급여를 많이 받는 직원의
-- 이름, 직급코드, 급여 조회
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE E
WHERE SALARY > (SELECT AVG(SALARY)
                FROM EMPLOYEE M
                WHERE E.JOB_CODE = M.JOB_CODE);
                
--------------------------------------------------------------------------------

-- 6. 스칼라 서브쿼리
-- SELECT절에 사용되는 단일행 서브쿼리(1행)
-- SQL에서는 단일 값을 가리켜 '스칼라'라고 함.

-- 예제 6-1.
-- 모든 사원의 사번, 이름, 관리자번호, 관리자명을 조회
-- 단, 관리자가 없는 경우 '없음'으로 표시
SELECT EMP_ID, EMP_NAME, MANAGER_ID,
        NVL((SELECT M.EMP_NAME
            FROM EMPLOYEE M
            WHERE E.MANAGER_ID = M.EMP_ID), '없음') 관리자명
FROM EMPLOYEE E
ORDER BY 1;

-- 예제 6-2.
-- 각 직원들이 속한 직급의 급여 평균을 조회(소수점 아래 내림)
SELECT EMP_NAME, JOB_CODE, FLOOR((SELECT AVG(SALARY)
                            FROM EMPLOYEE M
                            WHERE E.JOB_CODE = M.JOB_CODE)) "직급 급여 평균"
FROM EMPLOYEE E;

--------------------------------------------------------------------------------

-- 7. 인라인 뷰(INLINE VIEW)
-- FROM절에 사용하는 서브쿼리
-- 서브쿼리가 만든 결과의 집합(RESULT SET)을 테이블 대신 활용

SELECT 사번, 급여
FROM (SELECT EMP_ID 사번, EMP_NAME 이름, SALARY 급여
      FROM EMPLOYEE
      WHERE SALARY >= 3000000)
WHERE 급여 < 4000000;
      

SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- 예제 7-1 : 인라인 뷰를 이용한 TOP-N 분석

-- 전 직원 중 급여가 높은 상위 5명의
-- 순위, 이름, 급여 조회

-- * ROWNUM : 조회된 순서대로 1부터 1씩 증가하는 번호를 매기는 컬럼

-- ROWNUM 주의사항1 : ORDER BY절보다 먼저 해석되어 번호를 부여함
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC;

SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;

--> 인라인뷰 사용하기
SELECT * FROM EMPLOYEE
ORDER BY SALARY DESC;

SELECT ROWNUM, EMP_NAME, SALARY
FROM (SELECT *
      FROM EMPLOYEE
      ORDER BY SALARY DESC)
WHERE ROWNUM <= 5;

-- 예제 7-2.
-- 급여 평균이 3위 안에 드는 부서의 부서코드, 부서명, 급여 평균 조회
SELECT ROWNUM, DEPT_CODE, DEPT_TITLE, 평균
FROM(SELECT DEPT_CODE, DEPT_TITLE, FLOOR(AVG(SALARY)) 평균
     FROM EMPLOYEE
     JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
     GROUP BY DEPT_CODE, DEPT_TITLE
     ORDER BY AVG(SALARY) DESC)
WHERE ROWNUM <= 3;

--------------------------------------------------------------------------------

-- 8. WITH
-- 서브쿼리에 이름을 붙여주고 사용시 이름을 호출하게함.
-- 주로 인라인 뷰로 사용될 서브쿼리에 사용함.
-- 실행속도도 빨라짐.

-- 전 직원의 급여 순위 TOP 10 조회

WITH TOPN_SAL AS(SELECT EMP_ID, EMP_NAME, SALARY
                 FROM EMPLOYEE
                 ORDER BY SALARY DESC)
SELECT ROWNUM, EMP_ID, EMP_NAME, SALARY
FROM TOPN_SAL
WHERE ROWNUM <= 10;

--------------------------------------------------------------------------------

-- 9. RANK() OVER / DENSE_RACK() OVER

-- RANK() OVER : 동일한 순위 이후 등수를 동일한 인원 수 만큼 건너 뛰고 순위 계산
                    -- EX) 공동 1위가 2명이면 다음 순위는 3위
                    
-- DENSE_RACK() OVER : 동일한 순위 이후 등수를 건너 뛰지 않고 순위 계산
                    -- EX) 공동 1위가 2명이면 다음 순위는 2위
                    
-- 전체 급여 순위
SELECT EMP_NAME, SALARY,
    RANK() OVER(ORDER BY SALARY DESC) 순위 -- 급여 내림차순으로 순위 부여
FROM EMPLOYEE;

SELECT EMP_NAME, SALARY,
    DENSE_RANK() OVER(ORDER BY SALARY DESC) 순위 -- 급여 내림차순으로 순위 부여
FROM EMPLOYEE;

--------------------------------------------------------------------------------

-- 1번문제
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '전지연')
AND EMP_NAME != '전지연'
ORDER BY 1;

-- 2번 문제

SELECT EMP_ID, EMP_NAME, PHONE, SALARY, JOB_NAME
FROM EMPLOYEE
NATURAL JOIN JOB
WHERE SALARY = (SELECT MAX(SALARY)
                FROM EMPLOYEE
                WHERE HIRE_DATE >= '00/01/01');

-- 3번문제

SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
NATURAL JOIN JOB
WHERE (DEPT_CODE, JOB_CODE) IN ( SELECT DEPT_CODE, JOB_CODE
                                 FROM EMPLOYEE
                                 WHERE EMP_NAME = '노옹철')
AND EMP_NAME != '노옹철';
                                 
-- 4번문제

SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE
                               FROM EMPLOYEE
                               WHERE SUBSTR(HIRE_DATE, 1, 2) = 00);

-- 5번문제

SELECT EMP_ID, EMP_NAME, MANAGER_ID, EMP_NO, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, MANAGER_ID) = (SELECT DEPT_CODE, MANAGER_ID
                                 FROM EMPLOYEE
                                 WHERE SUBSTR(EMP_NO, 1, 2) = 77
                                 AND SUBSTR(EMP_NO, 8, 1) = 2);

-- 6번문제

SELECT EMP_ID, EMP_NAME, NVL(DEPT_TITLE, '소속없음'), JOB_NAME, HIRE_DATE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE)
WHERE (NVL(DEPT_CODE, 0), HIRE_DATE) IN (SELECT NVL(DEPT_CODE, 0), MIN(HIRE_DATE)
                                    FROM EMPLOYEE
                                    WHERE ENT_YN != 'Y'
                                    GROUP BY DEPT_CODE)
ORDER BY HIRE_DATE;

-- 7번문제
SELECT JOB_CODE, MIN(CEIL(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 6)))/12)) 나이
FROM EMPLOYEE
GROUP BY JOB_CODE;

SELECT EMP_ID, EMP_NAME, JOB_NAME, 
CEIL(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 6)))/12) 나이,
TO_CHAR(SALARY*(1+NVL(BONUS, 0))*12, 'L999,999,999') 연봉
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE (JOB_CODE, CEIL(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 6)))/12))
IN ( SELECT JOB_CODE, MIN(CEIL(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 6)))/12))
     FROM EMPLOYEE
     GROUP BY JOB_CODE)
ORDER BY 나이 DESC;


