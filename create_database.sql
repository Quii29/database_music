IF DB_ID(N'KhoCaKhuc') IS NULL
    CREATE DATABASE KhoCaKhuc;
GO

USE AmNhac;
GO

-- Xóa bảng nếu đã tồn tại (chạy theo thứ tự FK)
IF OBJECT_ID(N'dbo.Trinhbay', N'U') IS NOT NULL DROP TABLE dbo.Trinhbay;
IF OBJECT_ID(N'dbo.LoiViet',  N'U') IS NOT NULL DROP TABLE dbo.LoiViet;
IF OBJECT_ID(N'dbo.Cakhuc',   N'U') IS NOT NULL DROP TABLE dbo.Cakhuc;
IF OBJECT_ID(N'dbo.Tacgia',   N'U') IS NOT NULL DROP TABLE dbo.Tacgia;
GO

-- ============================================================
-- Bảng Tacgia
-- ============================================================
CREATE TABLE dbo.Tacgia (
    maTacgia    INT            NOT NULL,
    tenTacgia   NVARCHAR(100)  NOT NULL,
    Phai        NVARCHAR(3)    NOT NULL
        CONSTRAINT chk_Phai CHECK (Phai IN (N'Nam', N'Nữ')),
    CONSTRAINT pk_Tacgia PRIMARY KEY (maTacgia)
);
GO

-- ============================================================
-- Bảng Cakhuc
-- ============================================================
CREATE TABLE dbo.Cakhuc (
    maCakhuc        INT            NOT NULL,
    tenCakhuc       NVARCHAR(200)  NOT NULL,
    Theloai         NVARCHAR(50)   NOT NULL,
    maTacgia        INT            NOT NULL,
    ThoigianSangtac INT            NOT NULL,  -- năm sáng tác
    CONSTRAINT pk_Cakhuc    PRIMARY KEY (maCakhuc),
    CONSTRAINT fk_Cakhuc_Tg FOREIGN KEY (maTacgia) REFERENCES dbo.Tacgia(maTacgia)
);
GO

-- ============================================================
-- Bảng LoiViet
-- ============================================================
CREATE TABLE dbo.LoiViet (
    maCakhuc      INT            NOT NULL,
    TualoiViet    NVARCHAR(200)  NOT NULL,  -- tên/mã bản lời Việt
    Dichboi       NVARCHAR(100)  NOT NULL,
    ThoigianDich  INT            NOT NULL,  -- năm dịch
    CONSTRAINT pk_LoiViet    PRIMARY KEY (maCakhuc, TualoiViet),
    CONSTRAINT fk_LoiViet_Ck FOREIGN KEY (maCakhuc) REFERENCES dbo.Cakhuc(maCakhuc)
);
GO

-- ============================================================
-- Bảng Trinhbay
-- ============================================================
CREATE TABLE dbo.Trinhbay (
    maCakhuc    INT            NOT NULL,
    TualoiViet  NVARCHAR(200)  NOT NULL,
    tenCasi     NVARCHAR(100)  NOT NULL,
    CONSTRAINT pk_Trinhbay    PRIMARY KEY (maCakhuc, TualoiViet, tenCasi),
    CONSTRAINT fk_Trinhbay_Lv FOREIGN KEY (maCakhuc, TualoiViet)
                              REFERENCES dbo.LoiViet(maCakhuc, TualoiViet)
);
GO

-- ============================================================
-- PHẦN A: CHÈN DỮ LIỆU MẪU
-- ============================================================

-- ------------------------------------------------------------
-- Tacgia: 12 tác giả (9 nam, 3 nữ), đa dạng thế hệ
-- ------------------------------------------------------------
INSERT INTO dbo.Tacgia VALUES
(1,  N'Trịnh Công Sơn',   N'Nam'),
(2,  N'Phạm Duy',         N'Nam'),
(3,  N'Văn Cao',          N'Nam'),
(4,  N'Nguyễn Văn Tý',    N'Nam'),
(5,  N'Hoàng Hiệp',       N'Nam'),
(6,  N'Ngô Thụy Miên',    N'Nam'),
(7,  N'Lam Phương',       N'Nam'),
(8,  N'Bảo Chấn',         N'Nam'),
(9,  N'Thanh Tùng',       N'Nam'),
(10, N'Trần Tiến',        N'Nam'),
(11, N'Ánh Tuyết',        N'Nữ'),
(12, N'Phương Uyên',      N'Nữ');
GO

-- ------------------------------------------------------------
-- Cakhuc: 35 ca khúc
-- Theloai: Bolero, Trữ tình, Nhạc đỏ, Pop, Rock, Dân ca
-- ------------------------------------------------------------
INSERT INTO dbo.Cakhuc VALUES
-- Trịnh Công Sơn (TG1) – 6 ca khúc, đa thể loại
(1,  N'Diễm Xưa',                   N'Trữ tình', 1, 1960),
(2,  N'Nối Vòng Tay Lớn',           N'Nhạc đỏ',  1, 1968),
(3,  N'Hạ Trắng',                   N'Trữ tình', 1, 1961),
(4,  N'Cát Bụi',                    N'Trữ tình', 1, 1965),
(5,  N'Một Cõi Đi Về',              N'Trữ tình', 1, 1974),
(6,  N'Để Gió Cuốn Đi',             N'Nhạc đỏ',  1, 1975),
-- Phạm Duy (TG2) – 5 ca khúc
(7,  N'Tình Ca',                    N'Dân ca',   2, 1953),
(8,  N'Nghìn Trùng Xa Cách',        N'Trữ tình', 2, 1960),
(9,  N'Bà Mẹ Quê',                  N'Dân ca',   2, 1949),
(10, N'Ngày Trở Về',                N'Nhạc đỏ',  2, 1954),
(11, N'Áo Anh Sứt Chỉ Đường Tà',   N'Dân ca',   2, 1951),
-- Văn Cao (TG3) – 4 ca khúc
(12, N'Làng Tôi',                   N'Nhạc đỏ',  3, 1947),
(13, N'Suối Mơ',                    N'Trữ tình', 3, 1943),
(14, N'Thu Cô Liêu',                N'Trữ tình', 3, 1940),
(15, N'Tiến Quân Ca',               N'Nhạc đỏ',  3, 1944),
-- Nguyễn Văn Tý (TG4) – 3 ca khúc
(16, N'Dư Âm',                      N'Trữ tình', 4, 1950),
(17, N'Mẹ Yêu Con',                 N'Dân ca',   4, 1956),
(18, N'Người Đi Xây Hồ Kẻ Gỗ',     N'Nhạc đỏ',  4, 1976),
-- Hoàng Hiệp (TG5) – 2 ca khúc
(19, N'Câu Hò Bên Bờ Hiền Lương',  N'Nhạc đỏ',  5, 1957),
(20, N'Trở Về Dòng Sông Tuổi Thơ', N'Trữ tình', 5, 1983),
-- Ngô Thụy Miên (TG6) – 3 ca khúc (chuyên Trữ tình)
(21, N'Áo Lụa Hà Đông',            N'Trữ tình', 6, 1972),
(22, N'Riêng Một Góc Trời',        N'Trữ tình', 6, 1971),
(23, N'Tình Khúc Chiều Mưa',       N'Trữ tình', 6, 1975),
-- Lam Phương (TG7) – 2 ca khúc
(24, N'Thành Phố Buồn',            N'Bolero',   7, 1970),
(25, N'Kiếp Nghèo',                N'Bolero',   7, 1955),
-- Bảo Chấn (TG8) – 2 ca khúc
(26, N'Để Nhớ Một Thời Ta Đã Yêu', N'Pop',      8, 1995),
(27, N'Tình Thôi Xót Xa',          N'Pop',      8, 1997),
-- Thanh Tùng (TG9) – 2 ca khúc
(28, N'Lối Cũ Ta Về',              N'Pop',      9, 1988),
(29, N'Giọt Nước Mắt Ngà',        N'Trữ tình', 9, 1985),
-- Trần Tiến (TG10) – 2 ca khúc
(30, N'Ngẫu Hứng Sông Hồng',       N'Rock',    10, 1992),
(31, N'Sao Em Nỡ Vội Lấy Chồng',   N'Dân ca',  10, 1990),
-- Ánh Tuyết (TG11) – 2 ca khúc
(32, N'Ký Ức Mùa Thu',             N'Pop',     11, 2003),
(33, N'Nụ Cười Trong Mưa',         N'Pop',     11, 2005),
-- Phương Uyên (TG12) – 2 ca khúc
(34, N'Màu Nước Mắt',              N'Pop',     12, 2001),
(35, N'Bướm Bay',                  N'Pop',     12, 2006);
GO

-- ------------------------------------------------------------
-- LoiViet
-- Ca khúc nổi tiếng: nhiều bản dịch; Ca khúc ít tên tuổi: 1 bản
-- CK11, CK14, CK18, CK33, CK35 KHÔNG có lời Việt (dùng NOT EXISTS)
-- ------------------------------------------------------------
INSERT INTO dbo.LoiViet VALUES
-- CK1: Diễm Xưa – 4 bản dịch
(1, N'Diem Xua - BanA', N'Nguyễn Minh', 1970),
(1, N'Diem Xua - BanB', N'Khánh Ly',    1975),
(1, N'Diem Xua - BanC', N'Thanh Mai',   1990),
(1, N'Diem Xua - BanD', N'Trúc Chi',    2005),
-- CK2: Nối Vòng Tay Lớn – 3 bản dịch
(2, N'NVTL - BanA', N'Lê Hùng',  1975),
(2, N'NVTL - BanB', N'Mai Linh', 1985),
(2, N'NVTL - BanC', N'Đức Huy',  2000),
-- CK3: Hạ Trắng – 3 bản dịch
(3, N'HaTrang - BanA', N'Trần Nam',  1972),
(3, N'HaTrang - BanB', N'Phú Quỳnh', 1980),
(3, N'HaTrang - BanC', N'Bảo Ngọc',  1998),
-- CK4: Cát Bụi – 2 bản dịch
(4, N'CatBui - BanA', N'Văn Khoa', 1970),
(4, N'CatBui - BanB', N'Ngọc Lan', 1995),
-- CK5: Một Cõi Đi Về – 3 bản dịch
(5, N'MCDV - BanA', N'Hương Giang', 1978),
(5, N'MCDV - BanB', N'Thủy Tiên',   1990),
(5, N'MCDV - BanC', N'Minh Đức',    2010),
-- CK6: Để Gió Cuốn Đi – 2 bản dịch
(6, N'DGCD - BanA', N'Tâm Ngọc',  1980),
(6, N'DGCD - BanB', N'Hồng Nhung', 2000),
-- CK7: Tình Ca – 3 bản dịch
(7, N'TinhCa - BanA', N'Phạm Duy',  1956),
(7, N'TinhCa - BanB', N'Quỳnh Dao', 1975),
(7, N'TinhCa - BanC', N'Nam Lộc',   2000),
-- CK8: Nghìn Trùng Xa Cách – 2 bản dịch
(8, N'NTXC - BanA', N'Hoài Nam', 1965),
(8, N'NTXC - BanB', N'Thu Hà',   1988),
-- CK9: Bà Mẹ Quê – 1 bản dịch
(9, N'BaMeQue - BanA', N'Phạm Duy', 1952),
-- CK10: Ngày Trở Về – 2 bản dịch
(10, N'NTV - BanA', N'Lê Quang',  1958),
(10, N'NTV - BanB', N'Hoài Linh', 1990),
-- CK12: Làng Tôi – 3 bản dịch
(12, N'LangToi - BanA', N'Văn Cao',      1950),
(12, N'LangToi - BanB', N'Trọng Khang',  1975),
(12, N'LangToi - BanC', N'Bích Phượng',  2000),
-- CK13: Suối Mơ – 2 bản dịch
(13, N'SuoiMo - BanA', N'Trúc Kỳ',    1948),
(13, N'SuoiMo - BanB', N'Minh Thảo',  1980),
-- CK15: Tiến Quân Ca – 3 bản dịch
(15, N'TQC - BanA', N'Văn Cao',    1945),
(15, N'TQC - BanB', N'Trần Lâm',   1960),
(15, N'TQC - BanC', N'Minh Khoa',  2000),
-- CK16: Dư Âm – 2 bản dịch
(16, N'DuAm - BanA', N'Ngọc Bảo',   1955),
(16, N'DuAm - BanB', N'Ánh Tuyết',  1995),
-- CK17: Mẹ Yêu Con – 1 bản dịch
(17, N'MYC - BanA', N'Tường Vi', 1960),
-- CK19: Câu Hò Bên Bờ Hiền Lương – 2 bản dịch
(19, N'CHBBHL - BanA', N'Kim Tiến',    1960),
(19, N'CHBBHL - BanB', N'Thanh Thanh', 1975),
-- CK20: Trở Về Dòng Sông Tuổi Thơ – 1 bản dịch
(20, N'TVDST - BanA', N'Cẩm Vân', 1985),
-- CK21: Áo Lụa Hà Đông – 3 bản dịch
(21, N'ALHD - BanA', N'Ngô Thụy Miên', 1975),
(21, N'ALHD - BanB', N'Tuấn Vũ',       1988),
(21, N'ALHD - BanC', N'Ngọc Lan',      2000),
-- CK22: Riêng Một Góc Trời – 3 bản dịch
(22, N'RMGT - BanA', N'Lê Uyên',    1975),
(22, N'RMGT - BanB', N'Ngọc Bích',  1988),
(22, N'RMGT - BanC', N'Hiền Thục',  2005),
-- CK23: Tình Khúc Chiều Mưa – 2 bản dịch
(23, N'TKCM - BanA', N'Tuấn Ngọc', 1978),
(23, N'TKCM - BanB', N'Ý Lan',     1993),
-- CK24: Thành Phố Buồn – 3 bản dịch
(24, N'TPB - BanA', N'Lam Phương', 1972),
(24, N'TPB - BanB', N'Đan Nguyên', 1990),
(24, N'TPB - BanC', N'Mạnh Quỳnh', 2005),
-- CK25: Kiếp Nghèo – 2 bản dịch
(25, N'KiepNgheo - BanA', N'Lam Phương', 1958),
(25, N'KiepNgheo - BanB', N'Tuấn Vũ',    1990),
-- CK26: Để Nhớ Một Thời Ta Đã Yêu – 1 bản dịch
(26, N'DNMTTDY - BanA', N'Nhật Tiến', 1997),
-- CK27: Tình Thôi Xót Xa – 1 bản dịch
(27, N'TTXX - BanA', N'Cẩm Ly', 1998),
-- CK28: Lối Cũ Ta Về – 2 bản dịch
(28, N'LCTV - BanA', N'Khánh Hà', 1990),
(28, N'LCTV - BanB', N'Ái Vân',   2000),
-- CK29: Giọt Nước Mắt Ngà – 2 bản dịch
(29, N'GNMN - BanA', N'Thanh Tùng', 1987),
(29, N'GNMN - BanB', N'Như Quỳnh',  2000),
-- CK30: Ngẫu Hứng Sông Hồng – 1 bản dịch
(30, N'NHSH - BanA', N'Trần Tiến', 1993),
-- CK31: Sao Em Nỡ Vội Lấy Chồng – 1 bản dịch
(31, N'SENVLC - BanA', N'Bảo Yến', 1991),
-- CK32: Ký Ức Mùa Thu – 1 bản dịch
(32, N'KUMT - BanA', N'Ánh Tuyết', 2004),
-- CK34: Màu Nước Mắt – 1 bản dịch
(34, N'MNM - BanA', N'Phương Uyên', 2002);
GO

-- ------------------------------------------------------------
-- Trinhbay
-- Ca khúc để đời có ≥ 6 ca sĩ; ca khúc khác ít hơn
-- ------------------------------------------------------------
INSERT INTO dbo.Trinhbay VALUES
-- CK1: Diễm Xưa – 10 ca sĩ (để đời)
(1, N'Diem Xua - BanA', N'Khánh Ly'),
(1, N'Diem Xua - BanA', N'Lệ Thu'),
(1, N'Diem Xua - BanA', N'Hồng Nhung'),
(1, N'Diem Xua - BanA', N'Thu Phương'),
(1, N'Diem Xua - BanB', N'Thanh Lam'),
(1, N'Diem Xua - BanB', N'Mỹ Tâm'),
(1, N'Diem Xua - BanB', N'Hà Anh Tuấn'),
(1, N'Diem Xua - BanC', N'Đức Tuấn'),
(1, N'Diem Xua - BanC', N'Ái Vân'),
(1, N'Diem Xua - BanD', N'Trọng Tấn'),
-- CK2: Nối Vòng Tay Lớn – 8 ca sĩ (để đời)
(2, N'NVTL - BanA', N'Trịnh Công Sơn'),
(2, N'NVTL - BanA', N'Hồng Nhung'),
(2, N'NVTL - BanA', N'Thanh Lam'),
(2, N'NVTL - BanA', N'Lệ Thu'),
(2, N'NVTL - BanB', N'Mỹ Tâm'),
(2, N'NVTL - BanB', N'Hà Trần'),
(2, N'NVTL - BanC', N'Đức Tuấn'),
(2, N'NVTL - BanC', N'Đàm Vĩnh Hưng'),
-- CK3: Hạ Trắng – 7 ca sĩ (để đời)
(3, N'HaTrang - BanA', N'Khánh Ly'),
(3, N'HaTrang - BanA', N'Cẩm Vân'),
(3, N'HaTrang - BanA', N'Lệ Thu'),
(3, N'HaTrang - BanA', N'Hồng Nhung'),
(3, N'HaTrang - BanB', N'Thu Phương'),
(3, N'HaTrang - BanB', N'Bằng Kiều'),
(3, N'HaTrang - BanC', N'Tuấn Ngọc'),
-- CK4: Cát Bụi – 5 ca sĩ
(4, N'CatBui - BanA', N'Khánh Ly'),
(4, N'CatBui - BanA', N'Trịnh Công Sơn'),
(4, N'CatBui - BanA', N'Thanh Lam'),
(4, N'CatBui - BanB', N'Hồng Nhung'),
(4, N'CatBui - BanB', N'Lệ Thu'),
-- CK5: Một Cõi Đi Về – 8 ca sĩ (để đời)
(5, N'MCDV - BanA', N'Khánh Ly'),
(5, N'MCDV - BanA', N'Tuấn Ngọc'),
(5, N'MCDV - BanA', N'Lệ Thu'),
(5, N'MCDV - BanA', N'Cẩm Vân'),
(5, N'MCDV - BanB', N'Hồng Nhung'),
(5, N'MCDV - BanB', N'Thanh Lam'),
(5, N'MCDV - BanB', N'Hà Trần'),
(5, N'MCDV - BanC', N'Đức Tuấn'),
-- CK6: Để Gió Cuốn Đi – 4 ca sĩ
(6, N'DGCD - BanA', N'Khánh Ly'),
(6, N'DGCD - BanA', N'Cẩm Vân'),
(6, N'DGCD - BanB', N'Hồng Nhung'),
(6, N'DGCD - BanB', N'Lệ Thu'),
-- CK7: Tình Ca – 8 ca sĩ (để đời)
(7, N'TinhCa - BanA', N'Thái Thanh'),
(7, N'TinhCa - BanA', N'Phạm Duy'),
(7, N'TinhCa - BanA', N'Khánh Ly'),
(7, N'TinhCa - BanA', N'Ánh Tuyết'),
(7, N'TinhCa - BanB', N'Lệ Thu'),
(7, N'TinhCa - BanB', N'Tuấn Ngọc'),
(7, N'TinhCa - BanC', N'Ái Vân'),
(7, N'TinhCa - BanC', N'Bằng Kiều'),
-- CK8: Nghìn Trùng Xa Cách – 5 ca sĩ
(8, N'NTXC - BanA', N'Thái Thanh'),
(8, N'NTXC - BanA', N'Khánh Ly'),
(8, N'NTXC - BanA', N'Lệ Thu'),
(8, N'NTXC - BanB', N'Tuấn Ngọc'),
(8, N'NTXC - BanB', N'Thu Phương'),
-- CK9: Bà Mẹ Quê – 2 ca sĩ
(9, N'BaMeQue - BanA', N'Thái Thanh'),
(9, N'BaMeQue - BanA', N'Bích Phượng'),
-- CK10: Ngày Trở Về – 4 ca sĩ
(10, N'NTV - BanA', N'Thái Thanh'),
(10, N'NTV - BanA', N'Khánh Ly'),
(10, N'NTV - BanB', N'Trọng Tấn'),
(10, N'NTV - BanB', N'Ánh Tuyết'),
-- CK12: Làng Tôi – 7 ca sĩ (để đời)
(12, N'LangToi - BanA', N'Trọng Tấn'),
(12, N'LangToi - BanA', N'Bích Phượng'),
(12, N'LangToi - BanA', N'Quang Linh'),
(12, N'LangToi - BanA', N'Thu Hiền'),
(12, N'LangToi - BanB', N'Thanh Hoài'),
(12, N'LangToi - BanB', N'Ánh Tuyết'),
(12, N'LangToi - BanC', N'Ngọc Tân'),
-- CK13: Suối Mơ – 5 ca sĩ
(13, N'SuoiMo - BanA', N'Ánh Tuyết'),
(13, N'SuoiMo - BanA', N'Lệ Thu'),
(13, N'SuoiMo - BanA', N'Tuấn Ngọc'),
(13, N'SuoiMo - BanB', N'Khánh Ly'),
(13, N'SuoiMo - BanB', N'Quang Linh'),
-- CK15: Tiến Quân Ca – 5 ca sĩ
(15, N'TQC - BanA', N'Quốc ca'),
(15, N'TQC - BanB', N'Trọng Tấn'),
(15, N'TQC - BanB', N'Đoàn Trường'),
(15, N'TQC - BanC', N'Ngọc Tân'),
(15, N'TQC - BanC', N'Thu Hiền'),
-- CK16: Dư Âm – 7 ca sĩ (để đời)
(16, N'DuAm - BanA', N'Ngọc Bảo'),
(16, N'DuAm - BanA', N'Thái Thanh'),
(16, N'DuAm - BanA', N'Khánh Ly'),
(16, N'DuAm - BanA', N'Lệ Thu'),
(16, N'DuAm - BanA', N'Ánh Tuyết'),
(16, N'DuAm - BanB', N'Tuấn Ngọc'),
(16, N'DuAm - BanB', N'Ái Vân'),
-- CK17: Mẹ Yêu Con – 3 ca sĩ
(17, N'MYC - BanA', N'Tường Vi'),
(17, N'MYC - BanA', N'Thu Hiền'),
(17, N'MYC - BanA', N'Trọng Tấn'),
-- CK19: Câu Hò Bên Bờ Hiền Lương – 5 ca sĩ
(19, N'CHBBHL - BanA', N'Thu Hiền'),
(19, N'CHBBHL - BanA', N'Trọng Tấn'),
(19, N'CHBBHL - BanA', N'Ngọc Tân'),
(19, N'CHBBHL - BanB', N'Bích Phượng'),
(19, N'CHBBHL - BanB', N'Ánh Tuyết'),
-- CK20: Trở Về Dòng Sông Tuổi Thơ – 2 ca sĩ
(20, N'TVDST - BanA', N'Cẩm Vân'),
(20, N'TVDST - BanA', N'Quang Linh'),
-- CK21: Áo Lụa Hà Đông – 9 ca sĩ (để đời)
(21, N'ALHD - BanA', N'Tuấn Vũ'),
(21, N'ALHD - BanA', N'Ngọc Lan'),
(21, N'ALHD - BanA', N'Lệ Thu'),
(21, N'ALHD - BanA', N'Ý Lan'),
(21, N'ALHD - BanB', N'Khánh Ly'),
(21, N'ALHD - BanB', N'Thanh Lam'),
(21, N'ALHD - BanB', N'Hồng Nhung'),
(21, N'ALHD - BanC', N'Đức Tuấn'),
(21, N'ALHD - BanC', N'Hà Anh Tuấn'),
-- CK22: Riêng Một Góc Trời – 8 ca sĩ (để đời)
(22, N'RMGT - BanA', N'Lệ Thu'),
(22, N'RMGT - BanA', N'Tuấn Ngọc'),
(22, N'RMGT - BanA', N'Khánh Hà'),
(22, N'RMGT - BanA', N'Ý Lan'),
(22, N'RMGT - BanB', N'Hồng Nhung'),
(22, N'RMGT - BanB', N'Thanh Lam'),
(22, N'RMGT - BanC', N'Đức Tuấn'),
(22, N'RMGT - BanC', N'Hà Anh Tuấn'),
-- CK23: Tình Khúc Chiều Mưa – 5 ca sĩ
(23, N'TKCM - BanA', N'Tuấn Ngọc'),
(23, N'TKCM - BanA', N'Ý Lan'),
(23, N'TKCM - BanA', N'Lệ Thu'),
(23, N'TKCM - BanB', N'Thanh Lam'),
(23, N'TKCM - BanB', N'Mỹ Tâm'),
-- CK24: Thành Phố Buồn – 9 ca sĩ (để đời)
(24, N'TPB - BanA', N'Lam Phương'),
(24, N'TPB - BanA', N'Tuấn Vũ'),
(24, N'TPB - BanA', N'Đan Nguyên'),
(24, N'TPB - BanA', N'Mạnh Quỳnh'),
(24, N'TPB - BanA', N'Như Quỳnh'),
(24, N'TPB - BanB', N'Ý Lan'),
(24, N'TPB - BanB', N'Thanh Tuyền'),
(24, N'TPB - BanC', N'Đàm Vĩnh Hưng'),
(24, N'TPB - BanC', N'Quang Lê'),
-- CK25: Kiếp Nghèo – 6 ca sĩ (để đời)
(25, N'KiepNgheo - BanA', N'Lam Phương'),
(25, N'KiepNgheo - BanA', N'Thanh Tuyền'),
(25, N'KiepNgheo - BanA', N'Hương Lan'),
(25, N'KiepNgheo - BanB', N'Tuấn Vũ'),
(25, N'KiepNgheo - BanB', N'Như Quỳnh'),
(25, N'KiepNgheo - BanB', N'Mạnh Quỳnh'),
-- CK26: Để Nhớ Một Thời Ta Đã Yêu – 2 ca sĩ
(26, N'DNMTTDY - BanA', N'Mỹ Tâm'),
(26, N'DNMTTDY - BanA', N'Thu Phương'),
-- CK27: Tình Thôi Xót Xa – 3 ca sĩ
(27, N'TTXX - BanA', N'Cẩm Ly'),
(27, N'TTXX - BanA', N'Mỹ Tâm'),
(27, N'TTXX - BanA', N'Lam Trường'),
-- CK28: Lối Cũ Ta Về – 5 ca sĩ
(28, N'LCTV - BanA', N'Khánh Hà'),
(28, N'LCTV - BanA', N'Cẩm Vân'),
(28, N'LCTV - BanA', N'Thanh Tùng'),
(28, N'LCTV - BanB', N'Ái Vân'),
(28, N'LCTV - BanB', N'Hà Trần'),
-- CK29: Giọt Nước Mắt Ngà – 5 ca sĩ
(29, N'GNMN - BanA', N'Thanh Tùng'),
(29, N'GNMN - BanA', N'Cẩm Vân'),
(29, N'GNMN - BanA', N'Lệ Thu'),
(29, N'GNMN - BanB', N'Như Quỳnh'),
(29, N'GNMN - BanB', N'Hà Trần'),
-- CK30: Ngẫu Hứng Sông Hồng – 2 ca sĩ
(30, N'NHSH - BanA', N'Trần Tiến'),
(30, N'NHSH - BanA', N'Đàm Vĩnh Hưng'),
-- CK31: Sao Em Nỡ Vội Lấy Chồng – 3 ca sĩ
(31, N'SENVLC - BanA', N'Bảo Yến'),
(31, N'SENVLC - BanA', N'Thu Hiền'),
(31, N'SENVLC - BanA', N'Ánh Tuyết'),
-- CK32: Ký Ức Mùa Thu – 2 ca sĩ
(32, N'KUMT - BanA', N'Ánh Tuyết'),
(32, N'KUMT - BanA', N'Thanh Lam'),
-- CK34: Màu Nước Mắt – 2 ca sĩ
(34, N'MNM - BanA', N'Phương Uyên'),
(34, N'MNM - BanA', N'Mỹ Tâm');
GO
