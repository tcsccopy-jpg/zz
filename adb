 -- PRACTICAL 1: HORIZONTAL AND VERTICAL FRAGMENTATION

-- Step 1: Create database and core table
CREATE DATABASE CompanyDB;
USE CompanyDB;

CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(30),
    Department VARCHAR(20),
    Salary INT,
    City VARCHAR(20)
);

-- Step 2: Insert sample data
INSERT INTO Employee VALUES
(101, 'ShubhamMK', 'IT', 50000, 'Mumbai'),
(102, 'Rajashya', 'HR', 40000, 'Pune'),
(103, 'Neha', 'IT', 55000, 'Mumbai'),
(104, 'Priya', 'Sales', 45000, 'Delhi'),
(105, 'Rahul', 'HR', 42000, 'Pune');

SELECT * FROM Employee;

-- Step 3: Horizontal fragmentation (by City)
CREATE TABLE Employee_Mumbai AS SELECT * FROM Employee WHERE City = 'Mumbai';
CREATE TABLE Employee_Pune AS SELECT * FROM Employee WHERE City = 'Pune';

SELECT * FROM Employee_Mumbai;
SELECT * FROM Employee_Pune;

-- Step 4: Vertical fragmentation (by Attributes)
CREATE TABLE Employee_Personal AS SELECT EmpID, Name, City FROM Employee;
CREATE TABLE Employee_Official AS SELECT EmpID, Department, Salary FROM Employee;

SELECT * FROM Employee_Personal;
SELECT * FROM Employee_Official;


-- PRACTICAL 2: REPLICATION IN DISTRIBUTED DATABASE

-- Step 1: Create database and master table
CREATE DATABASE ADB_Practical_2;
USE ADB_Practical_2;

CREATE TABLE Student_Master (
    Roll_No INT PRIMARY KEY,
    Student_Name VARCHAR(50),
    Course VARCHAR(20),
    Semester INT,
    Marks INT
);

INSERT INTO Student_Master VALUES
(101, 'ShubhamMK', 'MSc CS', 1, 88),
(102, 'Amit Sharma', 'MSc CS', 1, 91),
(103, 'Priya Patel', 'MSc CS', 1, 85),
(104, 'Neha Verma', 'MSc CS', 2, 89),
(105, 'Rahul Gupta', 'MSc CS', 2, 76);

-- Step 2: Create replica table
CREATE TABLE Student_Replica AS SELECT * FROM Student_Master;

SELECT * FROM Student_Master;
SELECT * FROM Student_Replica;

-- Step 3: Replicate new row to replica table
INSERT INTO Student_Master VALUES (106, 'Kiran Desai', 'MSc CS', 3, 90);

INSERT INTO Student_Replica
SELECT * FROM Student_Master WHERE Roll_No = 106;

SELECT * FROM Student_Replica;


-- PRACTICAL 3: OBJECT-ORIENTED CONCEPTS & CRUD OPERATIONS

-- Step 1: Database setup
CREATE DATABASE ADB_PRACTICAL;
USE ADB_PRACTICAL;

-- Step 2: Tables with relational foreign key
CREATE TABLE DEPARTMENT (
    Dept_ID INT PRIMARY KEY,
    Dept_Name VARCHAR(50),
    Location VARCHAR(50)
);

CREATE TABLE EMPLOYEE (
    Emp_ID INT PRIMARY KEY,
    Emp_Name VARCHAR(50),
    Salary DECIMAL(10,2),
    Dept_ID INT,
    FOREIGN KEY (Dept_ID) REFERENCES DEPARTMENT(Dept_ID)
);

-- Step 3: Insert data
INSERT INTO DEPARTMENT VALUES
(101, 'Computer Science', 'Mumbai'),
(102, 'Information Technology', 'Pune'),
(103, 'Artificial Intelligence', 'Nashik');

INSERT INTO EMPLOYEE VALUES
(1, 'ShubhamMK', 55000, 101),
(2, 'Amit Sharma', 48000, 101),
(3, 'Priya Patel', 62000, 102),
(4, 'Neha Verma', 51000, 102),
(5, 'Rahul Gupta', 58000, 103);

SELECT * FROM DEPARTMENT;
SELECT * FROM EMPLOYEE;

-- Step 4: Update and Delete
UPDATE EMPLOYEE SET Salary = 60000 WHERE Emp_ID = 1;
DELETE FROM EMPLOYEE WHERE Emp_ID = 5;

-- Step 5: Join and filter queries
SELECT E.Emp_ID, E.Emp_Name, D.Dept_Name, D.Location, E.Salary
FROM EMPLOYEE E INNER JOIN DEPARTMENT D ON E.Dept_ID = D.Dept_ID;

SELECT * FROM EMPLOYEE WHERE Salary > 50000 ORDER BY Salary DESC;


-- PRACTICAL 4: MULTIMEDIA DATABASE

-- Step 1: Database and table setup
CREATE DATABASE  ADB_Multimedia;
USE ADB_Multimedia;

CREATE TABLE Multimedia (
    Media_ID INT PRIMARY KEY,
    Media_Name VARCHAR(100) NOT NULL,
    Media_Type VARCHAR(20) NOT NULL,
    File_Path VARCHAR(255),
    File_Size_MB DECIMAL(10,2),
    Description VARCHAR(255)
);

-- Step 2: Insert multimedia records
INSERT INTO Multimedia VALUES
(1, 'College Logo', 'Image', 'E:/wamp64/tmp/Image/college_logo.jpg', 0.01, 'Official College Logo'),
(2, 'Student Photo', 'Image', 'E:/wamp64/tmp/Image/student_photo.jpg', 0.04, 'Student Profile Photograph'),
(3, 'Computer Lab', 'Image', 'E:/wamp64/tmp/Image/computer_lab.jpg', 0.02, 'Computer Laboratory Image'),
(4, 'DBMS Lecture', 'Audio', 'E:/wamp64/tmp/Audio/dbms_lecture.mp3', 0.05, 'Database Management Lecture Recording'),
(5, 'Seminar Recording', 'Audio', 'E:/wamp64/tmp/Audio/seminar_recording.mp3', 0.46, 'Academic Seminar Audio'),
(6, 'Interview Recording', 'Audio', 'E:/wamp64/tmp/Audio/interview_recording.mp3', 0.53, 'Technical Interview Recording'),
(7, 'DBMS Tutorial', 'Video', 'E:/wamp64/tmp/Video/dbms_tutorial.mp4', 2.72, 'Database Tutorial Video'),
(8, 'Practical Demonstration', 'Video', 'E:/wamp64/tmp/Video/practical_demonstration.mp4', 1.09, 'Database Practical Demonstration'),
(9, 'Seminar Video', 'Video', 'E:/wamp64/tmp/Video/seminar_video.mp4', 4.85, 'Academic Seminar Video'),
(10, 'Project Presentation', 'Video', 'E:/wamp64/tmp/Video/project_presentation.mp4', 1.20, 'Student Project Presentation');

-- Step 3: Queries and aggregations
SELECT * FROM Multimedia;
SELECT * FROM Multimedia WHERE Media_Type = 'Image';
SELECT * FROM Multimedia WHERE Media_Type = 'Audio';
SELECT * FROM Multimedia WHERE Media_Type = 'Video';

SELECT Media_ID, Media_Name, Media_Type, File_Size_MB FROM Multimedia ORDER BY File_Size_MB DESC;
SELECT Media_Name, Media_Type, File_Size_MB FROM Multimedia WHERE File_Size_MB > 2;

SELECT COUNT(*) AS Total_Multimedia FROM Multimedia;
SELECT Media_Type, COUNT(*) AS Total_Files FROM Multimedia GROUP BY Media_Type;

-- Step 4: Update and delete operations
UPDATE Multimedia SET Description = 'MSc Advanced Database Systems Lecture Recording' WHERE Media_ID = 4;
SELECT * FROM Multimedia WHERE Media_ID = 4;

DELETE FROM Multimedia WHERE Media_ID = 10;
SELECT * FROM Multimedia;
SELECT Media_Type, COUNT(*) AS Total_Files FROM Multimedia GROUP BY Media_Type;


-- PRACTICAL 5: TEMPORAL DATABASE

-- Step 1: Database and temporal table setup
CREATE DATABASE  ADB_Temporal;
USE ADB_Temporal;

CREATE TABLE Student_Marks_History (
    Record_ID INT PRIMARY KEY,
    Student_ID INT NOT NULL,
    Student_Name VARCHAR(100) NOT NULL,
    Subject VARCHAR(50) NOT NULL,
    Marks INT NOT NULL,
    Valid_From DATE NOT NULL,
    Valid_To DATE
);

-- Step 2: Insert historical time-bound records
INSERT INTO Student_Marks_History VALUES
(1, 101, 'Rohit Singh', 'DBMS', 72, '2026-01-01', '2026-03-31'),
(2, 101, 'Rohit Singh', 'DBMS', 78, '2026-04-01', '2026-06-30'),
(3, 101, 'Rohit Singh', 'DBMS', 84, '2026-07-01', NULL),
(4, 102, 'Amit Sharma', 'DBMS', 68, '2026-01-01', '2026-05-31'),
(5, 102, 'Amit Sharma', 'DBMS', 75, '2026-06-01', NULL),
(6, 103, 'Priya Patel', 'DBMS', 81, '2026-01-01', '2026-04-30'),
(7, 103, 'Priya Patel', 'DBMS', 88, '2026-05-01', NULL),
(8, 104, 'Neha Verma', 'DBMS', 70, '2026-01-01', '2026-06-30'),
(9, 104, 'Neha Verma', 'DBMS', 79, '2026-07-01', NULL);

-- Step 3: Temporal queries
SELECT * FROM Student_Marks_History ORDER BY Student_ID, Valid_From;

-- Query specific date state
SELECT Student_ID, Student_Name, Subject, Marks, Valid_From, Valid_To
FROM Student_Marks_History
WHERE Student_ID = 101 AND '2026-05-01' >= Valid_From AND ('2026-05-01' <= Valid_To OR Valid_To IS NULL);

-- Retrieve current active records
SELECT Student_ID, Student_Name, Subject, Marks, Valid_From FROM Student_Marks_History WHERE Valid_To IS NULL;

-- Retrieve student history
SELECT Student_Name, Subject, Marks, Valid_From, Valid_To FROM Student_Marks_History WHERE Student_ID = 101 ORDER BY Valid_From;

-- Date range overlap query
SELECT Student_ID, Student_Name, Subject, Marks, Valid_From, Valid_To
FROM Student_Marks_History
WHERE Valid_From <= '2026-06-30' AND (Valid_To >= '2026-04-01' OR Valid_To IS NULL)
ORDER BY Student_ID, Valid_From;

-- Sort current marks
SELECT Student_Name, Subject, Marks FROM Student_Marks_History WHERE Valid_To IS NULL ORDER BY Marks DESC;

-- Count changes per student
SELECT Student_ID, Student_Name, COUNT(*) AS Number_of_Changes FROM Student_Marks_History GROUP BY Student_ID, Student_Name;

SELECT Record_ID, Student_ID, Student_Name, Subject, Marks, Valid_From, Valid_To FROM Student_Marks_History ORDER BY Student_ID, Valid_From;


-- PRACTICAL 6: SPATIAL DATABASE

-- Step 1: Spatial database setup
CREATE DATABASE  ADB_Spatial;
USE ADB_Spatial;

CREATE TABLE College_Location (
    College_ID INT PRIMARY KEY,
    College_Name VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Location POINT NOT NULL SRID 4326,
    SPATIAL INDEX idx_location (Location)
) ;

-- Step 2: Insert spatial point coordinates (Latitude Longitude order for SRID 4326)
INSERT INTO College_Location VALUES
(1, 'College A', 'Mumbai', ST_GeomFromText('POINT(19.0760 72.8777)', 4326)),
(2, 'College B', 'Mumbai', ST_GeomFromText('POINT(18.9712 72.8296)', 4326)),
(3, 'College C', 'Mumbai', ST_GeomFromText('POINT(19.0178 72.8826)', 4326)),
(4, 'College D', 'Mumbai', ST_GeomFromText('POINT(19.2183 72.8562)', 4326)),
(5, 'College E', 'Mumbai', ST_GeomFromText('POINT(19.1864 72.8258)', 4326)),
(6, 'College F', 'Mumbai', ST_GeomFromText('POINT(19.2076 72.8646)', 4326)),
(7, 'College G', 'Mumbai', ST_GeomFromText('POINT(19.0990 72.8397)', 4326)),
(8, 'College H', 'Mumbai', ST_GeomFromText('POINT(19.1197 72.8553)', 4326)),
(9, 'College I', 'Mumbai', ST_GeomFromText('POINT(19.0728 72.9081)', 4326)),
(10, 'College J', 'Mumbai', ST_GeomFromText('POINT(19.0500 72.8406)', 4326));

-- Step 3: Spatial queries
SELECT College_ID, College_Name, City, ST_AsText(Location) AS Coordinates FROM College_Location;

-- Calculate distance in KM between College A and College B
SELECT
    a.College_Name AS College1,
    b.College_Name AS College2,
    ROUND(ST_Distance_Sphere(a.Location, b.Location) / 1000, 2) AS Distance_KM
FROM College_Location a JOIN College_Location b
ON a.College_ID = 1 AND b.College_ID = 2;


-- PRACTICAL 7: ACTIVE DATABASE (TRIGGERS & PROCEDURES)

-- Step 1: Setup tables
CREATE DATABASE  ADB_Active;
USE ADB_Active;

CREATE TABLE Student (
    Student_ID INT PRIMARY KEY,
    Student_Name VARCHAR(100) NOT NULL,
    Subject VARCHAR(50),
    Marks INT
);

CREATE TABLE Student_Log (
    Log_ID INT AUTO_INCREMENT PRIMARY KEY,
    Student_ID INT,
    Action_Type VARCHAR(20),
    Action_Time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Step 2: INSERT trigger
DROP TRIGGER IF EXISTS student_insert_log;
CREATE TRIGGER student_insert_log
AFTER INSERT ON Student
FOR EACH ROW
INSERT INTO Student_Log (Student_ID, Action_Type) VALUES (NEW.Student_ID, 'INSERT');

-- Test INSERT trigger
INSERT INTO Student VALUES (101, 'Rohit', 'DBMS', 75);
SELECT * FROM Student_Log;

-- Step 3: UPDATE trigger
DROP TRIGGER IF EXISTS student_update_log;
CREATE TRIGGER student_update_log
AFTER UPDATE ON Student
FOR EACH ROW
INSERT INTO Student_Log (Student_ID, Action_Type) VALUES (NEW.Student_ID, 'UPDATE');

-- Test UPDATE trigger
UPDATE Student SET Marks = 85 WHERE Student_ID = 101;
SELECT * FROM Student_Log;

-- Step 4: DELETE trigger
DROP TRIGGER IF EXISTS student_delete_log;
CREATE TRIGGER student_delete_log
AFTER DELETE ON Student
FOR EACH ROW
INSERT INTO Student_Log (Student_ID, Action_Type) VALUES (OLD.Student_ID, 'DELETE');

-- Test DELETE trigger
DELETE FROM Student WHERE Student_ID = 101;
SELECT * FROM Student_Log;

-- Step 5: Stored Procedure for batch insertion
DROP PROCEDURE IF EXISTS AddMultipleStudents;

DELIMITER //
CREATE PROCEDURE AddMultipleStudents()
BEGIN
    INSERT INTO Student VALUES
    (102, 'Amit', 'DBMS', 80),
    (103, 'Priya', 'DBMS', 88);
END //
DELIMITER ;

CALL AddMultipleStudents();

-- Step 6: Verify final logs and tables
SELECT * FROM Student;
SELECT Log_ID, Student_ID, Action_Type, Action_Time FROM Student_Log ORDER BY Log_ID;


