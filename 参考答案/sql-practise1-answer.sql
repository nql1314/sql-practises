#1.��ѯStudent���е����м�¼��Sname��Ssex��Class�С�
SELECT Sname,Ssex,Class
FROM Student;
#2.��ѯ��ʦ���еĵ�λ�����ظ���Depart�С�
SELECT DISTINCT Depart
FROM Teachers;
#3.��ѯStudent������м�¼��
SELECT *
FROM Students;
#4.��ѯScore���гɼ���60��80֮������м�¼��
SELECT *
FROM Scores
WHERE Degree BETWEEN 60 AND 80;
#5.��ѯScore���гɼ�Ϊ85��86��88�ļ�¼��
SELECT *
FROM Scores
WHERE Degree IN (85,86,88);
#6.��ѯStudent���С�95031������Ա�Ϊ��Ů����ͬѧ��¼��
SELECT *
FROM Students
WHERE Class='95031' OR Ssex='Ů';
#7.��Class�����ѯStudent������м�¼��
SELECT *
FROM Students
ORDER BY Class DESC;
#8.��Cno����Degree�����ѯScore������м�¼��
SELECT *
FROM Scores
ORDER BY Cno,Degree DESC;
#9.��ѯ��95031�����ѧ��������
SELECT COUNT(1) AS StuNum
FROM Students
WHERE Class='95031';
#10.��ѯScore���е���߷ֵ�ѧ��ѧ�źͿγ̺š�
SELECT Sno,Cno
FROM Scores
ORDER BY Degree DESC
LIMIT 1;
#11.��ѯ��3-105���ſγ̵�ƽ���֡�
SELECT AVG(Degree)
FROM Scores
WHERE Cno='3-105';
#12.��ѯScore����������5��ѧ��ѡ�޵Ĳ���3��ͷ�Ŀγ̵�ƽ��������
SELECT Cno,AVG(Degree)
FROM Scores
WHERE Cno LIKE '3%'
GROUP BY Cno
HAVING COUNT(Sno) >= 5;
#13.��ѯ��ͷִ���70����߷�С��90��Sno�С�
SELECT Sno
FROM Scores
GROUP BY Sno
HAVING MAX(Degree)<90 AND MIN(Degree)>70;
#14.��ѯ����ѧ����Sname��Cno��Degree�С�
SELECT Sname,Cno,Degree
FROM Students INNER JOIN Scores
    ON(Students.Sno=Scores.Sno)
ORDER BY Sname;
#15.��ѯ����ѧ����Sno��Cname��Degree�С�
SELECT Sno,Cname,Degree
FROM Scores INNER JOIN Courses
    ON(Scores.Cno=Courses.Cno)
ORDER BY Sno;
#16.��ѯ����ѧ����Sname��Cname��Degree�С�
SELECT Sname,Cname,Degree
FROM Students INNER JOIN Scores
    ON(Students.Sno=Scores.Sno) INNER JOIN Courses
    ON(Scores.Cno=Courses.Cno)
ORDER BY Sname;
#17.��ѯ��95033������ѡ�γ̵�ƽ���֡�
SELECT Cname,AVG(Degree)
FROM Students INNER JOIN Scores
    ON(Students.Sno=Scores.Sno) INNER JOIN Courses
    ON(Scores.Cno=Courses.Cno)
WHERE Class='95033'
GROUP BY Courses.Cno
ORDER BY Cname;
#18.����ʹ�������������һ��grade��(��)�ֲ�ѯ����ͬѧ��Sno��Cno��rank�С�
SELECT Sno,Cno,rank
FROM Scores INNER JOIN grade
    ON(Scores.Degree>=grade.low AND Scores.Degree<=grade.upp)
ORDER BY Sno;
#19.��ѯѡ�ޡ�3-105���γ̵ĳɼ����ڡ�109����ͬѧ�ɼ�������ͬѧ�ļ�¼��
SELECT s1.Sno,s1.Degree
FROM Scores AS s1 INNER JOIN Scores AS s2
    ON(s1.Cno=s2.Cno AND s1.Degree>s2.Degree)
WHERE s1.Cno='3-105' AND s2.Sno='109'
ORDER BY s1.Sno;
#20.��ѯscore��ѡѧһ�����Ͽγ̵�ͬѧ�з���Ϊ����߷ֳɼ��ļ�¼��
SELECT *
FROM Scores
GROUP BY Sno
HAVING COUNT(cno)>1 AND Degree!=MAX(Degree);
#21.��ѯ�ɼ�����ѧ��Ϊ��109�����γ̺�Ϊ��3-105���ĳɼ������м�¼��
SELECT s1.Sno,s1.Degree
FROM Scores AS s1 INNER JOIN Scores AS s2
    ON(s1.Cno=s2.Cno AND s1.Degree>s2.Degree)
WHERE s1.Cno='3-105' AND s2.Sno='109'
ORDER BY s1.Sno;
#22.��ѯ��ѧ��Ϊ108��ͬѧͬ�����������ѧ����Sno��Sname��Sbirthday�С�
SELECT s1.Sno,s1.Sname,s1.Sbirthday
FROM Students AS s1 INNER JOIN Students AS s2
    ON(YEAR(s1.Sbirthday)=YEAR(s2.Sbirthday))
WHERE s2.Sno='108';
#23.��ѯ�����񡰽�ʦ�οε�ѧ���ɼ���
SELECT Sno,Degree
FROM Scores INNER JOIN Courses
    ON(Scores.Cno=Courses.Cno) INNER JOIN Teachers
    ON(Courses.Tno=Teachers.Tno)
WHERE Teachers.Tname='����';
#24.��ѯѡ��ĳ�γ̵�ͬѧ��������5�˵Ľ�ʦ������
SELECT DISTINCT Tname
FROM Scores INNER JOIN Courses
    ON(Scores.Cno=Courses.Cno) INNER JOIN Teachers
    ON(Courses.Tno=Teachers.Tno)
WHERE Courses.Cno IN(SELECT Cno FROM Scores GROUP BY(Cno) HAVING COUNT(Sno)>5);
#25.��ѯ95033���95031��ȫ��ѧ���ļ�¼��
SELECT *
FROM Students
WHERE Class IN ('95033','95031')
ORDER BY Class;
#26.��ѯ������85�����ϳɼ��Ŀγ�Cno.
SELECT DISTINCT Cno
FROM Scores
WHERE Degree>85;
#27.��ѯ���������ϵ����ʦ���̿γ̵ĳɼ���
SELECT Tname,Cname,SName,Degree
FROM Teachers INNER JOIN Courses
    ON(Teachers.Tno=Courses.Tno) INNER JOIN Scores
    ON(Courses.Cno=Scores.Cno) INNER JOIN Students
    ON(Scores.Sno=Students.Sno)
WHERE Teachers.Depart='�����ϵ'
ORDER BY Tname,Cname,Degree DESC;
#28.��ѯ�������ϵ���롰���ӹ���ϵ����ְͬ�ƵĽ�ʦ��Tname��Prof��
SELECT Tname,Prof
FROM Teachers
WHERE Depart='�����ϵ' AND Prof NOT IN(
  SELECT DISTINCT Prof
  FROM Teachers
  WHERE Depart='���ӹ���ϵ');
#29.��ѯѡ�ޱ��Ϊ��3-105���γ��ҳɼ����ٸ�������ѡ�ޱ��Ϊ��3-245����ͬѧ�ĳɼ���Cno��Sno��Degree,����Degree�Ӹߵ��ʹ�������
SELECT Cno,Sno,Degree
FROM Scores
WHERE Cno='3-105' AND Degree > ANY(
  SELECT Degree
  FROM Scores
  WHERE Cno='3-245')
ORDER BY Degree DESC;
#30.��ѯѡ�ޱ��Ϊ��3-105���ҳɼ���������ѡ�ޱ��Ϊ��3-245���γ̵�ͬѧ��Cno��Sno��Degree.
SELECT Cno,Sno,Degree
FROM Scores
WHERE Cno='3-105' AND Degree > ALL(
  SELECT Degree
  FROM Scores
  WHERE Cno='3-245')
ORDER BY Degree DESC;
#31.��ѯ���н�ʦ��ͬѧ��name��sex��birthday.
SELECT Sname,Ssex,Sbirthday
FROM Students
UNION
SELECT Tname,Tsex,Tbirthday
FROM Teachers;
#32.��ѯ���С�Ů����ʦ�͡�Ů��ͬѧ��name��sex��birthday.
SELECT Sname,Ssex,Sbirthday
FROM Students
WHERE Ssex='Ů'
UNION
SELECT Tname,Tsex,Tbirthday
FROM Teachers
WHERE Tsex='Ů';
#33.��ѯ�ɼ��ȸÿγ�ƽ���ɼ��͵�ͬѧ�ĳɼ���
SELECT s1.*
FROM Scores AS s1 INNER JOIN (
                               SELECT Cno,AVG(Degree) AS aDegree
                               FROM Scores
                               GROUP BY Cno) s2
    ON(s1.Cno=s2.Cno AND s1.Degree<s2.aDegree);
#34.��ѯ�����ον�ʦ��Tname��Depart.
SELECT Tname,Depart
FROM Teachers
WHERE Tno IN(
  SELECT Tno
  FROM Courses
);
#35.��ѯ����δ���εĽ�ʦ��Tname��Depart.
SELECT Tname,Depart
FROM Teachers
WHERE Tno NOT IN(
  SELECT Tno
  FROM Courses
);
#36.��ѯ������2�������İ�š�
SELECT Class,COUNT(1) AS boyCount
FROM Students
WHERE Ssex='��'
GROUP BY Class
HAVING boyCount>=2;
#37.��ѯStudent���в��ա�������ͬѧ��¼��
SELECT *
FROM Students
WHERE Sname NOT LIKE '��%';
#38.��ѯStudent����ÿ��ѧ�������������䡣
SELECT Sname,YEAR(NOW())-YEAR(Sbirthday) AS Sage
FROM Students;
#39.��ѯStudent����������С��Sbirthday����ֵ��
SELECT MIN(Sbirthday),MAX(Sbirthday)
FROM Students;
#40.�԰�ź�����Ӵ�С��˳���ѯStudent���е�ȫ����¼��
SELECT *
FROM Students
ORDER BY Class DESC,Sbirthday ASC;
#41.��ѯ���С���ʦ�������ϵĿγ̡�
SELECT Teachers.Tname,Courses.Cname
FROM Teachers INNER JOIN Courses
    ON(Teachers.Tno=Courses.Tno)
WHERE Teachers.Tsex='��';
#42.��ѯ��߷�ͬѧ��Sno��Cno��Degree�С�
SELECT *
FROM Scores
GROUP BY Cno
HAVING Degree=Max(Degree);
#43.��ѯ�͡������ͬ�Ա������ͬѧ��Sname.
SELECT s1.Sname
FROM Students AS s1 INNER JOIN Students AS s2
    ON(s1.Ssex=s2.Ssex)
WHERE s2.Sname='���';
#44.��ѯ�͡������ͬ�Ա�ͬ���ͬѧSname.
SELECT s1.Sname
FROM Students AS s1 INNER JOIN Students AS s2
    ON(s1.Ssex=s2.Ssex AND s1.Class=s2.Class)
WHERE s2.Sname='���';
#45.��ѯ����ѡ�ޡ���������ۡ��γ̵ġ��С�ͬѧ�ĳɼ���
SELECT *
FROM Scores
WHERE Sno IN (
  SELECT Sno
  FROM Students
  WHERE Ssex='��') AND
      Cno IN (
        SELECT Cno
        FROM Courses
        WHERE Cname='���������');