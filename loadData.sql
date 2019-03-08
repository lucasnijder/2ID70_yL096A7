COPY Degrees(degreeid, dept, degreedescription, TotalECTS) FROM '/mnt/ramdisk/tables/Degrees.table' DELIMITER ',' CSV HEADER;
ALTER TABLE degrees add primary key (DegreeId);
COPY Students(StudentId, StudentName, Address,BirthyearStudent, Gender) FROM '/mnt/ramdisk/tables/Students.table' DELIMITER ',' CSV HEADER;
ALTER TABLE Students add primary key (StudentId);
COPY StudentRegistrationsToDegrees(StudentRegistrationId, StudentId, DegreeId, RegistrationYear) FROM '/mnt/ramdisk/tables/StudentRegistrationsToDegrees.table' DELIMITER ',' CSV HEADER;
ALTER TABLE StudentRegistrationsToDegrees add primary key (StudentRegistrationId);
COPY Teachers(TeacherId, TeacherName, Address, BirthyearTeacher, Gender) FROM '/mnt/ramdisk/tables/Teachers.table' DELIMITER ',' CSV HEADER;
ALTER TABLE Teachers add primary key (TeacherId);
COPY Courses(CourseId, CourseName, CourseDescription, DegreeId, ECTS) FROM '/mnt/ramdisk/tables/Courses.table' DELIMITER ',' CSV HEADER;
ALTER TABLE Courses add primary key (CourseId);
COPY CourseOffers_tmp(CourseOfferId, CourseId, Year, Quartile) FROM '/mnt/ramdisk/tables/CourseOffers.table' DELIMITER ',' CSV HEADER;
SELECT CO.*, courses.CourseName, courses.ECTS, courses.degreeid INTO UNLOGGED TABLE CourseOffers FROM CourseOffers_tmp CO, Courses WHERE Courses.CourseId = CO.CourseID;
drop table courseoffers_tmp;
COPY TeacherAssignmentsToCourses(CourseOfferId, TeacherId) FROM '/mnt/ramdisk/tables/TeacherAssignmentsToCourses.table' DELIMITER ',' CSV HEADER;
COPY StudentAssistants(CourseOfferId, StudentRegistrationId) FROM '/mnt/ramdisk/tables/StudentAssistants.table' DELIMITER ',' CSV HEADER;
COPY CourseRegistrations(CourseOfferId, StudentRegistrationId, Grade) FROM '/mnt/ramdisk/tables/CourseRegistrations.table' DELIMITER ',' CSV HEADER NULL 'null';
CREATE UNLOGGED TABLE CourseOfferRegistrations AS SELECT CourseRegistrations.CourseOfferId, CourseRegistrations.StudentRegistrationId, CourseRegistrations.Grade, CourseOffers.CourseId, CourseOffers.coursename, courseoffers.ects, courseoffers.degreeid, CourseOffers.Year, Courseoffers.Quartile, Studentid FROM CourseRegistrations, CourseOffers, StudentRegistrationsToDegrees WHERE CourseRegistrations.CourseOfferId = CourseOffers.CourseOfferId AND StudentRegistrationsToDegrees.StudentRegistrationId = CourseRegistrations.StudentRegistrationId;
DROP TABLE CourseRegistrations;
ANALYZE VERBOSE;
