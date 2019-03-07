SELECT Coursename, grade FROM CourseOfferRegistrations, Courses WHERE StudentId = %1% AND DegreeId = %2% AND CourseOfferRegistrations.CourseId = Courses.CourseId ORDER BY year, quartile, CourseOfferID;
SELECT distinct studentid FROM completeddegrees, studentregistrationstodegrees, GPA WHERE completeddegrees.studentregistrationid = studentregistrationstodegrees.studentregistrationid AND studentregistrationstodegrees.studentregistrationid = gpa.studentregistrationid AND gpa.gpa > %1% ORDER BY studentid;
SELECT StudentRegistrationsToDegrees.DegreeId, CAST(count(*) filter (WHERE Students.Gender = 'F') AS FLOAT) / CAST(count(*) AS FLOAT) as percentage FROM StudentRegistrationsToDegrees, Students WHERE StudentRegistrationsToDegrees.StudentId = Students.StudentId AND NOT EXISTS (SELECT * FROM completeddegrees WHERE completeddegrees.StudentRegistrationId = StudentRegistrationsToDegrees.StudentRegistrationId) GROUP BY StudentRegistrationsToDegrees.DegreeId ORDER BY StudentRegistrationsToDegrees.DegreeId;
WITH StudentsinDegree AS (SELECT distinct students.studentid, students.gender from students, studentregistrationstodegrees, degrees where students.studentid = studentRegistrationsToDegrees.studentid AND studentregistrationstodegrees.degreeid = degrees.degreeid AND Degrees.Dept = %1%) SELECT 100.0 * (SUM(CASE WHEN Gender='F' THEN 1 ELSE 0 END)::DECIMAL / COUNT(studentsindegree.studentid)) as percentage FROM studentsindegree;
SELECT courseid, SUM(CASE WHEN nonnull.grade >= %1% THEN 1 ELSE 0 END)::DECIMAL / count(nonnull.grade) AS percentagePassing FROM (select courseofferid, courseid, grade from courseofferregistrations where grade is not null) as nonnull GROUP BY courseid ORDER BY courseid;
WITH max_grade_pc_1_2018 AS (SELECT COR.courseofferid, max(COR.grade) AS max_grade FROM courseofferregistrations COR WHERE COR.year = 2018 AND COR.quartile =1 GROUP BY COR.courseofferid), counts_excellent AS (SELECT studentID , count(courseofferregistrations.courseofferid) as counts FROM max_grade_pc_1_2018, courseofferregistrations WHERE max_grade_pc_1_2018.courseofferid = courseofferregistrations.courseofferid AND max_grade_pc_1_2018.max_grade = courseofferregistrations.grade GROUP BY studentid) SELECT studentID, counts FROM counts_excellent WHERE counts >= %1%;
SELECT DegreeId, BirthyearStudent, Gender, avg(GPA) AS avgGrade FROM GPA, StudentRegistrationsToDegrees, Students WHERE GPA.StudentRegistrationId = StudentRegistrationsToDegrees.StudentRegistrationId AND GPA.StudentRegistrationId NOT IN (SELECT completedDegrees.StudentregistrationId FROM CompletedDegrees) AND StudentRegistrationsToDegrees.StudentId = Students.StudentId GROUP BY CUBE (DegreeId, BirthYearStudent, Gender) ORDER BY DegreeId ASC, BirthYearStudent ASC, Gender ASC;
SELECT degreeid, BirthyearStudent as birthyear, gender, gpa as avgGrade FROM gpa, students, studentregistrationstodegrees WHERE studentregistrationstodegrees.studentid = students.studentid AND gpa.studentregistrationid = studentregistrationstodegrees.studentregistrationid;

-- SELECT degreeid, birthyearstudent, gender, avg(avgGrade) as avgGrade FROM students, GPA, active_students_per_degree WHERE students.studentid = active_students_per_degree.StudentId and GPA.studentid = students.StudentId GROUP BY cube(degreeid, birthyearstudent, gender);
-- SELECT coursename, year, quartile FROM courses, courseofferregistraions, student_assistant_count, student_count WHERE courseofferregistrations.courseid = courses.courseid and student_assistant_count.courseofferid = courseofferregistrations.CourseOfferId and student_count.courseofferid = courseofferregistrations.CourseOfferId and student_assistant_count.value*50 < student_count.value;
