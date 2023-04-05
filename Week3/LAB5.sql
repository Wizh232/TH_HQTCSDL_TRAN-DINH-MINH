--Câu 3
CREATE FUNCTION cau3_lab5(@TenSanPham NVARCHAR(255), @Nam INT)
RETURNS INT
AS
BEGIN
    DECLARE @TongSoLuong INT;
    SELECT @TongSoLuong = SUM(soluongN) - SUM(soluongX)
    FROM Nhap n
    INNER JOIN Xuat x ON n.masp = x.masp
    INNER JOIN Sanpham sp ON n.masp = sp.masp
    WHERE sp.tensp = @TenSanPham AND YEAR(n.ngaynhap) = @Nam AND YEAR(x.ngayxuat) = @Nam;
    RETURN @TongSoLuong;
END;

DECLARE @KetQua INT;
EXEC @KetQua = cau3_lab5 'F3 lite', 2020;
SELECT @KetQua AS 'Tổng số lượng thay đổi';
