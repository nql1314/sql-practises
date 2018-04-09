#1、 查询Student表中的所有记录的Sname、Ssex和Class列。
SELECT sname,ssex,class FROM students;
#2、 查询教师所有的单位即不重复的Depart列。
SELECT DISTINCT depart from teachers;
#3、 查询Student表的所有记录。
SELECT * FROM students;
#4、 查询Score表中成绩在60到80之间的所有记录。
SELECT * FROM scores WHERE degree BETWEEN 60 AND 80;
#5、 查询Score表中成绩为85，86或88的记录。
SELECT * FROM scores WHERE degree in (85,86,88);
#6、 查询Student表中“95031”班或性别为“女”的同学记录。
SELECT * FROM students WHERE class = '95031' or ssex = '女';
#7、 以Class降序查询Student表的所有记录。
SELECT * FROM students ORDER BY class DESC;
#8、 以Cno升序、Degree降序查询Score表的所有记录。
SELECT * FROM scores ORDER BY cno ASC,degree DESC;
#9、 查询“95031”班的学生人数。
SELECT count(*) FROM students WHERE class = '95031';
#10、查询Score表中的最高分的学生学号和课程号。
SELECT sno,cno FROM scores ORDER BY degree DESC limit 1;
#11、查询‘3-105’号课程的平均分。
SELECT cno,avg(degree) FROM scores WHERE cno = '3-105';
#12、查询Score表中至少有5名学生选修的并以3开头的课程的平均分数。
SELECT s1.cno as cno,avg(s1.degree) as avgdegree FROM scores s1 WHERE
  (select count(s2.sno) FROM scores s2 WHERE s2.cno = s1.cno)>=5 and s1.cno like '3%' GROUP BY s1.cno;
  #采用HAVING过滤组,修改后:
SELECT cno,avg(degree) FROM scores WHERE cno like '3%' GROUP BY cno HAVING count(sno) >5;
#13、查询最低分大于70，最高分小于90的Sno列。
SELECT sno FROM scores WHERE degree>70 and degree<90;
  #没考虑最高分，最低分，修改后：
SELECT sno FROM scores  GROUP BY sno HAVING max(degree)<90 and min(degree)>70;
#14、查询所有学生的Sname、Cno和Degree列。
SELECT students.sname,scores.cno,scores.degree FROM scores LEFT JOIN students ON scores.sno = students.sno;
#15、查询所有学生的Sno、Cname和Degree列。
SELECT students.sno,courses.cname,scores.degree FROM scores LEFT JOIN students ON scores.sno = students.sno
  LEFT JOIN courses ON scores.cno = courses.cno;
  #不需要连接student,修改后:
SELECT scores.sno,courses.cname,scores.degree FROM scores
  LEFT JOIN courses ON scores.cno = courses.cno;
#16、查询所有学生的Sname、Cname和Degree列。
SELECT students.sname,courses.cname,scores.degree FROM scores LEFT JOIN students ON scores.sno = students.sno
  LEFT JOIN courses ON scores.cno = courses.cno;
#17、查询“95033”班所选课程的平均分。
SELECT cno,avg(degree) FROM scores left JOIN students on scores.sno = students.sno WHERE class = '95033' GROUP BY cno;
#18、假设使用如下命令建立了一个grade表：
create table grade(low NUMERIC(3,0),upp NUMERIC(3),rank VARCHAR(1));
insert into grade values(90,100,'A');
insert into grade values(80,89,'B');
insert into grade values(70,79,'C');
insert into grade values(60,69,'D');
insert into grade values(0,59,'E');
commit;
#现查询所有同学的Sno、Cno和rank列。
SELECT sno,cno,rank FROM scores LEFT JOIN grade on degree BETWEEN low and upp ORDER BY sno;
#19、查询选修“3-105”课程的成绩高于“109”号同学成绩的所有同学的记录。
SELECT * FROM students WHERE sno IN (SELECT sno FROM scores WHERE cno = '3-105' AND degree>(SELECT degree FROM scores WHERE cno = '3-105' and sno = '109'));
  #采用连接,好像快一些,修改后
  SELECT students.* FROM students LEFT JOIN scores s1 on students.sno = s1.sno
    LEFT JOIN scores s2 on s1.cno = s2.cno and s1.degree>s2.degree WHERE s1.cno = '3-105' and s2.sno = '109';
#20、查询score中选学一门以上课程的同学中分数为非最高分成绩的记录。
SELECT * from (SELECT s1.* FROM scores s1 LEFT JOIN (select sno,count(cno) as count FROM scores GROUP BY sno) s2 on s1.sno = s2.sno  WHERE s2.count>1) as t; #不会去掉最高分
  #采用HAVING进行组内筛选，修改后
SELECT * FROM scores GROUP BY sno HAVING count(cno)>1 and degree !=max(degree);
#21、查询成绩高于学号为“109”、课程号为“3-105”的成绩的所有记录。
SELECT * FROM scores WHERE degree>(SELECT degree FROM scores WHERE sno='109' AND cno = '3-105');#题目有歧义
#22、查询和学号为108的同学同年出生的所有学生的Sno、Sname和Sbirthday列。
SELECT sno,sname,sbirthday FROM students WHERE YEAR(sbirthday) =(SELECT  YEAR(sbirthday) FROM students WHERE sno = '108') AND sno!='108';
#23、查询“张旭“教师任课的学生成绩。
SELECT scores.* FROM scores LEFT JOIN courses on scores.cno = courses.cno LEFT JOIN teachers on courses.tno = teachers.tno WHERE teachers.tname = '张旭';
#24、查询选修某课程的同学人数多于5人的教师姓名。
SELECT teachers.tname FROM teachers WHERE (SELECT count(students.sno) FROM students LEFT JOIN scores on students.sno = scores.sno
  LEFT JOIN courses on scores.cno = courses.cno WHERE courses.tno = teachers.tno) >5;
  #采用HAVING过滤组
  SELECT teachers.tname FROM teachers LEFT JOIN courses on teachers.tno = courses.tno
    LEFT JOIN scores on scores.cno = courses.cno GROUP BY scores.cno HAVING count(scores.sno)>5;
#25、查询95033班和95031班全体学生的记录。
SELECT * FROM students WHERE class = '95033' or '95031';
#26、查询存在有85分以上成绩的课程Cno.
SELECT courses.cno from courses WHERE (SELECT max(scores.degree) FROM scores WHERE scores.cno = courses.cno)>85;
  #参考答案写的比我好
#27、查询出“计算机系“教师所教课程的成绩表。
SELECT scores.* FROM scores LEFT JOIN courses on scores.cno = courses.cno LEFT JOIN teachers on courses.tno = teachers.tno WHERE teachers.depart = '计算机系';
#28、查询“计算机系”与“电子工程系“不同职称的教师的Tname和Prof。
(SELECT  t1.tname,t1.prof FROM teachers t1 where t1.depart = '计算机系' and  not exists(SELECT prof FROM teachers t2 WHERE t2.depart = '电子工程系' and t2.prof = t1.prof))
  UNION
(SELECT  t1.tname,t1.prof FROM teachers t1 where t1.depart = '电子工程系' and  not exists(SELECT prof FROM teachers t2 WHERE t2.depart = '计算机系' and t2.prof = t1.prof));
  #采用not in比较好
select tname,prof FROM teachers WHERE depart = '计算机系' AND prof not in (SELECT prof FROM teachers WHERE depart = '电子工程系');
#29、查询选修编号为“3-105“课程且成绩至少高于选修编号为“3-245”的同学的Cno、Sno和Degree,并按Degree从高到低次序排序。
SELECT sc1.cno,s1.sno,sc1.degree FROM students s1,scores sc1 WHERE s1.sno = sc1.sno AND sc1.cno = '3-105' AND sc1.degree>
        ANY(SELECT sc2.degree FROM students s2,scores sc2 WHERE s2.sno = sc2.sno AND sc2.cno = '3-245') ORDER BY degree desc;
  #不需要连接student
SELECT cno,sno,degree FROM scores WHERE  cno = '3-105' AND degree>
   ANY(SELECT degree FROM scores WHERE  cno = '3-245') ORDER BY degree desc;
#30、查询选修编号为“3-105”且成绩高于选修编号为“3-245”课程的同学的Cno、Sno和Degree.
SELECT sc1.cno,s1.sno,sc1.degree FROM students s1,scores sc1 WHERE s1.sno = sc1.sno AND sc1.cno = '3-105' AND sc1.degree>
        ALL(SELECT sc2.degree FROM students s2,scores sc2 WHERE s2.sno = sc2.sno AND sc2.cno = '3-245');
  #不需要连接student
SELECT cno,sno,degree FROM scores WHERE  cno = '3-105' AND degree>
   ALL(SELECT degree FROM scores WHERE  cno = '3-245') ORDER BY degree desc;
#31、查询所有教师和同学的name、sex和birthday.
(SELECT students.sname as name,students.ssex as sex,students.sbirthday as birttday FROM  students)
  UNION (SELECT teachers.tname as name,teachers.tsex as sex,teachers.tbirthday as birthday FROM teachers);
#32、查询所有“女”教师和“女”同学的name、sex和birthday.
(SELECT students.sname as name,students.ssex as sex,students.sbirthday as birttday FROM  students WHERE students.ssex = '女')
UNION (SELECT teachers.tname as name,teachers.tsex as sex,teachers.tbirthday as birthday FROM teachers WHERE teachers.tsex = '女');
#33、查询成绩比该课程平均成绩低的同学的成绩表。
SELECT s1.* FROM scores s1 WHERE s1.degree <(SELECT avg(s2.degree) FROM scores s2 WHERE s2.cno = s1.cno);
#34、查询所有任课教师的Tname和Depart.
SELECT teachers.tname,teachers.depart FROM teachers INNER JOIN courses on teachers.tno = courses.tno;
#35  查询所有未讲课的教师的Tname和Depart.
SELECT teachers.tname,teachers.depart FROM teachers WHERE teachers.tno not IN (SELECT DISTINCT tno from courses);
#36、查询至少有2名男生的班号。
select s1.class FROM students s1 WHERE (SELECT count(*) from students s2 where s2.ssex = '男' and s2.class = s1.class) GROUP BY s1.class;
  #改用HAVING
select class FROM students where  ssex = '男' GROUP BY class HAVING count(sno)>1;
#37、查询Student表中不姓“王”的同学记录。
SELECT * FROM students WHERE sname  not like '王%';
#38、查询Student表中每个学生的姓名和年龄。
SELECT sname,YEAR(NOW())-YEAR(sbirthday)+1 FROM students;
#39、查询Student表中最大和最小的Sbirthday日期值。
SELECT max(sbirthday),min(sbirthday) FROM students;
#40、以班号和年龄从大到小的顺序查询Student表中的全部记录。
SELECT * FROM students ORDER BY class DESC ,sbirthday ASC;
#41、查询“男”教师及其所上的课程。
SELECT teachers.*,courses.cname FROM teachers INNER JOIN courses ON courses.tno = teachers.tno and teachers.tsex = '男';
#42、查询最高分同学的Sno、Cno和Degree列。
SELECT sno,cno,max(degree) as degree FROM scores;
  #改用HAVING
SELECT * FROM scores  group by cno HAVING degree = max(degree);
#43、查询和“李军”同性别的所有同学的Sname.
SELECT s1.sname FROM students s1 WHERE s1.ssex = (SELECT s2.ssex FROM students s2 WHERE s2.sname = '李军') and s1.sname!= '李军';
  #改用自连接
select s1.sname FROM  students s1 LEFT JOIN students s2 on s1.ssex = s2.ssex WHERE s2.sname = '李军';
#44、查询和“李军”同性别并同班的同学Sname.
SELECT s1.sname FROM students s1 WHERE s1.ssex = (SELECT s2.ssex FROM students s2 WHERE s2.sname = '李军') and s1.sname!= '李军'
                                       AND s1.class = (SELECT s2.class FROM students s2 WHERE s2.sname = '李军');
  #改用自连接
select s1.sname FROM  students s1 LEFT JOIN  students s2 on s1.ssex = s2.ssex and s1.class = s2.class WHERE s2.sname = '李军';
#45、查询所有选修“计算机导论”课程的“男”同学的成绩表
SELECT scores.* FROM scores LEFT JOIN students on scores.sno = students.sno LEFT JOIN courses on scores.cno = courses.cno WHERE students.ssex = '男' and courses.cname = '计算机导论';