SELECT Coursename, grade FROM StudentRegistrationsToDegrees, CourseRegistrations, CourseOffers, Courses WHERE StudentRegistrationsToDegrees.StudentId = %1% AND StudentRegistrationsToDegrees.DegreeId = %2% AND StudentRegistrationsToDegrees.StudentRegistrationId = CourseRegistrations.StudentRegistrationId AND CourseRegistrations.CourseOfferId = CourseOffers.CourseOfferId AND CourseOffers.CourseId = Courses.CourseId ORDER BY year, quartile, CourseOffers.CourseOfferID;
SELECT DISTINCT StudentId FROM (SELECT StudentRegistrationsToDegrees.StudentRegistrationId, StudentId FROM StudentRegistrationsToDegrees, CourseOffers, Courses, Degrees, CourseRegistrations WHERE  StudentRegistrationsToDegrees.StudentRegistrationId = CourseRegistrations.StudentRegistrationId AND CourseOffers.CourseOfferId = CourseRegistrations.CourseOfferId AND Courses.CourseID = CourseOffers.CourseId AND CourseRegistrations.StudentRegistrationId NOT IN (SELECT CourseRegistrations.StudentRegistrationId FROM CourseRegistrations WHERE grade<5) AND Degrees.DegreeId = StudentRegistrationsToDegrees.DegreeId GROUP BY StudentRegistrationsToDegrees.StudentRegistrationId, Degrees.DegreeId HAVING (sum(grade*ECTS)/TotalESCTS > %1%) AND (sum(ECTS) >= Degrees.TotalESCTS)) AS High_GPU ORDER BY StudentId;
SELECT StudentRegistrationsToDegrees.DegreeId, CAST(count(*) filter (WHERE Students.Gender = 'F') AS FLOAT) / CAST(count(*) AS FLOAT) as percentage FROM StudentRegistrationsToDegrees, Students WHERE StudentRegistrationsToDegrees.StudentId = Students.StudentId AND NOT EXISTS (SELECT * FROM completeddegrees WHERE completeddegrees.StudentRegistrationId = StudentRegistrationsToDegrees.StudentRegistrationId) GROUP BY StudentRegistrationsToDegrees.DegreeId ORDER BY StudentRegistrationsToDegrees.DegreeId;
WITH StudentsinDegree AS (SELECT distinct students.studentid, students.gender from students, studentregistrationstodegrees, degrees where students.studentid = studentRegistrationsToDegrees.studentid AND studentregistrationstodegrees.degreeid = degrees.degreeid AND Degrees.Dept = %1%) SELECT 100.0 * (SUM(CASE WHEN Gender='F' THEN 1 ELSE 0 END)::DECIMAL / COUNT(studentsindegree.studentid)) as percentage FROM studentsindegree;
WITH nonnull AS (select courseofferid,grade from courseregistrations where grade is not null) select courseid, SUM(CASE WHEN nonnull.grade >= %1% THEN 1 ELSE 0 END)::DECIMAL * 100 / count(nonnull.grade) AS percentagePassing FROM nonnull, courseoffers WHERE nonnull.courseofferid = courseoffers.courseofferid GROUP BY courseid ORDER BY courseid;
WITH max_grade_pc_1_2018 AS (SELECT CR.courseofferid, max(CR.grade) AS max_grade FROM courseregistrations CR, courseoffers CO WHERE CO.year = 2018 AND CO.quartile =1 AND CR.courseofferid = CO.courseofferid GROUP BY CR.courseofferid), counts_excellent AS (SELECT studentID, count(courseregistrations.courseofferid) as counts FROM max_grade_pc_1_2018, courseregistrations, StudentRegistrationsToDegrees WHERE max_grade_pc_1_2018.courseofferid = courseregistrations.courseofferid AND max_grade_pc_1_2018.max_grade = courseregistrations.grade AND courseregistrations.studentregistrationid = studentregistrationstodegrees.studentregistrationid GROUP BY studentid) SELECT studentID, counts FROM counts_excellent WHERE counts >= %1%;
SELECT degreeid, birthyearstudent, gender, avg(avgGrade) as avgGrade FROM students, GPA, active_students_per_degree WHERE students.studentid = active_students_per_degree.StudentId and GPA.studentid = students.StudentId GROUP BY cube(degreeid, birthyearstudent, gender);
SELECT coursename, year, quartile FROM courses, courseoffers, student_assistant_count, student_count WHERE courseoffers.courseid = courses.courseid and student_assistant_count.courseofferid = courseoffers.CourseOfferId and student_count.courseofferid = courseoffers.CourseOfferId and student_assistant_count.value*50 < student_count.value;
