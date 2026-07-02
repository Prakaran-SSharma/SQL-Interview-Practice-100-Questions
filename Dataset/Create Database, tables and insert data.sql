
-------------------------------------  Creating Databse and Use it ---------------------------------------------

create database SQL_Interview_Practice;
Use SQL_Interview_Practice;

                                       -- Creating Departments Table  --

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

-------------------------------------  Inserting Records in Departments Table  ---------------------------------
INSERT INTO Departments VALUES
(1,'HR'),
(2,'Finance'),
(3,'IT'),
(4,'Operations'),
(5,'Sales');

                                          -- Creating Employees Table  --

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(50),
    DepartmentID INT,
    Salary DECIMAL(10,2),
    HireDate DATE,
    City VARCHAR(30),
    ManagerID INT NULL,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-------------------------------------  Inserting Records in Employees Table  ---------------------------------

INSERT INTO Employees VALUES
(101,'Amit',1,45000,'2021-01-15','Delhi',110),
(102,'Priya',2,60000,'2020-03-18','Noida',111),
(103,'Rahul',3,85000,'2019-05-20','Delhi',112),
(104,'Neha',4,52000,'2022-02-14','Pune',113),
(105,'Vikas',5,75000,'2020-06-12','Mumbai',114),
(106,'Anjali',3,90000,'2018-08-25','Noida',112),
(107,'Rohan',2,65000,'2021-04-10','Delhi',111),
(108,'Sneha',1,47000,'2023-01-18','Gurgaon',110),
(109,'Karan',5,72000,'2022-07-09','Mumbai',114),
(110,'Suresh',1,95000,'2017-09-15','Delhi',NULL),
(111,'Pooja',2,98000,'2016-11-20','Noida',NULL),
(112,'Manish',3,120000,'2015-05-08','Delhi',NULL),
(113,'Deepak',4,88000,'2018-10-12','Pune',NULL),
(114,'Ritika',5,105000,'2017-03-16','Mumbai',NULL),
(115,'Aakash',4,55000,'2023-04-01','Hyderabad',113);

                                             -- Creating Clients Table  --

CREATE TABLE Clients (
    ClientID INT PRIMARY KEY,
    ClientName VARCHAR(50),
    Country VARCHAR(30)
);
-------------------------------------  Inserting Records in Clients Table  ---------------------------------

INSERT INTO Clients VALUES
(1,'Google','USA'),
(2,'Microsoft','USA'),
(3,'Amazon','UK'),
(4,'Accenture','India'),
(5,'Infosys','India'),
(6,'IBM','Canada'),
(7,'Meta','USA'),
(8,'Oracle','India'),
(9,'Capgemini','France'),
(10,'Deloitte','UK'),
(11,'TCS','India'),
(12,'Wipro','India'),
(13,'EY','UK'),
(14,'KPMG','India'),
(15,'Cognizant','USA');

                                            -- Creating Recruiters Table  --

CREATE TABLE Recruiters (
    RecruiterID INT PRIMARY KEY,
    RecruiterName VARCHAR(50),
    DepartmentID INT,
    ExperienceYears INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);
-------------------------------------  Inserting Records in Recruiters Table  ---------------------------------

INSERT INTO Recruiters VALUES
(201,'Raj',1,2),
(202,'Ankit',1,5),
(203,'Simran',1,4),
(204,'Ravi',1,6),
(205,'Nisha',1,3),
(206,'Arjun',1,7),
(207,'Kriti',1,2),
(208,'Aman',1,5),
(209,'Shivani',1,4),
(210,'Tarun',1,6),
(211,'Megha',1,3),
(212,'Abhishek',1,5),
(213,'Pallavi',1,4),
(214,'Mohit',1,2),
(215,'Komal',1,6);

                                                     -- Creating Candidates Table  --

CREATE TABLE Candidates (
    CandidateID INT PRIMARY KEY,
    CandidateName VARCHAR(50),
    Skill VARCHAR(40),
    Experience INT,
    City VARCHAR(30)
);
-------------------------------------  Inserting Records in Candidates Table  ---------------------------------

INSERT INTO Candidates VALUES
(301,'Rohit','SQL',3,'Delhi'),
(302,'Anu','Power BI',4,'Noida'),
(303,'Kunal','Python',2,'Pune'),
(304,'Riya','Java',5,'Delhi'),
(305,'Nitin','SQL',6,'Mumbai'),
(306,'Priti','Python',3,'Delhi'),
(307,'Ajay','Power BI',2,'Noida'),
(308,'Divya','SQL',4,'Hyderabad'),
(309,'Sachin','Azure',5,'Delhi'),
(310,'Kajal','Excel',2,'Mumbai'),
(311,'Sonia','SQL',7,'Delhi'),
(312,'Varun','Python',5,'Pune'),
(313,'Meena','Power BI',3,'Noida'),
(314,'Aarti','Java',4,'Delhi'),
(315,'Vivek','SQL',5,'Mumbai');

                                            -- Creating Applications Table  --

CREATE TABLE Applications (
    ApplicationID INT PRIMARY KEY,
    CandidateID INT,
    ClientID INT,
    RecruiterID INT,
    Status VARCHAR(30),
    ApplicationDate DATE,
    FOREIGN KEY (CandidateID) REFERENCES Candidates(CandidateID),
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID),
    FOREIGN KEY (RecruiterID) REFERENCES Recruiters(RecruiterID)
);
-------------------------------------  Inserting Records in Applications Table  ---------------------------------

INSERT INTO Applications VALUES
(401,301,1,201,'Joined','2024-01-05'),
(402,302,2,202,'Interview','2024-01-08'),
(403,303,3,203,'Rejected','2024-01-10'),
(404,304,4,204,'Offer','2024-01-12'),
(405,305,5,205,'Joined','2024-01-15'),
(406,306,6,206,'Interview','2024-01-18'),
(407,307,7,207,'Screening','2024-01-20'),
(408,308,8,208,'Joined','2024-01-22'),
(409,309,9,209,'Rejected','2024-01-24'),
(410,310,10,210,'Offer','2024-01-26'),
(411,311,11,211,'Joined','2024-01-28'),
(412,312,12,212,'Interview','2024-02-01'),
(413,313,13,213,'Screening','2024-02-03'),
(414,314,14,214,'Joined','2024-02-05'),
(415,315,15,215,'Offer','2024-02-08');