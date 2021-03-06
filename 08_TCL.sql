/*
    TCL(Transaction Control Language) : 트랜잭션 제어(처리) 언어
    
    - COMMIT(트랜잭션 종료 처리 후 저장)
    - ROLLBACK(트랜잭션 취소)
    - SAVEPOINT(임시저장)
    
    
    Transaction이란?(★★★★★)
    
     - 데이터베이스의 논리적 연산단위
     - 데이터 변경 사항(DML)을 묶어 하나의 트랜잭션에 담아 처리함.
        -> 트랜잭션의 대상이 되는 SQL : INSERT, UPDATE, DELETE(DML)
    
    * COMMIT / ROLLBACK
      - COMMIT 또는 ROLLBACK이 입력되기 전 까지는
        SQL 구문이 DB에 반영되지 않고,
        메모리 버퍼에 임시 저장되어 있는 상태
    
      - COMMIT 입력 : 트랜잭션에 임시 저장된 데이터 -> DB에 반영
      
      - ROLLBACK 입력 : 트랜잭션에 저장된 데이터 변경 사항(DML)을 삭제하고
                        마지막 COMMIT 상태로 돌아감.
                        
      *** 주의사항!
          DML구문 작성 중
          중간에 DDL구문 (CREATE, ALTER, DROP, TRUNCATE)이 작성되면
          DDL구문 이전 까지의 DML 내용이 자동 COMMIT됨!!
          
      - SAVEPOINT
        트랜잭션에 저장 지점을 지정하여
        ROLLBACK시 전체 작업을 ROLLBACK하는 것이 아닌
        현 시점부터 지정한 SAVEPOINT 까지만 ROLLBACK
          
      [작성법]
        SAVEPOINT 포인트명1;
        SAVEPOINT 포인트명2;
        ...
        ROLLBACK TO 포인트명1; 포인트1까지 ROLLBACK
*/

SELECT * FROM MEMBER;

-- 현재 트랜잭션을 DB에 반영
COMMIT;

-- MEMBER 테이블에서 '고길동'이 있는 한 행을 삭제
DELETE FROM MEMBER
WHERE MEMBER_NAME = '고길동';

-- 삭제 확인(화면상으로는 삭제 된것으로 보이지만 아직 DB에는 반영 X)
SELECT * FROM MEMBER;

-- '고길동'이 삭제된 상태를 SAVEPOINT로 지정
SAVEPOINT SP1;

-- '박철수' 삭제
DELETE FROM MEMBER
WHERE MEMBER_NAME = '박철수';

-- '박철수' 삭제 확인
SELECT * FROM MEMBER;

-- SAVEPOINT SP1으로 롤백
ROLLBACK TO SP1;

-- 롤백 확인
SELECT * FROM MEMBER;

-- '김영희' 삭제
DELETE FROM MEMBER
WHERE MEMBER_NAME = '김영희';

-- '김영희' 삭제 확인
SELECT * FROM MEMBER;

-- 마지막 COMMIT 상태로 돌아가기 == ROLLBACK
ROLLBACK;

-- 롤백 확인
SELECT * FROM MEMBER;




