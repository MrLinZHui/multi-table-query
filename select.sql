# 1.查询同时存在1课程和2课程的情况
select * from student
 where id in (
     select sc1.studentId from student_course sc1 , student_course sc2
        where sc1.studentId = sc2.studentId and sc1.courseId = '1' and sc2.courseId ='2')
# 2.查询同时存在1课程和2课程的情况
select * from student
 where id in (
     select sc1.studentId from student_course sc1 , student_course sc2
        where sc1.studentId = sc2.studentId and sc1.courseId = '1' and sc2.courseId ='2')
# 3.查询平均成绩大于等于60分的同学的学生编号和学生姓名和平均成绩
select 
	s.id,s.name,avg(sc.score) as avg_score
from 
	student_course sc 
left join student s  on 
	sc.studentId = s.id
GROUP BY
	sc.studentId
having
	avg(sc.score) >= 60
# 4.查询在student_course表中不存在成绩的学生信息的SQL语句
select 
	*
from 
	student s
where s.id in(
select
	s1.id 
from 
	student s1
UNION ALL
SELECT 
	sc.studentId as id
from 
	student_course sc
)GROUP BY id HAVING COUNT(id)=1;
# 5.查询所有有成绩的SQL
select 
	*
from 
	student s
where s.id in(
select
	s1.id 
from 
	student s1
UNION ALL
SELECT 
	sc.studentId as id
from 
	student_course sc
)GROUP BY id HAVING COUNT(id)=2;
# 6.查询学过编号为1并且也学过编号为2的课程的同学的信息
select * from student
 where id in (
     select sc1.studentId from student_course sc1 , student_course sc2
        where sc1.studentId = sc2.studentId and sc1.courseId = '1' and sc2.courseId ='2')
# 7.检索1课程分数小于60，按分数降序排列的学生信息
SELECT
	s.*,sc.score
from student s, student_course sc
where
	s.id = sc.studentId and sc.courseId = 1 and sc.score >=60
ORDER BY
sc.score
# 8.查询每门课程的平均成绩，结果按平均成绩降序排列，平均成绩相同时，按课程编号升序排列
SELECT
	sc.courseId,AVG(sc.score)
from
	student_course sc
	GROUP BY
		sc.courseId
ORDER BY
	AVG(sc.score) DESC,sc.courseId DESC
# 9.查询课程名称为"数学"，且分数低于60的学生姓名和分数
SELECT 
	s.name,t.score
from student s,
(select 
	sc.studentId, sc.score 
from 
	student_course sc
WHERE sc.courseId in
	(select
		id 
	from 
		course 
	where 
		course.name = '数学') and sc.score < 60) as t
WHERE 
	s.id = t.studentId