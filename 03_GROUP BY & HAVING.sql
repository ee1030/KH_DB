/*
    SELCCT�� �ؼ� ����
    
    5 : SELECT �÷��� AS ��Ī, ����, �Լ���
    1 : FROM ������ ���̺��
         + JOIN
    2 : WHERE �÷��� | �Լ��� | ����� TRUE/FALSE
    3 : GROUP BY �׷��� ���� �÷���
    4 : HAVING �׷��Լ��� �񱳿����� �񱳰�
    6 : ORDER BY �÷��� | �÷����� | ��Ī ���Ĺ�� [NULLS FIRST|LAST]
*/

--------------------------------------------------------------------------------

-- GROUP BY

-- �μ��� �޿� �� ��ȸ
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

/*
    GROUP BY�� : ���� ������ ������ ��ϵ� �÷��� ������
                 ���� �÷����� �ϳ��� �׷����� ���� ����.
                 
    GROUP BY �÷��� | �Լ���[, �÷��� | �Լ���, ...]
    
    - GROUP BY�� ������ �׷� �� ��ŭ �׷� �Լ� ����� ��ȸ��.
    
    ** GROUP BY��� ��
    SELECT ������ GROUP BY�� �ۼ��� �÷��� �Ǵ� �׷��Լ��� �ۼ� ������
*/

-- EMPLOYEE ���̺���
-- �μ��ڵ�, �μ��� �޿���, �μ��� �޿� ���, �μ��� �ο� ��
-- �μ��ڵ� ������ ��ȸ
SELECT DEPT_CODE, SUM(SALARY) "�޿� ��",
    FLOOR(AVG(SALARY)) "�޿� ���",
    COUNT(*) "�ο� ��"
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- EMPLOYEE ���̺���
-- �μ����� ���ʽ��� �޴� ����� ����
-- �μ� �������� ��ȸ
SELECT DEPT_CODE, COUNT(BONUS)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE DESC NULLS LAST;

-- EMPLOYEE ���̺���
-- �� ������ �޿� ���, �޿� ��, �ο� ����
-- �ο� �� ������������ ��ȸ
SELECT DECODE(SUBSTR(EMP_NO, 8, 1), '1', '����', '2', '����') ����,
FLOOR(AVG(SALARY)) "�޿� ���", SUM(SALARY) "�޿� ��", COUNT(*) "�ο� ��"
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO, 8, 1), '1', '����', '2', '����')
ORDER BY 4 DESC;

--------------------------------------------------------------------------------

-- WHERE���� GROUP BY�� ȥ�ջ��
-- - WHERE���� �ؼ� �켱������ �� ����!
     --> �� �÷����� ���� ������ ���� �� ����ϴ°� WHERE���̴�.

-- EMPLOYEE ���̺��� �μ��ڵ尡 'D5', 'D6'�� �μ��� �޿� ��� ��ȸ
SELECT DEPT_CODE, FLOOR(AVG(SALARY))
FROM EMPLOYEE
WHERE DEPT_CODE IN('D5', 'D6')
GROUP BY DEPT_CODE;

-- EMPLOYEE ���̺���
-- ���� �ڵ庰 2000�⵵ ���� �Ի��� �Ի��ڵ��� �޿� ����
-- �����ڵ� ������������ ��ȸ
SELECT JOB_CODE "���� �ڵ�", SUM(SALARY)"�޿� ��"
FROM EMPLOYEE
WHERE EXTRACT(YEAR FROM HIRE_DATE) >= 2000
-- WHERE HIRE_DATE >= TO_DATE('20000101', 'YYYYMMDD')
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

--------------------------------------------------------------------------------

-- ���� �÷��� ��� �׷����� �����ϴ� ���

-- EMPLOYEE ���̺���
-- �μ����� Ư�� �����ڵ��� �ο� ���� �޿� ����
-- �μ��ڵ� ��������, �����ڵ� ������������ ��ȸ
SELECT DEPT_CODE, JOB_CODE, COUNT(*) "�ο� ��", SUM(SALARY) "�޿� ��"
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY DEPT_CODE, JOB_CODE DESC;

-- ** GROUP BY���� �ۼ����� ���� �÷��� SELECT���� �ۼ��� �� ����~~!~!~!~!~!

-- EMPLPYEE ���̺��� �μ� ���� �޿� ����� ���� ������ ����
-- �μ��ڵ庰 �޿� ��� ������������ ����

SELECT DEPT_CODE, SAL_LEVEL, COUNT(*) "�ο� ��"
FROM EMPLOYEE
GROUP BY DEPT_CODE, SAL_LEVEL
ORDER BY DEPT_CODE, SAL_LEVEL;

--------------------------------------------------------------------------------

/*
    HAVING �� : �׷쿡 ���� ������ ������ �� ����ϴ� ����
    
    HAVING �÷��� | �Լ���
*/

-- EMPLOYEE ���̺��� �μ��� �޿� ����� 3�鸸 �̻��� �μ���
-- �μ��ڵ� ������������ ��ȸ
SELECT DEPT_CODE, FLOOR(AVG(SALARY)) "�μ� �޿� ���"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING FLOOR(AVG(SALARY)) >= 3000000
ORDER BY DEPT_CODE;

-- EMPLOYEE ���̺��� �μ��� �޿� ���� 9�鸸 �ʰ��� �μ���
-- �μ��ڵ� ������������ ��ȸ
SELECT DEPT_CODE, TO_CHAR(SUM(SALARY), 'L999,999,999') "�޿� ��"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) > 9000000
ORDER BY DEPT_CODE;

-- 1. EMPLOYEE ���̺��� �� �μ��� ���� ���� �޿�, ���� ���� �޿��� ��ȸ�Ͽ�
-- �μ� �ڵ� ������������ �����ϼ���.
SELECT DEPT_CODE, MAX(SALARY) "�ְ� �޿�", MIN(SALARY) "�ּ� �޿�"
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;


-- 2. EMPLOYEE ���̺��� �� ���޺� ���ʽ��� �޴� ����� ���� ��ȸ�Ͽ�
-- �����ڵ� ������������ �����ϼ���
SELECT JOB_CODE, COUNT(BONUS) "��� ��"
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-- 3. EMPLOYEE ���̺��� 
-- �μ��� 70������ �޿� ����� 300�� �̻��� �μ��� ��ȸ�Ͽ�
-- �μ� �ڵ� ������������ �����ϼ���
SELECT DEPT_CODE, TO_CHAR(FLOOR(AVG(SALARY)), 'L999,999,999') "�޿� ���"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 1, 2) BETWEEN 70 AND 79
GROUP BY DEPT_CODE
HAVING FLOOR(AVG(SALARY)) >= 3000000
ORDER BY DEPT_CODE;

--------------------------------------------------------------------------------

-- �����Լ�
-- �׷� �� ���� ����� ����ϴ� �Լ�
-- GROUP BY������ �ۼ� ������ �Լ�

-- EMPLOYEE ���̺��� ���޺� �޿� ����
-- ���� �ڵ� ������������ ��ȸ
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-- ��� ������ �޿� �� ��ȸ
SELECT SUM(SALARY) FROM EMPLOYEE;

-- ROLLUP ���� �Լ� : 
-- �׷캰 '�߰� ����'�� '��ü ����'�� ����Ͽ� ����� �࿡ �ڵ� �߰����ִ� �Լ�

SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE)
ORDER BY JOB_CODE;

-- EMPLOYEE ���̺���
-- �� �μ��� �Ҽӵ� ���޺� �޿� ���� ��ȸ.
-- ��, �μ��� �޿� ��,
-- ���޺� �޿� ��,
-- ��ü �޿� �� ����� �߰�
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY 1;

--------------------------------------------------------------------------------

-- CUBE ���� �Լ� : ROLLUP + �׷����� ������ ��� �׷쿡 ���� ���� ��� �߰�

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY 1;

--------------------------------------------------------------------------------

-- GROUPING �Լ�
-- ROLLUP, CUBE�� ���� ���⹰��
-- ���ڷ� ���޹��� �÷� ������ ���⹰�̸� 0
-- �ƴϸ� 1�� ��ȯ�ϴ� �Լ�


SELECT DEPT_CODE, JOB_CODE, SUM(SALARY),
    GROUPING(DEPT_CODE) "�μ��� �׷�",
    GROUPING(JOB_CODE) "���޺� �׷�"
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY 1;


SELECT DEPT_CODE, JOB_CODE, SUM(SALARY),
    CASE WHEN GROUPING(DEPT_CODE) = 0 AND GROUPING(JOB_CODE) = 1 THEN '�μ�'
         WHEN GROUPING(DEPT_CODE) = 1 AND GROUPING(JOB_CODE) = 0 THEN '����'
         WHEN GROUPING(DEPT_CODE) = 1 AND GROUPING(JOB_CODE) = 1 THEN '����'
         ELSE '�μ�+����'
    END "���� �׷�"
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY 1;

--------------------------------------------------------------------------------

/*
    ���� ������(SET OPERATOR)
    - ���� SELECT���� �����(RESULT SET)�� �ϳ��� ����� ������
    - ���� ���� ���ǿ� ���� ����� �ٸ� SELECT���� �ϳ��� �����ϰ� ���� �� ���.
    - ������ �����Ͽ� �ʺ��ڵ��� ����ϱ� ����.
    
    ** ���ǻ���
    SELECT���� SELECT���� ��� �����ؾ� �Ѵ�
*/

-- UNION(������) : RESULT SET�� �ϳ��� ��ġ�� ������
-- �ߺ��Ǵ� ���� �ѹ��� ��ȸ��.

-- EMPLOYEE ���̺���
-- �μ��ڵ尡 'D5'�� ���� �̰ų�
-- �޿��� 300�� �ʰ��� ������
-- ���, �̸�, �μ��ڵ�, �޿��� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- UNION�� OR ����� ���� ����� ��ȯ��.
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR SALARY > 3000000;


-- INTERSECT(������)
-- RESULT SET�� ����Ǵ� �ุ ��ȸ

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- INTERSECT�� AND ����� ���� ����� ��ȯ��.
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY > 3000000;

-- UNION ALL(������ + ������)

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- MINUS(������) : ���� RESULT SET���� ���� RESULT SET�� ��ġ�ϴ� �κ��� �����Ѵ�.
-- �μ��ڵ尡 'D5'�� ���� �� �޿��� 300���� �ʰ��� ����� ������ ����� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- �޿��� 300�� �ʰ��� ����� �� �μ��ڵ尡 'D5'�� ����� ������ ����� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';







