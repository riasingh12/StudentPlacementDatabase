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