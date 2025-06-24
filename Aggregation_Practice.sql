create database UdemyDB
use UdemyDB

CREATE TABLE Instructors ( 
    InstructorID INT PRIMARY KEY, 
    FullName VARCHAR(100), 
    Email VARCHAR(100), 
    JoinDate DATE 
); 
CREATE TABLE Categories ( 
    CategoryID INT PRIMARY KEY, 
    CategoryName VARCHAR(50) 
); 
CREATE TABLE Courses ( 
    CourseID INT PRIMARY KEY, 
    Title VARCHAR(100), 
    InstructorID INT, 
    CategoryID INT, 
    Price DECIMAL(6,2), 
    PublishDate DATE, 
    FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID), 
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID) 
); 
CREATE TABLE Students ( 
    StudentID INT PRIMARY KEY, 
    FullName VARCHAR(100), 
    Email VARCHAR(100), 
    JoinDate DATE 
); 
CREATE TABLE Enrollments ( 
    EnrollmentID INT PRIMARY KEY, 
    StudentID INT, 
    CourseID INT, 
    EnrollDate DATE, 
    CompletionPercent INT, 
    Rating INT CHECK (Rating BETWEEN 1 AND 5), 
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID), 
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID) 
); 

-- Instructors 
INSERT INTO Instructors VALUES 
(1, 'Sarah Ahmed', 'sarah@learnhub.com', '2023-01-10'), 
(2, 'Mohammed Al-Busaidi', 'mo@learnhub.com', '2023-05-21'); 
-- Categories 
INSERT INTO Categories VALUES 
(1, 'Web Development'), 
(2, 'Data Science'), 
(3, 'Business'); 
-- Courses 
INSERT INTO Courses VALUES 
(101, 'HTML & CSS Basics', 1, 1, 29.99, '2023-02-01'), 
(102, 'Python for Data Analysis', 2, 2, 49.99, '2023-03-15'), 
(103, 'Excel for Business', 2, 3, 19.99, '2023-04-10'), 
(104, 'JavaScript Advanced', 1, 1, 39.99, '2023-05-01'); 
-- Students 
INSERT INTO Students VALUES 
(201, 'Ali Salim', 'ali@student.com', '2023-04-01'), 
(202, 'Layla Nasser', 'layla@student.com', '2023-04-05'), 
(203, 'Ahmed Said', 'ahmed@student.com', '2023-04-10'); 
-- Enrollments 
INSERT INTO Enrollments VALUES 
(1, 201, 101, '2023-04-10', 100, 5), 
(2, 202, 102, '2023-04-15', 80, 4), 
(3, 203, 101, '2023-04-20', 90, 4), 
(4, 201, 102, '2023-04-22', 50, 3), 
(5, 202, 103, '2023-04-25', 70, 4), 
(6, 203, 104, '2023-04-28', 30, 2), 
(7, 201, 104, '2023-05-01', 60, 3); 


--1. What is the difference between GROUP BY and ORDER BY? 
-- GROUP BY use to group rows that have same value 
--ORDER BY sort the result by one or more columns

--2. Why do we use HAVING instead of WHERE when filtering aggregate results? 
-- when applied during query execution used to filter rows before grouping
--  HAVING Used to filter groups after aggregation

--3. What are common beginner mistakes when writing aggregation queries? 
--use sum() cout() mix() wite out using GROUPE BY 
--Confusing WHERE and  HAVING

--4. When would you use COUNT(DISTINCT ...), AVG(...), and SUM(...) together? 
--multiple summary statistics from the same dataset 

--5. How does GROUP BY affect query performance, and how can indexes help? 
--Group by--> scan all data /hash data  this can be expensive for the larg data
-- indexing can help speeding group by 

select * from Enrollments
--Beginner Level 
--1. Count total number of students.
select count(StudentID) from Students -->3

--2. Count total number of enrollments. 
select * from Enrollments
select count(EnrollmentID) from Enrollments -->7

--3. Find average rating of each course. 
select * from Enrollments
select * from Courses

SELECT CourseID, AVG(Rating)
from Enrollments
group by CourseID

--4. Total number of courses per instructor. 
select * from Instructors
select * from Courses

select count(CourseID),InstructorID
from Courses
group by InstructorID

--5. Number of courses in each category. 
select count(CourseID),CategoryID
from Courses
group by CategoryID

--6. Number of students enrolled in each course. 

select * from Enrollments

select count(StudentID),CourseID
from Enrollments
group by CourseID


--7. Average course price per category. 
select * from Courses

select AVG(Price),CategoryID
from Courses
group by CategoryID

--8. Maximum course price. 
select max(price),CourseID
from Courses
group by CourseID

--9. Min, Max, and Avg rating per course. 
SELECT CourseID, max(Rating) AS MAXRating,min(Rating) AS MINRating,AVG(Rating) AS AverageRating
from Enrollments
group by CourseID

--10. Count how many students gave rating = 5. 
select * from Enrollments
select studentID, Rating
From Enrollments
where Rating = 5
------------------------------Intermediate Level ---------------------------------------------

--1. Average completion percent per course. 
select * from Enrollments
select CourseID,AVG(CompletionPercent) as AverageCompletion
From Enrollments
group by CourseID

--2. Find students enrolled in more than 1 course. 
select StudentID,count(CourseID)
From Enrollments
group by StudentID
Having count(CourseID)>1

--#3. Calculate revenue per course (price * enrollments). 
select * from Courses
select c.CourseID,Price, COUNT(e.EnrollmentID),(c.Price * COUNT(e.EnrollmentID))
from Courses c, Enrollments e
group by c.CourseID

--#4. List instructor name + distinct student count. 

--#5. Average enrollments per category. 

--#6. Average course rating by instructor.

--7. Top 3 courses by enrollment count.
select * from Enrollments
select TOP 3  count(EnrollmentID),CourseID
from Enrollments
group by CourseID

--#8. Average days students take to complete 100% (use mock logic).

--#9. Percentage of students who completed each course. 

--10. Count courses published each year.
select * from Courses
select count(courseID),YEAR(PublishDate)
from Courses
GROUP BY YEAR(PublishDate)