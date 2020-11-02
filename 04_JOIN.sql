/* 
[JOIN ��� ����]
  ����Ŭ       	  	                                SQL : 1999ǥ��(ANSI)
----------------------------------------------------------------------------------------------------------------
� ����		                            ���� ����(INNER JOIN), JOIN USING / ON
                                            + �ڿ� ����(NATURAL JOIN, � ���� ��� �� �ϳ�)
----------------------------------------------------------------------------------------------------------------
���� ���� 		                        ���� �ܺ� ����(LEFT OUTER), ������ �ܺ� ����(RIGHT OUTER)
                                            + ��ü �ܺ� ����(FULL OUTER, ����Ŭ �������δ� ��� ����)
----------------------------------------------------------------------------------------------------------------
��ü ����, �� ����   	                    JOIN ON
----------------------------------------------------------------------------------------------------------------
ī�׽þ�(īƼ��) ��		               ���� ����(CROSS JOIN)
CARTESIAN PRODUCT

- �̱� ���� ǥ�� ��ȸ(American National Standards Institute, ANSI) �̱��� ��� ǥ���� �����ϴ� �ΰ���ü.
- ����ǥ��ȭ�ⱸ ISO�� ���ԵǾ� ����.


*/

/*
    JOIN 
    - �ϳ� �̻��� ���̺��� �����͸� ��ȸ�ϱ� ���� ����ϴ� ����,
    - ���� ����� �ϳ��� RESULT SET���� ���´�.
    
    - ������ �����ͺ��̽����� SQL�� �̿��� ���̺� �� ���踦 ���� �� ����
    
        -- ������ �����ͺ��̽��� ������ ���Ἲ�� ����
           �ߺ��Ǵ� ������ ���� �ּ����� �����͸� ���̺� ���
           --> ���ϴ� ������ ��ȸ�ϱ� ���ؼ� �ϳ� �̻��� ���̺��� �ʿ��� ��찡 ����.
           
        -- ���� ����� �����͸� ���� ���̺��� ������� �ξ� �ʿ��� �����͸��� ������.
           --> JOIN
*/

-- ���, �����, �μ��ڵ�, �μ��� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

-- �μ��ڵ�, �μ��� ��ȸ
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

-- 3) JOIN ���
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

--------------------------------------------------------------------------------

--          ANSI                  ORACLE
-- 1. ���� ����(INNER JOIN)(== �����(EQUAL JOIN))
    --> ����� �÷��� ���� ��ġ�ϴ� ��鸸 ������ �̷����.
    --  (�÷����� ��ġ���� �ʴ� ���� ���ο��� ���ܵ�.)

-- *ANSI ǥ�� ����
-- ANSI�� �̱� ���� ǥ�� ��ȸ�� ����, �̱��� ���ǥ���� �����ϴ� �ΰ���ü�� 
-- ����ǥ��ȭ�ⱸ ISO�� ���ԵǾ��ִ�.
-- ANSI���� ������ ǥ���� ANSI��� �ϰ� 
-- ���⼭ ������ ǥ�� �� ���� ������ ���� ASCII�ڵ��̴�.

-- *����Ŭ ���� ����
-- FROM���� ','�� �����Ͽ� ��ġ�� �� ���̺���� ����ϰ�
-- WHERE���� ��ġ�⿡ ����� �÷����� ����Ѵ�.

-- 1) ���ῡ ����� �� �÷����� �ٸ����

-- EMPLOYEE, DEPARTMENT ���̺��� �����Ͽ�
-- ���, �̸�, �μ��ڵ�, �μ��� ��ȸ

    -- EMPLOYEE ���̺��� �μ��ڵ� : DEPT_CODE
    -- DEPARTMENT ���̺��� �μ��ڵ� : DEPT_ID
    --> ������ �÷��� �ǹ�, ������ �������� ���¸� �� == ������ �����ϴ�.

-- ANSI ���
-- ���ῡ ����� �÷����� �ٸ� ��� 
-- JOIN ���̺�� ON(�÷���1 = �÷���2)
SELECT EMP_ID, EMP_NAME, DEPT_ID, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

-- ����Ŭ ���
SELECT EMP_ID, EMP_NAME, DEPT_ID, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;

-- DEPARTMENT, LOCATION ���̺��� �����Ͽ�
-- �μ���, ������ ��ȸ

-- ANSI
SELECT DEPT_TITLE, LOCAL_NAME
FROM DEPARTMENT
/*INNER*/JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE);

-- ORACLE
SELECT DEPT_TITLE, LOCAL_NAME
FROM DEPARTMENT, LOCATION
WHERE DEPARTMENT.LOCATION_ID = LOCATION.LOCAL_CODE;

-- 2) ���ῡ ����� �� �÷����� ���� ���

-- EMPLOYEE, JOB ���̺��� �����Ͽ�
-- ���, �̸�, �����ڵ�, ���޸� ��ȸ

-- ANSI
-- ���ῡ ����� �÷����� ���� ���
-- JOIN ���̺�� USING(�����÷���)
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE);

-- ORACLE
-- ��� 1) ���� �÷����� �����ϱ� ���� ���̺������ ����
SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

-- ��� 2) ���̺�� ��Ī�� �����Ͽ� �����ϴµ� ���
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;

--------------------------------------------------------------------------------

/*
    2. �ܺ�����(OUTER JOIN) == (���� ����)
    -- �� ���̺��� ������ �÷����� ��ġ���� �ʴ� �൵ ���ο� ���� ��Ŵ.
    * OUTER JOIN�� �ݵ�� ����ؾ��� ���ϸ� �����   
*/

-- INNER JOIN�� OUTER JOIN�� ���ϱ� ���� SQL ����
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID); -- 21�� ��ȸ��

-- 1) LEFT [OUTER] JOIN
-- ��ġ�⿡ ����� �� ���̺� �� ���� ����� ���̺��� ��� �÷��� �������� ����
-- (NULL �������� ����)

-- ANSI
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
LEFT /*OUTER*/ JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
-- 23��(�̿���, �ϵ��� �߰�)

-- ORCALE (+)
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+);
-- ����(DEPT_CODE)�� �������� �Ͽ� ������(DEPT_ID)�� ���缭 �߰�

-- 2) RIGHT [OUTER] JOIN
-- ��ġ�⿡ ����� �� ���̺� �� ������ ����� ���̺��� ��� �÷��� �������� ����
-- (NULL �������� ����)

--ANSI
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
RIGHT /*OUTER*/ JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
-- 24�� : �����ʿ� ���ε��� �ʾҴ�
-- �ؿܿ���3��, �����ú�, ���������ΰ� �߰���

-- ORCALE (+)
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;

-- 3) FULL [OUTER] JOIN
-- ��ġ�⿡ ����� �� ���̺��� ���� ��� ���� ����� ����
-- LEFT ������ RIGHT

-- ANSI
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
FULL /*OUTER*/ JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

-- ORACLE�� FULL OUTER �ȵ�
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID(+);

--------------------------------------------------------------------------------

-- 3. ���� ����(CROSS JOIN)(== DARTESIAN PRODUCT. ������)
-- ���εǴ� ���̺��� �� ����� ��� ���ε� �����Ͱ� �˻��Ǵ� ���
SELECT EMP_NAME FROM EMPLOYEE; -- 23��
SELECT DEPT_TITLE FROM DEPARTMENT; -- 9��

SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
CROSS JOIN DEPARTMENT; -- 207�� = 23 * 9

--------------------------------------------------------------------------------

-- 4. �� ����(NON EQAUL JOIN)
-- '='(��ȣ)�� ������� �ʴ� ���ι�
-- ������ �÷� ���� ��ġ�ϴ� ���(�)�� �ƴ�
-- ������ �÷� ���� ���� ���� ���� ���ԵǴ� ���� ��� ������ ����

-- EMPLOYEE, SAL_GRADE�� �����Ͽ�
-- �ڽ��� �޿���޿� �´� �޿��� �ް� �ִ� �������
-- �̸�, �޿�, �޿� ��� ��ȸ

SELECT EMP_NAME, SALARY, S.SAL_LEVEL
FROM EMPLOYEE E
JOIN SAL_GRADE S ON(SALARY BETWEEN MIN_SAL AND MAX_SAL);

--------------------------------------------------------------------------------

-- 5. ��ü ����(SELF JOIN)
-- ���� ���̺��� ����

-- EMPLOYEE ���̺���
-- ���, �̸�, ������ ���, ������ �̸� ��ȸ

-- ANSI���
SELECT E.EMP_ID ���, E.EMP_NAME �̸�, E.MANAGER_ID �����ڻ��, M.EMP_NAME �������̸�
FROM EMPLOYEE E
-- JOIN EMPLOYEE M ON(E.MANAGER_ID = M.EMP_ID); -- 15��(INNER JOIN)
LEFT JOIN EMPLOYEE M ON(E.MANAGER_ID = M.EMP_ID); -- 23��(LEFT OUTER JOIN)

-- ORACLE ���
SELECT E.EMP_ID, E.EMP_NAME ����̸�, E.DEPT_CODE, E.MANAGER_ID, M.EMP_NAME �������̸�
FROM EMPLOYEE E, EMPLOYEE M
-- WHERE E.MANAGER_ID = M.EMP_ID; -- 15��(� ����)
WHERE E.MANAGER_ID = M.EMP_ID(+); -- 23��(���� ���� ����)
--------------------------------------------------------------------------------

-- 6. �ڿ�����(NATURAL JOIN)
-- �����Ϸ��� �� ���̺���
-- ������ Ÿ�԰� �̸��� ���� �÷��� �ִٸ� �ڵ������� ������ �̷�������� �ϴ� ����.
-- * �ݵ�� ������ Ÿ�԰� �̸��� �÷��� �־����.
    --> �ش� ������ �������� ������ CROSS JOIN�� �Ͼ.

-- EMPLOYEE, JOB ���̺��� �����Ͽ�
-- ���, �̸�, �����ڵ�, ���޸� ��ȸ

-- ANSI
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE);

-- ORACLE
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;

-- NATURAL JOIN
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
NATURAL JOIN JOB;

-- �÷��� �Ǵ� ������ Ÿ���� �ٸ� ��� ũ�ν������� ��Ÿ��
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
NATURAL JOIN DEPARTMENT;








