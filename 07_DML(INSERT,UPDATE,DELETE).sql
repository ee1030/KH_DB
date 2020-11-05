/*
    DML(Data Manipulation Language) : 데이터 조작 언어
    
    - 테이블에 값을 삽입(INSERT)하거나, 수정(UPDATE)하거나, 삭제(DELETE)하는 구문
    
    -- DML 수업 중 주의사항!!
       -> 혼자서 작성 다했다고 실행하지 말것!
       -> 절대 COMMIT, ROLLBACK 구문 마음대로 실행하지 말것!
       
    
*/

--------------------------------------------------------------------------------

/*
    1. INSERT
    - 테이블에 새로운 행을 추가하는 구문
    - 테이블의 행 개수가 증가함
    
    
    [작성법 1]
    INSERT INTO 테이블명(컬럼명1, 컬럼명2, 컬럼명3, ...)
    VALUES(데이터1, 데이터2, 데이터3, ...);
    
    -> 지정한 테이블에서 특정 컬럼을 선택하여 데이터 삽입(INSERT)하는 방법
        --> 선택이 안된 컬럼은 NULL 값이 들어가거나,
            설정되어있는 DEFAULT값이 들어감
*/

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, EMAIL,
                     PHONE, DEPT_CODE, JOB_CODE, SAL_LEVEL,
                     SALARY, BONUS, MANAGER_ID, HIRE_DATE, ENT_DATE, ENT_YN)
VALUES('900', '장채현', '901123-1080503', 'jang_ch@kh.or.kr',
       '01055569512', 'D1', 'J7', 'S3', 4300000, 0.2, '200', SYSDATE,
       NULL, DEFAULT);
       
SELECT * FROM EMPLOYEE WHERE EMP_NAME = '장채현';


