***Sander's query***
SELECT CourseOffers.*, Students.*, Degrees.* FROM StudentRegistrationsToDegrees, Students, Degrees, CourseOffers, StudentAssistants WHERE StudentRegistrationsToDegrees.StudentRegistrationId = 3 AND StudentRegistrationsToDegrees.StudentId = Students.StudentId AND StudentRegistrationsToDegrees.DegreeId = Degrees.DegreeId AND StudentAssistants.StudentRegistrationId = 140 AND CourseOffers.CourseOfferId = StudentAssistants.CourseOfferId;
SELECT AVG(Grade) FROM CourseRegistrations WHERE StudentRegistrationId = 3;
