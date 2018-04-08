#1.查询Student表中的所有记录的Sname、Ssex和Class列。
SELECT Sname,Ssex,Class
FROM Student;
#2.查询教师所有的单位即不重复的Depart列。
SELECT DISTINCT Depart
FROM Teachers;
#3.查询Student表的所有记录。
SELECT *
FROM Students;
#4.查询Score表中成绩在60到80之间的所有记录。
SELECT *
FROM Scores
WHERE Degree BETWEEN 60 AND 80;
#5.查询Score表中成绩为85，86或88的记录。
SELECT *
FROM Scores
WHERE Degree IN (85,86,88);
#6.查询Student表中“95031”班或性别为“女”的同学记录。
SELECT *
FROM Students
WHERE Class='95031' OR Ssex='女';
#7.以Class降序查询Student表的所有记录。
SELECT *
FROM Students
ORDER BY Class DESC;
#8.以Cno升序、Degree降序查询Score表的所有记录。
SELECT *
FROM Scores
ORDER BY Cno,Degree DESC;
#9.查询“95031”班的学生人数。
SELECT COUNT(1) AS StuNum
FROM Students
WHERE Class='95031';
#10.查询Score表中的最高分的学生学号和课程号。
SELECT Sno,Cno
FROM Scores
ORDER BY Degree DESC
LIMIT 1;
#11.查询‘3-105’号课程的平均分。
SELECT AVG(Degree)
FROM Scores
WHERE Cno='3-105';
#12.查询Score表中至少有5名学生选修的并以3开头的课程的平均分数。
SELECT Cno,AVG(Degree)
FROM Scores
WHERE Cno LIKE '3%'
GROUP BY Cno
HAVING COUNT(Sno) >= 5;
#13.查询最低分大于70，最高分小于90的Sno列。
SELECT Sno
FROM Scores
GROUP BY Sno
HAVING MAX(Degree)<90 AND MIN(Degree)>70;
#14.查询所有学生的Sname、Cno和Degree列。
SELECT Sname,Cno,Degree
FROM Students INNER JOIN Scores
    ON(Students.Sno=Scores.Sno)
ORDER BY Sname;
#15.查询所有学生的Sno、Cname和Degree列。
SELECT Sno,Cname,Degree
FROM Scores INNER JOIN Courses
    ON(Scores.Cno=Courses.Cno)
ORDER BY Sno;
#16.查询所有学生的Sname、Cname和Degree列。
SELECT Sname,Cname,Degree
FROM Students INNER JOIN Scores
    ON(Students.Sno=Scores.Sno) INNER JOIN Courses
    ON(Scores.Cno=Courses.Cno)
ORDER BY Sname;
#17.查询“95033”班所选课程的平均分。
SELECT Cname,AVG(Degree)
FROM Students INNER JOIN Scores
    ON(Students.Sno=Scores.Sno) INNER JOIN Courses
    ON(Scores.Cno=Courses.Cno)
WHERE Class='95033'
GROUP BY Courses.Cno
ORDER BY Cname;
#18.假设使用如下命令建立了一个grade表(略)现查询所有同学的Sno、Cno和rank列。
SELECT Sno,Cno,rank
FROM Scores INNER JOIN grade
    ON(Scores.Degree>=grade.low AND Scores.Degree<=grade.upp)
ORDER BY Sno;
#19.查询选修“3-105”课程的成绩高于“109”号同学成绩的所有同学的记录。
SELECT s1.Sno,s1.Degree
FROM Scores AS s1 INNER JOIN Scores AS s2
    ON(s1.Cno=s2.Cno AND s1.Degree>s2.Degree)
WHERE s1.Cno='3-105' AND s2.Sno='109'
ORDER BY s1.Sno;
#20.查询score中选学一门以上课程的同学中分数为非最高分成绩的记录。
SELECT *
FROM Scores
GROUP BY Sno
HAVING COUNT(cno)>1 AND Degree!=MAX(Degree);
#21.查询成绩高于学号为“109”、课程号为“3-105”的成绩的所有记录。
SELECT s1.Sno,s1.Degree
FROM Scores AS s1 INNER JOIN Scores AS s2
    ON(s1.Cno=s2.Cno AND s1.Degree>s2.Degree)
WHERE s1.Cno='3-105' AND s2.Sno='109'
ORDER BY s1.Sno;
#22.查询和学号为108的同学同年出生的所有学生的Sno、Sname和Sbirthday列。
SELECT s1.Sno,s1.Sname,s1.Sbirthday
FROM Students AS s1 INNER JOIN Students AS s2
    ON(YEAR(s1.Sbirthday)=YEAR(s2.Sbirthday))
WHERE s2.Sno='108';
#23.查询“张旭“教师任课的学生成绩。
SELECT Sno,Degree
FROM Scores INNER JOIN Courses
    ON(Scores.Cno=Courses.Cno) INNER JOIN Teachers
    ON(Courses.Tno=Teachers.Tno)
WHERE Teachers.Tname='张旭';
#24.查询选修某课程的同学人数多于5人的教师姓名。
SELECT DISTINCT Tname
FROM Scores INNER JOIN Courses
    ON(Scores.Cno=Courses.Cno) INNER JOIN Teachers
    ON(Courses.Tno=Teachers.Tno)
WHERE Courses.Cno IN(SELECT Cno FROM Scores GROUP BY(Cno) HAVING COUNT(Sno)>5);
#25.查询95033班和95031班全体学生的记录。
SELECT *
FROM Students
WHERE Class IN ('95033','95031')
ORDER BY Class;
#26.查询存在有85分以上成绩的课程Cno.
SELECT DISTINCT Cno
FROM Scores
WHERE Degree>85;
#27.查询出“计算机系“教师所教课程的成绩表。
SELECT Tname,Cname,SName,Degree
FROM Teachers INNER JOIN Courses
    ON(Teachers.Tno=Courses.Tno) INNER JOIN Scores
    ON(Courses.Cno=Scores.Cno) INNER JOIN Students
    ON(Scores.Sno=Students.Sno)
WHERE Teachers.Depart='计算机系'
ORDER BY Tname,Cname,Degree DESC;
#28.查询“计算机系”与“电子工程系“不同职称的教师的Tname和Prof。
SELECT Tname,Prof
FROM Teachers
WHERE Depart='计算机系' AND Prof NOT IN(
  SELECT DISTINCT Prof
  FROM Teachers
  WHERE Depart='电子工程系');
#29.查询选修编号为“3-105“课程且成绩至少高于任意选修编号为“3-245”的同学的成绩的Cno、Sno和Degree,并按Degree从高到低次序排序。
SELECT Cno,Sno,Degree
FROM Scores
WHERE Cno='3-105' AND Degree > ANY(
  SELECT Degree
  FROM Scores
  WHERE Cno='3-245')
ORDER BY Degree DESC;
#30.查询选修编号为“3-105”且成绩高于所有选修编号为“3-245”课程的同学的Cno、Sno和Degree.
SELECT Cno,Sno,Degree
FROM Scores
WHERE Cno='3-105' AND Degree > ALL(
  SELECT Degree
  FROM Scores
  WHERE Cno='3-245')
ORDER BY Degree DESC;
#31.查询所有教师和同学的name、sex和birthday.
SELECT Sname,Ssex,Sbirthday
FROM Students
UNION
SELECT Tname,Tsex,Tbirthday
FROM Teachers;
#32.查询所有“女”教师和“女”同学的name、sex和birthday.
SELECT Sname,Ssex,Sbirthday
FROM Students
WHERE Ssex='女'
UNION
SELECT Tname,Tsex,Tbirthday
FROM Teachers
WHERE Tsex='女';
#33.查询成绩比该课程平均成绩低的同学的成绩表。
SELECT s1.*
FROM Scores AS s1 INNER JOIN (
                               SELECT Cno,AVG(Degree) AS aDegree
                               FROM Scores
                               GROUP BY Cno) s2
    ON(s1.Cno=s2.Cno AND s1.Degree<s2.aDegree);
#34.查询所有任课教师的Tname和Depart.
SELECT Tname,Depart
FROM Teachers
WHERE Tno IN(
  SELECT Tno
  FROM Courses
);
#35.查询所有未讲课的教师的Tname和Depart.
SELECT Tname,Depart
FROM Teachers
WHERE Tno NOT IN(
  SELECT Tno
  FROM Courses
);
#36.查询至少有2名男生的班号。
SELECT Class,COUNT(1) AS boyCount
FROM Students
WHERE Ssex='男'
GROUP BY Class
HAVING boyCount>=2;
#37.查询Student表中不姓“王”的同学记录。
SELECT *
FROM Students
WHERE Sname NOT LIKE '王%';
#38.查询Student表中每个学生的姓名和年龄。
SELECT Sname,YEAR(NOW())-YEAR(Sbirthday) AS Sage
FROM Students;
#39.查询Student表中最大和最小的Sbirthday日期值。
SELECT MIN(Sbirthday),MAX(Sbirthday)
FROM Students;
#40.以班号和年龄从大到小的顺序查询Student表中的全部记录。
SELECT *
FROM Students
ORDER BY Class DESC,Sbirthday ASC;
#41.查询“男”教师及其所上的课程。
SELECT Teachers.Tname,Courses.Cname
FROM Teachers INNER JOIN Courses
    ON(Teachers.Tno=Courses.Tno)
WHERE Teachers.Tsex='男';
#42.查询最高分同学的Sno、Cno和Degree列。
SELECT *
FROM Scores
GROUP BY Cno
HAVING Degree=Max(Degree);
#43.查询和“李军”同性别的所有同学的Sname.
SELECT s1.Sname
FROM Students AS s1 INNER JOIN Students AS s2
    ON(s1.Ssex=s2.Ssex)
WHERE s2.Sname='李军';
#44.查询和“李军”同性别并同班的同学Sname.
SELECT s1.Sname
FROM Students AS s1 INNER JOIN Students AS s2
    ON(s1.Ssex=s2.Ssex AND s1.Class=s2.Class)
WHERE s2.Sname='李军';
#45.查询所有选修“计算机导论”课程的“男”同学的成绩表
SELECT *
FROM Scores
WHERE Sno IN (
  SELECT Sno
  FROM Students
  WHERE Ssex='男') AND
      Cno IN (
        SELECT Cno
        FROM Courses
        WHERE Cname='计算机导论');