-- 함수 : 컬럼의 값을 읽어서 계산한 결과를 리턴
/*
    - 단일 행 함수(SINGLE ROW)
      컬럼에 기록된 N개의 값을 읽어서 N개의 결과를 리턴하는 함수
      
    - 그룹 함수(GROUP)
      컬럼에 기록된 N개의 값을 읽어서 1개의 결과를 리턴하는 함수
    
    (주의사항)
    - 단일 행 함수와 그룹 함수는 같이 사용할 수 없다.
      --> 결과 행의 수가 다르기 때문
      
    - 함수를 사용할 수 있는 위치
      --> SELECT절, WHERE절, ORDER BY절
      --> GROUP BY절, HAVING절
*/

--------------------------------------------------------------------------------

-- 단일 행 함수

-- 1. 문자 관련 함수

-- 1. LENGTH / LENGTHB
-- LENGTH : 주어진 컬럼 데이터의 길이
-- LENGTHB : 주어진 컬럼 데이터의 BYTE 크기

-- EMPLOYEE 테이블에서 직원명, 이메일, 이메일 길이 조회
SELECT EMP_NAME, EMAIL, LENGTH(EMAIL)
FROM EMPLOYEE;

SELECT LENGTH('오라클') FROM DUAL;
-- DUAL(DUMMY TABLE) : 가상 테이블

SELECT LENGTH('ORACLE'), LENGTHB('ORACLE123') FROM DUAL;

SELECT LENGTHB('오라클') FROM DUAL;

-- ORACLE EXPRESS EDITION (XE버전) : 교육용 무료 버전
-- 영어, 숫자 1바이트
-- 한글, 다른나라 외국어, 특수문자 등 아스키코드 이외의 문자 : 3바이트
-- -> 컬럼의 데이터 타입을 NVARCHAR2를 사용(유니코드 문자 사용)

--------------------------------------------------------------------------------

-- 2) INSTR
-- 지정한 위치부터 지정한 숫자 번째로 나타나는 문자의 시작 위치 반환
-- [작성법]
-- INSTR('문자열'|컬럼명, '문자'[, 검색 시작 인덱스 [, 순번]])

-- 첫번째 문자(1)부터 검색하여 'B'가 처음 나오는 위치 조회
SELECT INSTR('AABAACBBAA', 'B', -1, 1) FROM DUAL;
--> 오라클은 인덱스가 1부터 시작

-- 첫번째 문자(1)부터 검색하여 'B'가 두번째로 나오는 위치 조회
SELECT INSTR('AABAACBBAA', 'B', 1, 2) FROM DUAL;

-- 마지막 문자부터 검색하여 'B'가 처음 나오는 위치 조회
SELECT INSTR('AABAACBBAA', 'B', -1, 1) FROM DUAL;

-- EMPLOYEE 테이블에서
-- 사원명, 이메일, 이메일에서 '@'의 위치 조회
SELECT EMP_NAME, EMAIL, INSTR(EMAIL, '@', 1, 1)
FROM EMPLOYEE;

--------------------------------------------------------------------------------

-- 3) TRIM
-- 주어진 문자열 또는 컬럼 값의 앞/뒤/양쪽에 있는 지정한 문자를 제거
-- 지정한 문자가 없는 경우 공백을 제거한다.

SELECT '     KH     ' FROM DUAL;
SELECT TRIM('     KH     ') FROM DUAL;

-- 양쪽 제거(BOTH, 기본값)
SELECT TRIM('-' FROM '-----KH-----') FROM DUAL;
SELECT TRIM(BOTH '-' FROM '-----KH-----') FROM DUAL;

-- 왼쪽 제거(LEADING, LTRIM)
SELECT TRIM(LEADING '-' FROM '-----KH-----') FROM DUAL;
SELECT LTRIM('-----KH-----', '-') FROM DUAL;

-- 오른쪽 제거(TRAILING, RTRIM)
SELECT TRIM(TRAILING '-' FROM '-----KH-----') FROM DUAL;
SELECT RTRIM('-----KH-----', '-') FROM DUAL;

--------------------------------------------------------------------------------

/* 4) SUBSTR
    - 컬럼 값이나 문자열에서 지정한 위치부터 지정한 개수의 문자를 잘라내어 반환하는 함수
    
    - [작성법]
        SUBSTR(컬럼명|'문자열', POSITION [, LENGTH]
        POSITION : 잘라내기 시작할 위치
        LENGTH : 잘라낼 길이
*/

SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL;

-- 7번부터 끝까지 잘라내어 반환
SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL;

SELECT SUBSTR('SHOWMETHEMONEY', 1, 6) FROM DUAL;

-- 끝에서 부터 8번째 부터 잘라내기 시작해서 3글자 자르기
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL;

-- EMPLOYEE 테이블에서
-- 사원명, 이메일, 이메일 아이디 조회
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') - 1)
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서
-- 사원명, 주민등록번호, 주민등록번호 중 성별 부분 조회
SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, INSTR(EMP_NO, '-')+1, 1)
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서
-- 성별이 남성인 사원만 조회
-- 사원명, 주민등록번호, 주민등록번호 중 성별 부분 조회
SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1) "성별 부분"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = '1';

-- EMPLOYEE 테이블에서
-- 사원명, 태어난 년도, 월, 일을 조회
SELECT 
    EMP_NAME, SUBSTR(EMP_NO, 1, 2) || '년' 연도,
    SUBSTR(EMP_NO, 3, 2) || '월' 월,
    SUBSTR(EMP_NO, 5, 2) || '일' 일
FROM 
    EMPLOYEE;
    
--------------------------------------------------------------------------------

-- 5) LPAD, RPAD
-- 주어진 컬럼 값이나 문자열에 임의의 문자열을 좌/우에 덧붙여서 길이 N인 문자열을 반환
-- [작성법]
-- LPAD | RPAD (컬럼명 | 문자열, 반환할 문자열의 길이(N)[, 덧붙이려는 문자(STR)]

-- 20칸을 할당하고 데이터를 오른쪽 정렬 후 왼쪽 공백에 빈칸을 덧붙인다.
SELECT 
    LPAD(EMAIL, 20) 
FROM 
    EMPLOYEE;

-- 20칸을 할당하고 데이터를 오른쪽 정렬 후 왼쪽 공백에 '#'을 덧붙인다.
SELECT 
    LPAD(EMAIL, 20, '#') 
FROM 
    EMPLOYEE;
    
-- 20칸을 할당하고 데이터를 왼쪽 정렬 후 오른쪽 공백에 '#'을 덧붙인다.
SELECT 
    RPAD(EMAIL, 20, '#') 
FROM 
    EMPLOYEE;
    
-- EMPLOYEE 테이블에서
-- 사원명, 주민등록번호를 조회
-- 단, 주민등록번호 뒷자리는 성별만 보이고 나머지는 *로 처리
SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO,1, 8), 14, '*') 주민등록번호
FROM EMPLOYEE;

--------------------------------------------------------------------------------

-- 6) REPLACE
-- 컬럼 값, 또는 문자열에서 특정 문자열을 지정한 문자열로 변경 후 반환
-- [작성법]
--  REPLACE(컬럼명 | 문자열, 변경하려는 문자열, 변경하고자 하는 문자열)
SELECT REPLACE('서울시 강남구 역삼동', '역삼동', '삼성동') 
FROM DUAL;

-- EMPLOYEE 테이블에서
-- 사원들의 이메일 주소를 'kh.or.kr'에서 'gmail.com'으로 변경하여
-- 사원명, 기존 이메일, 바뀐 이메일 조회
SELECT EMP_NAME, EMAIL, REPLACE(EMAIL, 'kh.or.kr', 'gmail.com')
FROM EMPLOYEE;

--------------------------------------------------------------------------------

-- 2. 숫자 처리 함수

-- 1) MOD
-- 두 수를 나누어 나머지를 반환하는 함수
SELECT MOD(10, 3) FROM DUAL;
SELECT MOD(-10, 3) FROM DUAL;
SELECT MOD(10.9, 3) FROM DUAL;

--------------------------------------------------------------------------------

-- 2) ROUND(반올림)
-- [작성법]
-- ROUND(컬럼명 | 숫자[, 반올림 위치])
SELECT ROUND(123.456) FROM DUAL;
--> ROUND의 기본값은 소수 첫번째 자리에서 반올림하여 정수를 반환함.

SELECT ROUND(123.456, 1) FROM DUAL; -- 123.5

SELECT ROUND(123.456, 0) FROM DUAL; -- 123

SELECT ROUND(123.456, 2) FROM DUAL; -- 123.46

SELECT ROUND(123.456, -2) FROM DUAL; -- 100

--------------------------------------------------------------------------------

-- 3) CEIL(올림)
SELECT CEIL(123.1) FROM DUAL;
SELECT CEIL(123.456*10) / 10 FROM DUAL;


--------------------------------------------------------------------------------

-- 4) FLOOR(내림)
SELECT FLOOR(123.1) FROM DUAL; -- 123
SELECT FLOOR(123.9) FROM DUAL; -- 123
SELECT FLOOR(123.456*10) / 10 FROM DUAL;

SELECT CEIL(-10.9), FLOOR(-10.9), TRUNC(-10.9) FROM DUAL;

-- 5) TRUNC(버림, 절삭)
SELECT TRUNC(123.456) FROM DUAL;
--> 소수점 모두 버림

SELECT TRUNC(123.456, 1) FROM DUAL;
SELECT TRUNC(123.456, 2) FROM DUAL;

--------------------------------------------------------------------------------

-- 3. 날짜(DATE) 처리 함수

-- 1) SYSDATE : 시스템에 저장되어 있는 현재 날짜(시간)을 반환하는 함수
SELECT SYSDATE FROM DUAL;

-- 2) MONTHS_BETWEEN(DATE ,DATE)
-- 두 DATE의 개월 수 차이를 숫자로 리턴하는 함수

-- EMPLOYEE 테이블에서
-- 사원명, 입사일, 근무 개월 수 조회
SELECT EMP_NAME, HIRE_DATE, FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) || '개월' "근무 개월 수"
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서
-- 사원명, 입사일, 연차 조회
SELECT EMP_NAME, HIRE_DATE, CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)/12) || '년차' "연차"
FROM EMPLOYEE;

-- 3) ADD_MONTHS(DATE, 숫자)
-- 날짜에 숫자 만큼의 개월 수를 추가하여 반환
SELECT ADD_MONTHS(SYSDATE, 5) FROM DUAL;

-- EMPLOYEE 테이블에서
-- 사원의 이름, 입사일, 입사일로 부터 6개월이 지난 날짜 조회
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 6)
FROM EMPLOYEE;

-- 4) LAST_DAY(날짜) : 해당 달의 마지막 날짜를 리턴
SELECT LAST_DAY('20/09/01') FROM DUAL;

-- 5) EXTRACT : 날짜 데이터에서 년, 월, 일 정보를 추출하여 리턴
-- EXTRACT(YEAR FROM 날짜) : 연도 추출
-- EXTRACT(MONTH FROM 날짜) : 월 추출
-- EXTRACT(DAY FROM 날짜) : 일 추출

-- EMPLOYEE 테이블에서
-- 사원명, 입사일의 년,월,일을 조회
SELECT EMP_NAME,
    EXTRACT(YEAR FROM HIRE_DATE) 입사연도,
    EXTRACT(MONTH FROM HIRE_DATE) 입사월,
    EXTRACT(DAY FROM HIRE_DATE) 입사일
FROM EMPLOYEE;


