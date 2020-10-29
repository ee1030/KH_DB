-- SELECT (��ȸ)
-- SELECT ������ ��ȸ ��� ���� : RESULT SET

/*
SELECT * | �÷���[, �÷���, ...]
FROM ���̺��
WHERE ���ǽ�;
*/

-- EMPLOYEE ���̺��� ��� ��� ������ ��� ��ȸ
SELECT * FROM EMPLOYEE;

-- EMPLOYEE ���̺��� ��� ����� ���, �̸� ��ȸ
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� ��� ����� �̸�, �̸���, ��ȭ��ȣ ��ȸ
SELECT EMP_NAME, EMAIL, PHONE
FROM EMPLOYEE;

-- JOB ���̺��� ��� ���� ��ȸ
SELECT * 
FROM JOB;

-- JOB ���̺��� ���޸� ��ȸ
SELECT JOB_NAME
FROM JOB;

-- DEPARTMENT ���̺��� ��� ���� ��ȸ
SELECT *
FROM DEPARTMENT;

-- EMPLOYEE ���̺��� �̸�, �̸���, ��ȭ��ȣ, ����� ��ȸ
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� �����, �����, ���� ��ȸ
SELECT HIRE_DATE, EMP_NAME, SALARY
FROM EMPLOYEE;

------------------------------------------------------------------------------

-- �÷� �� ��� ����
-- SELECT �� �÷��� �κп�
-- ����� �ʿ��� �÷��� + ����, �����ڸ� �̿��Ͽ�
-- ���ϴ� ��� ����� ��ȸ�� �� �ִ�.

-- EMPLOYEE ���̺��� ������� �̸�, �޿�, ���� ��ȸ
SELECT EMP_NAME, SALARY, SALARY*12
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� ����� �̸���, ���ʽ��� �ݿ��� ������ ��ȸ
SELECT EMP_NAME, SALARY*12, (SALARY + SALARY*BONUS) * 12
FROM EMPLOYEE;
-- DB���� ��� ���� �� NULL ���� ���ԵǾ� �ִٸ�
-- ����� ������ NULL�� ���´�.

-- EMPLOYEE ���̺��� ����� �̸�, �����, �ٹ� �ϼ� ��ȸ
SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE
FROM EMPLOYEE;

------------------------------------------------------------------------------

/* �÷� ��Ī

    �÷��� ��Ī / �÷��� AS ��Ī     /     �÷��� "��Ī" / �÷��� AS "��Ī"
       Ư������, ����X                     Ư������, ���� O
    
    
*/

-- EMPLOYEE ���̺��� ����� �̸�, �Ի���, �ٹ� �ϼ� ��ȸ
SELECT EMP_NAME AS �̸�, HIRE_DATE �Ի���, SYSDATE - HIRE_DATE "�ٹ� �ϼ�"
FROM EMPLOYEE;

------------------------------------------------------------------------------

-- ���ͷ�
-- ���Ƿ� ������ ���ڿ��� SELECT���� ����ϸ�
-- ���̺� �����ϴ� ������ ó�� ����� �� ����.
-- ���ͷ��� ǥ�� ��ȣ�� ''(Ȧ����ǥ)
-- ���ͷ��� result set�� ��� ��� �࿡ �ݺ������� ǥ�õ�

-- EMPLOYEE ���̺���
-- ���, �����, �޿�, ����(������ : ��) ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, '��' AS ����
FROM EMPLOYEE;

-- DISTINCT
-- �÷��� ���Ե� �ߺ� ���� �� ���� ǥ���ϰ��� �� �� ���

-- EMPLOYEE ���̺��� ������ ���� �ڵ带 ��ȸ
SELECT JOB_CODE FROM EMPLOYEE;

-- EMPLOYEE ���̺��� ������ ���� �ڵ带 ��ȸ
SELECT DISTINCT JOB_CODE FROM EMPLOYEE;

-- * DISTINCT ���ǻ��� 
--   -> DISTINCT SELECT ���� �ϳ� �� �� ���� ��� ����

-- DISTINCT�� ���ʿ� �ۼ��� �÷����� ��� ��� �ߺ����� �����Ͽ� ���
SELECT DISTINCT JOB_CODE, DEPT_CODE
FROM EMPLOYEE;

-- WHERE�� 
-- ��ȸ�� ���̺��� ������ �´� ���� ���� ���� ��󳻴� ����

-- WHERE������ TRUE, FALSE�� ���� �� �ִ�
-- �� �����ڰ� ����.
-- >, <, >=, =<
-- = (����), !=, ^=, <> (���� �ʴ�)

-- EMPLOYEE ���̺���
-- �μ��ڵ尡 'D9'�� ������ ���, �̸�, �μ��ڵ� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- �޿��� 4�鸸 �̻��� ����� �̸�, �޿� ��ȸ
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY > 4000000;

-- EMPLOYEE ���̺��� �μ��ڵ尡 'D9'�� �ƴ� �����
-- �̸�, �μ��ڵ� ��ȸ
SELECT EMP_NAME �̸�, DEPT_CODE "�μ� �ڵ�"
FROM EMPLOYEE
WHERE DEPT_CODE <> 'D9';

-- EMPLOYEE ���̺��� ����� �����
-- �̸�, ��ȭ��ȣ, �μ��ڵ� ��ȸ
SELECT EMP_NAME �̸�, PHONE ��ȭ��ȣ, DEPT_CODE �μ��ڵ�
FROM EMPLOYEE
WHERE ENT_YN = 'Y';