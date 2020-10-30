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


