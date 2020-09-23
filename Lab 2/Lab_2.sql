-- Lab Session 02 - SQL – Data Definition (1)
-- Code by Raf-Fly - https://github.com/VladRafli
-- Source Code can be downloaded at https://github.com/VladRafli/Lab_Database_Systems/Lab_2

-- 1.1. Create Database first and Select the Database to work with

CREATE DATABASE `Database_Lab_1`;

USE `Database_Lab_1`;

-- 1.2. Create All The Tables

-- 
-- Customer Table
-- 
CREATE TABLE `MsCustomer` (
    `CustomerId` CHAR(5) NOT NULL,
    `CustomerName` VARCHAR(50),
    `CustomerGender` VARCHAR(10),
    `CustomerPhone` VARCHAR(13),
    `CustomerAddress` VARCHAR(100),
    PRIMARY KEY (`CustomerId`),
    CHECK (`CustomerId` IN ('CU')),
    CHECK (`CustomerGender` IN ('Male' OR 'Female'))
);

-- 
-- Staff Table
-- 
CREATE TABLE `MsStaff` (
    `StaffId` CHAR(5) NOT NULL,
    `StaffName` VARCHAR(50),
    `StaffGender` VARCHAR(10),
    `StaffPhone` VARCHAR(13),
    `StaffAddress` VARCHAR(100),
    `StaffSalary` NUMERIC(11,2),
    `StaffPosition` VARCHAR(20),
    PRIMARY KEY (`StaffId`),
    CHECK (`StaffId` IN ('SF')),
    CHECK (`StaffGender` IN ('Male' OR 'Female'))
);

-- 
-- Treatment Type Table
-- 
CREATE TABLE `MsTreatmentType` (
    `TreatmentTypeId` CHAR(5) NOT NULL,
    `TreatmentTypeName` VARCHAR(50),
    PRIMARY KEY (`TreatmentTypeId`),
    CHECK (`TreatmentTypeId` IN ('TT'))
);

-- 
-- Treatment Table
-- 
CREATE TABLE `MsTreatment` (
    `TreatmentId` CHAR(5) NOT NULL,
    `TreatmentTypeId` CHAR(5) NOT NULL,
    `TreatmentName` VARCHAR(50),
    `Price` NUMERIC(11,2),
    PRIMARY KEY (`TreatmentId`),
    FOREIGN KEY (`TreatmentTypeId`) REFERENCES MsTreatmentType(`TreatmentTypeId`),
    CHECK (`TreatmentID` IN ('TM'))
);

-- 
-- Header Salon Services Table
-- 
CREATE TABLE `HeaderSalonServices` (
    `TransactionId` CHAR(5) NOT NULL,
    `CustomerId` CHAR(5) NOT NULL,
    `StaffId` CHAR(5) NOT NULL,
    `TransactionDate` DATE,
    `PaymentType` VARCHAR(20).
    PRIMARY KEY (`TransactionId`),
    FOREIGN KEY (`CustomerId`) REFERENCES MsCustomer(`CustomerId`),
    FOREIGN KEY (`StaffId`) REFERENCES MsStaff(`StaffId`),
    CHECK (`TransactionId` IN ('TR'))
);

-- 
-- Detail Salon Services Table
-- 
CREATE TABLE `DetailSalonServices` (
    `TransactionId` CHAR(5) NOT NULL,
    `TreatmentId` CHAR(5) NOT NULL,
    PRIMARY KEY (`TransactionId`),
    PRIMARY KEY (`TreatmentId`),
    FOREIGN KEY (`TransactionId`) REFERENCES HeaderSalonServices(`TransactionId`),
    FOREIGN KEY (`TreatmentId`) REFERENCES MsTreatment(`TreatmentId`)
);

-- 2.1 Delete Detail Salon Services Table

-- Delete Table DetailSalonServices
DROP TABLE `DetailSalonServices`;

-- 3.1 Create the table

-- 
-- Detail Salon Services Table
-- 
CREATE TABLE `DetailSalonServices` (
    `TransactionId` CHAR(5) NOT NULL,
    `TreatmentId` CHAR(5) NOT NULL
);

-- 3.2 Alter specified fields for Primary Key and Foreign Key

-- Add Primary Key of TransactionId
ALTER TABLE `DetailSalonServices`
    ADD PRIMARY KEY (`TransactionId`);

-- Add Primary Key of TreatmentId
ALTER TABLE `DetailSalonServices`
    ADD PRIMARY KEY (`TreatmentID`);

-- 4 Add a constraint for MsStaff

-- Add Constraint to MsStaff with Alter Table (This is not proved correct)
/*
    Error on console:
    - Missing comma before start of a new alter operation. (near ADD)
    - Unrecognized alter operation. (near ADD)
*/
ALTER TABLE `MsStaff`
    WITH NOCHECK
    ADD CONSTRAINT `Check_Len` CHECK (LEN(StaffName) <= 5 AND LEN(StaffName) >= 20);

-- Drop the Constraint

ALTER TABLE `MsStaff`
    DROP CONSTRAINT `Check_Len`;

-- 5 Add new column of 'Description' on MsTreatment with varchar(100). Then, delete the column

-- Add New Field 'Description'
ALTER TABLE `MsTreatment`
    ADD `Description` VARCHAR(100);

-- Drop New Filed of 'Description'
ALTER TABLE `MsTreatment`
    DROP COLUMN `Description`;