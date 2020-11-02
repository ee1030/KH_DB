/* 
[JOIN 용어 정리]
  오라클       	  	                                SQL : 1999표준(ANSI)
----------------------------------------------------------------------------------------------------------------
등가 조인		                            내부 조인(INNER JOIN), JOIN USING / ON
                                            + 자연 조인(NATURAL JOIN, 등가 조인 방법 중 하나)
----------------------------------------------------------------------------------------------------------------
포괄 조인 		                        왼쪽 외부 조인(LEFT OUTER), 오른쪽 외부 조인(RIGHT OUTER)
                                            + 전체 외부 조인(FULL OUTER, 오라클 구문으로는 사용 못함)
----------------------------------------------------------------------------------------------------------------
자체 조인, 비등가 조인   	                    JOIN ON
----------------------------------------------------------------------------------------------------------------
카테시안(카티션) 곱		               교차 조인(CROSS JOIN)
CARTESIAN PRODUCT

- 미국 국립 표준 협회(American National Standards Institute, ANSI) 미국의 산업 표준을 제정하는 민간단체.
- 국제표준화기구 ISO에 가입되어 있음.


*/

/*
    JOIN 
    - 하나 이상의 테이블에서 데이터를 조회하기 위해 사용하는 구문,
    - 수행 결과는 하나의 RESULT SET으로 나온다.
    
    - 관계형 데이터베이스에서 SQL을 이용해 테이블 간 관계를 맺을 수 있음
    
        -- 관계형 데이터베이스는 데이터 무결성을 위해
           중복되는 데이터 없이 최소한의 데이터를 테이블에 기록
           --> 원하는 정보를 조회하기 위해서 하나 이상의 테이블이 필요한 경우가 많음.
           
        -- 서로 연결된 데이터를 가진 테이블끼리 연결고리를 맺어 필요한 데이터만을 추출함.
           --> JOIN
*/

-- 사번, 사원명, 부서코드, 부서명 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

-- 부서코드, 부서명 조회
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

-- 3) JOIN 사용
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

--------------------------------------------------------------------------------

--          ANSI                  ORACLE
-- 1. 내부 조인(INNER JOIN)(== 등가조인(EQUAL JOIN))
    --> 연결된 컬럼의 값이 일치하는 행들만 조인이 이루어짐.
    --  (컬럼값이 일치하지 않는 행은 조인에서 제외됨.)

-- *ANSI 표준 구문
-- ANSI는 미국 국립 표준 협회를 뜻함, 미국의 산업표준을 제정하는 민간단체로 
-- 국제표준화기구 ISO에 가입되어있다.
-- ANSI에서 제정된 표준을 ANSI라고 하고 
-- 여기서 제정한 표준 중 가장 유명한 것이 ASCII코드이다.

-- *오라클 전용 구문
-- FROM절에 ','로 구분하여 합치게 될 테이블명을 기술하고
-- WHERE절에 합치기에 사용할 컬럼명을 명시한다.

-- 1) 연결에 사용할 두 컬럼명이 다른경우

-- EMPLOYEE, DEPARTMENT 테이블을 참조하여
-- 사번, 이름, 부서코드, 부서명 조회

    -- EMPLOYEE 테이블에서 부서코드 : DEPT_CODE
    -- DEPARTMENT 테이블에서 부서코드 : DEPT_ID
    --> 동일한 컬럼의 의미, 동일한 데이터의 형태를 띔 == 조인이 가능하다.

-- ANSI 방식
-- 연결에 사용할 컬럼명이 다른 경우 
-- JOIN 테이블명 ON(컬럼명1 = 컬럼명2)
SELECT EMP_ID, EMP_NAME, DEPT_ID, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

-- 오라클 방식
SELECT EMP_ID, EMP_NAME, DEPT_ID, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;

-- DEPARTMENT, LOCATION 테이블을 참조하여
-- 부서명, 지역명 조회

-- ANSI
SELECT DEPT_TITLE, LOCAL_NAME
FROM DEPARTMENT
/*INNER*/JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE);

-- ORACLE
SELECT DEPT_TITLE, LOCAL_NAME
FROM DEPARTMENT, LOCATION
WHERE DEPARTMENT.LOCATION_ID = LOCATION.LOCAL_CODE;

-- 2) 연결에 사용할 두 컬럼명이 같을 경우

-- EMPLOYEE, JOB 테이블을 참조하여
-- 사번, 이름, 직급코드, 직급명 조회

-- ANSI
-- 연결에 사용할 컬럼명이 같은 경우
-- JOIN 테이블명 USING(같은컬럼명)
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE);

-- ORACLE
-- 방법 1) 같은 컬럼명을 구분하기 위해 테이블명으로 구분
SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

-- 방법 2) 테이블명에 별칭을 지정하여 구분하는데 사용
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;

--------------------------------------------------------------------------------

/*
    2. 외부조인(OUTER JOIN) == (포괄 조인)
    -- 두 테이블의 지정한 컬럼값이 일치하지 않는 행도 조인에 포함 시킴.
    * OUTER JOIN은 반드시 명시해야함 안하면 지상렬   
*/

-- INNER JOIN과 OUTER JOIN을 비교하기 위한 SQL 구문
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID); -- 21명 조회됨

-- 1) LEFT [OUTER] JOIN
-- 합치기에 사용한 두 테이블 중 왼편에 기술된 테이블의 모든 컬럼을 기준으로 조인
-- (NULL 제외하지 않음)

-- ANSI
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
LEFT /*OUTER*/ JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
-- 23명(이오리, 하동운 추가)

-- ORCALE (+)
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+);
-- 왼쪽(DEPT_CODE)를 기준으로 하여 오른쪽(DEPT_ID)를 맞춰서 추가

-- 2) RIGHT [OUTER] JOIN
-- 합치기에 사용한 두 테이블 중 오른편에 기술된 테이블의 모든 컬럼을 기준으로 조인
-- (NULL 제외하지 않음)

--ANSI
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
RIGHT /*OUTER*/ JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
-- 24행 : 오른쪽에 조인되지 않았던
-- 해외영업3부, 마케팅부, 국내영업부가 추가됨

-- ORCALE (+)
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;

-- 3) FULL [OUTER] JOIN
-- 합치기에 사용한 두 테이블이 가진 모든 행을 결과에 포함
-- LEFT 합집합 RIGHT

-- ANSI
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
FULL /*OUTER*/ JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

-- ORACLE은 FULL OUTER 안됨
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID(+);

--------------------------------------------------------------------------------

-- 3. 교차 조인(CROSS JOIN)(== DARTESIAN PRODUCT. 곱집합)
-- 조인되는 테이블의 각 행들이 모두 매핑된 데이터가 검색되는 방법
SELECT EMP_NAME FROM EMPLOYEE; -- 23행
SELECT DEPT_TITLE FROM DEPARTMENT; -- 9행

SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
CROSS JOIN DEPARTMENT; -- 207행 = 23 * 9

--------------------------------------------------------------------------------

-- 4. 비등가 조인(NON EQAUL JOIN)
-- '='(등호)를 사용하지 않는 조인문
-- 지정한 컬럼 값이 일치하는 경우(등가)가 아닌
-- 지정한 컬럼 값이 일정 범위 내에 포함되는 값일 경우 조인을 수행

-- EMPLOYEE, SAL_GRADE를 참조하여
-- 자신의 급여등급에 맞는 급여를 받고 있는 사람들의
-- 이름, 급여, 급여 등급 조회

SELECT EMP_NAME, SALARY, S.SAL_LEVEL
FROM EMPLOYEE E
JOIN SAL_GRADE S ON(SALARY BETWEEN MIN_SAL AND MAX_SAL);

--------------------------------------------------------------------------------

-- 5. 자체 조인(SELF JOIN)
-- 같은 테이블을 조인

-- EMPLOYEE 테이블에서
-- 사번, 이름, 관리자 사번, 관리자 이름 조회

-- ANSI방식
SELECT E.EMP_ID 사번, E.EMP_NAME 이름, E.MANAGER_ID 관리자사번, M.EMP_NAME 관리자이름
FROM EMPLOYEE E
-- JOIN EMPLOYEE M ON(E.MANAGER_ID = M.EMP_ID); -- 15행(INNER JOIN)
LEFT JOIN EMPLOYEE M ON(E.MANAGER_ID = M.EMP_ID); -- 23행(LEFT OUTER JOIN)

-- ORACLE 방식
SELECT E.EMP_ID, E.EMP_NAME 사원이름, E.DEPT_CODE, E.MANAGER_ID, M.EMP_NAME 관리자이름
FROM EMPLOYEE E, EMPLOYEE M
-- WHERE E.MANAGER_ID = M.EMP_ID; -- 15행(등가 조인)
WHERE E.MANAGER_ID = M.EMP_ID(+); -- 23행(왼쪽 포괄 조인)
--------------------------------------------------------------------------------

-- 6. 자연조인(NATURAL JOIN)
-- 조인하려는 두 테이블이
-- 동일한 타입과 이름을 가진 컬럼이 있다면 자동적으로 조인이 이루어지도록 하는 구문.
-- * 반드시 동일한 타입과 이름의 컬럼이 있어야함.
    --> 해당 조건이 만족되지 않으면 CROSS JOIN이 일어남.

-- EMPLOYEE, JOB 테이블을 참조하여
-- 사번, 이름, 직급코드, 직급명 조회

-- ANSI
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE);

-- ORACLE
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;

-- NATURAL JOIN
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
NATURAL JOIN JOB;

-- 컬럼명 또는 데이터 타입이 다른 경우 크로스조인이 나타남
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
NATURAL JOIN DEPARTMENT;

--------------------------------------------------------------------------------

-- 7. 다중 조인
-- N개의 테이블을 조인할 때 사용
-- 조인 순서 중요!!!!!!(★★★★★)

-- EMPLOYEE, DEPARTMENTM LOCATION 테이블을 참조하여
-- 사번, 사원명, 부서명, 지역명 조회

-- ANSI
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE);

-- 조인 순서를 지키지 않은 경우
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE) 
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
-- EMPLOYEE 테이블에 LOCATION_ID가 없으므로 조인이 안됨
-- EMPLOYEE, LOCATION 테이블의 등가 조인이 성립하지 않음.

-- ORACLE
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE, DEPARTMENT, LOCATION
WHERE DEPT_CODE = DEPT_ID AND LOCATION_ID = LOCAL_CODE;

-- 23명 모든 사원 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
LEFT JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE);

-- 직급이 대리이면서 아시아 지역에 근무하는 직원 조회
-- 사번, 이름, 직급명, 부서명, 근무지역명, 급여를 조회
SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
WHERE JOB_NAME = '대리'
AND LOCAL_NAME LIKE 'ASIA%';

-- ORACLE
SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME, SALARY
FROM EMPLOYEE, JOB, DEPARTMENT, LOCATION
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE 
AND DEPT_CODE = DEPT_ID
AND LOCATION_ID = LOCAL_CODE
AND JOB_NAME = '대리'
AND LOCAL_NAME LIKE 'ASIA%';

-- 1. 주민번호가 70년대 생이면서 성별이 여자이고, 성이 ‘전’씨인 직원들의
-- 사원명, 주민번호, 부서명, 직급명을 조회하시오

SELECT EMP_NAME, EMP_NO, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE)
WHERE SUBSTR(EMP_NO, 1, 1) = '7' AND SUBSTR(EMP_NO, 8, 1) = '2'
AND EMP_NAME LIKE '전%';

-- 2. 이름에 '형'자가 들어가는 직원들의 사번, 사원명, 직급명을 조회하시오.

SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE EMP_NAME LIKE '%형%';

-- 3. 해외영업 1부, 2부에 근무하는 사원의
-- 사원명, 직급명, 부서코드, 부서명을 조회하시오.

SELECT EMP_NAME, JOB_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE IN('해외영업1부', '해외영업2부');

--4. 보너스포인트를 받는 직원들의 사원명, 보너스포인트, 부서명, 근무지역명을 조회하시오.
SELECT EMP_NAME, BONUS, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
WHERE BONUS IS NOT NULL;

--5. 부서가 있는 사원의 사원명, 직급명, 부서명, 지역명 조회
SELECT EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
WHERE DEPT_CODE IS NOT NULL;

-- 6. 급여등급별 최소급여(MIN_SAL)보다 많이 받는 직원들의
--사원명, 직급명, 급여, 연봉(보너스포함)을 조회하시오.
--연봉에 보너스포인트를 적용하시오.
SELECT EMP_NAME, JOB_NAME, SALARY,  SALARY*(1+NVL(BONUS, 0))*12 연봉
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
JOIN SAL_GRADE USING(SAL_LEVEL)
WHERE SALARY > MIN_SAL;

-- 7.한국(KO)과 일본(JP)에 근무하는 직원들의
-- 사원명, 부서명, 지역명, 국가명을 조회하시오.
SELECT EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE)
WHERE NATIONAL_NAME IN('한국', '일본');

-- 8. 같은 부서에 근무하는 직원들의 사원명, 부서코드, 동료이름을 조회하시오.
-- SELF JOIN 사용

SELECT E.EMP_NAME, E.DEPT_CODE, M.EMP_NAME
FROM EMPLOYEE E
RIGHT JOIN EMPLOYEE M ON(E.DEPT_CODE = M.DEPT_CODE)
WHERE E.EMP_NAME != M.EMP_NAME
ORDER BY 1;

-- 9. 보너스포인트가 없는 직원들 중에서 직급코드가 J4 와 J7 인 직원들의 사원명, 직급명, 급여를 조회하시오.
-- 단, JOIN, IN 사용할 것
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE BONUS IS NULL AND JOB_CODE IN('J4', 'J7');


