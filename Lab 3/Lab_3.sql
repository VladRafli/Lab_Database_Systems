-- Lab Session 03 - SQL – Data Manipulation (1)
-- Code by Raf-Fly - https://github.com/VladRafli
-- Source Code can be downloaded at https://github.com/VladRafli/Lab_Database_Systems/tree/master/Lab%203

-- This thing is only Executed at Microsoft SQL Server Management Studio
-- MariaDB, MySQL user might have different query

-- In this Practicum, we reuse available Database from last Practicum
-- Database_Lab_2

USE Database_Lab_2;

-- 1. Insert all data to tables

--
-- MsStaff
-- 
INSERT INTO MsStaff
    (
    StaffId,
    StaffNames,
    StaffGender,
    StaffPhone,
    StaffAddress,
    StaffSalary,
    StaffPosition
    )
VALUES
    (
        'SF006',
        'Jeklin Harefa',
        'Female',
        '085265433322',
        'Kebon Jeruk Street no 140',
        3000000,
        'Stylist'
    ),
    (
        'SF007',
        'Lavinia',
        'Female',
        '085755500011',
        'Kebon Jeruk Street no 153',
        3000000,
        'Stylist'
    ),
    (
        'SF008',
        'Stephen Adrianto',
        'Male',
        '085564223311',
        'Mandala Street no 14',
        3000000,
        'Stylist'
    ),
    (
        'SF009',
        'Rico Wijaya',
        'Male',
        '085710252525',
        'Keluarga Street no 78',
        3000000,
        'Stylist'
    );
--
-- HeaderSalonServices
-- 

INSERT INTO HeaderSalonServices
    (
    TransactionId,
    CustomerId,
    StaffId,
    TransactionDate,
    PaymentType
    )
VALUES
    (
        'TR011',
        'CU001',
        'SF004',
        '2012/12/23',
        'Credit'
    ),
    (
        'TR012',
        'CU002',
        'SF006',
        '2012/12/24',
        'Credit'
    ),
    (
        'TR013',
        'CU003',
        'SF007',
        '2012/12/24',
        'Cash'
    ),
    (
        'TR014',
        'CU004',
        'SF005',
        '2012/12/25',
        'Debit'
    ),
    (
        'TR015',
        'CU005',
        'SF007',
        '2012/12/25',
        'Debit'
    ),
    (
        'TR016',
        'CU005',
        'SF005',
        '2012/12/26',
        'Credit'
    ),
    (
        'TR017',
        'CU002',
        'SF001',
        '2012/12/26',
        'Cash'
    ),
    (
        'TR018',
        'CU003',
        'SF002',
        '2012/12/26',
        'Credit'
    ),
    (
        'TR019',
        'CU005',
        'SF001',
        '2012/12/27',
        'Debit'
    );

--
-- DetailSalonServices
--

INSERT INTO DetailSalonServices (
    TransactionId,
    TreatmentId
)
VALUES
    (
        'TR010',
        'TM003'
    ),
    (
        'TR010',
        'TM005'
    ),
    (
        'TR010',
        'TM010'
    ),
    (
        'TR011',
        'TM015'
    ),
    (
        'TR011',
        'TM025'
    ),
    (
        'TR012',
        'TM009'
    ),
    (
        'TR013',
        'TM003'
    ),
    (
        'TR013',
        'TM006'
    ),
    (
        'TR013',
        'TM015'
    ),
    (
        'TR014',
        'TM016'
    ),
    (
        'TR015',
        'TM016'
    ),
    (
        'TR015',
        'TM006'
    ),
    (
        'TR016',
        'TM015'
    ),
    (
        'TR016',
        'TM003'
    ),
    (
        'TR016',
        'TM005'
    ),
    (
        'TR017',
        'TM003'
    ),
    (
        'TR018',
        'TM006'
    ),
    (
        'TR018',
        'TM005'
    ),
    (
        'TR018',
        'TM007'
    );

INSERT INTO MsCustomer (
    CustomerId,
    CustomerNames,
    CustomerGender,
    CustomerPhone,
    CustomerAddress
)
VALUES
    (
        'CU001',
        'Franky',
        'Male',
        '08566543338',
        'Daan Mogot Baru Street no 6'
    ),
    (
        'CU002',
        'Emalia Dewi',
        'Female',
        '085264782135',
        'Tanjung Duren Street no 185'
    ),
    (
        'CU003',
        'Elysia Chen',
        'Female',
        '085754206611',
        'Kebon Jeruk Street no 120'
    ),
    (
        'CU004',
        'Brando Kartawijaya',
        'Male',
        '081170225561',
        'Greenvile Street no 88'
    ),
    (
        'CU005',
        'Andy Putra',
        'Male',
        '087751321421',
        'Sunter Street no 42'
    );

-- 2. Insert following data from pdf

INSERT INTO HeaderSalonServices (
    TransactionId,
    CustomerId,
    StaffId,
    TransactionDate,
    PaymentType
)
VALUES
    (
        'TR019',
        'CU005',
        'SF004',
        DATEADD(day, 3, CAST(GETDATE() AS date)),
        'Credit'
    );

-- 3. Insert following data from pdf
INSERT INTO MsStaff (
    StaffId,
    StaffNames,
    StaffGender,
    StaffPhone,
    StaffAddress,
    StaffSalary,
    StaffPosition
)
VALUES
    (
        'SF011',
        'Effendy Lesmana',
        'Male',
        '085218587878',
        'Tanggerang City Street no 88',
        FLOOR(RAND() * (5000000 - 3000000 + 1) + 3000000),
        'Stylist'
    );

-- 4. Change CustomerPhone Value

-- 4.1 Moved to upper line

-- 4.2 Change '08' to '628'

UPDATE  MsCustomer
SET     CustomerPhone = REPLACE(CustomerPhone, '08%', '628')
WHERE   CustomerPhone LIKE '08%'

-- 5. Change StaffPosition into Top Stylist and Increase StaffSalary to 7000000 named 'Effendy Lesmana'

-- 5.1 Change StaffPosition
UPDATE  MsStaff
SET     StaffPosition = REPLACE(StaffPosition, 'Stylist', 'Top Stylist')
WHERE   StaffNames LIKE 'Effendy Lesmana';

-- 5.2 Change StaffSalary
UPDATE  MsStaff
SET     StaffSalary = StaffSalary + 7000000
WHERE   StaffNames LIKE 'Effendy Lesmana';

-- 6. Change CustomerName
UPDATE  MsCustomer
SET     CustomerNames = LEFT(CustomerNames,CHARINDEX(' ',CustomerNames))
FROM    MsCustomer JOIN HeaderSalonServices
ON      MsCustomer.CustomerId = HeaderSalonServices.CustomerId
WHERE   DATEPART (day,TransactionDate) = 24;

-- 7. Change CustomerName by adding 'Ms. ' whose id 
UPDATE  MsCustomer
SET     CustomerNames = CONCAT('Ms.',CustomerNames)
WHERE   CustomerId IN ('CU002','CU003');

-- 8. Change CustomerAddress
UPDATE  MsCustomer
SET     CustomerAddress = 'Daan Mogot Baru Street no. 23'
SELECT  TransactionId
FROM    HeaderSalonServices
WHERE   TransactionId IN ('TR010')
SELECT  DATENAME(WEEKDAY,'2012/12/23') AS Thursday;

-- 9. Delete every data on HeaderSalonServices in customer with no space

DELETE 
FROM    HeaderSalonServices
FROM    HeaderSalonServices JOIN MsCustomer 
ON      HeaderSalonServices.CustomerId  = MsCustomer.CustomerId
WHERE   CHARINDEX(' ', CustomerNames) = 0;

-- 10. Delete every data on MsTreatment with 'Treatment' string

DELETE
FROM    MsTreatment
WHERE   TreatmentName LIKE ('%Treatment%');

--
-- Check database
-- 
SELECT *
FROM MsCustomer

SELECT *
FROM MsStaff

SELECT *
FROM MsTreatment

SELECT *
FROM MsTreatmentType

SELECT *
FROM HeaderSalonServices

SELECT *
FROM DetailSalonServices
--
-- To check Table Info
--
SELECT  *
FROM    INFORMATION_SCHEMA.COLUMNS
WHERE   TABLE_NAME='TableName';
--
-- To check Primary Key
--
EXEC sp_pkeys 'MsCustomer'
--
-- To check Foreign Key
--
EXEC sp_fkeys 'HeaderSalonServices'
