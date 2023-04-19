--Câu 1
CREATE TRIGGER trg_Nhap
ON Nhap
FOR INSERT
AS
BEGIN
    DECLARE @masp NVARCHAR(10), @manv NVARCHAR(10)
    DECLARE @sln INT, @dgn FLOAT

    SELECT @masp = masp, @manv = manv, @sln = soluongN, @dgn = dongiaN
    FROM inserted

    IF NOT EXISTS (SELECT * FROM sanpham WHERE masp = @masp)
    BEGIN
        RAISERROR(N'Không tồn tại sản phẩm trong danh mục sản phẩm.', 16, 1)
        ROLLBACK TRANSACTION
    END
    ELSE IF NOT EXISTS (SELECT * FROM nhanvien WHERE manv = @manv)
    BEGIN
        RAISERROR(N'Không tồn tại nhân viên có mã này.', 16, 1)
        ROLLBACK TRANSACTION
    END
    ELSE IF (@sln <= 0 OR @dgn <= 0)
    BEGIN
        RAISERROR(N'Nhập sai số lượng hoặc đơn giá.', 16, 1)
        ROLLBACK TRANSACTION
    END
    ELSE
    BEGIN
        -- Cập nhật số lượng sản phẩm trong bảng Sanpham
        UPDATE Sanpham
        SET soluong = soluong + @sln
        WHERE masp = @masp
    END
END

--Câu 2
go
CREATE TRIGGER trg_Xuat
ON Xuat
FOR INSERT
AS
BEGIN
    DECLARE @masp nvarchar(10), @manv nvarchar(10)
    DECLARE @slx int, @dgb float
    SELECT @masp = masp, @manv = manv, @slx = soluongX, @dgb = dongiaX FROM inserted
    IF NOT EXISTS (SELECT * FROM SanPham WHERE masp = @masp)
    BEGIN
        RAISERROR(N'Sản phẩm không tồn tại trong danh mục sản phẩm.', 16, 1)
        ROLLBACK TRANSACTION
    END
    ELSE IF NOT EXISTS (SELECT * FROM NhanVien WHERE manv = @manv)
    BEGIN
        RAISERROR(N'Nhân viên không tồn tại trong danh mục nhân viên.', 16, 1)
        ROLLBACK TRANSACTION
    END
    ELSE IF (@slx <= 0 OR @dgb <= 0)
    BEGIN
        RAISERROR(N'Số lượng hoặc đơn giá xuất không hợp lệ.', 16, 1)
        ROLLBACK TRANSACTION
    END
    ELSE IF (@slx > (SELECT soluong FROM SanPham WHERE masp = @masp))
    BEGIN
        RAISERROR(N'Số lượng sản phẩm trong kho không đủ để xuất.', 16, 1)
        ROLLBACK TRANSACTION
    END
    ELSE
    BEGIN
        UPDATE SanPham SET soluong = soluong - @slx WHERE masp = @masp
    END
END

go
--Câu 3
CREATE TRIGGER trg_XoaPhieuXuat
ON Xuat
AFTER DELETE
AS
BEGIN
  DECLARE @masp NVARCHAR(10), @sln INT;

  SELECT @masp = d.masp, @sln = d.soluongX
  FROM deleted d;

  UPDATE Sanpham
  SET soluong = soluong + @sln
  WHERE masp = @masp;
END


--Câu 4
CREATE TRIGGER trg_CapNhatXuat
ON Xuat
AFTER UPDATE
AS
BEGIN
    DECLARE @Count INT, @masp NVARCHAR(10), @sln INT, @sln_old INT

    SELECT @Count = COUNT(*) FROM INSERTED

    IF @Count > 1
    BEGIN
        RAISERROR(N'Số bản ghi thay đổi > 1 bản ghi', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END

    SELECT @masp = i.masp, @sln = i.soluongX, @sln_old = d.soluongX
    FROM INSERTED i INNER JOIN DELETED d ON i.sohdx = d.sohdx AND i.masp = d.masp

    IF @sln < @sln_old
    BEGIN
        RAISERROR(N'Số lượng xuất thay đổi nhỏ hơn số lượng trong bảng sản phẩm', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END

    UPDATE Xuat SET soluongX = @sln WHERE sohdx = (SELECT sohdx FROM INSERTED)

    UPDATE Sanpham SET soluong = soluong + (@sln_old - @sln) WHERE masp = @masp

END

go
--Câu 5
CREATE TRIGGER trg_UpdateNhapSoluong
ON Nhap
AFTER UPDATE
AS
BEGIN
    IF (SELECT COUNT(*) FROM inserted) > 1
    BEGIN
        RAISERROR(N'Chỉ được phép cập nhật một bản ghi tại một thời điểm!', 16, 1)
        ROLLBACK TRANSACTION
    END
    ELSE
    BEGIN
        DECLARE @masp NVARCHAR(10), @sln_old INT, @sln_new INT
        
        SELECT @masp = i.masp, @sln_old = d.soluongN, @sln_new = i.soluongN
        FROM inserted i
        INNER JOIN deleted d ON i.masp = d.masp
        
        IF @sln_new < @sln_old
        BEGIN
            RAISERROR(N'Số lượng nhập mới phải lớn hơn số lượng cũ!', 16, 1)
            ROLLBACK TRANSACTION
        END
        ELSE
        BEGIN
            UPDATE Sanpham
            SET soluong = soluong + (@sln_new - @sln_old)
            WHERE masp = @masp
        END
    END
END

go
--Câu 6
CREATE TRIGGER trg_XoaNhap
ON Nhap
AFTER DELETE
AS
BEGIN
    DECLARE @masp nvarchar(10), @sln int
    SELECT @masp = masp, @sln = soluongN FROM deleted
    UPDATE Sanpham SET soluong = soluong - @sln WHERE masp = @masp
END