/* VIEW(뷰)
    - SELECT문의 실행 결과(RESULT SET)을 저장한 논리적인 가상 테이블

    - 실질적으로 데이터를 저장하고 있지 않음.
    
    - 테이블을 사용하는 것과 동일하게 사용할 수 있음.
    
    * VIEW 사용 목적
        1) 복잡한 SELECT 쿼리문을 단순화 하여 쉽게 사용.
        2) 테이블의 진짜 모습을 감출 수 있어 보안상 유리함.
        
    * VIEW의 단점
        1) ALTER 구문을 사용할 수 없다.(VIEW는 가상 테이블이므로 수정 불가)
        2) VIEW를 이용한 DML을 사용할 수는 있으나 제약이 따른다.
            -> SINGLE TABLE VIEW에서만 부분적으로 DML 사용 가능.
            
        ** 실제적으로 VIEW를 이용한 DML은 지양되고 있으며
            SELECT 용도로만 사용함.
            
    [작성법]
    CREATE [OR REPLACE] VIEW 뷰이름
    AS 서브쿼리;
*/

-- 1. VIEW 사용 예시
-- 모든 사원의 사번, 이름, 부서명, 근무지역을 조회하는 SELECT문 작성 후
-- 해당 결과를 VIEW로 생성해서 저장(의 개념)
CREATE VIEW V_EMPLOYEE
AS 
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_NAME
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
LEFT JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
LEFT JOIN NATIONAL USING(NATIONAL_CODE);
-- ORA-01031: insufficient privileges : 뷰 생성 권한이 없음.
--> sys as sysdba로 접속을 전환한 후 kh계정에 VIEW 생성 권한을 부여
GRANT CREATE VIEW TO kh;
--> 다시 kh계정으로 접속 변경 후 위의 뷰 생성 구문을 다시 실행.
--> View V_EMPLOYEE이(가) 생성되었습니다.

SELECT * FROM V_EMPLOYEE;

-- * VIEW는 가상의 테이블 















