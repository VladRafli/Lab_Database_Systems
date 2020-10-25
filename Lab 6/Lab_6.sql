-- Lab Session 06 - SQL – Data Manipulation (4)
-- Code by Raf-Fly - https://github.com/VladRafli
-- Source Code can be downloaded at https://github.com/VladRafli/Lab_Database_Systems/tree/master/Lab%206

-- This thing is only Executed at Microsoft SQL Server Management Studio
-- MariaDB, MySQL user might have different query

--
--  Create Database one
--

USE master

DROP DATABASE Lab_6

CREATE DATABASE Lab_6

USE Lab_6

--
-- Recreate Table
--

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
    CONSTRAINT Check_CustId CHECK (CustomerId LIKE ('CU[0-9][0-9][0-9]')),
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
    CONSTRAINT Check_StaffId CHECK (StaffId LIKE ('SF[0-9][0-9][0-9]'))
);

-- 
-- Treatment Type Table
-- 
CREATE TABLE MsTreatmentType (
    TreatmentTypeId CHAR(5) NOT NULL,
    TreatmentTypeName VARCHAR(50),
    PRIMARY KEY (TreatmentTypeId),
    CONSTRAINT Check_TreatTypeId CHECK (TreatmentTypeId LIKE ('TT[0-9][0-9][0-9]'))
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
    CONSTRAINT Check_TreatId CHECK (TreatmentId LIKE ('TM[0-9][0-9][0-9]'))
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
    CONSTRAINT Check_TransId CHECK (TransactionId LIKE ('TR[0-9][0-9][0-9]'))
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

--
-- Check Tables
--

SELECT  *
FROM    INFORMATION_SCHEMA.COLUMNS

--
-- Insert Required Data
--


--
-- MsCustomer
--

INSERT INTO MsCustomer (CustomerId,CustomerName,CustomerGender, CustomerPhone,CustomerAddress)
VALUES
    ('CU001', 'Franky', 'Male', '08566543338', 'Daan Mogot Baru Street no 6'),
    ('CU002', 'Emalia Dewi', 'Female', '085264782135', 'Tanjung Duren Street no 185'),
    ('CU003', 'Elysia Chen', 'Female', '085754206611', 'Kebon Jeruk Street no 120'),
    ('CU004', 'Brando Kartawijaya', 'Male', '081170225561', 'Greenvile Street no 88'),
    ('CU005', 'Andy Putra', 'Male', '087751321421', 'Sunter Street no 42');

--
-- MsStaff
--
INSERT INTO MsStaff
    (StaffId, StaffName, StaffGender, StaffPhone, StaffAddress, StaffSalary, StaffPosition)
VALUES
    ('SF001', 'Dian Felita Tanoto', 'Female', '085265442222', 'Palmerah Street no 56', 15000000, 'Top Stylist'),
    ('SF002', 'Mellissa Pratiwi', 'Female', '085755552011', 'Kebon Jerus Street no 151', 1000000, 'Top Stylist'),
    ('SF003', 'Livia Ashianti', 'Female', '085218542222', 'Kebon Jerus Street no 19', 7000000, 'Stylist'),
    ('SF004', 'Indra Saswita', 'Male', '085564223311', 'Sunter Street no 91', 7000000, 'Stylist'),
    ('SF005', 'Ryan Nixon Salim', 'Male', '085710255522', 'Sunter Street no 91', 3000000, 'Stylist'),
    ('SF006', 'Jeklin Harefa', 'Female', '085265433322', 'Kebon Jeruk Street no 140', 3000000, 'Stylist'),
    ('SF007', 'Lavinia', 'Female', '085755500011', 'Kebon Jeruk Street no 153', 3000000, 'Stylist'),
    ('SF008', 'Stephen Adrianto', 'Male', '085564223311', 'Mandala Street no 14', 3000000, 'Stylist'),
    ('SF009', 'Rico Wijaya', 'Male', '085710252525', 'Keluarga Street no 78', 3000000, 'Stylist'),
    ('SF010', 'Effendy Lesmana', 'Male', '085218587878', 'Tanggerang City Street no 88', FLOOR(RAND() * (5000000 - 3000000 + 1) + 3000000), 'Stylist');

--
-- MsTreatmentType
--

INSERT INTO MsTreatmentType
VALUES	
    ('TT001', 'Hair Treatment'),
    ('TT002', 'Hair Spa Treatment'),
    ('TT003', 'Make Up and Facial'),
    ('TT004', 'Menicure Pedicure'),
    ('TT005', 'Premium Treatment');

--
-- MsTreatment
--

INSERT INTO MsTreatment (TreatmentId, TreatmentTypeId, TreatmentName, Price)
VALUES 
    ('TM001','TT001','Cutting by Stylist',150000),
	('TM002','TT001','Cutting by Top Stylist',450000),
	('TM003','TT001','Cutting by Pony',50000),
	('TM004','TT001','Blow',90000),
	('TM005','TT001','Coloring',480000),
	('TM006','TT001','Highlight',320000),
	('TM007','TT001','Japanese Perm',700000),
	('TM008','TT001','Digital Perm',1100000),
	('TM009','TT001','Special Perm',1100000),
	('TM010','TT001','Rebonding Treatment',110000),
	('TM011','TT002','Creambath',1500000),
	('TM012','TT002','Hair Spa',250000),
	('TM013','TT002','Hair Mask',250000),
	('TM014','TT002','Hand Spa Reflexy',200000),
	('TM015','TT002','Reflexy',250000),
	('TM016','TT002','Back Teraphy Massage',300000),
	('TM017','TT003','Make Up',500000),
	('TM018','TT003','Make Up Wedding',5000000),
	('TM019','TT003','Facial',300000),
	('TM020','TT004','Manicure',80000),
	('TM021','TT004','Pedicure',100000),
	('TM022','TT004','Nail Extension',250000),
	('TM023','TT004','Nail Acrylic Infill',340000),
	('TM024','TT005','Japanese Treatment',350000),
	('TM025','TT005','Scalp Treatment',250000),
	('TM026','TT005','Crystal Treatment',400000);

--
-- HeaderSalonServices
-- 

INSERT INTO HeaderSalonServices (TransactionId, CustomerId, StaffId, TransactionDate, PaymentType)
VALUES
    ('TR001', 'CU001', 'SF004', '2012/12/20', 'Credit'),
    ('TR002', 'CU002', 'SF005', '2012/12/20', 'Credit'),
    ('TR003', 'CU003', 'SF003', '2012/12/20', 'Cash'),
    ('TR004', 'CU004', 'SF005', '2012/12/20', 'Debit'),
    ('TR005', 'CU005', 'SF003', '2012/12/21', 'Debit'), 
    ('TR006', 'CU001', 'SF005', '2012/12/21', 'Credit'),
    ('TR007', 'CU002', 'SF001', '2012/12/22', 'Cash'),
    ('TR008', 'CU003', 'SF002', '2012/12/22', 'Credit'),
    ('TR009', 'CU005', 'SF004', '2012/12/22', 'Debit'),
    ('TR010', 'CU001', 'SF004', '2012/12/23', 'Credit'),
    ('TR011', 'CU001', 'SF004', '2012/12/23', 'Credit'),
    ('TR012', 'CU002', 'SF006', '2012/12/24', 'Cash'),
    ('TR013', 'CU003', 'SF007', '2012/12/24', 'Debit'),
    ('TR014', 'CU004', 'SF005', '2012/12/25', 'Debit'),
    ('TR015', 'CU005', 'SF007', '2012/12/25', 'Credit'),
    ('TR016', 'CU005', 'SF005', '2012/12/26', 'Cash'),
    ('TR017', 'CU002', 'SF001', '2012/12/26', 'Credit'),
    ('TR018', 'CU003', 'SF002', '2012/12/26', 'Debit'),
    ('TR019', 'CU005', 'SF004', '2015/12/20', 'Credit');

--
-- DetailSalonServices
--

INSERT INTO DetailSalonServices (TransactionId, TreatmentId)
VALUES
    ('TR010', 'TM003'),
    ('TR010', 'TM005'),
    ('TR010', 'TM010'),
    ('TR011', 'TM015'),
    ('TR011', 'TM025'),
    ('TR012', 'TM009'),
    ('TR013', 'TM003'),
    ('TR013', 'TM006'),
    ('TR013', 'TM015'),
    ('TR014', 'TM016'),
    ('TR015', 'TM016'),
    ('TR015', 'TM006'),
    ('TR016', 'TM015'),
    ('TR016', 'TM003'),
    ('TR016', 'TM005'),
    ('TR017', 'TM003'),
    ('TR018', 'TM006'),
    ('TR018', 'TM005'),
    ('TR018', 'TM007');

--
-- 1. TreatmentTypeName, TreatmentName, and Price for every treatment which name contains ‘hair’ or start with ‘nail’ word and has price below 100000.
--

SELECT      MsTreatmentType.TreatmentTypeName, 
            MsTreatment.TreatmentName, 
            MsTreatment.Price
FROM        MsTreatment
INNER JOIN  MsTreatmentType ON MsTreatment.TreatmentTypeId = MsTreatmentType.TreatmentTypeId -- Join Tabel MsTreatmentType
WHERE       (
                MsTreatmentType.TreatmentTypeName LIKE '%hair%' -- Find TreatmentTypeName contains 'hair'
                OR 
                MsTreatmentType.TreatmentTypeName LIKE '%menicure%' -- Find TreatmentTypeName contains 'menicure'
            )
AND         MsTreatment.Price < 100000; -- Find treatment price that below 100000

--
-- 2. Display StaffName and StaffEmail (obtained from the first character of staff’s name in lowercase format and followed with last word of staff’s name and ‘@oosalon.com’ word) for every staff who handle transaction on Thursday.The duplicated data must be displayed only once
--

SELECT      DISTINCT MsStaff.StaffName, -- StaffName with same data will not shown
            LOWER(LEFT(MsStaff.StaffName, 1)) + -- Lowercase 1 char from left StaffName
            LOWER(RIGHT(MsStaff.StaffName, CHARINDEX(' ', REVERSE(MsStaff.StaffName)) - 1)) + -- Lowercase all char before whitespace from right StaffName
            '@oosalon.com' AS 'Staff Email' -- Concat '@oosalon.com'
FROM        MsStaff
INNER JOIN  HeaderSalonServices ON HeaderSalonServices.StaffId = MsStaff.StaffId -- Join Table HeaderSalonServices
WHERE       DATENAME(WEEKDAY, HeaderSalonServices.TransactionDate) = 'Thursday'; -- Find the TransactionDate happened at Thursday

--
-- 3. Display New Transaction ID (obtained by replacing ‘TR’ in TransactionID with ‘Trans’), Old Transaction ID (obtained from TransactionId), TransactionDate, StaffName, and CustomerName for every transaction which happened 2 days before 24th December 2012.
--

SELECT      REPLACE(HeaderSalonServices.TransactionId, 'TR', 'Trans') AS 'New Transaction ID', -- Replace 2 word 'TR' in TransactionID to 'Trans'
            HeaderSalonServices.TransactionId AS 'Old Transaction ID',
            HeaderSalonServices.TransactionDate, 
            MsStaff.StaffName, 
            MsCustomer.CustomerName
FROM        HeaderSalonServices
INNER JOIN  MsStaff ON MsStaff.StaffId = HeaderSalonServices.StaffId -- Join table MsStaff
INNER JOIN  MsCustomer ON MsCustomer.CustomerId = HeaderSalonServices.CustomerId -- Join table MsCustomer
WHERE       DATEDIFF(DAY, HeaderSalonServices.TransactionDate, '2012/12/24') = 2; -- Find data that happened 2 day before 24-12-2020

--
-- 4. Display New Transaction Date (obtained by adding 5 days to TransactionDate), OldTransaction Date (obtained from TransactionDate), and CustomerName for every transaction which didn’t happen on day 20th.
--

SELECT      DATEADD(DAY, 5, HeaderSalonServices.TransactionDate) AS 'New Transaction ID', -- Add 5 day of TransactionDate
            HeaderSalonServices.TransactionDate AS 'Old Transaction ID', 
            MsCustomer.CustomerName
FROM        HeaderSalonServices
INNER JOIN  MsCustomer ON MsCustomer.CustomerId = HeaderSalonServices.CustomerId -- Join table MsCustomer
WHERE       DATEPART(DAY, HeaderSalonServices.TransactionDate) != 20; -- Find TransactioDate that occour on day 20th

--
-- 5. Display Day (obtained from the day transaction happened), CustomerName, and TreatmentName for every Customer who was handled by female staff that has position name begin with 'TOP' word. Then order the data based on CustomerName in ascending format.
--

SELECT      DATENAME(WEEKDAY, HeaderSalonServices.TransactionDate) AS 'Day', -- Select the Day of TransactionDate
            MsCustomer.CustomerName, 
            MsTreatment.TreatmentName
FROM        HeaderSalonServices
INNER JOIN  MsCustomer ON MsCustomer.CustomerId = HeaderSalonServices.CustomerId -- Join Table MsCustomer
INNER JOIN  DetailSalonServices ON DetailSalonServices.TransactionId = HeaderSalonServices.TransactionId -- Join table DetailSalonServices
INNER JOIN  MsTreatment ON MsTreatment.TreatmentId = DetailSalonServices.TreatmentId -- Join table MsTreatment
INNER JOIN  MsStaff ON MsStaff.StaffId = HeaderSalonServices.StaffId -- Join MsStaff
WHERE       MsStaff.StaffGender IN ('Female') -- Find the Selected data that has StaffGender Female
AND         MsStaff.StaffPosition LIKE '%top%' -- Find the Selected data that has StaffPosition has 'top' word inside it
ORDER BY    MsCustomer.CustomerName ASC; -- Sort the CustomerName by Ascending Format

--
-- 6. Display the first data of CustomerId, CustomerName, TransactionId, Total Treatment (obtained from the total number of treatment). Then sort the data based on Total Treatment in descending format.
--

SELECT      TOP 1 MsCustomer.CustomerId, 
            MsCustomer.CustomerName, 
            HeaderSalonServices.TransactionId, 
            COUNT(DetailSalonServices.TreatmentId) AS 'Total Treatment' -- Count All TreatmentID with Selected CustomerName
FROM        MsCustomer
INNER JOIN  HeaderSalonServices ON HeaderSalonServices.CustomerId = MsCustomer.CustomerId -- Join table HeaderSalonServices
INNER JOIN  DetailSalonServices ON DetailSalonServices.TransactionId = HeaderSalonServices.TransactionId -- Join table TransactionId
GROUP BY    MsCustomer.CustomerId, 
            MsCustomer.CustomerName, 
            HeaderSalonServices.TransactionId -- Group the Data
ORDER BY    'Total Treatment' DESC; -- Sort Total Treatment In Descending Format

--
-- 7. Display CustomerId, TransactionId, CustomerName, and Total Price (obtained from total amount of price) for every transaction with total price is higher than the average value of treatment price from every transaction. Then sort the data based on Total Price in descending format.
--

SELECT      MsCustomer.CustomerId, 
            HeaderSalonServices.TransactionId, 
            MsCustomer.CustomerName, 
            SUM(MsTreatment.Price) AS 'Total Price' -- Sum the Price
FROM        MsCustomer
INNER JOIN  HeaderSalonServices ON HeaderSalonServices.CustomerId = MsCustomer.CustomerId -- Join Table HeaderSalonServices
INNER JOIN  DetailSalonServices ON DetailSalonServices.TransactionId = HeaderSalonServices.TransactionId -- Join Table DetailSalonServices
INNER JOIN  MsTreatment ON MsTreatment.TreatmentId = DetailSalonServices.TreatmentId -- Join table MsTreatment
GROUP BY    MsCustomer.CustomerId, 
            HeaderSalonServices.TransactionId, 
            MsCustomer.CustomerName -- Group the data
HAVING      SUM(MsTreatment.Price) > (
                SELECT SUM(a.Result) FROM (
                    SELECT AVG(MsTreatment.Price) AS Result
                ) AS a
            ) -- The Sum of Treatment Price must more then Sum of Average of Treatment Price
ORDER BY    'Total Price' DESC; -- Sort Total Price by Descending format

-- Crosscheck the Subquery
/* SELECT AVG(a.Result) AS 'Avg of Sum' FROM (SELECT CAST(SUM(MsTreatment.Price) AS DECIMAL(12, 0)) AS Result FROM MsTreatment) AS a */

--
-- 8. Display Name (obtained by adding ‘Mr. ’ in front of StaffName), StaffPosition, and StaffSalary for every male staff. The combine it with Name (obtained by adding ‘Ms. ’ in front of StaffName), StaffPosition, and StaffSalary for every female staff. Then sort the data based on Name and StaffPosition in ascending format.
--

SELECT      'Mr. ' + StaffName AS 'StaffName', -- Add 'Mr.' Before StaffName
            StaffPosition,
            StaffSalary
FROM        MsStaff
WHERE       StaffGender IN ('Male') -- Find every StaffGender that is Male
UNION
SELECT      'Ms. ' + StaffName AS 'StaffName', -- Add 'Ms.' Before StaffName
            StaffPosition,
            StaffSalary
FROM        MsStaff
WHERE       StaffGender IN ('Female'); -- Find every StaffGender that is Female

--
-- 9. Display TreatmentName, Price (obtained by adding ‘Rp. ’ in front of Price), and Status as ‘Maximum Price’ for every Treatment which price is the highest treatment’s price. Then combine it with TreatmentName, Price (obtained by adding ‘Rp. ’ in front of Price), and Status as ‘Minimum Price’ for every Treatment which price is the lowest treatment’s price.
--

SELECT      TreatmentName, 
            Price, 
            'Minimum Price' AS 'Status'
FROM        MsTreatment
WHERE       Price = (
    SELECT MIN(Price) FROM MsTreatment
) -- Find Price that is Minimum Value at table
UNION
SELECT      TreatmentName, 
            Price, 
            'Maximum Price' AS 'Status'
FROM        MsTreatment
WHERE       Price = (
    SELECT MAX(Price) FROM MsTreatment
); -- Find Price that is Maximum Value at table

--
-- 10. Display Longest Name of Staff and Customer (obtained from CustomerName), Length of Name (obtained from length of customer’s name), Status as ‘Customer’ for every customer who has the longest name. Then combine it with Longest Name of Staff and Customer (obtained from StaffName), Length of Name (obtained from length of staff’s name), Status as ‘Staff’ for every staff who has the longest name
-- 

SELECT      CustomerName, 
            LEN(CustomerName) AS 'Length of Name', -- Length of CustomerName
            'Customer' AS 'Status'
FROM        MsCustomer
WHERE       LEN(CustomerName) = (
    SELECT  MAX(LEN(CustomerName)) FROM MsCustomer
) -- Find the Length of CustomerName that is Longest lenght
UNION
SELECT      StaffName, 
            LEN(StaffName) AS 'Length of Name', -- Length of StaffName
            'Staff' AS 'Status'
FROM        MsStaff
WHERE       LEN(StaffName) = (
    SELECT  MAX(LEN(StaffName)) FROM MsStaff
); -- Find the Length of CustomerName that is Longest lenght