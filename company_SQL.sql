--DDL (Data Definition Language)
-- Step 1: Create the database
CREATE DATABASE company;

-- Step 2: Use the database
use company;

-- Step 3: Create tables with PKs, constraints, and FKs
-- Table 1: Department

CREATE TABLE Department (
    Dnum INT PRIMARY KEY identity(10,10),                      
    DName VARCHAR(50) NOT NULL,              
    MgrSSN INT NOT NULL,      --FK from emp table                 
    HireD DATE NOT NULL                        
);


-- Table 2: DepartmentLocation (multi-valued attribute)
CREATE TABLE DepartmentLocation (
    Dnum INT NOT NULL,                         
    Loc VARCHAR(50) NOT NULL,                 
    PRIMARY KEY (Dnum, Loc),
    FOREIGN KEY (Dnum) REFERENCES Department(Dnum)
);

-- Table 3: Emp (Employee)
CREATE TABLE Emp (
    SSN INT IDENTITY(1,1) PRIMARY KEY,         
    BD DATE NOT NULL,                          
    Gender CHAR(1) CHECK (Gender IN ('M', 'F')), 
    FName VARCHAR(50) NOT NULL,                
    Lname VARCHAR(50) NOT NULL,
    S_id INT NOT NULL,
    Dnum INT ,                                 
    FOREIGN KEY (Dnum) REFERENCES Department(Dnum),
    FOREIGN KEY (S_id) REFERENCES Emp(SSN)

);


-- Table 4: Projects
CREATE TABLE Projects (
    Pnum INT PRIMARY KEY IDENTITY(1,1),                      
    Pname VARCHAR(100) NOT NULL,               
    Loca VARCHAR(50),
	City VARCHAR(50),
    Dnum INT,                                  
    FOREIGN KEY (Dnum) REFERENCES Department(Dnum)
);


-- Table 5: Dependent
CREATE TABLE Dependent (
    Depname VARCHAR(50) primary key,            
    BD DATE NOT NULL,                          
    Gender CHAR(1) CHECK (Gender IN ('M', 'F')), 
    SSN INT NOT NULL,                          
    FOREIGN KEY (SSN) REFERENCES Emp(SSN)
);

-- Table 6: Work (Associative Entity between Emp and Projects)
CREATE TABLE Work (
    Pnum INT NOT NULL,                         
    SSN INT NOT NULL,                          
    PRIMARY KEY (Pnum, SSN),
    FOREIGN KEY (Pnum) REFERENCES Projects(Pnum),
    FOREIGN KEY (SSN) REFERENCES Emp(SSN)
);
--dlete the table to add a colum
drop TABLE Work
--uding workingH col
CREATE TABLE Work (
    Pnum INT NOT NULL,                         
    SSN INT NOT NULL,
	workingH int not null,
    PRIMARY KEY (Pnum, SSN),
    FOREIGN KEY (Pnum) REFERENCES Projects(Pnum),
    FOREIGN KEY (SSN) REFERENCES Emp(SSN)
);

-- Step 4: add FK in departement table
ALTER TABLE Department
ADD CONSTRAINT FK_Department_Manager
FOREIGN KEY (MgrSSN) REFERENCES Emp(SSN)

--DML (Data Manipulation Language)
-- 1 : INSERT 
--insert into Emp table
INSERT INTO Emp (BD, Gender, FName, Lname, S_id, Dnum) VALUES
	('1980-01-01', 'M', 'John', 'Smith', 1, NULL)

INSERT INTO Emp (BD, Gender, FName, Lname, S_id, Dnum) VALUES
('1985-02-02', 'F', 'Jane', 'Doe', 1, NULL),
('1990-03-03', 'M', 'Mike', 'Brown', 1, NULL),
('1992-04-04', 'F', 'Sara', 'White', 1, NULL),
('1995-05-05', 'M', 'Tom', 'Green', 1, NULL);

Select * from Emp

INSERT INTO Department (DName, MgrSSN, HireD) VALUES
('HR', 1, '2010-01-01'),
('IT', 2, '2011-02-02'),
('Finance', 3, '2012-03-03'),
('Marketing', 4, '2013-04-04'),
('Logistics', 5, '2014-05-05');

-- insert int Department table
INSERT INTO Department (DName, MgrSSN, HireD) VALUES
('HR', 1, '2010-01-01'),
('IT', 2, '2011-02-02'),
('Finance', 3, '2012-03-03'),
('Marketing', 4, '2013-04-04'),
('Logistics', 5, '2014-05-05');

--insert into DepartmentLocation

INSERT INTO DepartmentLocation (Dnum, Loc) VALUES
(10, 'New York'),
(10, 'Boston'),            
(20, 'Chicago'),
(20, 'Houston'),           
(30, 'San Francisco'),
(30, 'San Diego'),        
(40, 'Los Angeles'),
(50, 'Seattle'),
(50, 'Portland');         
 
--insert into Projects
INSERT INTO Projects (Pname, Loca, City, Dnum) VALUES
('Project Alpha', 'Building A', 'New York', 10),
('Project Beta', 'Building B', 'Chicago', 20),
('Project Gamma', 'Building C', 'San Francisco', 30),
('Project Delta', 'Building D', 'Los Angeles', 40),
('Project Epsilon', 'Building E', 'Seattle', 50);

--insert into Dependent
INSERT INTO Dependent (Depname, BD, Gender, SSN) VALUES
('Anna', '2010-01-01', 'F', 1),
('Ben', '2011-02-02', 'M', 2),
('Clara', '2012-03-03', 'F', 3),
('David', '2013-04-04', 'M', 4),
('Eva', '2014-05-05', 'F', 5);


-- insert into Work
INSERT INTO Work (Pnum, SSN, workingH) VALUES
(1, 1, 40),
(2, 2, 35),
(3, 3, 30),
(4, 4, 25),
(5, 5, 20);




--Update Emp to assign departments
UPDATE Emp SET Dnum = 10 WHERE SSN = 1;
UPDATE Emp SET Dnum = 20 WHERE SSN = 2;
UPDATE Emp SET Dnum = 30 WHERE SSN = 3;
UPDATE Emp SET Dnum = 40 WHERE SSN = 4;
UPDATE Emp SET Dnum = 50 WHERE SSN = 5;




-- SELECT 
SELECT * FROM Emp;
SELECT FName, Lname FROM Emp WHERE Gender = 'F';
SELECT * FROM Projects WHERE City = 'Chicago';

SELECT * FROM Dependent;
SELECT Depname FROM Dependent WHERE Gender = 'F';

UPDATE Emp SET Lname = 'Black' WHERE SSN = 3;
SELECT * FROM Emp;

SELECT * FROM Projects;
UPDATE Projects SET City = 'Boston' WHERE Pnum = 2;

-- DELETE
SELECT * FROM Dependent;
DELETE FROM Dependent WHERE Depname = 'Eva';

SELECT * FROM Work;
DELETE FROM Work WHERE workingH < 26;

