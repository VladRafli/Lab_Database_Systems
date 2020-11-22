-- Lab Session 08 - SQL – Data Definition (2)
-- Code by Raf-Fly - https://github.com/VladRafli
-- Source Code can be downloaded at https://github.com/VladRafli/Lab_Database_Systems/tree/master/Lab%208

-- This thing is only Executed at Microsoft SQL Server Management Studio
-- MariaDB, MySQL user might have different query

--
--  Create Database
--

USE master

DROP DATABASE Lab_8

CREATE DATABASE Lab_8

USE Lab_8

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

SELECT  TABLE_NAME, COLUMN_NAME, IS_NULLABLE, DATA_TYPE
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
    ('TR018', 'CU003', 'SF002', '2012/12/27', 'Debit'),
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

GO;

-- 1. Create a view named ‘ViewBonus’ to display BinusId (obtained from CustomerID by replacing the first 2 characters with ‘BN ’), and CustomerName for every customer whose name is more than 10 characters.

CREATE VIEW ViewBonus AS
    SELECT  REPLACE(CustomerId, 'CU', 'BN') AS "BinusID", CustomerName
    FROM    MsCustomer
    WHERE   LEN(CustomerName) > 10;

GO;

SELECT * FROM ViewBonus;

GO;

-- 2. Create a view named ‘ViewCustomerData’ to display Name (obtained from customer’s name from the first character until a character before space), Address (obtained from CustomerAddress), and Phone (obtained from CustomerPhone) for every customer whose name contains space. 

CREATE VIEW ViewCustomerData AS
    SELECT  LEFT(CustomerName, CHARINDEX(' ', CustomerName)) AS "Name", 
            CustomerAddress AS "Address", 
            CustomerPhone AS "Phone"
    FROM    MsCustomer
    WHERE   LEN(CustomerName) - LEN(REPLACE(CustomerName, ' ', '')) > 0;

GO;

SELECT * FROM ViewCustomerData;

GO;

-- 3. Create a view named ‘ViewTreatment’ to display TreatmentName, TreatmentTypeName, Price (obtained from Price by adding ‘Rp. ’ in front of Price) for every treatment which type is ‘Hair Treatment’ and price is between 450000 and 800000. 

CREATE VIEW ViewTreatment AS
    SELECT  MsTreatment.TreatmentName, 
            MsTreatmentType.TreatmentTypeName,
            'Rp.' + CAST(MsTreatment.Price AS VARCHAR) AS "Price"
    FROM    MsTreatment, MsTreatmentType
    WHERE   MsTreatmentType.TreatmentTypeId = MsTreatment.TreatmentTypeId
    AND     MsTreatmentType.TreatmentTypeName = 'Hair Treatment'
    AND     MsTreatment.Price BETWEEN 450000 AND 800000;

GO;

SELECT * FROM ViewTreatment;

GO;

-- 4. Create a view named ‘ViewTransaction’ to display StaffName, CustomerName, TransactionDate (obtained from TransactionDate in ‘dd mon yyyy’ format), and PaymentType for every transaction which the transaction is between 21st and 25th day and was paid by ‘Credit’. 

CREATE VIEW ViewTreatment AS
    SELECT  MsStaff.StaffName, 
            MsCustomer.CustomerName,
            CONVERT(DATE, HeaderSalonServices.TransactionDate, 106) AS "TransactionDate"
    FROM    MsStaff, MsCustomer, HeaderSalonServices
    WHERE   MsCustomer.CustomerId = HeaderSalonServices.CustomerId
    AND     MsStaff.StaffId = HeaderSalonServices.StaffId
    AND     DAY(HeaderSalonServices.TransactionDate) BETWEEN 21 AND 25
    AND     HeaderSalonServices.PaymentType = 'Credit';

GO;

SELECT * FROM ViewTreatment;

GO;

-- 5. Create a view named ‘ViewBonusCustomer’ to display BonusId (obtained from CustomerId by replacing ‘CU’ with ‘BN’), Name (Obtained from CustomerName by taking the next character after space until the last character in lower case format), Day (obtained from the day when the transaction happened), and TransactionDate (obtained from TransactionDate in ‘mm/dd/yy’ format) for every transaction which customer’s name contains space and staff’s last name contains ‘a’ character.

CREATE VIEW ViewBonusCustomer AS
    SELECT  REPLACE(MsCustomer.CustomerId, 'CU', 'BN') AS "BonusID",
            LOWER(
                SUBSTRING(
                    MsCustomer.CustomerName, 
                    CHARINDEX(' ', MsCustomer.CustomerName) + 1, 
                    LEN(MsCustomer.CustomerName)
                    )
                ) AS "Name",
            DATENAME(WEEKDAY, HeaderSalonServices.TransactionDate) AS "Day",
            CONVERT(DATE, HeaderSalonServices.TransactionDate, 101) AS "TransactionDate"
    FROM    MsCustomer, HeaderSalonServices
    WHERE   MsCustomer.CustomerId = HeaderSalonServices.CustomerId
    AND     LEN(MsCustomer.CustomerName) - LEN(REPLACE(MsCustomer.CustomerName, ' ', '')) > 0
    AND     MsCustomer.CustomerName LIKE '%a';

GO;

SELECT * FROM ViewBonusCustomer;

GO;

-- 6. Create a view named ‘ViewTransactionByLivia’ to display TransactionId, Date (obtained from TransactionDate in ‘Mon dd, yyyy’ format), and TreatmentName for every transaction which occurred on the 21st day and handled by staff whose name is ‘Livia Ashianti’. 

-- The selected data is unavailable, so I inserted it myself
INSERT INTO DetailSalonServices (TransactionId, TreatmentId)
VALUES ('TR005', 'TM016');

GO;

CREATE VIEW ViewTransactionByLivia AS
    SELECT  HeaderSalonServices.TransactionId,
            CONVERT(DATE, HeaderSalonServices.TransactionDate, 107) AS "Date",
            MsTreatment.TreatmentName
    FROM    MsStaff, 
            MsTreatment, 
            HeaderSalonServices, 
            DetailSalonServices
    WHERE   MsStaff.StaffId = HeaderSalonServices.StaffId
    AND     MsTreatment.TreatmentId = DetailSalonServices.TreatmentId
    AND     DetailSalonServices.TransactionId = HeaderSalonServices.TransactionId
    AND     DAY(HeaderSalonServices.TransactionDate) = 21
    AND     MsStaff.StaffName LIKE 'Livia Ashianti';

GO;

SELECT * FROM ViewTransactionByLivia;

GO;

-- 7. Change the view named ‘ViewCustomerData’ to ID (obtained from the last 3 digit characters of (CustomerID), Name (obtained from CustomerName), Address (obtained from CustomerAddress), and Phone (obtained from CustomerPhone) for every customer whose name contains space.

ALTER VIEW ViewCustomerData AS
    SELECT  RIGHT(CustomerId, CHARINDEX('U', CustomerId) + 1) AS "ID",
            CustomerName AS "Name",
            CustomerAddress AS "Address",
            CustomerPhone AS "Phone"
    FROM    MsCustomer
    WHERE   CHARINDEX(' ', CustomerName) > 0;

GO;

SELECT * FROM ViewCustomerData;

GO;

-- 8. Create a view named ‘ViewCustomer’ to display CustomerId, CustomerName, CustomerGender from MsCustomer, then add the data to ViewCustomer with the following specifications:
/*  ------------------------------------------------- 
    | CustomerID    | CustomerName  | CustomerGender|
    -------------------------------------------------
    | CU006         | Cristian      | Male          |
    -------------------------------------------------
*/

/* Masih Gagal! */

CREATE VIEW ViewCustomer AS
    SELECT  *
    FROM    MsCustomer;

GO;

INSERT INTO ViewCustomer (CustomerId, CustomerName, CustomerGender)
VALUES ('CU006', 'Cristian', 'Male');

GO;

-- Untuk Perbandingan
SELECT * FROM MsCustomer;

SELECT * FROM ViewCustomer;

DROP VIEW ViewCustomer;

DELETE FROM MsCustomer
WHERE   CustomerId = 'CU006'

GO;

-- 9. Delete data in view ‘ViewCustomerData’ that has ID ‘005’. Then display all data from ViewCustomerData.

SELECT * FROM ViewCustomerData;

GO;

DELETE FROM ViewCustomerData
    WHERE ID = '005';

GO;

SELECT * FROM ViewCustomerData;

GO;

-- 10. Delete the view named ‘ViewCustomerData’.

DROP VIEW ViewCustomerData;

GO;