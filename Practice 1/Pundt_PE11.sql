/*
NAME: Griffin Pundt
CLASS: ISTE230
ASSIGNMENT: PE11
*/

/*if Pundt_PE11 database exists, deletes it and creates a new one*/
DROP DATABASE IF EXISTS Pundt_PE11;
CREATE DATABASE Pundt_PE11;

SHOW DATABASES;
USE Pundt_PE11;

/*Creates PERSON table*/
CREATE TABLE PERSON(
	personID INT UNSIGNED AUTO_INCREMENT,
	firstName VARCHAR(25),
	lastName VARCHAR(25),
	staff CHAR CHECK (staff="y" OR staff="n"),
	patient CHAR CHECK (patient="y" OR patient="n"),
	CONSTRAINT person_personID_pk PRIMARY KEY(personID)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8;
	
DESCRIBE PERSON;

/*Creates DEPARTMENT Table*/
CREATE TABLE DEPARTMENT(
	deptNum SMALLINT UNSIGNED AUTO_INCREMENT,
	name VARCHAR(50),
	CONSTRAINT department_deptNum_pk PRIMARY KEY(deptNum)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DESCRIBE DEPARTMENT;

/*Creates INSURANCE_COMPANY table*/
CREATE TABLE INSURANCE_COMPANY(
	coID INT UNSIGNED AUTO_INCREMENT,
	name VARCHAR(80),
	CONSTRAINT insurance_company_coID_pk PRIMARY KEY(coID)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8;
	
DESCRIBE INSURANCE_COMPANY;


/*Create STAFF table*/
CREATE TABLE STAFF(
	staffID INT UNSIGNED NOT NULL,
	managerID INT UNSIGNED,
	supportStaff CHAR NOT NULL CHECK (supportStaff="y" OR supportStaff="n") DEFAULT "n",
	nurse CHAR NOT NULL CHECK (nurse="y" OR nurse="n") DEFAULT "n",
	doctor CHAR NOT NULL CHECK (doctor="y" OR doctor="n") DEFAULT "n",
	CONSTRAINT staff_staffID_pk PRIMARY KEY(staffID),
	CONSTRAINT staff_staffID_fk FOREIGN KEY(staffID) REFERENCES PERSON(personID),
	CONSTRAINT staff_managerID_fk FOREIGN KEY(managerID) REFERENCES STAFF(staffID)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8;
	
DESCRIBE STAFF;


/*Create SUPPORT_STAFF table*/
CREATE TABLE SUPPORT_STAFF(
	supportStaffID INT UNSIGNED NOT NULL,
	wage DECIMAL(4, 2) NOT NULL,
	CONSTRAINT sstaff_supportStaffID_pk PRIMARY KEY(supportStaffID),
	CONSTRAINT sstaff_supportStaffID_fk FOREIGN KEY (supportStaffID) REFERENCES STAFF(staffID)
	)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DESCRIBE SUPPORT_STAFF;


/*Create NURSE table*/
CREATE TABLE NURSE(
	nurseID INT UNSIGNED NOT NULL,
	certification VARCHAR(4) NOT NULL CHECK(certification="LPN" OR certification="RN" OR certification="APRN"),
	CONSTRAINT nurse_nurseID_pk PRIMARY KEY (nurseID),
	CONSTRAINT nurse_nurseID_fk FOREIGN KEY (nurseID) REFERENCES STAFF(staffID)
	)ENGINE=InnoDB DEFAULT CHARSET=utf8;
	
DESCRIBE NURSE;



/*Create DOCTOR table*/
CREATE TABLE DOCTOR(
	doctorID INT UNSIGNED NOT NULL,
	mentorID INT UNSIGNED,
	CONSTRAINT doctor_doctorID_pk PRIMARY KEY (doctorID),
	CONSTRAINT doctor_doctorID_fk FOREIGN KEY (doctorID) REFERENCES STAFF(staffID),
	CONSTRAINT doctor_mentorID_fk FOREIGN KEY (mentorID) REFERENCES DOCTOR(doctorID)
	)ENGINE=InnoDB DEFAULT CHARSET=utf8;
	
DESCRIBE DOCTOR;


/*Create PATIENT table*/
CREATE TABLE PATIENT(
	patientID INT UNSIGNED NOT NULL,
	doctorID INT UNSIGNED,
	CONSTRAINT patient_patientID_pk PRIMARY KEY (patientID),
	CONSTRAINT patient_patientID_fk FOREIGN KEY (patientID) REFERENCES PERSON(personID),
	CONSTRAINT patient_doctorID_fk FOREIGN KEY (doctorID) REFERENCES DOCTOR(doctorID)
	)ENGINE=InnoDB DEFAULT CHARSET=utf8;
	
DESCRIBE PATIENT;


/*Create DEPARTMENT_STAFF table*/
CREATE TABLE DEPARTMENT_STAFF(
	deptNum SMALLINT UNSIGNED NOT NULL,
	staffID INT UNSIGNED NOT NULL,
	CONSTRAINT deptNum_staffID_pk PRIMARY KEY (deptNum, staffID),
	CONSTRAINT department_deptNum_fk FOREIGN KEY (deptNum) REFERENCES DEPARTMENT (deptNum),
	CONSTRAINT department_staffID_fk FOREIGN KEY (staffID) REFERENCES STAFF(staffID)
	)ENGINE=InnoDB DEFAULT CHARSET=utf8;
	
DESCRIBE DEPARTMENT_STAFF;


/*Create INSURANCE_POLICY table*/
CREATE TABLE INSURANCE_POLICY(
	policyNum SMALLINT CHECK (policyNum >= 0 AND policyNum <= 25) NOT NULL,
	patientID INT UNSIGNED NOT NULL,
	insCoID INT UNSIGNED NOT NULL,
	CONSTRAINT ipolicy_pk PRIMARY KEY (policyNum, patientID, insCoID),
	CONSTRAINT ipolicy_patientID_fk FOREIGN KEY (patientID) REFERENCES PATIENT(patientID),
	CONSTRAINT ipolicy_insColID_fk FOREIGN KEY (insCoID) REFERENCES INSURANCE_COMPANY(coID)
	)ENGINE=InnoDB DEFAULT CHARSET=utf8;
	
DESCRIBE INSURANCE_POLICY;

/*Shows all created tables*/
SHOW TABLES;