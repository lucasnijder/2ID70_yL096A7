CREATE UNLOGGED TABLE Degrees(DegreeId int PRIMARY KEY, Dept varchar(50), DegreeDescription varchar(200), TotalESCTS smallint);
CREATE UNLOGGED TABLE Students(StudentId int PRIMARY KEY, StudentName varchar(50), Address varchar(200), BirthyearStudent smallint, Gender char(1));
CREATE UNLOGGED TABLE StudentRegistrationsToDegrees(StudentRegistrationId int PRIMARY KEY, StudentId int, DegreeId int, RegistrationYear smallint);
CREATE UNLOGGED TABLE Teachers(TeacherId int PRIMARY KEY, TeacherName varchar(50), Address varchar(200), BirthyearTeacher smallint, Gender char(1));
CREATE UNLOGGED TABLE Courses(CourseId int PRIMARY KEY, CourseName varchar(50), CourseDescription varchar(200), DegreeId int, ECTS smallint);
CREATE UNLOGGED TABLE CourseOffers(CourseOfferId int PRIMARY KEY, CourseId int, Year smallint, Quartile smallint);
CREATE UNLOGGED TABLE TeacherAssignmentsToCourses(CourseOfferId int, TeacherId int);
CREATE UNLOGGED TABLE StudentAssistants(CourseOfferId int, StudentRegistrationId int);
CREATE UNLOGGED TABLE CourseRegistrations(CourseOfferId int, StudentRegistrationId int, Grade smallint);

