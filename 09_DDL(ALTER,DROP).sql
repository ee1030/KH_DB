/*
    DDL(Data Definition Language) : ������ ���� ���
    - ��ü(OBJECT)�� �����(CREATE), ����(ALTER)�ϰ�, ����(DROP)�ϴ� ����
    
    * ALTER
        - ��ü�� �����ϴ� ����
        
        [���̺� ���� �ۼ���]
        ALTER TABLE ���̺�� ������ ����;
        
        -> ������ ����
            -- �÷� �߰�/����
            -- �������� �߰�/����
            -- �÷��� �ڷ��� ����
            -- �÷��� DEFAULT�� ����
            -- �÷���, �������Ǹ�, ���̺�� ����
*/

-- 1. �÷� �߰�, ����, ����
SELECT * FROM DEPT_COPY;

-- 1) �÷� �߰�(ADD)
ALTER TABLE DEPT_COPY
ADD (CNAME VARCHAR2(20));
-- Table DEPT_COPY��(��) ����Ǿ����ϴ�.

SELECT * FROM DEPT_COPY;

-- �÷� �߰� �� DEFAULT�� ����
ALTER TABLE DEPT_COPY
ADD (LNAME VARCHAR2(40) DEFAULT '�ѱ�');

SELECT * FROM DEPT_COPY;

-- 2) �÷� ����
ALTER TABLE DEPT_COPY
MODIFY DEPT_ID CHAR(3)
MODIFY DEPT_TITLE VARCHAR2(30)
MODIFY LOCATION_ID VARCHAR2(10)
MODIFY LNAME DEFAULT '�̱�';

-- �÷� ���� �� ���ǻ���
--> ũ�⸦ �����Ϸ��� �÷��� ���� ���� ũ�⺸�� ū �����Ͱ� ������ �������� ����.

ALTER TABLE DEPT_COPY
MODIFY DEPT_TITLE VARCHAR2(10);
-- ORA-01441: cannot decrease column length because some value is too big


-- 3) �÷� ����(DROP COLUMN �÷���)
-- �÷� ���� �����ص� �÷��� ������.
-- ������ �÷��� �������� ����(DDL�� �ٷ� DB�� �ݿ���)
-- ��� �÷��� ������ ���� ����.(�ּ� �Ѱ� �̻��� �÷��� �����ؾ� ���̺���)

CREATE TABLE DEPT_COPY2
AS SELECT * FROM DEPT_COPY;

ALTER TABLE DEPT_COPY2
DROP COLUMN DEPT_ID;

SELECT * FROM DEPT_COPY2;

ALTER TABLE DEPT_COPY2
DROP COLUMN LOCATION_ID;

ALTER TABLE DEPT_COPY2
DROP COLUMN CNAME;

ALTER TABLE DEPT_COPY2
DROP COLUMN LNAME;

SELECT * FROM DEPT_COPY2;

ALTER TABLE DEPT_COPY2
DROP COLUMN DEPT_TITLE;
-- ORA-12983: cannot drop all columns in a table

-- �÷� ���� �� ���ǻ���
   --> �÷� ���� �� FK ���������� ������ �÷��� �������� ����.
   
--------------------------------------------------------------------------------
/*
    2. �������� �߰�, ����
    
    1) �������� �߰�(ADD, MODIFY(NOT NULL �߰� ��))
    
    [�ۼ���]
    ALTER TABLE ���̺��
    ADD CONSTRAINT �������Ǹ� ��������(�÷���);
    
    (NOT NULL�� ���)
    ALTER TABLE ���̺��
    MODIFY �÷��� CONSTRAINT �������Ǹ� NOT NULL;
*/

ALTER TABLE DEPT_COPY
ADD CONSTRAINT DC_ID_PK PRIMARY KEY(DEPT_ID);

ALTER TABLE DEPT_COPY
ADD CONSTRAINT DC_TITLE_UK UNIQUE(DEPT_TITLE)
MODIFY LNAME CONSTRAINT DC_LNAME_NN NOT NULL;
--> SQL DEVELOPER ������ ���� ���� �ƴ�

-- ���� ���̺� FK ���� ���� �߰��ϱ�

-- EMPLOYEE - DEPARTMENT  FK �߰�
ALTER TABLE EMPLOYEE
ADD CONSTRAINT EMP_DCODE_FK FOREIGN KEY(DEPT_CODE)
REFERENCES DEPARTMENT/*(DEPT_ID)*/;

-- EMPLOYEE - JOB
ALTER TABLE EMPLOYEE
ADD CONSTRAINT EMP_JCODE_FK FOREIGN KEY(JOB_CODE)
REFERENCES JOB/*(JOB_CODE)*/;

-- EMPLOYEE - SAL_GRADE
ALTER TABLE EMPLOYEE
ADD CONSTRAINT EMP_SLEV_FK FOREIGN KEY(SAL_LEVEL)
REFERENCES SAL_GRADE/*(SAL_LEVEL)*/;

-- DEPARTMENT - LOCATION
ALTER TABLE DEPARTMENT
ADD CONSTRAINT DEPT_LID_FK FOREIGN KEY(LOCATION_ID)
REFERENCES LOCATION/*(LOCAL_CODE)*/;

-- LOCATION - NATIONAL
ALTER TABLE LOCATION
ADD CONSTRAINT LO_NCODE_FK FOREIGN KEY(NATIONAL_CODE)
REFERENCES NATIONAL/*(NATIONAL_CODE)*/;





