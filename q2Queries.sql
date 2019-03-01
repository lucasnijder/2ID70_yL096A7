Q1 
SELECT Coursename, grade FROM StudentRegistrationsToDegrees, CourseRegistrations, CourseOffers, Courses WHERE StudentRegistrationsToDegrees.StudentId = %1% AND StudentRegistrationsToDegrees.DegreeId = %2% AND StudentRegistrationsToDegrees.StudentRegistrationId = CourseRegistrations.StudentRegistrationId AND CourseRegistrations.CourseOfferId = CourseOffers.CourseOfferId AND CourseOffers.CourseId = Courses.CourseId ORDER BY year, quartile, CourseOffers.CourseOfferID;

Q2 
SELECT DISTINCT StudentId FROM (SELECT StudentRegistrationsToDegrees.StudentRegistrationId, StudentId FROM StudentRegistrationsToDegrees, CourseOffers, Courses, Degrees, CourseRegistrations WHERE  StudentRegistrationsToDegrees.StudentRegistrationId = CourseRegistrations.StudentRegistrationId AND CourseOffers.CourseOfferId = CourseRegistrations.CourseOfferId AND Courses.CourseID = CourseOffers.CourseId AND CourseRegistrations.StudentRegistrationId NOT IN (SELECT CourseRegistrations.StudentRegistrationId FROM CourseRegistrations WHERE grade<5) AND Degrees.DegreeId = StudentRegistrationsToDegrees.DegreeId GROUP BY StudentRegistrationsToDegrees.StudentRegistrationId, Degrees.DegreeId HAVING (sum(grade*ECTS)/TotalESCTS > %1%) AND (sum(ECTS) >= Degrees.TotalESCTS)) AS High_GPU ORDER BY StudentId;

Q3
SELECT Degrees.DegreeId, count(case when gender='F'then 1.0 end)/cast (count(gender)AS FLOAT)*100.0 AS Percentage FROM StudentRegistrationsToDegrees, Students, Degrees, courses WHERE Students.StudentId = StudentRegistrationsToDegrees.StudentId AND Degrees.DegreeId = StudentRegistrationsToDegrees.DegreeId AND Courses.DegreeId = Degrees.DegreeId GROUP BY Degrees.DegreeId HAVING sum(ECTS) < TotalESCTS;

Q4 Change '%thou%' to %1%
WITH StudentsinDegree AS (SELECT distinct students.studentid, students.gender from students, studentregistrationstodegrees, degrees where students.studentid = studentRegistrationsToDegrees.studentid AND studentregistrationstodegrees.degreeid = degrees.degreeid AND Degrees.Dept = '%thou%') SELECT 100.0 * (SUM(CASE WHEN Gender='F' THEN 1 ELSE 0 END)::DECIMAL / COUNT(studentsindegree.studentid)) as percentage FROM studentsindegree;

Q5 Change every 5 to %1%
WITH nonnull AS (select courseofferid,grade from courseregistrations where grade is not null) select courseid, SUM(CASE WHEN nonnull.grade >= 5 THEN 1 ELSE 0 END)::DECIMAL * 100 / count(nonnull.grade) AS percentagePassing FROM nonnull, courseoffers WHERE nonnull.courseofferid = courseoffers.courseofferid GROUP BY courseid ORDER BY courseid;

Q6
WITH excellent AS (SELECT  FROM 

Q7

Q8

SELECT pg_size_pretty(pg_database_size('uni'))
