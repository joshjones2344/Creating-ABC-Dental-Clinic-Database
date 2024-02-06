--create database for "ABCDentalClinicNormalized"

CREATE DATABASE ABCDentalClinicNormalized;


CREATE TABLE Patients(
    PatientID INT NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Birth_Date DATE,
    Email VARCHAR(50),
    Phone VARCHAR(50),
    Address VARCHAR(200),
    PRIMARY KEY(PatientID)
);

--Create the table for Dentists
CREATE TABLE Dentists(
    DentistID INT NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(50),
    Phone VARCHAR(50),
    PRIMARY KEY(DentistID)
);

--Create the table for Appointments
CREATE TABLE Appointments(
    AppointmentID INT NOT NULL,
    PatientID INT NOT NULL,
    DentistID INT NOT NULL,
    Appn_Date DATE,
    Time_start TIME,
    Time_end TIME,
    Procedure VARCHAR(200),
    PRIMARY KEY(AppointmentID),
    FOREIGN KEY(PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY(DentistID) REFERENCES Dentists(DentistID)
);

--Create the table for Surgery
CREATE TABLE Surgery(
    SurgeryID INT NOT NULL,
    AppointmentID INT NOT NULL,
    SurgeryName VARCHAR(200),
    Description VARCHAR(200),
    Cost DECIMAL(10,2),
    PRIMARY KEY(SurgeryID),
    FOREIGN KEY(AppointmentID) REFERENCES Appointments(AppointmentID)
);