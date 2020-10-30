-- �Լ� : �÷��� ���� �о ����� ����� ����
/*
    - ���� �� �Լ�(SINGLE ROW)
      �÷��� ��ϵ� N���� ���� �о N���� ����� �����ϴ� �Լ�
      
    - �׷� �Լ�(GROUP)
      �÷��� ��ϵ� N���� ���� �о 1���� ����� �����ϴ� �Լ�
    
    (���ǻ���)
    - ���� �� �Լ��� �׷� �Լ��� ���� ����� �� ����.
      --> ��� ���� ���� �ٸ��� ����
      
    - �Լ��� ����� �� �ִ� ��ġ
      --> SELECT��, WHERE��, ORDER BY��
      --> GROUP BY��, HAVING��
*/

--------------------------------------------------------------------------------

-- ���� �� �Լ�

-- 1. ���� ���� �Լ�

-- 1. LENGTH / LENGTHB
-- LENGTH : �־��� �÷� �������� ����
-- LENGTHB : �־��� �÷� �������� BYTE ũ��

-- EMPLOYEE ���̺��� ������, �̸���, �̸��� ���� ��ȸ
SELECT EMP_NAME, EMAIL, LENGTH(EMAIL)
FROM EMPLOYEE;

SELECT LENGTH('����Ŭ') FROM DUAL;
-- DUAL(DUMMY TABLE) : ���� ���̺�

SELECT LENGTH('ORACLE'), LENGTHB('ORACLE123') FROM DUAL;

SELECT LENGTHB('����Ŭ') FROM DUAL;

-- ORACLE EXPRESS EDITION (XE����) : ������ ���� ����
-- ����, ���� 1����Ʈ
-- �ѱ�, �ٸ����� �ܱ���, Ư������ �� �ƽ�Ű�ڵ� �̿��� ���� : 3����Ʈ
-- -> �÷��� ������ Ÿ���� NVARCHAR2�� ���(�����ڵ� ���� ���)

--------------------------------------------------------------------------------

-- 2) INSTR
-- ������ ��ġ���� ������ ���� ��°�� ��Ÿ���� ������ ���� ��ġ ��ȯ
-- [�ۼ���]
-- INSTR('���ڿ�'|�÷���, '����'[, �˻� ���� �ε��� [, ����]])

-- ù��° ����(1)���� �˻��Ͽ� 'B'�� ó�� ������ ��ġ ��ȸ
SELECT INSTR('AABAACBBAA', 'B', -1, 1) FROM DUAL;
--> ����Ŭ�� �ε����� 1���� ����

-- ù��° ����(1)���� �˻��Ͽ� 'B'�� �ι�°�� ������ ��ġ ��ȸ
SELECT INSTR('AABAACBBAA', 'B', 1, 2) FROM DUAL;

-- ������ ���ں��� �˻��Ͽ� 'B'�� ó�� ������ ��ġ ��ȸ
SELECT INSTR('AABAACBBAA', 'B', -1, 1) FROM DUAL;

-- EMPLOYEE ���̺���
-- �����, �̸���, �̸��Ͽ��� '@'�� ��ġ ��ȸ
SELECT EMP_NAME, EMAIL, INSTR(EMAIL, '@', 1, 1)
FROM EMPLOYEE;

--------------------------------------------------------------------------------

-- 3) TRIM
-- �־��� ���ڿ� �Ǵ� �÷� ���� ��/��/���ʿ� �ִ� ������ ���ڸ� ����
-- ������ ���ڰ� ���� ��� ������ �����Ѵ�.

SELECT '     KH     ' FROM DUAL;
SELECT TRIM('     KH     ') FROM DUAL;

-- ���� ����(BOTH, �⺻��)
SELECT TRIM('-' FROM '-----KH-----') FROM DUAL;
SELECT TRIM(BOTH '-' FROM '-----KH-----') FROM DUAL;

-- ���� ����(LEADING, LTRIM)
SELECT TRIM(LEADING '-' FROM '-----KH-----') FROM DUAL;
SELECT LTRIM('-----KH-----', '-') FROM DUAL;

-- ������ ����(TRAILING, RTRIM)
SELECT TRIM(TRAILING '-' FROM '-----KH-----') FROM DUAL;
SELECT RTRIM('-----KH-----', '-') FROM DUAL;

--------------------------------------------------------------------------------

/* 4) SUBSTR
    - �÷� ���̳� ���ڿ����� ������ ��ġ���� ������ ������ ���ڸ� �߶󳻾� ��ȯ�ϴ� �Լ�
    
    - [�ۼ���]
        SUBSTR(�÷���|'���ڿ�', POSITION [, LENGTH]
        POSITION : �߶󳻱� ������ ��ġ
        LENGTH : �߶� ����
*/

SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL;

-- 7������ ������ �߶󳻾� ��ȯ
SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL;

SELECT SUBSTR('SHOWMETHEMONEY', 1, 6) FROM DUAL;

-- ������ ���� 8��° ���� �߶󳻱� �����ؼ� 3���� �ڸ���
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL;

-- EMPLOYEE ���̺���
-- �����, �̸���, �̸��� ���̵� ��ȸ
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') - 1)
FROM EMPLOYEE;


