Q4 ==> WITH StudentsinDegree AS (SELECT distinct students.studentid, students.gender from students, studentregistrationstodegrees, degrees where students.studentid = studentRegistrationsToDegrees.studentid AND studentregistrationstodegrees.degreeid = degrees.degreeid AND Degrees.Dept = %1%) SELECT 100.0 * (SUM(CASE WHEN Gender='F' THEN 1 ELSE 0 END)::DECIMAL / COUNT(studentsindegree.studentid)) as percentage FROM studentsindegree;

Q5 ==> 
WITH nonnull AS (select * from courseregistrations where grade is not null) select courseid, SUM(CASE WHEN grade >= 5 THEN 1 ELSE 0 END)::DECIMAL / SUM(CASE WHEN grade < 5 THEN 1 ELSE 0 END)::DECIMAL FROM nonnull, courseoffers WHERE nonnull.courseofferid = courseoffers.courseofferid GROUP BY courseid ORDER BY courseid;

Q6 ==> 
