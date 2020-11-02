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
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE);

-- ORACLE
SELECT DEPT_TITLE, LOCAL_NAME
FROM DEPARTMENT, LOCATION
WHERE DEPARTMENT.LOCATION_ID = LOCATION.LOCAL_CODE;




