Q1

Q2

Q3

Q4 Change '%thou%' to %1%
WITH StudentsinDegree AS (SELECT distinct students.studentid, students.gender from students, studentregistrationstodegrees, degrees where students.studentid = studentRegistrationsToDegrees.studentid AND studentregistrationstodegrees.degreeid = degrees.degreeid AND Degrees.Dept = '%thou%') SELECT 100.0 * (SUM(CASE WHEN Gender='F' THEN 1 ELSE 0 END)::DECIMAL / COUNT(studentsindegree.studentid)) as percentage FROM studentsindegree;

Q5 Change every 5 to %1%
WITH nonnull AS (select courseofferid,grade from courseregistrations where grade is not null) select courseid, SUM(CASE WHEN nonnull.grade >= 5 THEN 1 ELSE 0 END)::DECIMAL * 100 / count(nonnull.grade) AS percentagePassing FROM nonnull, courseoffers WHERE nonnull.courseofferid = courseoffers.courseofferid GROUP BY courseid ORDER BY courseid;

Q6
WITH excellent AS (SELECT  FROM 

Q7

Q8

SELECT pg_size_pretty(pg_database_size('uni'))
