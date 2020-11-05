/*
    TCL(Transaction Control Language) : Ʈ����� ����(ó��) ���
    
    - COMMIT(Ʈ����� ���� ó�� �� ����)
    - ROLLBACK(Ʈ����� ���)
    - SAVEPOINT(�ӽ�����)
    
    
    Transaction�̶�?(�ڡڡڡڡ�)
    
     - �����ͺ��̽��� ������ �������
     - ������ ���� ����(DML)�� ���� �ϳ��� Ʈ����ǿ� ��� ó����.
        -> Ʈ������� ����� �Ǵ� SQL : INSERT, UPDATE, DELETE(DML)
    
    * COMMIT / ROLLBACK
      - COMMIT �Ǵ� ROLLBACK�� �ԷµǱ� �� ������
        SQL ������ DB�� �ݿ����� �ʰ�,
        �޸� ���ۿ� �ӽ� ����Ǿ� �ִ� ����
    
      - COMMIT �Է� : Ʈ����ǿ� �ӽ� ����� ������ -> DB�� �ݿ�
      
      - ROLLBACK �Է� : Ʈ����ǿ� ����� ������ ���� ����(DML)�� �����ϰ�
                        ������ COMMIT ���·� ���ư�.
                        
      *** ���ǻ���!
          DML���� �ۼ� ��
          �߰��� DDL���� (CREATE, ALTER, DROP, TRUNCATE)�� �ۼ��Ǹ�
          DDL���� ���� ������ DML ������ �ڵ� COMMIT��!!
          
      - SAVEPOINT
        Ʈ����ǿ� ���� ������ �����Ͽ�
        ROLLBACK�� ��ü �۾��� ROLLBACK�ϴ� ���� �ƴ�
        �� �������� ������ SAVEPOINT ������ ROLLBACK
          
      [�ۼ���]
        SAVEPOINT ����Ʈ��1;
        SAVEPOINT ����Ʈ��2;
        ...
        ROLLBACK TO ����Ʈ��1; ����Ʈ1���� ROLLBACK
*/

SELECT * FROM MEMBER;

-- ���� Ʈ������� DB�� �ݿ�
COMMIT;

-- MEMBER ���̺����� '���浿'�� �ִ� �� ���� ����
DELETE FROM MEMBER
WHERE MEMBER_NAME = '���浿';

-- ���� Ȯ��(ȭ������δ� ���� �Ȱ����� �������� ���� DB���� �ݿ� X)
SELECT * FROM MEMBER;

-- '���浿'�� ������ ���¸� SAVEPOINT�� ����
SAVEPOINT SP1;

-- '��ö��' ����
DELETE FROM MEMBER
WHERE MEMBER_NAME = '��ö��';

-- '��ö��' ���� Ȯ��
SELECT * FROM MEMBER;

-- SAVEPOINT SP1���� �ѹ�
ROLLBACK TO SP1;

-- �ѹ� Ȯ��
SELECT * FROM MEMBER;

-- '�迵��' ����
DELETE FROM MEMBER
WHERE MEMBER_NAME = '�迵��';

-- '�迵��' ���� Ȯ��
SELECT * FROM MEMBER;

-- ������ COMMIT ���·� ���ư��� == ROLLBACK
ROLLBACK;

-- �ѹ� Ȯ��
SELECT * FROM MEMBER;



