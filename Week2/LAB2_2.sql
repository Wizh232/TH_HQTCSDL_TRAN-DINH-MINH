--Câu 1
SELECT Hangsx.tenhang, COUNT(SanPham.masp) AS SoLuongSanPham
FROM Hangsx
LEFT JOIN SanPham ON Hangsx.mahangsx = SanPham.mahangsx
GROUP BY Hangsx.tenhang

--Câu 2
SELECT SanPham.tensp, SUM(Nhap.soluongN * Nhap.dongiaN) AS TongTienNhap
FROM SanPham
INNER JOIN Nhap ON SanPham.masp = Nhap.masp
WHERE YEAR(Nhap.ngaynhap) = 2018
GROUP BY SanPham.tensp
ORDER BY TongTienNhap DESC

--Câu3
SELECT SanPham.masp, SanPham.tensp, SUM(Xuat.soluongX) AS TongSoLuongXuat
FROM SanPham
INNER JOIN Xuat ON SanPham.masp = Xuat.masp
INNER JOIN Hangsx ON SanPham.mahangsx = Hangsx.mahangsx
WHERE YEAR(Xuat.ngayxuat) = 2018 AND Hangsx.tenhang = 'Samsung'
GROUP BY SanPham.masp, SanPham.tensp
HAVING SUM(Xuat.soluongX) > 10000
ORDER BY TongSoLuongXuat DESC

--Câu 4
SELECT phong, COUNT(*) AS soluong_nam
FROM NhanVien
WHERE gioitinh = N'Nam'
GROUP BY phong

--Câu 5
SELECT Hangsx.tenhang, SUM(Nhap.soluongN) AS tong_soluong_nhap
FROM Hangsx JOIN SanPham ON Hangsx.mahangsx = SanPham.mahangsx
             JOIN Nhap ON SanPham.masp = Nhap.masp
WHERE YEAR(Nhap.ngaynhap) = 2018
GROUP BY Hangsx.tenhang


--Câu 6
SELECT Nhanvien.manv, tennv, SUM(soluongX * giaban) AS tong_tien_xuat
FROM Xuat
JOIN SanPham ON Xuat.masp = SanPham.masp
JOIN NhanVien ON Xuat.manv = NhanVien.manv
WHERE YEAR(ngayxuat) = 2018
GROUP BY Nhanvien.manv, tennv

--Câu 7
SELECT manv, SUM(soluongN*dongiaN) as TongTienNhap
FROM Nhap
WHERE MONTH(ngaynhap) = 8 AND YEAR(ngaynhap) = 2018
GROUP BY manv
HAVING SUM(soluongN*dongiaN) > 100000

--Câu 8
SELECT *
FROM SanPham
WHERE masp NOT IN (
  SELECT masp
  FROM Xuat
)

--Câu 9
SELECT sp.*
FROM SanPham sp
INNER JOIN Xuat hd ON sp.masp = hd.masp
WHERE YEAR(sp.mota) = 2018 AND YEAR(hd.ngayxuat) = 2018

--Câu 10
SELECT DISTINCT manv, tennv
FROM (
  SELECT manv, tennv, 'Nhap' AS HoatDong
  FROM Nhap
  JOIN NhanVien ON Nhap.manv = NhanVien.manv
  UNION
  SELECT manv, tennv, 'Xuat' AS HoatDong
  FROM Xuat
  JOIN NhanVien ON Xuat.manv = NhanVien.manv
) AS HoatDongNhanVien
ORDER BY manv

--Câu 11
SELECT nv.manv, nv.tennv, nv.phong
FROM Nhanvien nv
LEFT JOIN Nhap n ON nv.manv = n.manv
LEFT JOIN Xuat x ON nv.manv = x.manv
WHERE n.manv IS NULL AND x.manv IS NULL