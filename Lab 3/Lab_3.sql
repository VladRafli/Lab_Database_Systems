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
        'TR010',
        'CU001',
        'SF004',
        '2012/12/23',
        'Credit'
    ),
    (
        'TR011',
        'CU002',
        'SF006',
        '2012/12/24',
        'Credit'
    ),
    (
        'TR012',
        'CU003',
        'SF007',
        '2012/12/24',
        'Cash'
    ),
    (
        'TR013',
        'CU004',
        'SF005',
        '2012/12/25',
        'Debit'
    ),
    (
        'TR014',
        'CU005',
        'SF007',
        '2012/12/25',
        'Debit'
    ),
    (
        'TR015',
        'CU005',
        'SF005',
        '2012/12/26',
        'Credit'
    ),
    (
        'TR016',
        'CU002',
        'SF001',
        '2012/12/26',
        'Cash'
    ),
    (
        'TR017',
        'CU003',
        'SF002',
        '2012/12/26',
        'Credit'
    ),
    (
        'TR018',
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
        'SF010',
        'Effendy Lesmana',
        'Male',
        '085218587878',
        'Tanggerang City Street no 88',
        FLOOR(RAND() * (5000000 - 3000000 + 1) + 3000000),
        'Stylist'
    );

-- 4. Change CustomerPhone Value

-- 4.1 Insert Data to MsCustomer
INSERT INTO MsCustomer (
    CustomerId,
    CustomerName,
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
SET     CustomerName = LEFT(CustomerName, CHARINDEX(' ', CustomerName))
-- WHERE   HeaderSalonServices LIKE DATEPART(day, HeaderSalonServices.TransactionDate)

-- 7. Change CustomerName by adding 'Ms. ' whose id 


--
-- To check Table Info
--
SELECT  *
FROM    INFORMATION_SCHEMA.COLUMNS
WHERE   TABLE_NAME='MsStaff';
--
-- To check Primary Key
--
/* SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE OBJECTPROPERTY(OBJECT_ID(CONSTRAINT_SCHEMA + '.' + QUOTENAME(CONSTRAINT_NAME)), 'IsPrimaryKey') = 1
AND TABLE_NAME = 'TableName' AND TABLE_SCHEMA = 'Schema'; */
EXEC sp_pkeys 'MsCustomer'
--
-- To check Foreign Key
--
EXEC sp_fkeys 'HeaderSalonServices'
