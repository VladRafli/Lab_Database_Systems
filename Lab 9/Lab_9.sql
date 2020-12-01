-- Lab Session 09 - SQL – Advanced SQL
-- Code by Raf-Fly - https://github.com/VladRafli
-- Source Code can be downloaded at https://github.com/VladRafli/Lab_Database_Systems/tree/master/Lab%209

-- This thing is only Executed at Microsoft SQL Server Management Studio
-- MariaDB, MySQL user might have different query

-- Transact SQL is used here...

--
--  Create Database
--

USE master

DROP DATABASE Lab_9

CREATE DATABASE Lab_9

USE Lab_9

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

INSERT INTO MsCustomer (CustomerId, CustomerName, CustomerGender, CustomerPhone, CustomerAddress)
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

-- Check all data

SELECT * FROM MsCustomer;
SELECT * FROM MsStaff;
SELECT * FROM MsTreatment;
SELECT * FROM MsTreatmentType;
SELECT * FROM HeaderSalonServices;
SELECT * FROM DetailSalonServices;

GO;

-- 1. . Create a store procedure with named ‘sp1’ to display CustomerId, CustomerName, CustomerGender, and CustomerAddress for every Customer with Id based on user’s input.

CREATE PROCEDURE [sp1] @id CHAR(5)
AS
    BEGIN
        SELECT  CustomerId,
                CustomerName,
                CustomerGender,
                CustomerAddress
        FROM    MsCustomer
        WHERE   CustomerId = @id
    END;

EXEC sp1 'CU001';

GO;

-- 2. Create a store procedure with named ‘sp2’ that receives CustomerName as input from user with the following specification:
-- - If the length of CustomerName is odd then procedure will give output ‘Character Length of Mentor Name is an Odd Number’.
-- - If the length of CustomerName is even then procedure will display CustomerId, CustomerName, CustomerGender, TransactionId, and TransactionDate for every transaction with customer whose name contains the name that was inputted by user.

CREATE PROCEDURE [sp2] @name VARCHAR(50)
AS
    BEGIN
        IF LEN(@name) % 2 = 1
            BEGIN
                PRINT 'Character Length of Mentor Name is an Odd Number'
            END
        ELSE
            BEGIN
                SELECT  MsCustomer.CustomerId,
                        MsCustomer.CustomerName,
                        MsCustomer.CustomerGender,
                        HeaderSalonServices.TransactionId,
                        HeaderSalonServices.TransactionDate
                FROM    MsCustomer
                JOIN    HeaderSalonServices ON HeaderSalonServices.CustomerId = MsCustomer.CustomerId
                WHERE   MsCustomer.CustomerName LIKE '%' + @name + '%'
            END
    END;

EXEC sp2 'Elysia Chen';

EXEC sp2 'Fran';

GO;

-- 3. . Create a store procedure named ‘sp3’ to update StaffId, StaffName, StaffGender, and StaffPhone on MsStaff table based on StaffId, StaffName, StaffGender, and StaffPhone that was inputted by user.
--  Then display the updated data if the StaffId exists in MsStaff table. Otherwise show message ‘Staff does not exists’.

CREATE PROCEDURE [sp3] @id CHAR(5), @name VARCHAR(50), @gender VARCHAR(10), @phone VARCHAR(13)
AS
    BEGIN
        IF EXISTS(
            SELECT  StaffId
            FROM    MsStaff 
            WHERE   StaffId = @id
            AND     StaffName = @name
            AND     StaffGender = @gender
            AND     StaffPhone = @phone
            )
            BEGIN
                -- Update data
                UPDATE  MsStaff
                SET     StaffId = @id,
                        StaffName = @name,
                        StaffGender = @gender,
                        StaffPhone = @phone
                WHERE   StaffId = @id
                -- Check if data is updated
                SELECT  *
                FROM    MsStaff
                WHERE   StaffId = @id
            END
        ELSE
            BEGIN
                -- Data not exists
                PRINT 'Staff does not exists'
            END
        -- Check all data
        SELECT  *
        FROM    MsStaff
    END;

EXEC sp3 'SF005', 'Ryan Nixon', 'M', '08567756123'

EXEC sp3 'SF008', 'Ryan Nixon', 'M', '08567756123'

GO;

-- 4. Create trigger named ‘trig1’ for MsCustomer table to validate if there are any data which had been updated, it will display before and after updated data on MsCustomer table.

CREATE TRIGGER [trig1]
    ON MsCustomer
    FOR UPDATE
        AS
            BEGIN
                SELECT * FROM INSERTED
                UNION
                SELECT * FROM DELETED
            END

SELECT  *
FROM    MsCustomer

BEGIN TRANSACTION
    UPDATE  MsCustomer
    SET     CustomerName = 'Franky Quo'
    WHERE   CustomerId = 'CU001'
    SELECT * FROM MsCustomer
    ROLLBACK

GO;

-- 5. Create trigger with name ‘trig2’ for MsCustomer table to validate if there are any new inserted data, then the first data on MsCustomer will be deleted.

CREATE TRIGGER [trig2]
    ON MsCustomer
    AFTER UPDATE
        AS
            BEGIN
                DELETE  TOP(1)
                FROM    MsCustomer
            END

BEGIN TRANSACTION
    INSERT INTO MsCustomer 
    (
        CustomerId, 
        CustomerName, 
        CustomerGender, 
        CustomerPhone,
        CustomerAddress
    )
    VALUES (
        'CU006',
        'Yogie Soesanto',
        'Male',
        '085562133000',
        'Pelsakih Street no 52'
    )
    SELECT  *
    FROM    MsCustomer
    ROLLBACK

SELECT  *
FROM    MsCustomer

GO;

-- 6. Create trigger with name ‘trig3’ on MsCustomer table to validate if the data on MsCustomer table is deleted, then the deleted data will be insert into Removed table. If Removed table hasn’t been created, then create the Removed table and insert the deleted data to Removed table.

-- Not Done!

CREATE TRIGGER [trig3]
    ON MsCustomer
    FOR DELETE
        AS
            BEGIN
                IF OBJECT_ID('REMOVED') IS NOT NULL
                    BEGIN
                        INSERT INTO [REMOVED]
                        SELECT  *
                        FROM    MsCustomer
                    END
                ELSE
                    BEGIN
                        SELECT  * 
                        INTO    [REMOVED] 
                        FROM    MsCustomer
                    END
            END

BEGIN TRANSACTION
    DELETE FROM MsCustomer
    WHERE CustomerId = 'CU002'
    SELECT * FROM MsCustomer
    SELECT * FROM [REMOVED]
    ROLLBACK

DROP TRIGGER [trig3]

GO

-- 7. Create cursor with name ‘cur1’ to validate whether the length of StaffName is odd or even then show the message about result.

DECLARE @name VARCHAR(50)

DECLARE [cur1] CURSOR
    FOR 
        SELECT  StaffName 
        FROM    MsStaff

OPEN [cur1]
FETCH NEXT FROM [cur1] INTO @name

IF @@FETCH_STATUS <> 0
    PRINT 'Cursor Fetch Failed!'

WHILE @@FETCH_STATUS = 0
    BEGIN
        IF LEN(@name) % 2 = 0
            BEGIN
                PRINT 'The length from StaffName ' + @name + ' is an odd number'
            END
        ELSE
            BEGIN
                PRINT 'The length from StaffName ' + @name + ' is an even number'
            END
        FETCH NEXT FROM [cur1] INTO @name
    END

CLOSE [cur1]
DEALLOCATE [cur1]

GO

-- 8. Create procedure named ‘sp4’ that receive StaffName from user’s input to display StaffName and StaffPosition for every staff which name contains the word that has been inputted by user.

CREATE PROCEDURE [sp4] @search VARCHAR(50)
    AS
        BEGIN
            DECLARE [cur2] CURSOR
                FOR
                    SELECT  StaffName, 
                            StaffPosition
                    FROM    MsStaff
                    WHERE   StaffName LIKE '%' + @search + '%'
            
            DECLARE 
                @name VARCHAR(50),
                @position VARCHAR(20)
            
            OPEN [cur2]
            
            FETCH NEXT FROM [cur2] INTO @name, @position

            IF @@FETCH_STATUS <> 0
                PRINT 'Cursor Fetch Failed!'

            WHILE @@FETCH_STATUS = 0
                BEGIN
                    PRINT 'StaffName : ' + @name + ' : ' + @position
                    FETCH NEXT FROM [cur2] INTO @name, @position
                END
            
            CLOSE [cur2]
            DEALLOCATE [cur2]
        END

EXEC [sp4] 'a'

DROP PROCEDURE sp4

GO

-- 9. Create procedure with name ‘sp5’ that receive CustomerId from user’s input to display CustomerName, and TransactionDate for every customer which Id has been inputted by user and did treatment which ID is an even number.

CREATE PROCEDURE [sp5] @id CHAR(5)
    AS
        BEGIN
            DECLARE [cur3] CURSOR
                FOR
                    SELECT  MsCustomer.CustomerName,
                            HeaderSalonServices.TransactionDate
                    FROM    MsCustomer
                    JOIN    HeaderSalonServices
                    ON      MsCustomer.CustomerId = HeaderSalonServices.CustomerId
                    WHERE   MsCustomer.CustomerId IN (@id)
                
            DECLARE
                @nama VARCHAR(50),
                @date DATE
            
            OPEN [cur3]

            FETCH NEXT FROM [cur3] INTO @nama, @date

            IF @@FETCH_STATUS <> 0
                PRINT 'Cursor Fetch Failed!'

            WHILE @@FETCH_STATUS = 0
                BEGIN
                    PRINT 'Customer Name : ' + @nama + ' Transaction Date is ' + CAST(@date AS VARCHAR)
                    FETCH NEXT FROM [cur3] INTO @nama, @date
                END

            CLOSE [cur3]
            DEALLOCATE [cur3]
        END

EXEC [sp5] 'CU001'

GO

-- 10. Delete all procedure and trigger that has been made.

DROP PROCEDURE [sp1], [sp2], [sp3], [sp4], [sp5]
DROP TRIGGER [trig1], [trig2], [trig3]