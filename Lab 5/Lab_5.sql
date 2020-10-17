-- Lab Session 05 - SQL – Data Manipulation (2)
-- Code by Raf-Fly - https://github.com/VladRafli
-- Source Code can be downloaded at https://github.com/VladRafli/Lab_Database_Systems/tree/master/Lab%205

-- This thing is only Executed at Microsoft SQL Server Management Studio
-- MariaDB, MySQL user might have different query

--
--  Create Database one
--

USE master

DROP DATABASE Lab_5

CREATE DATABASE Lab_5

USE Lab_5

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
    ('TM001','TT001','Cutting by Stylist','150000'),
	('TM002','TT001','Cutting by Top Stylist','450000'),
	('TM003','TT001','Cutting by Pony','50000'),
	('TM004','TT001','Blow','90000'),
	('TM005','TT001','Coloring','480000'),
	('TM006','TT001','Highlight','320000'),
	('TM007','TT001','Japanese Perm','700000'),
	('TM008','TT001','Digital Perm','1100000'),
	('TM009','TT001','Special Perm','1100000'),
	('TM010','TT001','Rebonding Treatment','110000'),
	('TM011','TT002','Creambath','1500000'),
	('TM012','TT002','Hair Spa','250000'),
	('TM013','TT002','Hair Mask','250000'),
	('TM014','TT002','Hand Spa Reflexy','200000'),
	('TM015','TT002','Reflexy','250000'),
	('TM016','TT002','Back Teraphy Massage','300000'),
	('TM017','TT003','Make Up','500000'),
	('TM018','TT003','Make Up Wedding','5000000'),
	('TM019','TT003','Facial','300000'),
	('TM020','TT004','Manicure','80000'),
	('TM021','TT004','Pedicure','100000'),
	('TM022','TT004','Nail Extension','250000'),
	('TM023','TT004','Nail Acrylic Infill','340000'),
	('TM024','TT005','Japanese Treatment','350000'),
	('TM025','TT005','Scalp Treatment','250000'),
	('TM026','TT005','Crystal Treatment','400000');

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
-- 1. Display Maximum Price (Max Price of all data), Minimum Price (Min Price of all data), Average Price (Round average value all data with 2 decimal format) from MsTreatment
--

SELECT  MAX(Price) AS 'Maximum Price', -- Ambil data paling besar di kolom Price
        MIN(Price) AS 'Minimum Price', -- Ambil data paling kecil di kolom Price
        CAST(ROUND(AVG(Price), 0) AS DECIMAL(12, 2)) AS 'Average Price' -- Cari rata rata dari data pada price, lalu di bulatkan dan diubah menjadi format desimal dengan 2 nol dibelakang koma
FROM    MsTreatment;

--
-- 2. Display StaffPosition, Gender (First Char), Average Salary (Concat with 'Rp.' and 2 Decimal Format)
--

SELECT      StaffPosition, 
            LEFT(StaffGender, 1) AS StaffGender, -- Ambil 1 Huruf dari kiri data StaffGender
            'Rp. ' + CAST(CAST(AVG(StaffSalary) AS DECIMAL(12, 2)) AS VARCHAR) AS StaffSalary -- Cetak 'Rp. ' ditambah dengan rata rata StaffSalary lalu dibuat format desimal dengan 2 nol dibelakang koma, setelah itu angka desimal tersebut diubah menjadi VARCHAR agar dapat digabungkan dengan kata 'Rp. '
FROM        MsStaff
GROUP BY    StaffPosition, StaffGender; -- Kelompokkkan data yang sama pada StaffPostion dan StaffGender

-- 
-- 3. Display TransactionDate (Format 'Mon dd, yyyy'), Total Transaction per Day (Total number of transaction per day) 
--

SELECT      CONVERT(VARCHAR, TransactionDate, 107) AS TransactionDate, -- Ubah bentuk data dari TransactionDate menjadi 'Mon dd, yyyy'
            COUNT(TransactionDate) AS 'Total Transaction per Day' -- Hitung jumlah data pada TransactionDate
FROM        HeaderSalonServices
GROUP BY    TransactionDate; -- Kelompokkan data yang sama pada TransactionDate

--
-- 4. Display CustomerGender (Uppercase), Total Transaction (Total number of Transaction)
--

SELECT      UPPER(cust.CustomerGender) AS CustomerGender,  -- Ubah CustomerGender menjadi Uppercase
            COUNT(cust.CustomerGender) AS 'Total Transaction' -- Hitung jumlah data pada CustomerGender
FROM        MsCustomer cust, HeaderSalonServices head
WHERE       cust.CustomerId = head.CustomerId
GROUP BY    cust.CustomerGender -- Kelompokkan data yang sama pada CustomerGender

--
-- 5. Display TreatmentTypeName, Total Transaction (Total number of Transaction). Sort data in descending format base on total transaction
--

SELECT      MsTreatmentType.TreatmentTypeName, COUNT(DetailSalonServices.TreatmentId) AS 'Total Transaction' --Hitung jumlah data pada TreatmentId
FROM        MsTreatmentType, MsTreatment, DetailSalonServices
WHERE       MsTreatmentType.TreatmentTypeId = MsTreatment.TreatmentTypeId
AND         MsTreatment.TreatmentId = DetailSalonServices.TreatmentId
GROUP BY    MsTreatmentType.TreatmentTypeName -- Kelompokkan data yang sama pada TreatmentTypeName
ORDER BY    'Total Transaction' DESC; -- Urutkan data 'Total Transaction' berdasarkan urutan Descending

--
-- 6. Display Date (TransactionDate with Format 'dd Mon yyyy'), Revenue per Day (Concat with 'Rp. ' with total price) for every date with Revenue is between 100000 and 5000000
--

SELECT      CONVERT(VARCHAR, HeaderSalonServices.TransactionDate, 113) AS 'Date',  -- Mengubah format dari data TransactionDate menjadi 'dd Mon yyyy'
            CONCAT('Rp. ', CAST(SUM(MsTreatment.Price) AS VARCHAR)) AS 'Revenue per Day' -- Hitung total Price lalu diubah menjadi tipe data VARCHAR lalu digabungkan dengan awalan 'Rp. '
FROM        HeaderSalonServices, DetailSalonServices, MsTreatment
WHERE       HeaderSalonServices.TransactionId = DetailSalonServices.TransactionId
AND         DetailSalonServices.TreatmentId = MsTreatment.TreatmentId
GROUP BY    TransactionDate -- Kelompokkan data yang sama pada TransactionDate
HAVING      SUM(MsTreatment.Price) BETWEEN 1000000 AND 5000000; -- Cari data yang jumlah total price pada data yang berjumlah diantara 1 jt dan 5 jt

--
-- 7. Display ID (Replace 'TT0' in TreatmentTypeID with 'Treatment Type'), TreatmentTypeName, and Total Treatment per Type (Total data with 'Treatment' string on it) and consist more than 5 treatments. Then sort data in descending format based on Total Treatment per Type
--

SELECT      REPLACE(MsTreatment.TreatmentTypeId, 'TT0', 'Treatment Type ') AS 'ID', -- Ganti string 'TT0' pada TreatmentTypeId menjadi 'Treatment Type'
            CONCAT(COUNT(MsTreatment.TreatmentTypeId), ' Treatment') AS 'Total Treatment per Type' -- Hitung jumlah TreatmentTypeId lalu tambahkan hasil tersebut dengan kata 'Treatment'
FROM        MsTreatment, MsTreatmentType
WHERE       MsTreatment.TreatmentTypeId = MsTreatmentType.TreatmentTypeId
GROUP BY    MsTreatment.TreatmentTypeId, MsTreatmentType.TreatmentTypeName -- Kelompokkkan data yang sama pada TreatmentTypeUd dan TreatmentTypeName
HAVING      COUNT(MsTreatment.TreatmentTypeId) > 5 -- Cari data yang total TreatmentTypeId nya lebih dari 5 data
ORDER BY    COUNT(MsTreatment.TreatmentTypeId) DESC; -- Urutkan data jumlah TreatmentTypeId berdasarkan urutan Descending

--
-- 8. Display StaffName (First Name), TransactionID, Total Treatment per Transaction (Total number of treatment)
--

SELECT      CASE
                CHARINDEX(' ', MsStaff.StaffName) WHEN 0 -- Jika tidak ada data StaffName yang mengandung spasi
                THEN -- Maka,
                    MsStaff.StaffName -- Tampilkan data seperti biasa
                ELSE -- Selain itu, jika ada data StaffName yang mengandung spasi, maka
                    LEFT(MsStaff.StaffName, CHARINDEX(' ', MsStaff.StaffName)) -- Ambil huruf dari kiri lalu kekanan sampai bertemu dengan spasi pada data
            END AS StaffName,
            HeaderSalonServices.TransactionId, 
            COUNT(HeaderSalonServices.TransactionId) AS 'Total Treatment per Transaction' -- Hitung total data TransactionId
FROM        MsStaff, HeaderSalonServices, DetailSalonServices
WHERE       HeaderSalonServices.StaffId = MsStaff.StaffId
AND         HeaderSalonServices.TransactionId = DetailSalonServices.TransactionId
GROUP BY    MsStaff.StaffName, HeaderSalonServices.TransactionId; -- Kelompokkan data yang sama pada StaffName dan TransactionId

--
-- 9. Display TransactionDate, CustomerName, TreatmentName, and Price for every transaction which happened on 'Thursday' and handled by staff named 'Ryan'. Order data on TransactionDate and CustomerName in Ascending format.
--

SELECT      HeaderSalonServices.TransactionDate, 
            MsCustomer.CustomerName, 
            MsTreatment.TreatmentName,
            MsTreatment.Price
FROM        MsCustomer, 
            MsStaff, 
            MsTreatment, 
            HeaderSalonServices,
            DetailSalonServices
WHERE       HeaderSalonServices.CustomerId = MsCustomer.CustomerId
AND         HeaderSalonServices.StaffId = MsStaff.StaffId
AND         HeaderSalonServices.TransactionId = DetailSalonServices.TransactionId
AND         DetailSalonServices.TreatmentId = MsTreatment.TreatmentId
AND         DATENAME(WEEKDAY, HeaderSalonServices.TransactionDate) = 'Tuesday' -- Cari data yang TransactionDate nya ada pada hari 'Tuesday'
AND         MsStaff.StaffName LIKE '%Ryan%' -- Cari data yang dilayani oleh staff yang bernama 'Ryan'
ORDER BY    HeaderSalonServices.TransactionDate, MsCustomer.CustomerName ASC; -- Urutkan data TransactionDate dan CustomerName berdasarkan format Ascending

--
-- 10. Display TransactionDate, CustomerName, and Total Price (Total all Treatment Price) for every transaction happened after 20th. Order data on TransactionDate in Ascending Format.
--

SELECT      HeaderSalonServices.TransactionDate, 
            MsCustomer.CustomerName,
            SUM(MsTreatment.Price) AS TotalPrice -- Hitung total jumlah Price pada kolom
FROM        MsCustomer, 
            MsTreatment, 
            HeaderSalonServices, 
            DetailSalonServices
WHERE       HeaderSalonServices.CustomerId = MsCustomer.CustomerId
AND         HeaderSalonServices.TransactionId = DetailSalonServices.TransactionId
AND         DetailSalonServices.TreatmentId = MsTreatment.TreatmentId
AND         DATENAME(DAY, HeaderSalonServices.TransactionDate) > 20 -- Cari data yang tanggalnya lebih dari tanggal 20
GROUP BY    HeaderSalonServices.TransactionDate, MsCustomer.CustomerName -- Kelompokkan data yang sama pada TransactionDate dan CustomerName
ORDER BY    HeaderSalonServices.TransactionDate ASC; -- Urutkan data TransactionDate berdasarkan format Ascending