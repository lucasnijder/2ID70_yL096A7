--create index for Q1
create index student_idx on courseOfferRegistrations(studentId);
-- create a view for calculating the achieved ects per student per degree
CREATE VIEW ects_per_degree AS
SELECT StudentRegistrationsToDegrees.StudentRegistrationId, StudentRegistrationsToDegrees.DegreeId, SUM(ECTS) as currentects, CAST(SUM(CourseOfferRegistrations.Grade * ECTS) AS FLOAT) / CAST(SUM(ECTS) AS FLOAT) as GPA
FROM StudentRegistrationsToDegrees, CourseOfferRegistrations
WHERE CourseOfferRegistrations.StudentRegistrationId = StudentRegistrationsToDegrees.StudentRegistrationId
AND CourseOfferRegistrations.Grade >= 5
GROUP BY StudentRegistrationsToDegrees.StudentRegistrationId, StudentRegistrationsToDegrees.DegreeId;

-- create materialized view for completed degrees based on the ects per degree vs the total ects per degree
CREATE MATERIALIZED VIEW CompletedDegrees AS
SELECT ects_per_degree.StudentRegistrationId, gpa
FROM ects_per_degree, Degrees
WHERE ects_per_degree.DegreeId = Degrees.DegreeId
AND ects_per_degree.currentects >= Degrees.TotalECTS;

create index offer_idx on courseofferregistrations(CourseOfferId);
