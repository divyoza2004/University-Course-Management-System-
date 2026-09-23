CREATE DATABASE UniverseCourseManagementSystem;
USE UniverseCourseManagementSystem;
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL
);
INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'Computer Science'), (2, 'Mathematics');
CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DepartmentID INT,
    Salary DECIMAL(10, 2),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);
INSERT INTO Instructors (InstructorID, FirstName, LastName, DepartmentID, Salary) VALUES
(1, 'Alan', 'Turing', 1, 95000.00), (2, 'Ada', 'Lovelace', 1, 105000.00), (3, 'Carl', 'Gauss', 2, 88000.00);
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    BirthDate DATE,
    EnrollmentDate DATE
);
INSERT INTO Students (StudentID, FirstName, LastName, Email, BirthDate, EnrollmentDate) VALUES
(1, 'John', 'Doe', 'john.doe@email.com', '2000-01-15', '2022-08-01'), (2, 'Jane', 'Smith', 'jane.smith@email.com', '1999-05-25', '2021-08-01');
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    DepartmentID INT,
    Credits INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);
INSERT INTO Courses (CourseID, CourseName, DepartmentID, Credits) VALUES
(101, 'Introduction to SQL', 1, 3), (102, 'Data Structures', 2, 4);
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    EnrollmentDate DATE,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);
INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, EnrollmentDate) VALUES
(1, 1, 101, '2022-08-01'), (2, 2, 102, '2021-08-01');
INSERT INTO Students (StudentID, FirstName, LastName, Email, BirthDate, EnrollmentDate) 
VALUES (3, 'Alice', 'Johnson', 'alice.j@email.com', '2001-03-10', '2023-01-15');
SELECT * FROM Students;
UPDATE Students SET Email = 'alice.johnson@email.com' WHERE StudentID = 3;
DELETE FROM Students WHERE StudentID = 3;
SELECT * FROM Students WHERE EnrollmentDate > '2022-12-31';
SELECT c.* FROM Courses c JOIN Departments d ON c.DepartmentID = d.DepartmentID WHERE d.DepartmentName = 'Mathematics' LIMIT 5;
SELECT CourseID, COUNT(StudentID) AS EnrolledStudents FROM Enrollments GROUP BY CourseID HAVING COUNT(StudentID) > 5;
SELECT s.* FROM Students s JOIN Enrollments e1 ON s.StudentID = e1.StudentID JOIN Courses c1 ON e1.CourseID = c1.CourseID JOIN Enrollments e2 ON s.StudentID = e2.StudentID JOIN Courses c2 ON e2.CourseID = c2.CourseID WHERE c1.CourseName = 'Introduction to SQL' AND c2.CourseName = 'Data Structures';
SELECT DISTINCT s.* FROM Students s JOIN Enrollments e ON s.StudentID = e.StudentID JOIN Courses c ON e.CourseID = c.CourseID WHERE c.CourseName IN ('Introduction to SQL', 'Data Structures');
SELECT AVG(Credits) AS AverageCredits FROM Courses;
SELECT MAX(i.Salary) AS MaxSalary FROM Instructors i JOIN Departments d ON i.DepartmentID = d.DepartmentID WHERE d.DepartmentName = 'Computer Science';
SELECT d.DepartmentName, COUNT(DISTINCT e.StudentID) AS StudentCount FROM Departments d JOIN Courses c ON d.DepartmentID = c.DepartmentID JOIN Enrollments e ON c.CourseID = e.CourseID GROUP BY d.DepartmentID, d.DepartmentName;
SELECT s.StudentID, s.FirstName, s.LastName, c.CourseName FROM Students s INNER JOIN Enrollments e ON s.StudentID = e.StudentID INNER JOIN Courses c ON e.CourseID = c.CourseID;
SELECT s.StudentID, s.FirstName, s.LastName, c.CourseName FROM Students s LEFT JOIN Enrollments e ON s.StudentID = e.StudentID LEFT JOIN Courses c ON e.CourseID = c.CourseID;
SELECT * FROM Students WHERE StudentID IN (SELECT StudentID FROM Enrollments WHERE CourseID IN (SELECT CourseID FROM Enrollments GROUP BY CourseID HAVING COUNT(StudentID) > 10));