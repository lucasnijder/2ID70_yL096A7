CREATE UNLOGGED TABLE Degrees(DegreeId int primary key, Dept varchar(50), DegreeDescription varchar(200), TotalESCTS int);
CREATE UNLOGGED TABLE Students(StudentId int PRIMARY KEY, StudentName varchar(50), Address varchar(200), BirthyearStudent int, Gender char(1));
CREATE UNLOGGED TABLE StudentRegistrationsToDegrees(StudentRegistrationId int PRIMARY KEY, StudentId int, DegreeId int, RegistrationYear int);
CREATE UNLOGGED TABLE Teachers(TeacherId int PRIMARY KEY, TeacherName varchar(50), Address varchar(200), BirthyearTeacher int, Gender char(1));
CREATE UNLOGGED TABLE Courses(CourseId int PRIMARY KEY, CourseName varchar(50), CourseDescription varchar(200), DegreeId int, ECTS int);
CREATE UNLOGGED TABLE CourseOffers(CourseOfferId int PRIMARY KEY, CourseId int, Year int, Quartile int);
CREATE UNLOGGED TABLE TeacherAssignmentsToCourses(CourseOfferId int, TeacherId int);
CREATE UNLOGGED TABLE StudentAssistants(CourseOfferId int, StudentRegistrationId int);
CREATE UNLOGGED TABLE CourseRegistrations(CourseOfferId int, StudentRegistrationId int, Grade int);

