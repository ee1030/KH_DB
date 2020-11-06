/* VIEW(��)
    - SELECT���� ���� ���(RESULT SET)�� ������ ������ ���� ���̺�

    - ���������� �����͸� �����ϰ� ���� ����.
    
    - ���̺��� ����ϴ� �Ͱ� �����ϰ� ����� �� ����.
    
    * VIEW ��� ����
        1) ������ SELECT �������� �ܼ�ȭ �Ͽ� ���� ���.
        2) ���̺��� ��¥ ����� ���� �� �־� ���Ȼ� ������.
        
    * VIEW�� ����
        1) ALTER ������ ����� �� ����.(VIEW�� ���� ���̺��̹Ƿ� ���� �Ұ�)
        2) VIEW�� �̿��� DML�� ����� ���� ������ ������ ������.
            -> SINGLE TABLE VIEW������ �κ������� DML ��� ����.
            
        ** ���������� VIEW�� �̿��� DML�� ����ǰ� ������
            SELECT �뵵�θ� �����.
            
    [�ۼ���]
    CREATE [OR REPLACE] VIEW ���̸�
    AS ��������;
*/

-- 1. VIEW ��� ����
-- ��� ����� ���, �̸�, �μ���, �ٹ������� ��ȸ�ϴ� SELECT�� �ۼ� ��
-- �ش� ����� VIEW�� �����ؼ� ����(�� ����)
CREATE VIEW V_EMPLOYEE
AS 
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_NAME
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
LEFT JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
LEFT JOIN NATIONAL USING(NATIONAL_CODE);
-- ORA-01031: insufficient privileges : �� ���� ������ ����.
--> sys as sysdba�� ������ ��ȯ�� �� kh������ VIEW ���� ������ �ο�
GRANT CREATE VIEW TO kh;
--> �ٽ� kh�������� ���� ���� �� ���� �� ���� ������ �ٽ� ����.
--> View V_EMPLOYEE��(��) �����Ǿ����ϴ�.

SELECT * FROM V_EMPLOYEE;

-- * VIEW�� ������ ���̺� 















