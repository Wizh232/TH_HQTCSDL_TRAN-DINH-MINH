--Câu 1
CREATE FUNCTION dbo.cau1_lab6
(
    @TenHang NVARCHAR(50)
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        sp.masp AS 'MaSP',
        sp.tensp AS 'TenSP',
        hs.tenhang AS 'TenHang',
        sp.soluong AS 'SoLuong',
        sp.mausac AS 'MauSac',
        sp.giaban AS 'GiaBan',
        sp.donvitinh AS 'DonViTinh',
        sp.mota AS 'MoTa'
    FROM
        Sanpham sp
    INNER JOIN
        Hangsx hs ON sp.mahangsx = hs.mahangsx
    WHERE
        hs.tenhang LIKE '%' + @TenHang + '%'
);

SELECT *
FROM dbo.cau1_lab6('Samsung');

--Câu 2

CREATE FUNCTION dbo.cau2_lab6
(
    @NgayBatDau DATE,
    @NgayKetThuc DATE
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        sp.masp AS 'MaSP',
        sp.tensp AS 'TenSP',
        hs.tenhang AS 'TenHang',
        sp.soluong AS 'SoLuong',
        sp.mausac AS 'MauSac',
        sp.giaban AS 'GiaBan',
        sp.donvitinh AS 'DonViTinh',
        sp.mota AS 'MoTa',
        np.ngaynhap AS 'NgayNhap'
    FROM
        Nhap np
    INNER JOIN
        Sanpham sp ON np.masp = sp.masp
    INNER JOIN
        Hangsx hs ON sp.mahangsx = hs.mahangsx
    WHERE
        np.ngaynhap BETWEEN @NgayBatDau AND @NgayKetThuc
);

SELECT *
FROM dbo.cau2_lab6('2019-05-02', '2020-05-02');

--Câu 3
CREATE FUNCTION cau3_lab6
(
    @MaHangSX NCHAR(10),
    @LuaChon INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT Sanpham.masp, Sanpham.mahangsx, Sanpham.tensp, Sanpham.soluong, Sanpham.mausac, Sanpham.giaban, Sanpham.donvitinh, Sanpham.mota
    FROM Sanpham
    WHERE Sanpham.mahangsx = @MaHangSX
    AND (@LuaChon = 0 AND Sanpham.soluong = 0 OR @LuaChon = 1 AND Sanpham.soluong > 0)
);

DECLARE @MaHangSX NCHAR(10);
DECLARE @LuaChon INT;

SET @MaHangSX = N'H01'; 
SET @LuaChon = 1; 

SELECT * FROM cau3_lab6(@MaHangSX, @LuaChon);


--Câu 4
CREATE FUNCTION cau4_lab6
(
    @TenPhong NVARCHAR(50)
)
RETURNS TABLE
AS
RETURN
(
    SELECT Nhanvien.manv, Nhanvien.tennv, Nhanvien.gioitinh, Nhanvien.diachi, Nhanvien.sodt, Nhanvien.email, Nhanvien.phong
    FROM Nhanvien
    WHERE Nhanvien.phong = @TenPhong
);

DECLARE @TenPhong NVARCHAR(50);
SET @TenPhong = N'K? toán'; 
SELECT * FROM cau4_lab6(@TenPhong);

--Câu 5
CREATE FUNCTION cau5_lab6
(
    @DiaChi NVARCHAR(255)
)
RETURNS TABLE
AS
RETURN
(
    SELECT Hangsx.mahangsx, Hangsx.tenhang, Hangsx.diachi, Hangsx.sodt, Hangsx.email
    FROM Hangsx
    WHERE Hangsx.diachi LIKE '%' + @DiaChi + '%'
);

DECLARE @DiaChi NVARCHAR(255);

SET @DiaChi = N'Korea'; 

SELECT * FROM cau5_lab6(@DiaChi);

--Câu 6
CREATE FUNCTION cau6_lab6
(
    @NamBatDau INT,
    @NamKetThuc INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT Sanpham.masp, Sanpham.mahangsx, Sanpham.tensp, Hangsx.tenhang
    FROM Sanpham
    INNER JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
    INNER JOIN Nhap ON Sanpham.masp = Nhap.masp
    WHERE YEAR(Nhap.ngaynhap) BETWEEN @NamBatDau AND @NamKetThuc
);

DECLARE @NamBatDau INT;
DECLARE @NamKetThuc INT;

SET @NamBatDau = 2019; 
SET @NamKetThuc = 2021; 

SELECT * FROM cau6_lab6(@NamBatDau, @NamKetThuc);

--Câu 7
CREATE FUNCTION cau7_lab6
(
    @GiaBatDau DECIMAL(18, 2),
    @GiaKetThuc DECIMAL(18, 2),
    @TenHangSX NVARCHAR(100)
)
RETURNS TABLE
AS
RETURN
(
    SELECT Sanpham.masp, Sanpham.mahangsx, Sanpham.tensp, Sanpham.giaban
    FROM Sanpham
    INNER JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
    WHERE Sanpham.giaban BETWEEN @GiaBatDau AND @GiaKetThuc
    AND Hangsx.tenhang = @TenHangSX
);

SELECT masp, mahangsx, tensp, giaban
FROM cau7_lab6(1900000.0000, 8000000.0000, 'H01');

--Câu 8
CREATE FUNCTION cau8_lab6
(
    @NgayNhap DATE
)
RETURNS TABLE
AS
RETURN
(
    SELECT nhanvien.*
    FROM Nhap
    INNER JOIN Nhanvien ON Nhap.manv = Nhanvien.manv
    WHERE Nhap.ngaynhap = @NgayNhap
);


SELECT *
FROM cau8_lab6('2019-05-02');

--Câu 9
CREATE FUNCTION cau9_lab6
(
    @GiaBanMin FLOAT,
    @GiaBanMax FLOAT,
    @CongTySanXuat NVARCHAR(100)
)
RETURNS TABLE
AS
RETURN
(
    SELECT Sanpham.*, Hangsx.tenhang
    FROM Sanpham
    INNER JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
    WHERE Sanpham.giaban BETWEEN @GiaBanMin AND @GiaBanMax
    AND Hangsx.tenhang = @CongTySanXuat
);

SELECT *
FROM cau9_lab6(100, 1900000.00, 'Samsung');

--Câu 10
CREATE FUNCTION cau10_lab6
()
RETURNS TABLE
AS
RETURN
(
    SELECT Sanpham.*, Hangsx.tenhang
    FROM Sanpham
    INNER JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
);

SELECT *
FROM cau10_lab6();





