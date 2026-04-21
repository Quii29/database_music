-- ============================================================
-- FILE SQL: DATA STORYTELLING - DIEU GI LAM NEN MOT NHAC SI LUNG DANH?
-- MSSQL Server
-- ============================================================

-- ============================================================
-- SECTION 1: TAO DATABASE
-- ============================================================
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'CaKhucNuocNgoai')
    DROP DATABASE CaKhucNuocNgoai;
GO

CREATE DATABASE CaKhucNuocNgoai;
GO

USE CaKhucNuocNgoai;
GO

-- ============================================================
-- SECTION 2: TAO BANG VA RANG BUOC
-- ============================================================

-- Bang Tacgia: luu thong tin nhac si / nha soan nhac goc
CREATE TABLE Tacgia (
    maTacgia    CHAR(4)      NOT NULL,
    tenTacgia   NVARCHAR(100) NOT NULL,
    Phai        NVARCHAR(3)  NOT NULL,  -- N'Nam' hoac N'Nữ'
    CONSTRAINT PK_Tacgia PRIMARY KEY (maTacgia)
);
GO

-- Bang Cakhuc: luu thong tin ca khuc
CREATE TABLE Cakhuc (
    maCakhuc        CHAR(5)       NOT NULL,
    tenCakhuc       NVARCHAR(200) NOT NULL,
    Theloai         NVARCHAR(50)  NOT NULL,
    maTacgia        CHAR(4)       NOT NULL,
    ThoigianSangtac INT           NOT NULL,
    CONSTRAINT PK_Cakhuc PRIMARY KEY (maCakhuc),
    CONSTRAINT FK_Cakhuc_Tacgia FOREIGN KEY (maTacgia) REFERENCES Tacgia(maTacgia)
);
GO

-- Bang LoiViet: luu ban dich tieng Viet cua ca khuc
-- DichBoi tham chieu den maTacgia (nguoi dich la nhac si Viet)
CREATE TABLE LoiViet (
    maCakhuc    CHAR(5)       NOT NULL,
    TualoiViet  NVARCHAR(200) NOT NULL,
    DichBoi     CHAR(4)       NOT NULL,  -- FK -> Tacgia.maTacgia (nguoi dich)
    ThoigianDich INT          NOT NULL,
    CONSTRAINT PK_LoiViet PRIMARY KEY (maCakhuc, TualoiViet),
    CONSTRAINT FK_LoiViet_Cakhuc  FOREIGN KEY (maCakhuc)   REFERENCES Cakhuc(maCakhuc),
    CONSTRAINT FK_LoiViet_DichBoi FOREIGN KEY (DichBoi)    REFERENCES Tacgia(maTacgia)
);
GO

-- Bang Trinhbay: luu thong tin ca si trinh bay ban dich
CREATE TABLE Trinhbay (
    maCakhuc    CHAR(5)       NOT NULL,
    TualoiViet  NVARCHAR(200) NOT NULL,
    tenCasi     NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_Trinhbay PRIMARY KEY (maCakhuc, TualoiViet, tenCasi),
    CONSTRAINT FK_Trinhbay_LoiViet FOREIGN KEY (maCakhuc, TualoiViet) REFERENCES LoiViet(maCakhuc, TualoiViet)
);
GO

-- ============================================================
-- SECTION 3: INSERT DU LIEU - BANG Tacgia
-- ============================================================
-- Ghi chu phan nhom:
--   TG01 Bob Dylan        -> Nhom Can man + Lung danh
--   TG02 Paul Simon       -> Nhom Can man
--   TG03 John Lennon      -> Nhom Tai nang + Lung danh
--   TG04 Paul McCartney   -> Nhom Tai nang + Lung danh
--   TG05 Edith Piaf       -> Nhom Chuyen mon (Pop/Chanson Phap) + Lung danh
--   TG06 Frank Sinatra    -> Nhom Chuyen mon (Jazz/Swing)
--   TG07 Jim Morrison     -> Nhom Chuyen mon (Rock)
--   TG08 Phạm Duy         -> Nhom Da tai + Lung danh (nguoi dich tieu bieu, cung la tac gia)
--   TG09 Trịnh Công Sơn   -> Nhom Da tai (nguoi dich + tac gia Viet)
--   TG10 Nguyễn Duy       -> Nhom Da tai
--   TG11 Kris Kristofferson -> Nhom Can man
--   TG12 Burt Bacharach   -> Nhom Tai nang
--   TG13 Joni Mitchell    -> Nhom Can man
--   TG14 Cat Stevens      -> Nhom Can man
--   TG15 Elvis Presley    -> Nhom Binh thuong
--   TG16 Neil Diamond     -> Nhom Binh thuong
--   TG17 James Taylor     -> Nhom Binh thuong
-- Lưu ý: TG08, TG09, TG10 vừa là người dịch lời (DichBoi) vừa là tác giả Việt trong bảng Tacgia

INSERT INTO Tacgia (maTacgia, tenTacgia, Phai) VALUES
('TG01', N'Bob Dylan',           N'Nam'),
('TG02', N'Paul Simon',          N'Nam'),
('TG03', N'John Lennon',         N'Nam'),
('TG04', N'Paul McCartney',      N'Nam'),
('TG05', N'Edith Piaf',          N'Nữ'),
('TG06', N'Frank Sinatra',       N'Nam'),
('TG07', N'Jim Morrison',        N'Nam'),
('TG08', N'Phạm Duy',            N'Nam'),
('TG09', N'Trịnh Công Sơn',      N'Nam'),
('TG10', N'Nguyễn Duy',          N'Nam'),
('TG11', N'Kris Kristofferson',  N'Nam'),
('TG12', N'Burt Bacharach',      N'Nam'),
('TG13', N'Joni Mitchell',       N'Nữ'),
('TG14', N'Cat Stevens',         N'Nam'),
('TG15', N'Elvis Presley',       N'Nam'),
('TG16', N'Neil Diamond',        N'Nam'),
('TG17', N'James Taylor',        N'Nam');
GO

-- ============================================================
-- SECTION 4: INSERT DU LIEU - BANG Cakhuc (100+ bai)
-- ============================================================
-- TG01 Bob Dylan: 12 bai (Nhom Can man)
INSERT INTO Cakhuc (maCakhuc, tenCakhuc, Theloai, maTacgia, ThoigianSangtac) VALUES
('CK001', N'Blowin in the Wind',        N'Folk',      'TG01', 1962),
('CK002', N'The Times They Are A-Changin', N'Folk',   'TG01', 1963),
('CK003', N'Mr Tambourine Man',         N'Folk',      'TG01', 1964),
('CK004', N'Like a Rolling Stone',      N'Rock',      'TG01', 1965),
('CK005', N'Knockin on Heavens Door',   N'Folk',      'TG01', 1973),
('CK006', N'Forever Young',             N'Folk',      'TG01', 1973),
('CK007', N'Hurricane',                 N'Folk',      'TG01', 1975),
('CK008', N'Tangled Up in Blue',        N'Folk',      'TG01', 1975),
('CK009', N'Shelter from the Storm',    N'Folk',      'TG01', 1975),
('CK010', N'Simple Twist of Fate',      N'Folk',      'TG01', 1975),
('CK011', N'Lay Lady Lay',              N'Country',   'TG01', 1969),
('CK012', N'Make You Feel My Love',     N'Pop',       'TG01', 1997);
GO

-- TG02 Paul Simon: 10 bai (Nhom Can man)
INSERT INTO Cakhuc (maCakhuc, tenCakhuc, Theloai, maTacgia, ThoigianSangtac) VALUES
('CK013', N'The Sound of Silence',      N'Folk',      'TG02', 1964),
('CK014', N'Mrs Robinson',              N'Pop',       'TG02', 1968),
('CK015', N'Bridge Over Troubled Water', N'Pop',      'TG02', 1970),
('CK016', N'El Condor Pasa',            N'Folk',      'TG02', 1970),
('CK017', N'Scarborough Fair',          N'Folk',      'TG02', 1966),
('CK018', N'The Boxer',                 N'Folk',      'TG02', 1969),
('CK019', N'Cecilia',                   N'Pop',       'TG02', 1970),
('CK020', N'America',                   N'Folk',      'TG02', 1968),
('CK021', N'Homeward Bound',            N'Folk',      'TG02', 1966),
('CK022', N'50 Ways to Leave Your Lover', N'Pop',     'TG02', 1975);
GO

-- TG03 John Lennon: 7 bai (Nhom Tai nang + Lung danh)
INSERT INTO Cakhuc (maCakhuc, tenCakhuc, Theloai, maTacgia, ThoigianSangtac) VALUES
('CK023', N'Imagine',                   N'Pop',       'TG03', 1971),
('CK024', N'Let It Be',                 N'Pop',       'TG03', 1970),
('CK025', N'Yesterday',                 N'Pop',       'TG03', 1965),
('CK026', N'Hey Jude',                  N'Pop',       'TG03', 1968),
('CK027', N'Come Together',             N'Rock',      'TG03', 1969),
('CK028', N'In My Life',                N'Pop',       'TG03', 1965),
('CK029', N'Love Me Do',                N'Pop',       'TG03', 1962);
GO

-- TG04 Paul McCartney: 6 bai (Nhom Tai nang + Lung danh)
INSERT INTO Cakhuc (maCakhuc, tenCakhuc, Theloai, maTacgia, ThoigianSangtac) VALUES
('CK030', N'And I Love Her',            N'Pop',       'TG04', 1964),
('CK031', N'Blackbird',                 N'Folk',      'TG04', 1968),
('CK032', N'The Long and Winding Road', N'Pop',       'TG04', 1970),
('CK033', N'Michelle',                  N'Pop',       'TG04', 1965),
('CK034', N'Eleanor Rigby',             N'Classical', 'TG04', 1966),
('CK035', N'Ob-La-Di Ob-La-Da',         N'Pop',       'TG04', 1968);
GO

-- TG05 Edith Piaf: 8 bai (Nhom Chuyen mon Chanson + Lung danh)
INSERT INTO Cakhuc (maCakhuc, tenCakhuc, Theloai, maTacgia, ThoigianSangtac) VALUES
('CK036', N'La Vie En Rose',            N'Pop',       'TG05', 1945),
('CK037', N'Non Je Ne Regrette Rien',   N'Pop',       'TG05', 1960),
('CK038', N'Hymne a LAmour',            N'Pop',       'TG05', 1950),
('CK039', N'Milord',                    N'Pop',       'TG05', 1959),
('CK040', N'La Foule',                  N'Pop',       'TG05', 1957),
('CK041', N'Padam Padam',               N'Pop',       'TG05', 1951),
('CK042', N'Mon Dieu',                  N'Pop',       'TG05', 1960),
('CK043', N'LAccordeoniste',            N'Pop',       'TG05', 1942);
GO

-- TG06 Frank Sinatra: 9 bai (Nhom Chuyen mon Jazz/Swing)
INSERT INTO Cakhuc (maCakhuc, tenCakhuc, Theloai, maTacgia, ThoigianSangtac) VALUES
('CK044', N'My Way',                    N'Jazz',      'TG06', 1969),
('CK045', N'Fly Me to the Moon',        N'Jazz',      'TG06', 1954),
('CK046', N'New York New York',         N'Jazz',      'TG06', 1980),
('CK047', N'Strangers in the Night',    N'Jazz',      'TG06', 1966),
('CK048', N'Summer Wind',               N'Jazz',      'TG06', 1966),
('CK049', N'The Lady Is a Tramp',       N'Jazz',      'TG06', 1960),
('CK050', N'Night and Day',             N'Jazz',      'TG06', 1932),
('CK051', N'Witchcraft',                N'Jazz',      'TG06', 1957),
('CK052', N'Thats Life',                N'RnB',       'TG06', 1966);
GO

-- TG07 Jim Morrison: 8 bai (Nhom Chuyen mon Rock)
INSERT INTO Cakhuc (maCakhuc, tenCakhuc, Theloai, maTacgia, ThoigianSangtac) VALUES
('CK053', N'Light My Fire',             N'Rock',      'TG07', 1967),
('CK054', N'Riders on the Storm',       N'Rock',      'TG07', 1971),
('CK055', N'People Are Strange',        N'Rock',      'TG07', 1967),
('CK056', N'Break On Through',          N'Rock',      'TG07', 1967),
('CK057', N'The End',                   N'Rock',      'TG07', 1967),
('CK058', N'Love Her Madly',            N'Rock',      'TG07', 1971),
('CK059', N'Roadhouse Blues',           N'Rock',      'TG07', 1970),
('CK060', N'Touch Me',                  N'Rock',      'TG07', 1969);
GO

-- TG08 Pham Duy: 10 bai (Nhom Da tai - 5 the loai + Lung danh)
INSERT INTO Cakhuc (maCakhuc, tenCakhuc, Theloai, maTacgia, ThoigianSangtac) VALUES
('CK061', N'Those Were the Days',       N'Folk',      'TG08', 1968),
('CK062', N'Donna Donna',               N'Folk',      'TG08', 1940),
('CK063', N'Edelweiss',                 N'Classical', 'TG08', 1959),
('CK064', N'What a Wonderful World',    N'Jazz',      'TG08', 1967),
('CK065', N'Stand By Me',               N'RnB',       'TG08', 1961),
('CK066', N'La Paloma',                 N'Classical', 'TG08', 1863),
('CK067', N'Sailing',                   N'Pop',       'TG08', 1975),
('CK068', N'Danny Boy',                 N'Folk',      'TG08', 1913),
('CK069', N'Greensleeves',              N'Classical', 'TG08', 1580),
('CK070', N'House of the Rising Sun',   N'Rock',      'TG08', 1964);
GO

-- TG09 Trinh Cong Son: 8 bai (Nhom Da tai - 4 the loai)
INSERT INTO Cakhuc (maCakhuc, tenCakhuc, Theloai, maTacgia, ThoigianSangtac) VALUES
('CK071', N'Plaisir dAmour',            N'Classical', 'TG09', 1784),
('CK072', N'Ave Maria',                 N'Classical', 'TG09', 1825),
('CK073', N'Besame Mucho',              N'Jazz',      'TG09', 1940),
('CK074', N'Historia de un Amor',       N'Pop',       'TG09', 1955),
('CK075', N'Quizas Quizas Quizas',      N'Jazz',      'TG09', 1947),
('CK076', N'Bossa Nova Baby',           N'RnB',       'TG09', 1963),
('CK077', N'The Girl from Ipanema',     N'Jazz',      'TG09', 1962),
('CK078', N'O Sole Mio',                N'Classical', 'TG09', 1898);
GO

-- TG10 Nguyen Duy: 8 bai (Nhom Da tai - 4 the loai)
INSERT INTO Cakhuc (maCakhuc, tenCakhuc, Theloai, maTacgia, ThoigianSangtac) VALUES
('CK079', N'Summertime',                N'Jazz',      'TG10', 1935),
('CK080', N'Moon River',                N'Jazz',      'TG10', 1961),
('CK081', N'Autumn Leaves',             N'Jazz',      'TG10', 1945),
('CK082', N'La Mer',                    N'Pop',       'TG10', 1945),
('CK083', N'Sous le Ciel de Paris',     N'Pop',       'TG10', 1951),
('CK084', N'Je Ne Sais Pas Pourquoi',   N'Pop',       'TG10', 1987),
('CK085', N'Blue Bayou',                N'Country',   'TG10', 1961),
('CK086', N'Country Roads',             N'Country',   'TG10', 1971);
GO

-- TG11 Kris Kristofferson: 9 bai (Nhom Can man)
INSERT INTO Cakhuc (maCakhuc, tenCakhuc, Theloai, maTacgia, ThoigianSangtac) VALUES
('CK087', N'Me and Bobby McGee',        N'Country',   'TG11', 1969),
('CK088', N'Help Me Make It Through the Night', N'Country', 'TG11', 1970),
('CK089', N'Sunday Mornin Comin Down',  N'Country',   'TG11', 1970),
('CK090', N'For the Good Times',        N'Country',   'TG11', 1968),
('CK091', N'Why Me Lord',               N'Country',   'TG11', 1973),
('CK092', N'Silver Tongued Devil',      N'Country',   'TG11', 1971),
('CK093', N'Loving Her Was Easier',     N'Country',   'TG11', 1971),
('CK094', N'The Pilgrim Chapter 33',    N'Country',   'TG11', 1971),
('CK095', N'Josie',                     N'Folk',      'TG11', 1974);
GO

-- TG12 Burt Bacharach: 6 bai (Nhom Tai nang)
INSERT INTO Cakhuc (maCakhuc, tenCakhuc, Theloai, maTacgia, ThoigianSangtac) VALUES
('CK096', N'What the World Needs Now Is Love', N'Pop', 'TG12', 1965),
('CK097', N'Walk On By',                N'RnB',       'TG12', 1964),
('CK098', N'Say a Little Prayer',       N'Pop',       'TG12', 1967),
('CK099', N'Close to You',              N'Pop',       'TG12', 1970),
('CK100', N'Do You Know the Way to San Jose', N'Pop', 'TG12', 1968),
('CK101', N'Raindrops Keep Fallin on My Head', N'Pop','TG12', 1969);
GO

-- TG13 Joni Mitchell: 8 bai (Nhom Can man)
INSERT INTO Cakhuc (maCakhuc, tenCakhuc, Theloai, maTacgia, ThoigianSangtac) VALUES
('CK102', N'Both Sides Now',            N'Folk',      'TG13', 1969),
('CK103', N'Big Yellow Taxi',           N'Folk',      'TG13', 1970),
('CK104', N'Woodstock',                 N'Folk',      'TG13', 1969),
('CK105', N'River',                     N'Folk',      'TG13', 1971),
('CK106', N'A Case of You',             N'Folk',      'TG13', 1971),
('CK107', N'Help Me',                   N'Pop',       'TG13', 1974),
('CK108', N'Free Man in Paris',         N'Pop',       'TG13', 1974),
('CK109', N'California',                N'Folk',      'TG13', 1971);
GO

-- TG14 Cat Stevens: 8 bai (Nhom Can man)
INSERT INTO Cakhuc (maCakhuc, tenCakhuc, Theloai, maTacgia, ThoigianSangtac) VALUES
('CK110', N'Wild World',                N'Folk',      'TG14', 1970),
('CK111', N'Father and Son',            N'Folk',      'TG14', 1970),
('CK112', N'Peace Train',               N'Folk',      'TG14', 1971),
('CK113', N'Morning Has Broken',        N'Folk',      'TG14', 1971),
('CK114', N'Tea for the Tillerman',     N'Folk',      'TG14', 1970),
('CK115', N'Moon Shadow',               N'Folk',      'TG14', 1971),
('CK116', N'Sitting',                   N'Folk',      'TG14', 1972),
('CK117', N'Sad Lisa',                  N'Classical', 'TG14', 1970);
GO

-- TG15 Elvis Presley: 3 bai (Nhom Binh thuong)
INSERT INTO Cakhuc (maCakhuc, tenCakhuc, Theloai, maTacgia, ThoigianSangtac) VALUES
('CK118', N'Love Me Tender',            N'Country',   'TG15', 1956),
('CK119', N'Are You Lonesome Tonight',  N'Pop',       'TG15', 1960),
('CK120', N'Suspicious Minds',          N'RnB',       'TG15', 1969);
GO

-- TG16 Neil Diamond: 3 bai (Nhom Binh thuong)
INSERT INTO Cakhuc (maCakhuc, tenCakhuc, Theloai, maTacgia, ThoigianSangtac) VALUES
('CK121', N'Sweet Caroline',            N'Pop',       'TG16', 1969),
('CK122', N'Cracklin Rosie',            N'Country',   'TG16', 1970),
('CK123', N'Song Sung Blue',            N'Pop',       'TG16', 1972);
GO

-- TG17 James Taylor: 3 bai (Nhom Binh thuong)
INSERT INTO Cakhuc (maCakhuc, tenCakhuc, Theloai, maTacgia, ThoigianSangtac) VALUES
('CK124', N'Fire and Rain',             N'Folk',      'TG17', 1970),
('CK125', N'Youve Got a Friend',        N'Pop',       'TG17', 1971),
('CK126', N'Country Road',              N'Folk',      'TG17', 1968);
GO

-- ============================================================
-- SECTION 5: INSERT DU LIEU - BANG LoiViet (60+ dong)
-- ============================================================
-- Nguoi dich tham chieu maTacgia: TG08 (Pham Duy), TG09 (Trinh Cong Son), TG10 (Nguyen Duy)
-- Cac bai de doi: >= 3 ban dich
-- CK001 Blowin in the Wind: 3 ban dich
INSERT INTO LoiViet (maCakhuc, TualoiViet, DichBoi, ThoigianDich) VALUES
('CK001', N'Gió Cuốn Bay',              'TG08', 1970),
('CK001', N'Gió Thổi Bay Đi',           'TG09', 1975),
('CK001', N'Câu Hỏi Gió Đưa',          'TG10', 1980);

-- CK013 Sound of Silence: 3 ban dich
INSERT INTO LoiViet (maCakhuc, TualoiViet, DichBoi, ThoigianDich) VALUES
('CK013', N'Âm Thanh Của Bóng Tối',    'TG08', 1968),
('CK013', N'Tiếng Vọng Trong Im Lặng', 'TG09', 1972),
('CK013', N'Bóng Im Lặng',              'TG10', 1985);

-- CK023 Imagine: 4 ban dich (bai de doi)
INSERT INTO LoiViet (maCakhuc, TualoiViet, DichBoi, ThoigianDich) VALUES
('CK023', N'Hãy Tưởng Tượng',          'TG08', 1972),
('CK023', N'Ước Mơ Hòa Bình',          'TG09', 1975),
('CK023', N'Thế Giới Không Biên Giới', 'TG10', 1980);

-- CK036 La Vie En Rose: 3 ban dich (bai de doi)
INSERT INTO LoiViet (maCakhuc, TualoiViet, DichBoi, ThoigianDich) VALUES
('CK036', N'Đời Màu Hồng',             'TG08', 1960),
('CK036', N'Cuộc Đời Tươi Hồng',       'TG09', 1970),
('CK036', N'Hoa Hồng Cuộc Đời',        'TG10', 1982);

-- CK044 My Way: 3 ban dich (bai de doi)
INSERT INTO LoiViet (maCakhuc, TualoiViet, DichBoi, ThoigianDich) VALUES
('CK044', N'Đường Ta Ta Cứ Đi',        'TG08', 1972),
('CK044', N'Con Đường Của Tôi',         'TG09', 1975),
('CK044', N'Theo Cách Của Mình',        'TG10', 1985);

-- CK061 Those Were the Days: 3 ban dich (bai de doi)
INSERT INTO LoiViet (maCakhuc, TualoiViet, DichBoi, ThoigianDich) VALUES
('CK061', N'Tình Ca Du Mục',            'TG08', 1970),
('CK061', N'Ngày Xưa Ơi',              'TG09', 1975),
('CK061', N'Những Ngày Đó',             'TG10', 1983);

-- CK024 Let It Be: 3 ban dich (bai de doi)
INSERT INTO LoiViet (maCakhuc, TualoiViet, DichBoi, ThoigianDich) VALUES
('CK024', N'Hãy Để Mặc',               'TG08', 1972),
('CK024', N'Buông Tay',                 'TG09', 1974),
('CK024', N'Cứ Để Yên Vậy',            'TG10', 1980);

-- CK025 Yesterday: 3 ban dich (bai de doi)
INSERT INTO LoiViet (maCakhuc, TualoiViet, DichBoi, ThoigianDich) VALUES
('CK025', N'Hôm Qua',                   'TG08', 1967),
('CK025', N'Ngày Hôm Qua',             'TG09', 1970),
('CK025', N'Ký Ức Ngày Qua',           'TG10', 1978);

-- CK064 What a Wonderful World: 3 ban dich (bai de doi)
INSERT INTO LoiViet (maCakhuc, TualoiViet, DichBoi, ThoigianDich) VALUES
('CK064', N'Thế Giới Kỳ Diệu',         'TG08', 1970),
('CK064', N'Thật Tuyệt Vời',           'TG09', 1973),
('CK064', N'Đời Thật Đẹp',             'TG10', 1982);

-- CK045 Fly Me to the Moon: 2 ban dich
INSERT INTO LoiViet (maCakhuc, TualoiViet, DichBoi, ThoigianDich) VALUES
('CK045', N'Đưa Tôi Lên Mặt Trăng',   'TG08', 1968),
('CK045', N'Bay Lên Cung Trăng',        'TG09', 1975);

-- CK062 Donna Donna: 2 ban dich
INSERT INTO LoiViet (maCakhuc, TualoiViet, DichBoi, ThoigianDich) VALUES
('CK062', N'Đôi Mắt Người Xưa',        'TG08', 1965),
('CK062', N'Donna Ơi',                  'TG09', 1972);

-- CK037 Non Je Ne Regrette Rien: 2 ban dich
INSERT INTO LoiViet (maCakhuc, TualoiViet, DichBoi, ThoigianDich) VALUES
('CK037', N'Tôi Không Hối Tiếc',       'TG08', 1965),
('CK037', N'Chẳng Hề Ân Hận',         'TG09', 1975);

-- CK015 Bridge Over Troubled Water: 2 ban dich
INSERT INTO LoiViet (maCakhuc, TualoiViet, DichBoi, ThoigianDich) VALUES
('CK015', N'Cầu Qua Sóng Gió',        'TG08', 1972),
('CK015', N'Nhịp Cầu Nước Mắt',       'TG09', 1978);

-- CK073 Besame Mucho: 2 ban dich
INSERT INTO LoiViet (maCakhuc, TualoiViet, DichBoi, ThoigianDich) VALUES
('CK073', N'Hôn Em Nhiều',              'TG08', 1960),
('CK073', N'Hãy Hôn Ta Nữa Đi',       'TG09', 1970);

-- CK079 Summertime: 2 ban dich
INSERT INTO LoiViet (maCakhuc, TualoiViet, DichBoi, ThoigianDich) VALUES
('CK079', N'Ngày Hè',                   'TG08', 1965),
('CK079', N'Mùa Hè',                    'TG10', 1975);

-- CK080 Moon River: 2 ban dich
INSERT INTO LoiViet (maCakhuc, TualoiViet, DichBoi, ThoigianDich) VALUES
('CK080', N'Dòng Sông Trăng',          'TG08', 1965),
('CK080', N'Ánh Trăng Trên Sông',      'TG09', 1972);

-- CK096 What the World Needs Now Is Love: 2 ban dich
INSERT INTO LoiViet (maCakhuc, TualoiViet, DichBoi, ThoigianDich) VALUES
('CK096', N'Thế Gian Cần Tình Yêu',   'TG08', 1968),
('CK096', N'Yêu Thương Cần Thiết',    'TG09', 1975);

-- CK065 Stand By Me: 2 ban dich
INSERT INTO LoiViet (maCakhuc, TualoiViet, DichBoi, ThoigianDich) VALUES
('CK065', N'Ở Bên Tôi',                'TG08', 1965),
('CK065', N'Sát Cánh Cùng Nhau',       'TG09', 1972);

-- Cac bai chi 1 ban dich (de dam bao du 60 dong)
INSERT INTO LoiViet (maCakhuc, TualoiViet, DichBoi, ThoigianDich) VALUES
('CK002', N'Thời Đại Đang Thay Đổi',  'TG08', 1970),
('CK003', N'Chàng Trai Ống Sậy',       'TG08', 1968),
('CK005', N'Gõ Cửa Thiên Đàng',        'TG09', 1975),
('CK006', N'Mãi Mãi Trẻ Trung',        'TG10', 1980),
('CK011', N'Em Hãy Nằm Xuống',         'TG08', 1972),
('CK017', N'Hội Chợ Scarborough',       'TG09', 1970),
('CK018', N'Người Võ Sĩ',              'TG10', 1975),
('CK026', N'Này Hey Jude',             'TG08', 1972),
('CK031', N'Chú Chim Hồng',            'TG09', 1975),
('CK038', N'Bài Ca Tình Yêu',          'TG08', 1965),
('CK039', N'Milord',                    'TG09', 1965),
('CK053', N'Thắp Lửa',                 'TG08', 1970),
('CK054', N'Kỵ Sĩ Bão Tố',            'TG09', 1975),
('CK063', N'Hoa Nhung Tuyết',          'TG08', 1965),
('CK070', N'Ngôi Nhà Mặt Trời Mọc',   'TG08', 1968),
('CK081', N'Lá Mùa Thu',               'TG10', 1975),
('CK086', N'Những Con Đường Làng',     'TG10', 1978),
('CK087', N'Tôi Và Bobby McGee',       'TG09', 1975),
('CK099', N'Gần Gũi Bên Em',           'TG08', 1975),
('CK102', N'Hai Chiều Suy Nghĩ',       'TG09', 1975),
('CK110', N'Thế Giới Hoang Dã',       'TG09', 1975),
('CK111', N'Cha Và Con',               'TG08', 1975);
GO

-- ============================================================
-- SECTION 6: INSERT DU LIEU - BANG Trinhbay (150+ dong)
-- ============================================================
-- --------- CK001 Blowin in the Wind (3 ban dich) ---------
INSERT INTO Trinhbay (maCakhuc, TualoiViet, tenCasi) VALUES
('CK001', N'Gió Cuốn Bay',             N'Khánh Ly'),
('CK001', N'Gió Cuốn Bay',             N'Tuấn Vũ'),
('CK001', N'Gió Cuốn Bay',             N'Hương Lan'),
('CK001', N'Gió Cuốn Bay',             N'Mỹ Tâm'),
('CK001', N'Gió Cuốn Bay',             N'Trọng Tấn'),
('CK001', N'Gió Cuốn Bay',             N'Ngọc Anh'),
('CK001', N'Gió Thổi Bay Đi',          N'Khánh Ly'),
('CK001', N'Gió Thổi Bay Đi',          N'Bảo Yến'),
('CK001', N'Câu Hỏi Gió Đưa',         N'Tuấn Ngọc'),
('CK001', N'Câu Hỏi Gió Đưa',         N'Ánh Tuyết');

-- --------- CK013 Sound of Silence (3 ban dich) ---------
INSERT INTO Trinhbay (maCakhuc, TualoiViet, tenCasi) VALUES
('CK013', N'Âm Thanh Của Bóng Tối',   N'Khánh Ly'),
('CK013', N'Âm Thanh Của Bóng Tối',   N'Tuấn Vũ'),
('CK013', N'Âm Thanh Của Bóng Tối',   N'Hương Lan'),
('CK013', N'Âm Thanh Của Bóng Tối',   N'Mỹ Tâm'),
('CK013', N'Âm Thanh Của Bóng Tối',   N'Ngọc Anh'),
('CK013', N'Âm Thanh Của Bóng Tối',   N'Ánh Tuyết'),
('CK013', N'Tiếng Vọng Trong Im Lặng',N'Bảo Yến'),
('CK013', N'Tiếng Vọng Trong Im Lặng',N'Trọng Tấn'),
('CK013', N'Bóng Im Lặng',             N'Tuấn Ngọc'),
('CK013', N'Bóng Im Lặng',             N'Cẩm Ly');

-- --------- CK023 Imagine (4 ban dich - bai de doi TG03) ---------
INSERT INTO Trinhbay (maCakhuc, TualoiViet, tenCasi) VALUES
('CK023', N'Hãy Tưởng Tượng',         N'Khánh Ly'),
('CK023', N'Hãy Tưởng Tượng',         N'Mỹ Tâm'),
('CK023', N'Hãy Tưởng Tượng',         N'Tuấn Vũ'),
('CK023', N'Hãy Tưởng Tượng',         N'Hương Lan'),
('CK023', N'Ước Mơ Hòa Bình',         N'Ngọc Anh'),
('CK023', N'Ước Mơ Hòa Bình',         N'Ánh Tuyết'),
('CK023', N'Ước Mơ Hòa Bình',         N'Bảo Yến'),
('CK023', N'Thế Giới Không Biên Giới',N'Trọng Tấn'),
('CK023', N'Thế Giới Không Biên Giới',N'Tuấn Ngọc'),
('CK023', N'Thế Giới Không Biên Giới',N'Cẩm Ly');

-- --------- CK024 Let It Be (3 ban dich - bai de doi TG03) ---------
INSERT INTO Trinhbay (maCakhuc, TualoiViet, tenCasi) VALUES
('CK024', N'Hãy Để Mặc',              N'Khánh Ly'),
('CK024', N'Hãy Để Mặc',              N'Mỹ Tâm'),
('CK024', N'Hãy Để Mặc',              N'Tuấn Vũ'),
('CK024', N'Hãy Để Mặc',              N'Hương Lan'),
('CK024', N'Buông Tay',                N'Ngọc Anh'),
('CK024', N'Buông Tay',                N'Ánh Tuyết'),
('CK024', N'Cứ Để Yên Vậy',           N'Bảo Yến'),
('CK024', N'Cứ Để Yên Vậy',           N'Trọng Tấn');

-- --------- CK025 Yesterday (3 ban dich - bai de doi TG03) ---------
INSERT INTO Trinhbay (maCakhuc, TualoiViet, tenCasi) VALUES
('CK025', N'Hôm Qua',                  N'Khánh Ly'),
('CK025', N'Hôm Qua',                  N'Tuấn Vũ'),
('CK025', N'Hôm Qua',                  N'Mỹ Tâm'),
('CK025', N'Hôm Qua',                  N'Hương Lan'),
('CK025', N'Hôm Qua',                  N'Ngọc Anh'),
('CK025', N'Ngày Hôm Qua',            N'Ánh Tuyết'),
('CK025', N'Ngày Hôm Qua',            N'Bảo Yến'),
('CK025', N'Ký Ức Ngày Qua',          N'Tuấn Ngọc');

-- --------- CK036 La Vie En Rose (3 ban dich - bai de doi TG05) ---------
INSERT INTO Trinhbay (maCakhuc, TualoiViet, tenCasi) VALUES
('CK036', N'Đời Màu Hồng',            N'Khánh Ly'),
('CK036', N'Đời Màu Hồng',            N'Mỹ Tâm'),
('CK036', N'Đời Màu Hồng',            N'Hương Lan'),
('CK036', N'Đời Màu Hồng',            N'Ánh Tuyết'),
('CK036', N'Đời Màu Hồng',            N'Ngọc Anh'),
('CK036', N'Cuộc Đời Tươi Hồng',      N'Bảo Yến'),
('CK036', N'Cuộc Đời Tươi Hồng',      N'Trọng Tấn'),
('CK036', N'Hoa Hồng Cuộc Đời',       N'Cẩm Ly');

-- --------- CK044 My Way (3 ban dich - bai de doi TG06) ---------
INSERT INTO Trinhbay (maCakhuc, TualoiViet, tenCasi) VALUES
('CK044', N'Đường Ta Ta Cứ Đi',       N'Tuấn Vũ'),
('CK044', N'Đường Ta Ta Cứ Đi',       N'Khánh Ly'),
('CK044', N'Đường Ta Ta Cứ Đi',       N'Mỹ Tâm'),
('CK044', N'Đường Ta Ta Cứ Đi',       N'Trọng Tấn'),
('CK044', N'Đường Ta Ta Cứ Đi',       N'Hương Lan'),
('CK044', N'Con Đường Của Tôi',        N'Tuấn Ngọc'),
('CK044', N'Con Đường Của Tôi',        N'Ngọc Anh'),
('CK044', N'Theo Cách Của Mình',       N'Bảo Yến');

-- --------- CK061 Those Were the Days (3 ban dich - bai de doi TG08) ---------
INSERT INTO Trinhbay (maCakhuc, TualoiViet, tenCasi) VALUES
('CK061', N'Tình Ca Du Mục',           N'Khánh Ly'),
('CK061', N'Tình Ca Du Mục',           N'Tuấn Vũ'),
('CK061', N'Tình Ca Du Mục',           N'Mỹ Tâm'),
('CK061', N'Tình Ca Du Mục',           N'Hương Lan'),
('CK061', N'Tình Ca Du Mục',           N'Ngọc Anh'),
('CK061', N'Ngày Xưa Ơi',             N'Ánh Tuyết'),
('CK061', N'Ngày Xưa Ơi',             N'Bảo Yến'),
('CK061', N'Những Ngày Đó',            N'Trọng Tấn'),
('CK061', N'Những Ngày Đó',            N'Tuấn Ngọc');

-- --------- CK064 What a Wonderful World (3 ban dich - bai de doi TG08) ---------
INSERT INTO Trinhbay (maCakhuc, TualoiViet, tenCasi) VALUES
('CK064', N'Thế Giới Kỳ Diệu',        N'Khánh Ly'),
('CK064', N'Thế Giới Kỳ Diệu',        N'Mỹ Tâm'),
('CK064', N'Thế Giới Kỳ Diệu',        N'Tuấn Vũ'),
('CK064', N'Thế Giới Kỳ Diệu',        N'Hương Lan'),
('CK064', N'Thế Giới Kỳ Diệu',        N'Ngọc Anh'),
('CK064', N'Thật Tuyệt Vời',          N'Ánh Tuyết'),
('CK064', N'Thật Tuyệt Vời',          N'Bảo Yến'),
('CK064', N'Đời Thật Đẹp',            N'Trọng Tấn');

-- --------- CK045 Fly Me to the Moon (2 ban dich) ---------
INSERT INTO Trinhbay (maCakhuc, TualoiViet, tenCasi) VALUES
('CK045', N'Đưa Tôi Lên Mặt Trăng',  N'Khánh Ly'),
('CK045', N'Đưa Tôi Lên Mặt Trăng',  N'Mỹ Tâm'),
('CK045', N'Đưa Tôi Lên Mặt Trăng',  N'Tuấn Vũ'),
('CK045', N'Đưa Tôi Lên Mặt Trăng',  N'Cẩm Ly'),
('CK045', N'Bay Lên Cung Trăng',       N'Hương Lan'),
('CK045', N'Bay Lên Cung Trăng',       N'Bảo Yến');

-- --------- CK062 Donna Donna (2 ban dich) ---------
INSERT INTO Trinhbay (maCakhuc, TualoiViet, tenCasi) VALUES
('CK062', N'Đôi Mắt Người Xưa',       N'Khánh Ly'),
('CK062', N'Đôi Mắt Người Xưa',       N'Mỹ Tâm'),
('CK062', N'Đôi Mắt Người Xưa',       N'Tuấn Vũ'),
('CK062', N'Đôi Mắt Người Xưa',       N'Hương Lan'),
('CK062', N'Đôi Mắt Người Xưa',       N'Ngọc Anh'),
('CK062', N'Donna Ơi',                  N'Ánh Tuyết'),
('CK062', N'Donna Ơi',                  N'Bảo Yến');

-- --------- CK037 Non Je Ne Regrette Rien (2 ban dich) ---------
INSERT INTO Trinhbay (maCakhuc, TualoiViet, tenCasi) VALUES
('CK037', N'Tôi Không Hối Tiếc',      N'Khánh Ly'),
('CK037', N'Tôi Không Hối Tiếc',      N'Mỹ Tâm'),
('CK037', N'Tôi Không Hối Tiếc',      N'Hương Lan'),
('CK037', N'Tôi Không Hối Tiếc',      N'Ngọc Anh'),
('CK037', N'Chẳng Hề Ân Hận',        N'Ánh Tuyết'),
('CK037', N'Chẳng Hề Ân Hận',        N'Trọng Tấn');

-- --------- CK015 Bridge Over Troubled Water (2 ban dich) ---------
INSERT INTO Trinhbay (maCakhuc, TualoiViet, tenCasi) VALUES
('CK015', N'Cầu Qua Sóng Gió',       N'Khánh Ly'),
('CK015', N'Cầu Qua Sóng Gió',       N'Tuấn Vũ'),
('CK015', N'Cầu Qua Sóng Gió',       N'Mỹ Tâm'),
('CK015', N'Nhịp Cầu Nước Mắt',      N'Hương Lan'),
('CK015', N'Nhịp Cầu Nước Mắt',      N'Bảo Yến');

-- --------- CK073 Besame Mucho (2 ban dich) ---------
INSERT INTO Trinhbay (maCakhuc, TualoiViet, tenCasi) VALUES
('CK073', N'Hôn Em Nhiều',             N'Khánh Ly'),
('CK073', N'Hôn Em Nhiều',             N'Mỹ Tâm'),
('CK073', N'Hôn Em Nhiều',             N'Tuấn Vũ'),
('CK073', N'Hãy Hôn Ta Nữa Đi',      N'Hương Lan'),
('CK073', N'Hãy Hôn Ta Nữa Đi',      N'Ánh Tuyết');

-- --------- CK079 Summertime (2 ban dich) ---------
INSERT INTO Trinhbay (maCakhuc, TualoiViet, tenCasi) VALUES
('CK079', N'Ngày Hè',                  N'Khánh Ly'),
('CK079', N'Ngày Hè',                  N'Tuấn Vũ'),
('CK079', N'Ngày Hè',                  N'Cẩm Ly'),
('CK079', N'Mùa Hè',                   N'Mỹ Tâm'),
('CK079', N'Mùa Hè',                   N'Bảo Yến');

-- --------- CK080 Moon River (2 ban dich) ---------
INSERT INTO Trinhbay (maCakhuc, TualoiViet, tenCasi) VALUES
('CK080', N'Dòng Sông Trăng',         N'Khánh Ly'),
('CK080', N'Dòng Sông Trăng',         N'Mỹ Tâm'),
('CK080', N'Dòng Sông Trăng',         N'Hương Lan'),
('CK080', N'Ánh Trăng Trên Sông',     N'Tuấn Vũ'),
('CK080', N'Ánh Trăng Trên Sông',     N'Ngọc Anh');

-- --------- CK096 What the World Needs Now Is Love (2 ban dich) ---------
INSERT INTO Trinhbay (maCakhuc, TualoiViet, tenCasi) VALUES
('CK096', N'Thế Gian Cần Tình Yêu',  N'Khánh Ly'),
('CK096', N'Thế Gian Cần Tình Yêu',  N'Mỹ Tâm'),
('CK096', N'Thế Gian Cần Tình Yêu',  N'Tuấn Vũ'),
('CK096', N'Yêu Thương Cần Thiết',   N'Hương Lan'),
('CK096', N'Yêu Thương Cần Thiết',   N'Bảo Yến');

-- --------- CK065 Stand By Me (2 ban dich) ---------
INSERT INTO Trinhbay (maCakhuc, TualoiViet, tenCasi) VALUES
('CK065', N'Ở Bên Tôi',               N'Khánh Ly'),
('CK065', N'Ở Bên Tôi',               N'Mỹ Tâm'),
('CK065', N'Ở Bên Tôi',               N'Tuấn Vũ'),
('CK065', N'Sát Cánh Cùng Nhau',      N'Hương Lan'),
('CK065', N'Sát Cánh Cùng Nhau',      N'Ngọc Anh');

-- --------- Cac bai 1 ban dich - trinh bay nhieu ca si ---------
INSERT INTO Trinhbay (maCakhuc, TualoiViet, tenCasi) VALUES
('CK002', N'Thời Đại Đang Thay Đổi',  N'Khánh Ly'),
('CK002', N'Thời Đại Đang Thay Đổi',  N'Tuấn Vũ'),
('CK002', N'Thời Đại Đang Thay Đổi',  N'Mỹ Tâm'),
('CK003', N'Chàng Trai Ống Sậy',       N'Khánh Ly'),
('CK003', N'Chàng Trai Ống Sậy',       N'Hương Lan'),
('CK005', N'Gõ Cửa Thiên Đàng',        N'Tuấn Vũ'),
('CK005', N'Gõ Cửa Thiên Đàng',        N'Mỹ Tâm'),
('CK005', N'Gõ Cửa Thiên Đàng',        N'Ngọc Anh'),
('CK006', N'Mãi Mãi Trẻ Trung',        N'Khánh Ly'),
('CK006', N'Mãi Mãi Trẻ Trung',        N'Tuấn Vũ'),
('CK017', N'Hội Chợ Scarborough',       N'Khánh Ly'),
('CK017', N'Hội Chợ Scarborough',       N'Mỹ Tâm'),
('CK018', N'Người Võ Sĩ',              N'Tuấn Vũ'),
('CK018', N'Người Võ Sĩ',              N'Hương Lan'),
('CK026', N'Này Hey Jude',             N'Khánh Ly'),
('CK026', N'Này Hey Jude',             N'Mỹ Tâm'),
('CK026', N'Này Hey Jude',             N'Tuấn Vũ'),
('CK031', N'Chú Chim Hồng',            N'Ánh Tuyết'),
('CK031', N'Chú Chim Hồng',            N'Bảo Yến'),
('CK038', N'Bài Ca Tình Yêu',          N'Khánh Ly'),
('CK038', N'Bài Ca Tình Yêu',          N'Mỹ Tâm'),
('CK038', N'Bài Ca Tình Yêu',          N'Hương Lan'),
('CK039', N'Milord',                    N'Khánh Ly'),
('CK039', N'Milord',                    N'Ngọc Anh'),
('CK053', N'Thắp Lửa',                 N'Tuấn Vũ'),
('CK053', N'Thắp Lửa',                 N'Mỹ Tâm'),
('CK054', N'Kỵ Sĩ Bão Tố',            N'Khánh Ly'),
('CK054', N'Kỵ Sĩ Bão Tố',            N'Hương Lan'),
('CK063', N'Hoa Nhung Tuyết',          N'Khánh Ly'),
('CK063', N'Hoa Nhung Tuyết',          N'Tuấn Vũ'),
('CK063', N'Hoa Nhung Tuyết',          N'Mỹ Tâm'),
('CK070', N'Ngôi Nhà Mặt Trời Mọc',   N'Khánh Ly'),
('CK070', N'Ngôi Nhà Mặt Trời Mọc',   N'Tuấn Vũ'),
('CK070', N'Ngôi Nhà Mặt Trời Mọc',   N'Hương Lan'),
('CK081', N'Lá Mùa Thu',               N'Khánh Ly'),
('CK081', N'Lá Mùa Thu',               N'Mỹ Tâm'),
('CK086', N'Những Con Đường Làng',     N'Tuấn Vũ'),
('CK086', N'Những Con Đường Làng',     N'Trọng Tấn'),
('CK087', N'Tôi Và Bobby McGee',       N'Tuấn Vũ'),
('CK087', N'Tôi Và Bobby McGee',       N'Cẩm Ly'),
('CK099', N'Gần Gũi Bên Em',           N'Khánh Ly'),
('CK099', N'Gần Gũi Bên Em',           N'Mỹ Tâm'),
('CK102', N'Hai Chiều Suy Nghĩ',       N'Ánh Tuyết'),
('CK102', N'Hai Chiều Suy Nghĩ',       N'Hương Lan'),
('CK110', N'Thế Giới Hoang Dã',       N'Tuấn Vũ'),
('CK110', N'Thế Giới Hoang Dã',       N'Mỹ Tâm'),
('CK111', N'Cha Và Con',               N'Khánh Ly'),
('CK111', N'Cha Và Con',               N'Tuấn Vũ');
GO
