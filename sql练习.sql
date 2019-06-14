-- 1.��ѯ��������һ��Ա�������в���
SELECT DISTINCT d.*
FROM emp e,dept d
WHERE e.deptno = d.deptno
SELECT * FROM EMP   
-- 2.��ѯ���������ƺ���Щ���ŵ�Ա����Ϣ��ͬʱ��ѯ��û��Ա���Ĳ���
SELECT d.dname,e.*
FROM dept d LEFT JOIN emp e
ON d.deptno = e.deptno
-- 3.��ѯ���С�CLERK"(����Ա) �������Ͳ������ƣ��Լ���������
SELECT S2.NUM,S1.ENAME,S1.DNAME
FROM(SELECT E.ENAME,D.DNAME,E.DEPTNO FROM EMP E,DEPT D WHERE JOB='CLERK' AND E.DEPTNO=D.DEPTNO) S1,(SELECT COUNT(1) NUM,DEPTNO FROM EMP GROUP BY DEPTNO) S2
WHERE S1.DEPTNO=S2.DEPTNO
-- 4.��ѯ������Ա����������ֱ���ϼ�������
SELECT e1.ename,e2.ename
FROM emp e1 LEFT JOIN emp e2
ON e1.mgr=e2.empno

-- 5.��ѯ��job��Ա�����ʵ����ֵ����Сֵ��ƽ��ֵ���ܺ�
SELECT MAX(sal),MIN(SAL),AVG(nvl(SAL,0)),SUM(nvl(SAL,0)),JOB
FROM emp
GROUP BY JOB 
-- 6.ѡ��ͳ�Ƹ���job��Ա������(��ʾ:��job���з���)
SELECT COUNT(1),JOB FROM EMP GROUP BY JOB   
-- 7.��ѯԱ����߹��ʺ���͹��ʵĲ��,����ΪDIFFERENCE��
SELECT (MAX(SAL)-MIN(SAL)) DIFFERENCE FROM EMP

-- 8.��ѯ��������������Ա������͹��ʣ�������͹��ʲ��ܵ���800��û�й����ߵ�Ա������������
SELECT e1.empno,MIN(e2.sal)
FROM emp e1,emp e2
WHERE e1.empno = e2.mgr GROUP BY e1.empno HAVING MIN(e2.sal) >= 800

-- 9.��ѯ���в��ŵĲ�������dname������λ��loc��Ա�������͹���ƽ��ֵ�� 
SELECT d2.*,d1.loc
FROM dept d1,(
SELECT COUNT(1) NUM,AVG(NVL(sal,0)) average,e.deptno
FROM emp e,dept d
WHERE e.deptno=d.deptno GROUP BY e.deptno) d2
WHERE d1.deptno=d2.deptno    

-- 10.��ѯ��scott��ͬ���ŵ�Ա������ename�͹�������hiredate
SELECT ename,hiredate
FROM emp
WHERE deptno IN (SELECT deptno FROM emp WHERE ename='SCOTT')

--11.��ѯ���ʱȹ�˾ƽ�����ʸߵ�����Ա����Ա����empno������ename�͹���sal��
SELECT empno,ename,sal FROM emp WHERE sal>(SELECT AVG(NVL(sal,0)) FROM emp)

--12.��ѯ�������а�����ĸu��Ա������ͬ���ŵ�Ա����Ա����empno������ename
SELECT empno,ename FROM emp WHERE deptno IN (SELECT deptno FROM emp WHERE ename LIKE '%U%')

--13.��ѯ�ڲ��ŵ�locΪnewYork�Ĳ��Ź�����Ա����Ա������ename����������dname�͸�λ����job

SELECT e.ename,d.dname,e.job
FROM emp e,(SELECT deptno,dname FROM dept WHERE loc='NEW YORK') d
WHERE e.deptno=d.deptno
-- 14.��ѯ��������king��Ա������ename�͹���sal
 
SELECT ename,sal
FROM emp
WHERE mgr IN (SELECT empno FROM emp WHERE ename='KING')

--15.��ʾsales��������Щְλ
SELECT DISTINCT JOB,DEPTNO
FROM EMP
WHERE DEPTNO IN (SELECT deptno FROM dept WHERE dname='SALES')   

--16.���������й��ʴ���1500��Ա������
SELECT COUNT(1),deptno NUM FROM emp WHERE sal>1500 GROUP BY deptno 

--17.��ЩԱ���Ĺ��ʣ�����������˾��ƽ�����ʣ��г�Ա�������ֺ͹��ʣ�����
SELECT ename,sal
FROM emp
WHERE sal>(SELECT AVG(NVL(sal,0)) FROM emp ) ORDER BY sal DESC

-- 18.���ڲ���ƽ�����ʸ���1500��Ա������
SELECT ename
FROM emp
WHERE deptno IN (SELECT deptno FROM emp GROUP BY deptno HAVING AVG(NVL(sal,0))>1500)
  
--19.�г����������й�����ߵ�Ա������Ϣ�����֡����źš����� 
SELECT ename,deptno,sal
FROM emp
WHERE sal IN (SELECT MAX(sal) FROM emp GROUP BY deptno )

--20.�ĸ����ŵ�ƽ����������ߵģ��г����źš�ƽ������
SELECT s.* FROM (SELECT AVG(NVL(sal,0)),deptno FROM emp GROUP BY deptno ORDER BY AVG(NVL(sal,0)) DESC) s WHERE ROWNUM =1

--21.�г����ʸ��ڱ�����ƽ�����ʵ��˵���Ϣ��
SELECT e.*
FROM emp e,(SELECT AVG(NVL(sal,0)) s,deptno FROM emp GROUP BY deptno) d
WHERE e.deptno=d.deptno AND e.sal>d.s
