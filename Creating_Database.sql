--create database for "ABCDentalClinicNormalized"
CREATE DATABASE ABCDentalClinicNormalized;
--On Created database, click new query and run the following code to create tables
--Create the normalized tables (Patients,Dentists,Appointments,Surgery) according to erd we designed
--Create the table for Patients

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

-- Next we create database for "ABCDentalClinicDimensional"
CREATE DATABASE ABCDentalClinicDimensional;
--Create the dimensional tables (Patients,Dentists,Appointments,Surgery) according to erd we designed
--Create the table for Time Dimension
CREATE TABLE Time_Dimension(
    TimeID INT NOT NULL,
    Appn_Date DATE,
    Time_start TIME,
    Time_end TIME,
    PRIMARY KEY(TimeID)
);

--Create the table for Patient Dimension
CREATE TABLE Patient_Dimension(
    PatientID INT NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Birth_Date DATE,
    Email VARCHAR(50),
    Phone VARCHAR(50),
    Address VARCHAR(200),
    PRIMARY KEY(PatientID)
);

--Create the table for Dentist Dimension
CREATE TABLE Dentist_Dimension(
    DentistID INT NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(50),
    Phone VARCHAR(50),
    PRIMARY KEY(DentistID)
);

--Create the table for Surgery Dimension
CREATE TABLE Surgery_Dimension(
    SurgeryID INT NOT NULL,
    SurgeryName VARCHAR(200),
    Description VARCHAR(200),
    Cost DECIMAL(10,2),
    PRIMARY KEY(SurgeryID)
);

--Create the table for Appointment Fact
CREATE TABLE AppointmentFact (
    AppointmentKey INT NOT NULL,
    TimeID INT NOT NULL,
    PatientID INT NOT NULL,
    DentistID INT NOT NULL,
    SurgeryID INT NOT NULL,
    Time_start TIME,
    Time_end TIME,
    PRIMARY KEY(AppointmentKey),
    FOREIGN KEY(TimeID) REFERENCES Time_Dimension(TimeID),
    FOREIGN KEY(PatientID) REFERENCES Patient_Dimension(PatientID),
    FOREIGN KEY(DentistID) REFERENCES Dentist_Dimension(DentistID),
    FOREIGN KEY(SurgeryID) REFERENCES Surgery_Dimension(SurgeryID)
);

--Create the table for Revenue Fact
CREATE TABLE RevenueFact (
    TimeID INT NOT NULL,
    TotalRevenue DECIMAL(10,2),
    PRIMARY KEY(TimeID),
    FOREIGN KEY(TimeID) REFERENCES Time_Dimension(TimeID)
);

