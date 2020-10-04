-- Lab Session 02 - SQL – Data Definition (1)
-- Code by Raf-Fly - https://github.com/VladRafli
-- Source Code can be downloaded at https://github.com/VladRafli/Lab_Database_Systems/tree/master/Lab%202

-- This thing is only Executed at Microsoft SQL Server Management Studio
-- XAMPP user might have different query

-- 1.1. Create Database first and Select the Database to work with
-- You need to run this query on different file.

-- CREATE DATABASE Database_Lab_2;

-- Then you can just import all this query below

-- Select the Database
USE Database_Lab_2;

-- 1.2. Create All The Tables

-- 
-- Customer Table
-- 
CREATE TABLE MsCustomer (
    CustomerId CHAR(5) NOT NULL,
    CustomerName VARCHAR(50),
    CustomerGender VARCHAR(10),
    CustomerPhone VARCHAR(13),
    CustomerAddress VARCHAR(100),
    PRIMARY KEY (CustomerId),
    CONSTRAINT Check_CustId CHECK (CustomerId LIKE ('CU[0-9][0-9][1-9]')),
    CONSTRAINT Check_CustGen CHECK (CustomerGender IN ('Male', 'Female'))
);

-- 
-- Staff Table
-- 
CREATE TABLE MsStaff (
    StaffId CHAR(5) NOT NULL,
    StaffName VARCHAR(50),
    StaffGender VARCHAR(10),
    StaffPhone VARCHAR(13),
    StaffAddress VARCHAR(100),
    StaffSalary NUMERIC(11,2),
    StaffPosition VARCHAR(20),
    PRIMARY KEY (StaffId),
    CONSTRAINT Check_StaffId CHECK (StaffId LIKE ('SF[0-9][0-9][1-9]'))
);

-- 
-- Treatment Type Table
-- 
CREATE TABLE MsTreatmentType (
    TreatmentTypeId CHAR(5) NOT NULL,
    TreatmentTypeName VARCHAR(50),
    PRIMARY KEY (TreatmentTypeId),
    CONSTRAINT Check_TreatTypeId CHECK (TreatmentTypeId LIKE ('TT[0-9][0-9][1-9]'))
);

-- 
-- Treatment Table
-- 
CREATE TABLE MsTreatment (
    TreatmentId CHAR(5) NOT NULL,
    TreatmentTypeId CHAR(5) NOT NULL,
    TreatmentName VARCHAR(50),
    Price NUMERIC(11,2),
    PRIMARY KEY (TreatmentId),
    FOREIGN KEY (TreatmentTypeId) REFERENCES MsTreatmentType(TreatmentTypeId) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT Check_TreatId CHECK (TreatmentId LIKE ('TM[0-9][0-9][1-9]'))
);

-- 
-- Header Salon Services Table
-- 
CREATE TABLE HeaderSalonServices (
    TransactionId CHAR(5) NOT NULL,
    CustomerId CHAR(5) NOT NULL,
    StaffId CHAR(5) NOT NULL,
    TransactionDate DATE,
    PaymentType VARCHAR(20),
    PRIMARY KEY (TransactionId),
    FOREIGN KEY (CustomerId) REFERENCES MsCustomer(CustomerId) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (StaffId) REFERENCES MsStaff(StaffId) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT Check_TransId CHECK (TransactionId LIKE ('TR[0-9][0-9][1-9]'))
);

-- 
-- Detail Salon Services Table
-- 
CREATE TABLE DetailSalonServices (
    TransactionId CHAR(5) NOT NULL,
    TreatmentId CHAR(5) NOT NULL,
    FOREIGN KEY (TransactionId) REFERENCES HeaderSalonServices(TransactionId) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (TreatmentId) REFERENCES MsTreatment(TreatmentId) ON UPDATE CASCADE ON DELETE CASCADE
);

-- 2.1 Delete Detail Salon Services Table

-- Delete Table DetailSalonServices
DROP TABLE DetailSalonServices;

-- 3.1 Create the table

-- 
-- Detail Salon Services Table
-- 
CREATE TABLE DetailSalonServices (
    TransactionId CHAR(5) NOT NULL,
    TreatmentId CHAR(5) NOT NULL
);

-- 3.2 Alter specified fields for Foreign Key

-- 3.2.1 Add Foreign Key of TransactionId from HeaderSalonServices
ALTER TABLE DetailSalonServices
    ADD FOREIGN KEY (TransactionId) REFERENCES HeaderSalonServices(TransactionId) ON UPDATE CASCADE ON DELETE CASCADE;

-- 3.2.2 Add Foreign Key of TreatmentId
ALTER TABLE DetailSalonServices
    ADD FOREIGN KEY (TreatmentId) REFERENCES MsTreatment(TreatmentId) ON UPDATE CASCADE ON DELETE CASCADE;

-- 4 Add a constraint for MsStaff

-- 4.1 Add Constraint to MsStaff with Alter Table (This is not proved correct)
ALTER TABLE MsStaff
    WITH NOCHECK
    ADD CONSTRAINT Check_Len CHECK (LEN(StaffName) <= 5 AND LEN(StaffName) >= 20);

-- 4.2 Drop the Constraint

ALTER TABLE MsStaff
    DROP CONSTRAINT Check_Len;

-- 5 Add new column of 'Description' on MsTreatment with varchar(100). Then, delete the column

-- 5.1 Add New Field 'Description'
ALTER TABLE MsTreatment
    ADD Description VARCHAR(100);

-- 5.2 Drop New Field of 'Description'
ALTER TABLE MsTreatment
    DROP COLUMN Description;

-- Lastly, to see all the tables
-- Do this query

SELECT * FROM INFORMATION_SCHEMA.COLUMNS;

-- To see specific table
-- Do this query

-- SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='tableName';