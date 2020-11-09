/* SEQUENCE(������)
    - ���������� �������� �ڵ� �������ִ� 
      �ڵ� ��ȣ �߻��� ������ �ϴ� ��ü
    
    [�ۼ���]
    1. ����
    CREATE SEQUENCE ��������
    [START WITH ����] -- ó�� �߻���ų ���� �� ����, ������ �⺻ �� 1
    [INCREMENT BY ����] -- ���� ���� ���� ����ġ, ������ �⺻ �� 1
    [MAXVALUE ���� | NOMAXVALUE(�⺻��)] -- �߻���ų �ִ밪�� ����(10^27 - 1),
    [MINVALUE ���� | NOMINVALUE(�⺻��)] -- �߻���ų �ּҰ��� ����(-10^26),
    [CYCLE | NOCYCLE(�⺻��)] -- �� ��ȯ ���� ���� 
    [CACHE ����Ʈũ�� | NOCACHE] -- ĳ�ø޸�ũ�� ����. �ּҰ� 2����Ʈ
                                 -- NOCACHE �⺻ �� 20����Ʈ
    * �������� ĳ�ø޸𸮴� �Ҵ�� ũ�� ��ŭ �̸� ���� ���� �����ؼ� ������ �д�.
      --> ���� ������ ȣ�� �� ����� ���� ��ȯ�ϹǷ� �ӵ��� ������.(DB�ӵ� ���)
*/

-- 1. ������ ����
CREATE SEQUENCE SEQ_EMP_ID
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOMINVALUE
NOCYCLE
NOCACHE;

-- ����ڰ� ������ ������ Ȯ��
SELECT * FROM USER_SEQUENCES;

--------------------------------------------------------------------------------

-- 2. ������ ���
/* [�ۼ���]

1) ���� ������ ������ �� ��ȯ
��������.CURRVAL

2) ������ ���� INCREMENT �� ��ŭ ������Ų ���� ��ȯ
��������.NEXTVAL

*/

SELECT SEQ_EMP_ID.CURRVAL FROM DUAL;
-- CURRVAL�� �������� ȣ��� NEXTVAL�� ���� �����ϴ� ���� ���� ����.

--> NEXTVAL�� ���� ȣ��

SELECT SEQ_EMP_ID.NEXTVAL FROM DUAL; -- �ʱⰪ 300
SELECT SEQ_EMP_ID.CURRVAL FROM DUAL;
SELECT SEQ_EMP_ID.NEXTVAL FROM DUAL; -- 305
SELECT SEQ_EMP_ID.NEXTVAL FROM DUAL; -- 310
SELECT SEQ_EMP_ID.NEXTVAL FROM DUAL; -- ����(�ִ� �ʰ�)

SELECT * FROM USER_SEQUENCES;


/* ������(CURRVAL, NEXTVAL) ��� ����/�Ұ��� SQL��

    1) ��� ����
        - ��������(���������� �ƴ� SELECT��)
        - INSERT���� �������� SELECT��
        - INSERT���� VALUES��
        - UPDATE���� SET��
    
    2) ��� �Ұ���
        - VIEW�� SELECT��
        - DISTINCT�� �ִ� SELECT��
        - GROUP BY, HAVING, ORDER BY���� ���Ե� SELECT ��
        - SELECT, DELETE, UPDATE���� ��������
        - CREATE TABLE, ALTER TABLE�� DEFAULT ��
*/

CREATE SEQUENCE SEQ_EID
START WITH 300
-- INCREMENT BY 1
MAXVALUE 10000
-- NOMINVALUE
-- NOCYCLE
CACHE 30;

COMMIT;

INSERT INTO EMPLOYEE
VALUES(SEQ_EID.NEXTVAL, 'ȫ�浿', '001109-1234567', 'hong-gd@kh.or.kr',
        '01012341234', 'D2', 'J7', 'S1', 6000000, 0.1, 200, SYSDATE, NULL, DEFAULT);

SELECT * FROM EMPLOYEE
WHERE EMP_NAME = 'ȫ�浿';

INSERT INTO EMPLOYEE
VALUES(SEQ_EID.NEXTVAL, 'ȫ���', '001109-2234567', 'hong-gs@kh.or.kr',
        '01012345678', 'D2', 'J7', 'S1', 6000000, 0.1, 200, SYSDATE, NULL, DEFAULT);

SELECT * FROM EMPLOYEE
WHERE EMP_NAME = 'ȫ���';

--------------------------------------------------------------------------------

/*3. ������ ����
    [�ۼ���]
    ALTER SEQUENCE ��������
    [INCREMENT BY ����] -- ���� ���� ���� ����ġ, ������ �⺻ �� 1
    [MAXVALUE ���� | NOMAXVALUE(�⺻��)]
    [MINVALUE ���� | NOMINVALUE(�⺻��)]
    [CYCLE | NOCYCLE(�⺻��)]
    [CACHE ����Ʈũ�� | NOCACHE];
    
    --> START WITH�� ���� �Ұ�
    
    * ���� START WITH�� �����ϰ� �ʹٸ�
    
        DROP SEQUENCE ��������; -- �������� ��
        
        CREATE SEQUENCE ��������; -- �ٽ� ����
*/

ALTER SEQUENCE SEQ_EMP_ID
INCREMENT BY 10
MAXVALUE 400
MINVALUE 200
CYCLE;

SELECT SEQ_EMP_ID.CURRVAL FROM DUAL;
SELECT SEQ_EMP_ID.NEXTVAL FROM DUAL;

















