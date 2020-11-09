/* INDEX(�ε���)

    - SQL���� �˻� ó�� �ӵ��� ����Ű�� ���ؼ�
      �÷��� ���� �����ϴ� ����Ŭ ��ü
      
    - �ε��� ���� ������ B* Ʈ�� �������� �����Ǿ� ����.
    
    * �ε����� ����
        - ����Ʈ�� �������� �����Ǿ� �־� �ڵ� ���� �� �˻� �ӵ��� ����.
        - �ý��ۿ� �ɸ��� ���ϸ� �ٿ� �ý��� ��ü ������ ���.
        
    * �ε����� ����
        - �ε����� �߰��ϱ� ���� ������ ���� ������ �ʿ���.
        - �ε����� �����ϴµ� �ð��� �ɸ�.
        - ������ ���� �۾�(DML)�� ����ϰ� �߻��ϴ� ��쿡��
          ������ ���� ���ϸ� �ʷ���.
*/

--------------------------------------------------------------------------------

/* �ε��� ���� ���

CREATE [UNIQUE] INDEX �ε�����
ON ���̺��(�÷��� | �Լ��� | ����, ...);

*/

-- �ε��� ����
--> ROWID : DB �� ������ ���� �ּ�
SELECT ROWID EMP_IDM, EMP_NAME
FROM EMPLOYEE;
-- AAAE5e AAB AAALC5 AAA
-- 1~6 : ������ ������Ʈ ��ȣ
-- 7~9 : ���� ��ȣ
-- 10~15 : BLOCK ��ȣ
-- 16~18 : ROW ��ȣ

-- �����ͺ��̽��� ���� ������ �������� ����.
--> �׷��� ORDER BY���� ����Ѵ�.

-- ���̺� ���� ���� �� PK�� ������ �÷��� 
-- �ڵ����� INDEX�� �����ȴ�. (�ڡڡڡڡ�)

-- �ε��� Ȱ�� ���

-- 1) �ε����� Ȱ������ ���� SELECT��
SELECT EMP_ID, EMP_NAME 
FROM EMPLOYEE; -- 0.002��

-- 2) �ε����� Ȱ���� SELECT��
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID > 0;
--> WHERE���� INDEX�� ������ �÷��� ���ԵǸ� �ȴ�.
--> �����Ͱ� �� ��� �ӵ����̰� �ȳ�����

CREATE TABLE BOARD(
    BOARD_NO NUMBER PRIMARY KEY,
    BOARD_TITLE VARCHAR2(300) NOT NULL,
    BOARD_CONTENT CLOB NOT NULL,
    BOARD_COUNT NUMBER DEFAULT 0,
    BOARD_CREATE_DT DATE DEFAULT SYSDATE,
    BOARD_MODIFY_DT DATE DEFAULT SYSDATE,
    BOARD_STATUS CHAR(1) DEFAULT 'Y' CHECK(BOARD_STATUS IN ('Y','B','N')),
    BOARD_WRITER NUMBER NOT NULL,
    BOARD_CATEGORY NUMBER NOT NULL,
    BOARD_TYPE NUMBER NOT NULL
);

CREATE SEQUENCE SEQ_BNO
START WITH 1
INCREMENT BY 1
MAXVALUE 10000000
NOCYCLE
NOCACHE;

/* PL/SQL(Procedural Language extension to SQL)
    - ����Ŭ ��ü�� ����Ǿ��ִ� ������ ���
    - SQL ���� ������ ������ ����, ����ó��(IF), �ݺ�ó��(FOR, WHILE, LOOP)����
      �����Ͽ�, SQL�� ������ ������ ���
*/

BEGIN
    FOR N IN 1..1000000 LOOP
    
        INSERT INTO BOARD
        VALUES(SEQ_BNO.NEXTVAL, N || '��° �Խñ�',
                N || '��° �Խñ��� �����Դϴ�.',
                DEFAULT, DEFAULT, DEFAULT, DEFAULT,  1,
                CEIL(DBMS_RANDOM.VALUE(0,6))*10, 1);
    
    END LOOP;
    
    COMMIT;
END;
/





















