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
GROUP BY JOB_CODE
ORDER BY JOB_CODE;







