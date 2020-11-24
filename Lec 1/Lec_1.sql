-- Lec Session Unknown - SQL - Topic not Specified
-- Code by Raf-Fly - https://github.com/VladRafli
-- Source Code can be downloaded at https://github.com/VladRafli/Lab_Database_Systems/tree/master/Lec%201

-- In Case there is mistake on process
-- Execute query below

-- USE master;
-- DROP DATABASE Lec_1;
-- CREATE DATABASE Lec_1;
-- USE Lec_1;

-- Use Database Master first before creating new Database

USE master;

-- Create New Database Called Lec_1

CREATE DATABASE Lec_1;

-- Use Database Lec_1 to work with

USE Lec_1;

-- Referencing from Database Schemes on First Page
-- Create Tables

-- "SPESIALISASI" Table
CREATE TABLE [SPESIALISASI] (
    Kode_Spesial CHAR(5) NOT NULL,
    Spesialis VARCHAR(25) NOT NULL,
    PRIMARY KEY (Kode_Spesial)
);

-- "DOKTER" Table
CREATE TABLE [DOKTER] (
    Id_Dokter CHAR(5) NOT NULL,
    Nama_Depan VARCHAR(15) NOT NULL,
    Nama_Belakang VARCHAR(15),
    Spesialis CHAR(5),
    Alamat VARCHAR(50) NOT NULL,
    No_Telepon VARCHAR(15),
    Tarif NUMERIC(10, 2),
    PRIMARY KEY (Id_Dokter),
    FOREIGN KEY (Spesialis) REFERENCES SPESIALISASI(Kode_Spesial) ON UPDATE CASCADE ON DELETE CASCADE
);

-- "PASIEN" Table
CREATE TABLE [PASIEN] (
    Id_Pasien CHAR(5) NOT NULL,
    Nama_Depan VARCHAR(15) NOT NULL,
    Nama_Belakang VARCHAR(15),
    Gender CHAR(1) NOT NULL,
    Alamat VARCHAR(50),
    No_Telepon VARCHAR(15),
    Umur INT,
    PRIMARY KEY (Id_Pasien)
);

-- "RESEP" Table
CREATE TABLE [RESEP] (
    Id_Resep CHAR(10) NOT NULL,
    Pasien_Id CHAR(5) NOT NULL,
    Dokter_Id CHAR(5) NOT NULL,
    Tanggal DATE NOT NULL,
    Harga NUMERIC(10, 2),
    PRIMARY KEY (Id_Resep),
    FOREIGN KEY (Pasien_Id) REFERENCES PASIEN(Id_Pasien) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Dokter_Id) REFERENCES DOKTER(Id_Dokter) ON UPDATE CASCADE ON DELETE CASCADE
);

-- "KATEGORI_OBAT" Table
CREATE TABLE [KATEGORI_OBAT] (
    Id_Kategori CHAR(5) NOT NULL,
    Kategori VARCHAR(20) NOT NULL,
    PRIMARY KEY (Id_Kategori)
);

-- "OBAT" Table
CREATE TABLE [OBAT] (
    Id_Obat CHAR(5) NOT NULL,
    Nama_Obat VARCHAR(25) NOT NULL,
    Harga_Satuan NUMERIC(10, 2) NOT NULL,
    Kategori CHAR(5),
    PRIMARY KEY (Id_Obat),
    FOREIGN KEY (Kategori) REFERENCES KATEGORI_OBAT(Id_Kategori) ON UPDATE CASCADE ON DELETE CASCADE
);

-- "DETAIL_OBAT" Table
CREATE TABLE [DETAIL_OBAT] (
    Id_Obat CHAR(5) NOT NULL,
    Id_Resep CHAR(10) NOT NULL,
    Jumlah INT NOT NULL,
    FOREIGN KEY (Id_Obat) REFERENCES OBAT(Id_Obat) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Id_Resep) REFERENCES RESEP(Id_Resep) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Show Table List on Database
SELECT * FROM INFORMATION_SCHEMA.TABLES

-- Show Table content on Database
SELECT TABLE_NAME, COLUMN_NAME, IS_NULLABLE, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS

-- Insert Data according list of data on third page
-- Insert Data on Tables

-- Insert into table "SPESIALISASI"
INSERT INTO [SPESIALISASI] 
    (Kode_Spesial, Spesialis)
VALUES
    ('SP001', 'Jantung' ),
    ('SP006', 'Bedah'   ),
    ('SP005', 'Saraf'   ),
    ('SP007', 'Mata'    ),
    ('SP008', 'Anak'    );

-- Insert into table "DOKTER"
INSERT INTO [DOKTER]
    (Id_Dokter, Nama_Depan, Nama_Belakang, Spesialis, Alamat, No_Telepon, Tarif)
VALUES
    ('DR001', 'Syaiful' , 'Anwar'   , 'SP001', 'Jakarta Pusat', '+6281111222', 150000),
    ('DR003', 'Edi'     , 'Harto'   , 'SP006', 'Bogor'        , '+6221211321', 200000),
    ('DR004', 'Andrea'  , 'Dian'    , 'SP008', 'Depok'        , '+6288899988', 100000),
    ('DR011', 'Dewi'    , NULL      , 'SP006', 'Bekasi'       , '+6212332111', 120000),
    ('DR009', 'Muhammad', 'Ridwan'  , 'SP001', 'Depok'        , '+625656565' , 120000),
    ('DR012', 'Agung'   , 'Pribadi' , 'SP005', 'Jakarta Pusat', '+624545111' , 180000),
    ('DR007', 'James'   , 'Bon'     , 'SP007', 'Bekasi'       , '+620000007' , 230000),
    ('DR010', 'Ida'     , 'Nurhaida', 'SP008', 'Bogor'        , '+621921211' , 70000 );

-- Insert into table "PASIEN"
INSERT INTO [PASIEN]
    (Id_Pasien, Nama_Depan, Nama_Belakang, Gender, Alamat, No_Telepon, Umur)
VALUES
    ('P0001', 'Ubet'  , NULL      , 'L', 'Bandung', '+6282222123', 21),
    ('P0003', 'Juju'  , 'Jubaidah', 'P', 'Cimahi' , NULL         , 70),
    ('P0002', 'Bon'   , 'Kurei'   , 'L', 'Bogor'  , NULL         , 45),
    ('P0005', 'Arya'  , 'Stak'    , 'P', 'Jakarta', '+628989898' , 6 ),
    ('P0008', 'Mario' , 'Bolateli', 'L', 'Depok'  , '+627117213' , 21),
    ('P0009', 'Jamal' , 'Widodo'  , 'L', 'Bekasi' , '+622167809' , 55),
    ('P0010', 'Kiara' , NULL      , 'P', 'Bogor'  , NULL         , 4 ),
    ('P0011', 'Bondan', 'Prakosa' , 'L', 'Jakarta', '+6200101011', 21),
    ('P0013', 'Gatot' , 'Kaca'    , 'L', 'Solo'   , NULL         , 45),
    ('P0014', 'Pipit' , NULL      , 'P', NULL     , '+6233333333', 23);

-- Insert into table "RESEP"
INSERT INTO [RESEP]
    (Id_Resep, Pasien_Id, Dokter_Id, Tanggal, Harga)
VALUES
    ('R250115001', 'P0001', 'DR011', CONVERT(DATE, '25/1/2015', 103), NULL),
    ('R250115002', 'P0009', 'DR001', CONVERT(DATE, '25/1/2015', 103), NULL),
    ('R260115001', 'P0008', 'DR007', CONVERT(DATE, '26/1/2015', 103), NULL),
    ('R270115001', 'P0014', 'DR003', CONVERT(DATE, '27/1/2015', 103), NULL),
    ('R300115001', 'P0010', 'DR010', CONVERT(DATE, '30/1/2015', 103), NULL),
    ('R300115002', 'P0013', 'DR003', CONVERT(DATE, '30/1/2015', 103), NULL),
    ('R010215001', 'P0009', 'DR001', CONVERT(DATE, '1/2/2015' , 103), NULL),
    ('R010215002', 'P0003', 'DR009', CONVERT(DATE, '1/2/2015' , 103), NULL),
    ('R010215003', 'P0010', 'DR010', CONVERT(DATE, '1/2/2015' , 103), NULL),
    ('R020215001', 'P0005', 'DR004', CONVERT(DATE, '2/2/2015' , 103), NULL),
    ('R020215002', 'P0009', 'DR001', CONVERT(DATE, '2/2/2015' , 103), NULL),
    ('R020215003', 'P0014', 'DR012', CONVERT(DATE, '2/2/2015' , 103), NULL),
    ('R030215001', 'P0005', 'DR004', CONVERT(DATE, '3/2/2015' , 103), NULL),
    ('R030215002', 'P0003', 'DR009', CONVERT(DATE, '3/2/2015' , 103), NULL);

-- Insert into table "KATEGORI_OBAT"
INSERT INTO [KATEGORI_OBAT]
    (Id_Kategori, Kategori)
VALUES
    ('OK001', 'Jantung' ),
    ('OK002', 'Saraf'   ),
    ('OK003', 'Infus'   ),
    ('OK004', 'Nutrisi' ),
    ('OK005', 'Mata'    );

-- Insert into table "OBAT"
INSERT INTO [OBAT]
    (Id_Obat, Nama_Obat, Harga_Satuan, Kategori)
VALUES
    ('OB001', 'Akrinor Tablet'          , 65000 , 'OK001'),
    ('OB002', 'Cardiject Vial'          , 7800  , 'OK001'),
    ('OB003', 'Fargoxin Injeksi'        , 21000 , 'OK001'),
    ('OB004', 'Kendaron Ampul'          , 20000 , 'OK001'),
    ('OB005', 'Tiaryt Tablet'           , 16000 , 'OK001'),
    ('OB006', 'Exelon Capsule 3 Mg'     , 70000 , 'OK002'),
    ('OB007', 'Fordesia Tablet'         , 79000 , 'OK002'),
    ('OB008', 'Reminily Tablet 4 Mg'    , 33000 , 'OK002'),
    ('OB009', 'Albucid Tetes Mata'      , 15000 , 'OK005'),
    ('OB010', 'Cendo Fenicol Salep Mata', 20000 , 'OK005'),
    ('OB011', 'Interflox Tetes Mata'    , 36000 , 'OK005'),
    ('OB012', 'Haemaccel Infus'         , 200000, 'OK003'),
    ('OB013', 'Human Albumin Infus'     , 900000, 'OK003'),
    ('OB014', 'Curfos Syrup'            , 74000 , 'OK004'),
    ('OB015', 'Vitacur Syrup'           , 36000 , 'OK004'),
    ('OB016', 'Cerebrovit Active'       , 133000, 'OK004');

-- Insert into table "DETAIL_OBAT"
INSERT INTO [DETAIL_OBAT]
    (Id_Obat, Id_Resep, Jumlah)
VALUES
    ('OB013', 'R250115001', 1),
    ('OB002', 'R250115002', 5),
    ('OB003', 'R250115002', 2),
    ('OB012', 'R270115001', 1),
    ('OB015', 'R300115001', 1),
    ('OB002', 'R010215001', 5),
    ('OB001', 'R010215002', 2),
    ('OB002', 'R010215002', 4),
    ('OB014', 'R010215003', 1),
    ('OB016', 'R020215001', 2),
    ('OB002', 'R020215002', 3),
    ('OB003', 'R020215002', 1),
    ('OB007', 'R020215003', 4),
    ('OB008', 'R020215003', 6),
    ('OB016', 'R030215001', 1),
    ('OB003', 'R030215002', 2),
    ('OB004', 'R030215002', 4);

-- Show all inserted data
SELECT * FROM SPESIALISASI
SELECT * FROM DOKTER
SELECT * FROM PASIEN
SELECT * FROM RESEP
SELECT * FROM KATEGORI_OBAT
SELECT * FROM OBAT
SELECT * FROM DETAIL_OBAT

-- Use this query if any wrong data inserted to tables
-- DELETE FROM SPESIALISASI
-- DELETE FROM DOKTER
-- DELETE FROM PASIEN
-- DELETE FROM RESEP
-- DELETE FROM KATEGORI_OBAT
-- DELETE FROM OBAT
-- DELETE FROM DETAIL_OBAT

-- Soal Basic Query from sixth page to end of file

-- 1. Buatlah query	untuk mengembalikan	data obat yang harga satuannya tidak lebih dari Rp 50.000,00. Tampilkan	nama obat, harga, dan nama kategorinya.

SELECT      OBAT.Nama_Obat AS "Nama Obat", 
            OBAT.Harga_Satuan AS "Harga Satuan", 
            KATEGORI_OBAT.Kategori AS "Kategori Obat"
FROM        OBAT
INNER JOIN  KATEGORI_OBAT ON KATEGORI_OBAT.Id_Kategori = OBAT.Kategori
WHERE       OBAT.Harga_Satuan <= 50000
ORDER BY    OBAT.Harga_Satuan DESC;

-- 2. Buatlah query	untuk mengembalikan	data pasien	yang nama depannya mengandung huruf 'o'. Tampilkan semua kolomnya kecuali nomor telepon.

SELECT      PASIEN.Id_Pasien AS "ID Pasien",
            (CASE
                WHEN PASIEN.Nama_Belakang IS NOT NULL
                    THEN
                        PASIEN.Nama_Depan + ' ' + PASIEN.Nama_Belakang
                WHEN PASIEN.Nama_Belakang IS NULL
                    THEN
                        PASIEN.Nama_Depan
            END) AS "Nama Pasien",
            PASIEN.Gender AS "Gender",
            PASIEN.Alamat AS "Alamat",
            PASIEN.Umur AS "Umur"
FROM        PASIEN
WHERE       (CASE
                WHEN PASIEN.Nama_Belakang IS NOT NULL
                    THEN
                        PASIEN.Nama_Depan + ' ' + PASIEN.Nama_Belakang
                WHEN PASIEN.Nama_Belakang IS NULL
                    THEN
                        PASIEN.Nama_Depan
            END) LIKE '%o%'

-- 3. Buatlah query	untuk mengembalikan data pasien yang berobat pada dokter spesialis jantung. Tampilkan data nama (nama lengkap), umur, dan	nama dokter yang menangani.

SELECT      DISTINCT (CASE
                WHEN PASIEN.Nama_Belakang IS NOT NULL
                    THEN
                        PASIEN.Nama_Depan + ' ' + PASIEN.Nama_Belakang
                WHEN PASIEN.Nama_Belakang IS NULL
                    THEN
                        PASIEN.Nama_Depan
            END) AS "Nama Pasien",
            PASIEN.Umur AS "Umur",
            (CASE
                WHEN DOKTER.Nama_Belakang IS NOT NULL
                    THEN
                        DOKTER.Nama_Depan + ' ' + DOKTER.Nama_Belakang
                WHEN DOKTER.Nama_Belakang IS NULL
                    THEN
                        DOKTER.Nama_Depan
            END) AS "Nama Dokter"
FROM        PASIEN
INNER JOIN  RESEP ON RESEP.Pasien_Id = PASIEN.Id_Pasien
INNER JOIN  DOKTER ON DOKTER.Id_Dokter = RESEP.Dokter_Id
INNER JOIN  SPESIALISASI ON SPESIALISASI.Kode_Spesial = DOKTER.Spesialis
WHERE       SPESIALISASI.Spesialis = 'Jantung'

-- 4. Buatlah query untuk menampilkan resep untuk obat 'Cardiject Vial'. Tampilkan nomor resep, dan tanggalnya.

SELECT      RESEP.Id_Resep AS "ID Resep",
            RESEP.Tanggal
FROM        RESEP
INNER JOIN  DETAIL_OBAT ON DETAIL_OBAT.Id_Resep = RESEP.Id_Resep
INNER JOIN  OBAT ON OBAT.Id_Obat = DETAIL_OBAT.Id_Obat
WHERE       OBAT.Nama_Obat = 'Cardiject Vial';

-- 5. Buatlah query untuk mengembalikan daftar nama obat yang dalam satu resep diminta dalam jumlah lebih dari 2. Tampilkan id obat dan	nama obatnya tanpa duplikasi.

SELECT      DISTINCT OBAT.Id_Obat AS "ID Obat",
            OBAT.Nama_Obat AS "Nama Obat"
FROM        RESEP
INNER JOIN  DETAIL_OBAT ON DETAIL_OBAT.Id_Resep = RESEP.Id_Resep
INNER JOIN  OBAT ON OBAT.Id_Obat = DETAIL_OBAT.Id_Obat
WHERE       DETAIL_OBAT.Jumlah > 2;