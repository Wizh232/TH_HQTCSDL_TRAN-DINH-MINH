--Câu 1
CREATE PROCEDURE cau1_lab8
    @manv NVARCHAR(10),
    @tennv NVARCHAR(50),
    @gioitinh NCHAR(3),
    @diachi NVARCHAR(100),
    @sodt NVARCHAR(20),
    @email NVARCHAR(50),
    @phong NVARCHAR(50),
    @Flag BIT
AS
BEGIN

    IF @gioitinh NOT IN ('Nam', 'Nu')
    BEGIN
    
        SELECT 1 AS 'ErrorCode', 'Giới tính không hợp lệ' AS 'ErrorMessage'
        RETURN
    END
   
    IF @Flag = 0
    BEGIN
    
        INSERT INTO NhanVien (MaNV, TenNV, GioiTinh, DiaChi, SoDT, Email, Phong)
        VALUES (@manv, @tennv, @gioitinh, @diachi, @sodt, @email, @phong)
    END
    ELSE
    BEGIN
        
        UPDATE NhanVien
        SET TenNV = @tennv,
            GioiTinh = @gioitinh,
            DiaChi = @diachi,
            SoDT = @sodt,
            Email = @email,
            Phong = @phong
        WHERE MaNV = @manv
    END

 
    SELECT 0 AS 'ErrorCode', 'Thực hiện thành công' AS 'ErrorMessage'
    RETURN
END
--Câu 2
CREATE PROCEDURE cau2_lab8
    @masp nchar(10),
    @tenhang nvarchar(20),
    @tensp nvarchar(20),
    @soluong int,
    @mausac nvarchar(20),
    @giaban money,
    @donvitinh nchar(10),
    @mota nvarchar(max),
    @flag bit,
    @error int OUTPUT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM [dbo].[Hangsx] WHERE tenhang = @tenhang)
    BEGIN
        SET @error = 1
        RETURN
    END

    IF @soluong < 0
    BEGIN
        SET @error = 2
        RETURN
    END

    IF @flag = 0
        INSERT INTO [dbo].[SanPham] (masp, mahangsx, tensp, soluong, mausac, giaban, donvitinh, mota)
        VALUES (@masp, (SELECT mahangsx FROM [dbo].[Hangsx] WHERE tenhang = @tenhang), @tensp, @soluong, @mausac, @giaban, @donvitinh, @mota)
    ELSE
        UPDATE [dbo].[SanPham]
        SET mahangsx = (SELECT mahangsx FROM [dbo].[Hangsx] WHERE tenhang = @tenhang),
            tensp = @tensp,
            soluong = @soluong,
            mausac = @mausac,
            giaban = @giaban,
            donvitinh = @donvitinh,
            mota = @mota
        WHERE masp = @masp

    SET @error = 0
END


--Câu 3
CREATE PROCEDURE cau3_lab8
    @manv nvarchar(10)
AS
BEGIN
    SET NOCOUNT ON;

    
    IF NOT EXISTS (SELECT * FROM nhanvien WHERE manv = @manv)
    BEGIN
       
        RETURN 1;
    END

 
    BEGIN
     
        DELETE FROM Nhap WHERE manv = @manv;

     
        DELETE FROM Xuat WHERE manv = @manv;

     
        DELETE FROM nhanvien WHERE manv = @manv;
    END

   
    RETURN 0;
END
--Câu 4
CREATE PROCEDURE cau4_lab8
    @masp nchar(10),
    @error int OUTPUT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM [dbo].[SanPham] WHERE masp = @masp)
    BEGIN
        SET @error = 1
        RETURN
    END

    DELETE FROM [dbo].[Nhap] WHERE masp = @masp
    DELETE FROM [dbo].[Xuat] WHERE masp = @masp
    DELETE FROM [dbo].[SanPham] WHERE masp = @masp

    SET @error = 0
END
--Câu 5
CREATE PROCEDURE cau5_lab8
    @mahangsx NVARCHAR(10),
    @tenhang NVARCHAR(50),
    @diachi NVARCHAR(100),
    @sodt NVARCHAR(20),
    @email NVARCHAR(50)
AS
BEGIN
    IF EXISTS (SELECT * FROM Hangsx WHERE tenhang = @tenhang)
    BEGIN
   
        RETURN 1;
    END
    ELSE
    BEGIN
   
        INSERT INTO Hangsx (mahangsx, tenhang, diachi, sodt, email)
        VALUES (@mahangsx, @tenhang, @diachi, @sodt, @email);
  
        RETURN 0;
    END
END

--Câu 6
CREATE PROCEDURE cau6_lab8
    @sohdn nchar(10),
    @masp nchar(10),
    @manv nchar(10),
    @ngaynhap date,
    @soluongN int,
    @dongiaN money,
    @error int OUTPUT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM SanPham WHERE masp = @masp)
    BEGIN
        SET @error = 1
        RETURN
    END

    IF NOT EXISTS (SELECT 1 FROM NhanVien WHERE manv = @manv)
    BEGIN
        SET @error = 2
        RETURN
    END

    IF EXISTS (SELECT 1 FROM Nhap WHERE sohdn = @sohdn)
        UPDATE Nhap
        SET masp = @masp,
            manv = @manv,
            ngaynhap = @ngaynhap,
            soluongN = @soluongN,
            dongiaN = @dongiaN
        WHERE sohdn = @sohdn
    ELSE
        INSERT INTO Nhap (sohdn, masp, manv, ngaynhap, soluongN, dongiaN)
        VALUES (@sohdn, @masp, @manv, @ngaynhap, @soluongN, @dongiaN)

    SET @error = 0
END

--Câu 7
CREATE PROCEDURE cau7_lab8
    @sohdx NVARCHAR(10), 
    @masp NVARCHAR(10), 
    @manv NVARCHAR(10), 
    @ngayxuat DATE, 
    @soluongX INT, 
    @flag INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    
    IF NOT EXISTS(SELECT * FROM Sanpham WHERE Masp = @masp)
    BEGIN
        SET @flag = 1; 
        RETURN;
    END

   
    IF NOT EXISTS(SELECT * FROM Nhanvien WHERE Manv = @manv)
    BEGIN
        SET @flag = 2; 
        RETURN;
    END

    
    IF @soluongX > (SELECT SoLuong FROM Sanpham WHERE Masp = @masp)
    BEGIN
        SET @flag = 3; 
        RETURN;
    END


    IF EXISTS(SELECT * FROM Xuat WHERE SoHDX = @sohdx)
    BEGIN
      
        UPDATE Xuat 
        SET MaSP = @masp, 
            Manv = @manv, 
            Ngayxuat = @ngayxuat, 
            SoLuongX = @soluongX 
        WHERE SoHDX = @sohdx;
    END
    ELSE
    BEGIN
      
        INSERT INTO Xuat (SoHDX, MaSP, Manv, Ngayxuat, SoLuongX) 
        VALUES (@sohdx, @masp, @manv, @ngayxuat, @soluongX);
    END

    
    SET @flag = 0;
END





