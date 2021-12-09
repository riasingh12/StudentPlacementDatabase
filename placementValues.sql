DROP TABLE IF EXISTS Student, College, Degree, Department, Faculty, Company, Placement, Internship, Project;

CREATE TABLE College(college_id VARCHAR(50) NOT NULL,college_name VARCHAR(100) NOT NULL,addr VARCHAR(100),PRIMARY KEY (college_id));

CREATE TABLE Department(dept_id VARCHAR(50) NOT NULL,dept_name VARCHAR(100) NOT NULL UNIQUE,PRIMARY KEY (dept_id));

CREATE TABLE Degree(degree_id VARCHAR(50) NOT NULL,degree_name VARCHAR(100) NOT NULL,dept_id VARCHAR(50) NOT NULL,specialization VARCHAR(20) NOT NULL DEFAULT 'None', FOREIGN KEY(dept_id) REFERENCES Department(dept_id),PRIMARY KEY (degree_id));

CREATE TABLE Student(SRN INT NOT NULL ,student_name VARCHAR(100) NOT NULL,cgpa FLOAT NOT NULL DEFAULT 0.0,year_of_admission DATE NOT NULL,college_id VARCHAR(50) NOT NULL,degree_id VARCHAR(50) NOT NULL,FOREIGN KEY(college_id) REFERENCES College(college_id),FOREIGN KEY(degree_id) REFERENCES Degree(degree_id),PRIMARY KEY (SRN,college_id));

CREATE TABLE Faculty(faculty_id VARCHAR(50) NOT NULL,faculty_name VARCHAR(100) NOT NULL,dept_id VARCHAR(50) NOT NULL,college_id VARCHAR(50) NOT NULL,FOREIGN KEY(college_id) REFERENCES College(college_id),FOREIGN KEY(dept_id) REFERENCES Department(dept_id),PRIMARY KEY (faculty_id));

CREATE TABLE Company(company_id VARCHAR(50) NOT NULL, company_name VARCHAR(100) NOT NULL UNIQUE, vacancy INT,PRIMARY KEY(company_id));

CREATE TABLE Placement(CTC DECIMAL(32, 2),jobpost VARCHAR(100) NOT NULL DEFAULT 'Freshman', SRN INT NOT NULL,faculty_id VARCHAR(50) NOT NULL,company_id VARCHAR(50) NOT NULL,college_id VARCHAR(50) NOT NULL,FOREIGN KEY(SRN,college_id) REFERENCES Student(SRN,college_id),FOREIGN KEY(faculty_id) REFERENCES Faculty(faculty_id),PRIMARY KEY(SRN,college_id, company_id));

CREATE TABLE Project(project_id INT NOT NULL,project_name VARCHAR(50) NOT NULL UNIQUE DEFAULT 'Intern',PRIMARY KEY (project_id));

CREATE TABLE Internship(SRN INT NOT NULL,faculty_id VARCHAR(50) NOT NULL,company_id VARCHAR(50) NOT NULL,college_id VARCHAR(50) NOT NULL,project_id INT NOT NULL,FOREIGN KEY(SRN,college_id) REFERENCES Student(SRN,college_id),FOREIGN KEY(project_id) REFERENCES Project(project_id),FOREIGN KEY(faculty_id) REFERENCES Faculty(faculty_id),FOREIGN KEY(company_id) REFERENCES Company(company_id),PRIMARY KEY (SRN, college_id, project_id));


INSERT INTO College VALUES ('PES', 'PEOPLES EDUCATION SOCIETY', 'HOSUR ROAD, BENGALURU'),('XIE', 'XAVIER INSTITUTE OF ENGINEERING', 'PALM BEACH ROAD, MUMBAI'),('MIT', 'MIT COLLEGE OF ENGINEERING', 'LONAVLA, PUNE'),('BITP', 'BITS PILANI', 'SADASHIV NAGAR, PILANI'),('BITH', 'BITS PILANI', 'K R PURAM, HYDERABAD');

INSERT INTO Department VALUES ('CSE','COMPUTER SCIENCE'),('ECE','ELECTRONICS AND COMMUNICATION'),('MECH','MECHANICAL ENGINEERING');

INSERT INTO Degree VALUES('UECS','BACHELORS','CSE','CYBERSECURITY' ),('UEEC','BACHELORS', 'ECE','IMAGE PROCESSING'),('UEME','BACHELORS','MECH','FLUID MECHANICS'),('MECS','MASTERS','CSE','DATA SCIENCE'),('MEEC','MASTERS','ECE','SIGNAL PROCESSING'),('MEME','MASTERS','MECH','THERMODYNAMICS'),('DECS','DOCTORATE','CSE','MACHINE LEARNING'),('DEEC','DOCTORATE','ECE','VLSI'),('DEME','DOCTORATE','MECH','BIOMECHANICS');

INSERT INTO Student VALUES (326, 'RIA SINGH', 8.3, '2020-6-1', 'PES', 'UECS'),(310, 'RAEESA TANSEEN', 9.5, '2019-6-1', 'PES', 'MECS'),(286, 'PRACHI SENGAR', 9.7, '2018-6-1', 'PES', 'DECS'),(354, 'SHLOK GUPTA', 8.5, '2020-5-1', 'XIE', 'MEME'),(145, 'RITU KUMAR', 7.8, '2019-5-15', 'BITH', 'MECS'),(298, 'AAKANSHA AGARWAL', 6.0, '2020-7-1', 'BITP', 'DEEC'),(109, 'RAJ MALHOTRA', 8.7, '2018-8-1', 'MIT', 'UEEC'),(286, 'BHUMI PADREKAR', 7.6, '2019-5-1', 'MIT', 'UEME');

INSERT INTO Faculty VALUES('XIECS101', 'Vandana M', 'CSE', 'XIE'),('PESEC111', 'Archana S', 'ECE', 'PES'),('PESME121', 'Aishwarya S', 'MECH', 'PES'),('BITPME103', 'Satish HM', 'MECH', 'BITP'),('BITPEC002', 'Sarthak G', 'ECE', 'BITP'),('BITHCS105', 'Anand BV', 'CSE', 'BITH'),('BITHME112', 'Sriram K', 'MECH', 'BITH'),('XIEME111', 'Priya K', 'MECH', 'XIE'),('MITEC123', 'Priya K', 'ECE', 'MIT'),('MITME023', 'Narayan N', 'MECH', 'MIT'),('PESCS115', 'Jeet P', 'CSE', 'PES');

INSERT INTO Company VALUES('A1', 'XORIANT', 5),('A2', 'QUINNOX', 3),('B3', 'AMAZON', 2),('B4', 'IGATE', 10),('C5', 'MICROSOFT', 8),('C6', 'MAQ SOFTWARE', 4),('D7', 'DIRECTI', 11),('D8', 'ATOS', 5);

INSERT INTO Placement VALUES (150405.50, 'Junior Assistant', 326,'PESCS115', 'A1', 'PES'),(60405.50, 'Research Assistant', 145,'BITHCS105', 'A2', 'BITH'),(130434.50, 'Junior Manager', 286,'MITME023', 'B3', 'MIT'),(150435.50, 'Junior Manager', 310,'PESCS115', 'C6', 'PES'),(67405.50, 'Junior Software Executive', 354,'XIEME111', 'D8', 'XIE'),(96042.50, 'Project Manager', 286,'PESCS115', 'B3', 'PES'), (157392.50, 'Software Architect', 298,'BITPEC002', 'C6', 'BITP'), (86948.50, 'Big Data Engineer', 109,'MITEC123', 'A2', 'MIT');

INSERT INTO Project VALUES (1001,'E-Commerce website'),(1002,'Blogging App'), (1003,'Library Management App'),(1004,'Machine Learning'),(1005,'Event Management website'),(1006,'Shooting game'),(1007,'Robot automation'),(1008,'Big data');

INSERT INTO Internship VALUES (326,'PESCS115','A1','PES',1008),(354,'XIEME111','D7','XIE',1001),(109,'MITEC123','C6','MIT',1002),(286,'PESCS115','B3','PES',1003),(286,'MITME023','A2','MIT',1004),(310,'PESCS115','B3','PES',1005),(354,'XIEME111','D8','XIE',1006),(145,'BITHCS105','C6','BITH',1007);