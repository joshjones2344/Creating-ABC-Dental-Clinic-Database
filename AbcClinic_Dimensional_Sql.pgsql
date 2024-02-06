-- Next we create database for "ABCDentalClinicDimensional"
CREATE DATABASE ABCDentalClinicDimensional;
--Create the dimensional tables (Patients,Dentists,Appointments,Surgery) according to erd we designed
--Create the table for Time Dimension
CREATE TABLE TimeDimension (
       DateKey INT PRIMARY KEY,
       Date DATE,
       DayOfWeek VARCHAR(10),
       Month VARCHAR(10),
       Quarter INT,
       Year INT
   );
--Create the table for Patients Dimension
CREATE TABLE PatientsDimension (
       PatientKey INT  NOT NULL,
       PatientID INT,
       FirstName VARCHAR(50) NOT NULL,
       LastName VARCHAR(50) NOT NULL,
       Birth_Date DATE,
       Email VARCHAR(50),
       Phone VARCHAR(50),
       Address VARCHAR(200),
       PRIMARY KEY(PatientKey)
);   
--Create the table for Dentist Dimension
CREATE TABLE Dentist_Dimension(
    DentistKey INT NOT NULL,
    DentistID INT NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(50),
    Phone VARCHAR(50),
    PRIMARY KEY(DentistKey)
);

--Create the table for Surgery Dimension
CREATE TABLE Surgery_Dimension(
    SurgeryKey INT NOT NULL,
    SurgeryID INT NOT NULL,
    SurgeryName VARCHAR(200),
    Description VARCHAR(200),
    Cost DECIMAL(10,2),
    PRIMARY KEY(SurgeryKey)
);

--Create the table for Appointment Fact
CREATE TABLE AppointmentFact (
    AppointmentKey INT NOT NULL,
    DateKey INT NOT NULL,
    PatientKey INT NOT NULL,
    DentistKey INT NOT NULL,
    SurgeryKey INT NOT NULL,
    Time_start TIME,
    Time_end TIME,
    PRIMARY KEY(AppointmentKey),
    FOREIGN KEY (DateKey) REFERENCES TimeDimension(DateKey),
    FOREIGN KEY (PatientKey) REFERENCES PatientsDimension(PatientKey),
    FOREIGN KEY (DentistKey) REFERENCES Dentist_Dimension(DentistKey),
    FOREIGN KEY (SurgeryKey) REFERENCES Surgery_Dimension(SurgeryKey)
);

--Create the table for Revenue Fact
CREATE TABLE RevenueFact (
    DateKey INT NOT NULL,
    TotalRevenue DECIMAL(10,2),
    PRIMARY KEY(DateKey),
    FOREIGN KEY (DateKey) REFERENCES TimeDimension(DateKey)
);