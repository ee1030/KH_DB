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
GROUP BY JOB_CODE
ORDER BY JOB_CODE;







