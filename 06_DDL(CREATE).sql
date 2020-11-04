/*
    DDL(Data Definition Language) : ������ ���� ���(�ڡڡڡڡ�)
    
    - ��ü(OBJECT)�� �����, ����(ALTER), ����(DROP)�ϴ� ��
      ������ ��ü ������ �����ϴ� ����
      �ַ� DB������ �����ڰ� �����.
      
      
    - ����Ŭ���� ���ϴ� ��ü :
        TABLE, VIEW, SEQUENCE, INDEX, PACKAGE, TRIGGER,
        PROCEDURE, FUNCTION, SYNONYM(���Ǿ�), USER
        
--------------------------------------------------------------------------------

    CREATE
    - ���̺��̳� ��, �ε��� �� �پ��� �����ͺ��̽� ��ü�� �����ϴ� ����
    
    - 1. ���̺� �����ϱ�
    
    - ���̺�(TABLE)�̶�?(�ڡڡ�)
      -- ���(ROW)�� ��(COLUMN)�� �����Ǵ� �����ͺ��̽��� ���� �⺻���� ��ü
      -- �����ͺ��̽� ������ ��� �����ʹ� ���̺��� ���� ����ȴ�.

    - ���̺� ���� SQL���� �ۼ���
    
      CREATE TABLE ���̺��(
        �÷��� ������Ÿ��(ũ�� | �ڸ���),
        �÷��� ������Ÿ��(ũ�� | �ڸ���),
        ...
      );
    
*/

-- CHAR : �������� ���� �ڷ��� (2000BYTE)
          --> ������ ����Ʈ���� �������� �����Ͱ� ����Ǿ
          -- ���� �뷮�� ��ȯ���� ����

-- VARCHAR : �������� ���� �ڷ��� (2000BYTE)
             --> ������ ����Ʈ���� ���� ���� �����Ͱ� ����� ���
             -- ���� ũ��(�뷮) ��ȯ
             
-- VARCHAR2 : 4000 BYTE �������� ���� �ڷ���

-- ������ �����͸� 30����Ʈ���� ������ �� �ִ� MEMBER_ID �÷�

CREATE TABLE MEMBER(
    MEMBER_ID VARCHAR2(30), 
    MEMBER_PWD VARCHAR2(30),
    MEMBER_NAME VARCHAR2(20),
    MEMBER_SSN CHAR(14),
    ENROLL_DATE DATE DEFAULT SYSDATE
);
-- DEFAULT SYSDATE : �ԷµǴ� ���� ���ų�, DEFAULT�� �Է� �� ��� ���� �ð� ���

-- MEMBER TABLE ���� Ȯ��
SELECT * FROM MEMBER;

-- 2. �÷��� �ڸ�Ʈ(�ּ�) �ޱ�
-- [�ۼ���]
-- COMMENT ON COLUMN ���̺��.�÷��� IS '�ּ�����';
COMMENT ON COLUMN MEMBER.MEMBER_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS 'ȸ����й�ȣ';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS 'ȸ���̸�';
COMMENT ON COLUMN MEMBER.MEMBER_SSN IS '�ֹε�Ϲ�ȣ';
COMMENT ON COLUMN MEMBER.ENROLL_DATE IS '��������';

-- ����ڰ� ������ ���̺� Ȯ��
SELECT * FROM USER_TABLES;

-- ��ųʸ� ��(Dictionary View)
-- USER_TABLES : ����ڰ� �ۼ��� ���̺��� Ȯ���ϴ� ��(������ ���̺�)


/*
    Data Dictionary(������ ��ųʸ�)(�ڡڡڡڡ�)
    
    - �ڿ��� ȿ�������� �����ϱ� ���� �پ��� ������ �����ϴ� �ý��� ���̺�.
    
    - ������ ��ųʸ��� ����ڰ� ���̺��� �����ϰų� ����ڸ� �����ϴ� ����
      �۾��� �� �� �����ͺ��̽� ������ ���ؼ� �ڵ����� ���ŵǴ� ���̺��̴�.
*/

SELECT USERNAME FROM DBA_USERS;
-- DBA_USERS : �����ͺ��̽��� �����ϴ� ��� �����(USER) ������ ��ȸ�ϴ� ��ųʸ� ��
-- (SYS AS SYSDBA �������θ� ����)

SELECT * FROM USER_TAB_COLUMNS
WHERE TABLE_NAME = 'MEMBER';
-- USER_TAB_COLUMNS : ���̺�, ��, Ŭ�������� �÷��� ���õ� ������ ��ȸ�ϴ� ��ųʸ� ��

DESC MEMBER;
-- DESC�� : ���̺��� ������ ǥ���ϴ� ����

-- MEMBER ���̺� ���� ������ ����
INSERT INTO MEMBER VALUES('MEM01', '123ABC', '��浿', '000101-3345678', DEFAULT);

-- ������ ���� Ȯ��
SELECT * FROM MEMBER;

COMMIT;
-- ���̺� ���� ����(DML)�� ���� DB�� �ݿ��ϴ� TCL ����

-- ������ -> SYSDATE�� Ȱ��
INSERT INTO MEMBER VALUES ('MEM02', 'QWER1234', '�迵��', '971208-2123456', SYSDATE); 

-- ������ -> DEFAULT Ȱ��(���̺� ���� �� ���ǵ� ���� �ݿ���)
INSERT INTO MEMBER VALUES ('MEM03', 'ZZ9786', '��ö��', '900314-1122334',  DEFAULT); -- DEFAULT

-- ������ -> INSERT �� ���ۼ� �ϴ� ��� -> DEAFULT ���� �ݿ���
INSERT INTO MEMBER(MEMBER_ID, MEMBER_PWD, MEMBER_NAME, MEMBER_SSN)
VALUES ('MEM4', 'ASDQWE','������', '851011-2345678');

COMMIT;

SELECT * FROM MEMBER;

-- �ֹ���Ϲ�ȣ, ��ȭ��ȣ �� ���ڰ� ���Ե� �������� �÷��� ���ڿ��� �ϴ� ����
CREATE TABLE MEMBER2(
    MEMBER_ID VARCHAR2(30), 
    MEMBER_PWD VARCHAR2(30),
    MEMBER_NAME VARCHAR2(20),
    MEMBER_SSN NUMBER,
    ENROLL_DATE DATE DEFAULT SYSDATE
);

INSERT INTO MEMBER2 VALUES ('MEM02', 'QWER1234', '�迵��', 0712082123456, SYSDATE); 

SELECT * FROM MEMBER2;
-- �ֹε�Ϲ�ȣ ���� �� 0�� ������� ������ �߻���.
    --> �̸� �ذ��ϱ� ���� ���� ������ Ÿ���� �����.

--------------------------------------------------------------------------------

/*
    ���� ����(CONSTRAINTS)
    
    - ����ڰ� ���ϴ� ������ �����͸� �����ϱ� ���ؼ� Ư�� �÷��� �����ϴ� ����
    - ���̺� �ۼ� �� �� �÷��� ���� �� ��Ͽ� ���� ���� ������ ���� ����.
    
    ���� ������ ���� 
    - ������ ���Ἲ ����.(�ߺ� ������X, NULL X)
    - �Է� �����Ϳ� ������ ���� �ڵ� �˻�.
    - �������� ����/���� ���� ����

    ���� ������ ����
    - PRIMARY KEY
    - NOT NULL
    - UNIQUE
    - CHECK
    - FOERIGN KEY
*/

-- ���� ���� Ȯ�� ���
SELECT * FROM USER_CONSTRAINTS;
-- USER_CONSTRAINTS : ����ڰ� �ۼ��� ���� ������ Ȯ���ϴ� ��ųʸ� ��

SELECT * FROM USER_CONS_COLUMNS;
-- USER_CONS_COLUMNS : ���� ������ ������ �÷��� Ȯ���ϴ� ��ųʸ� ��

--------------------------------------------------------------------------------

-- 1. NOT NULL ���� ����
-- �ش� �÷��� �ݵ�� ���� ��ϵǾ�� �ϴ� ��� ����ϴ� ���� ����
-- ������ ����/���� �� NULL ���� ������� �ʵ���
-- �÷� �������� ������.

-- NOT NULL ���������� ���� ���
CREATE TABLE USER_NOT_NN(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(20),
    USER_NAME VARCHAR2(30),
    GENDER CHAR(3),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
);

INSERT INTO USER_NOT_NN 
VALUES(1, 'USER01', 'PASS01', '�迵��', '��', '010-1111-2222', 'USER01@naver.com');

INSERT INTO USER_NOT_NN 
VALUES(2, NULL, NULL, NULL, '��', '010-1111-2222', 'USER01@naver.com');

SELECT * FROM USER_NOT_NN;

-- NOT NULL ���������� ������ ���
-- �ڡڡڡڡڡڡڡڡڡ�(�볻 �߿�) NOT NULL ���������� ���̺� ���� �� �÷� �����θ� ���� ������
CREATE TABLE USER_NN(
    USER_NO NUMBER NOT NULL,
    USER_ID VARCHAR2(20) NOT NULL,
    USER_PWD VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER CHAR(3),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50) NOT NULL
);

-- �ۼ��� �������� Ȯ��
SELECT C1.TABLE_NAME, COLUMN_NAME, SEARCH_CONDITION
FROM USER_CONSTRAINTS C1
JOIN USER_CONS_COLUMNS C2 USING(CONSTRAINT_NAME)
WHERE C1.TABLE_NAME = 'USER_NN';

INSERT INTO USER_NN 
VALUES(1, 'USER01', 'PASS01', '�迵��', '��', '010-1111-2222', 'USER01@naver.com');

INSERT INTO USER_NN 
VALUES(2, 'USER02', 'PASS02', NULL, '��', '010-1111-2222', 'USER01@naver.com');







