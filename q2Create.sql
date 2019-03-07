-- create a view for calculating the achieved ects per student per degree
CREATE VIEW ects_per_degree AS
SELECT StudentRegistrationsToDegrees.StudentRegistrationId, StudentRegistrationsToDegrees.DegreeId, SUM(Courses.ECTS) as currentects
FROM StudentRegistrationsToDegrees, CourseOfferRegistrations, Courses
WHERE CourseOfferRegistrations.StudentRegistrationId = StudentRegistrationsToDegrees.StudentRegistrationId
AND CourseOfferRegistrations.Grade >= 5
AND Courses.CourseId = CourseOfferRegistrations.CourseId
GROUP BY StudentRegistrationsToDegrees.StudentRegistrationId, StudentRegistrationsToDegrees.DegreeId;

-- create materialized view for completed degrees based on the ects per degree vs the total ects per degree
CREATE MATERIALIZED VIEW CompletedDegrees AS
SELECT ects_per_degree.StudentRegistrationId
FROM ects_per_degree, Degrees
WHERE ects_per_degree.DegreeId = Degrees.DegreeId
AND ects_per_degree.currentects >= Degrees.TotalECTS;

CREATE MATERIALIZED VIEW GPA(StudentId, StudentRegistrationId, SumECTS, GPA) AS 
SELECT StudentId, StudentRegistrationId, sum(ECTS), (sum(ECTS * Grade))/(Sum(ECTS)) 
FROM CourseOfferRegistrations, Courses, Degrees WHERE CourseOfferRegistrations.CourseId = Courses.courseId 
AND Degrees.DegreeId = Courses.DegreeId AND Grade >=5 GROUP BY StudentId, StudentRegistrationId;
