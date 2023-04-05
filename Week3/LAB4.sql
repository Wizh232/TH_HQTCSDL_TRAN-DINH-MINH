--Cau 1
CREATE VIEW vwhangsx AS
select * from Hangsx;
 

CREATE VIEW vwnhanvien AS
select * from Nhanvien;
 

CREATE VIEW vwnhap AS
select * from Nhap;
 

CREATE VIEW vwsanpham AS
select * from SanPham;
 

CREATE VIEW vwxuat AS
select * from Xuat;
 

--Câu 2
CREATE VIEW cau2_lab2_1 AS
SELECT sp.masp, sp.tensp, hs.tenhang, sp.soluong, sp.mausac, sp.giaban, sp.donvitinh, sp.mota
FROM Sanpham sp
JOIN Hangsx hs ON sp.mahangsx = hs.mahangsx;

 

--Cau 3
CREATE VIEW cau3_lab2_1 AS
SELECT masp, tensp, tenhang, soluong, mausac, giaban, donvitinh, mota
FROM Sanpham
INNER JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
WHERE Hangsx.tenhang = 'Samsung' AND soluong > 0;
 


--Câu 4
CREATE VIEW cau4_lab2_1 AS
SELECT * FROM Nhanvien 
WHERE gioitinh = N'N?' AND phong = N'K? toán';
 
--Câu 5
CREATE VIEW cau5_lab2_1 AS
SELECT np.sohdn, sp.masp,
	sp.tensp, hsx.tenhang,
	np.soluongN, np.dongiaN,
	np.soluongN * np.dongiaN as tiennhap,
	sp.mausac, sp.donvitinh, np.ngaynhap,
	nv.tennv, nv.phong
	FROM Nhap np
	INNER JOIN Sanpham sp ON np.masp = sp.masp
	INNER JOIN Hangsx hsx ON sp.mahangsx = hsx.mahangsx
	INNER JOIN Nhanvien nv ON np.manv = nv.manv
	ORDER BY tiennhap ASC;
 

--Câu 6
CREATE VIEW cau6_lab2_1 AS
SELECT hdx.sohdx, sp.masp, sp.tensp, hsx.tenhang, hdx.soluongX, sp.giaban, (hdx.soluongX * sp.giaban) as tienxuat, sp.mausac, sp.donvitinh, hdx.ngayxuat, nv.tennv, nv.phong
FROM Xuat hdx
INNER JOIN SanPham sp ON hdx.masp = sp.masp
INNER JOIN Hangsx hsx ON sp.mahangsx = hsx.mahangsx
INNER JOIN NhanVien nv ON hdx.manv = nv.manv
WHERE MONTH(hdx.ngayxuat) = 6 AND YEAR(hdx.ngayxuat) = 2020
ORDER BY hdx.ngayxuat ASC
OFFSET 0 ROWS;
 
--Câu 7
CREATE VIEW cau7_lab2_1 AS
SELECT N.sohdn, N.masp, S.tensp, N.soluongN, N.dongiaN, N.ngaynhap, NV.tennv, NV.phong
FROM Nhap N
JOIN Sanpham S ON N.masp = S.masp
JOIN Nhanvien NV ON N.manv = NV.manv
JOIN Hangsx H ON S.mahangsx = H.mahangsx
WHERE YEAR(N.ngaynhap) = 2020 AND H.tenhang = 'Samsung';
 
--Câu 8
CREATE VIEW cau8_lab2_1 AS
SELECT TOP 10 Xuat.sohdx, SanPham.tensp, Xuat.soluongX
FROM Xuat
INNER JOIN SanPham ON Xuat.masp = SanPham.masp
WHERE YEAR(Xuat.ngayxuat) = 2020
ORDER BY Xuat.soluongX DESC;
 
--Câu 9
CREATE VIEW cau9_lab2_1 AS
SELECT TOP 10 SanPham.masp, SanPham.tensp, SanPham.giaban
FROM SanPham
ORDER BY SanPham.giaban DESC;
 

--Câu 10
CREATE VIEW cau10_lab2_1 AS
SELECT Sanpham.masp, Sanpham.tensp, Sanpham.giaban, Sanpham.donvitinh, Hangsx.tenhang
FROM Sanpham
INNER JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
WHERE Hangsx.tenhang = 'Samsung' AND Sanpham.giaban >= 100000 AND Sanpham.giaban <= 500000;
 
--Câu 11
CREATE VIEW cau11_lab2_1 AS
SELECT SUM(Nhap.soluongN * SanPham.giaban) AS TongTienNhap
FROM Nhap
JOIN SanPham ON Nhap.masp = SanPham.masp
JOIN Hangsx ON SanPham.mahangsx = Hangsx.mahangsx
WHERE Hangsx.tenhang = 'Samsung' AND YEAR(Nhap.ngaynhap) = 2020;
 
--Câu 12
CREATE VIEW cau12_lab2_1 AS
SELECT SUM(Xuat.soluongX * SanPham.giaban) AS TongTienXuat
FROM Xuat
JOIN SanPham ON Xuat.masp = SanPham.masp
WHERE Xuat.ngayxuat = '2020-06-14'
 
--Câu 13
CREATE VIEW cau13_lab2_1 AS
SELECT top 1 sohdn, ngaynhap
FROM Nhap
WHERE YEAR(ngaynhap) = 2020
ORDER BY soluongN * dongiaN DESC
 
--Câu 14
CREATE VIEW cau14_lab2_1 AS
SELECT TOP 10 SanPham.tensp, SUM(Nhap.soluongN) AS TongSoLuongNhap
FROM Nhap
JOIN SanPham ON Nhap.masp = SanPham.masp
WHERE YEAR(Nhap.ngaynhap) = 2019
GROUP BY SanPham.tensp
ORDER BY SUM(Nhap.soluongN) DESC
 
--Câu 15
CREATE VIEW cau15_lab2_1 AS
SELECT SanPham.masp, SanPham.tensp
FROM Nhap
JOIN SanPham ON Nhap.masp = SanPham.masp
JOIN Hangsx ON SanPham.mahangsx = Hangsx.mahangsx
JOIN NhanVien ON Nhap.manv = NhanVien.manv
WHERE Hangsx.tenhang = 'Samsung' AND NhanVien.manv = 'NV01'
 
--Câu 16
CREATE VIEW cau16_lab2_1 AS
SELECT Nhap.sohdn, Nhap.masp, Nhap.soluongN, Nhap.ngaynhap
FROM Nhap
JOIN Xuat ON Nhap.masp = Xuat.masp AND Nhap.sohdn = Xuat.sohdx
WHERE Nhap.masp = 'SP02' AND Xuat.manv = 'NV02';
 
--Câu 17
CREATE VIEW cau17_lab2_1 AS
SELECT Nhanvien.manv, Nhanvien.tennv
FROM Nhanvien
JOIN Xuat ON Nhanvien.manv = Xuat.manv
WHERE Xuat.masp = 'SP02' AND Xuat.ngayxuat = '2020-03-02';
 

--Câu 18
CREATE VIEW cau18_lab2_2 AS
SELECT hsx.tenhang, COUNT(sp.masp) AS N'SoLoaiSP'
FROM Sanpham sp
INNER JOIN Hangsx hsx ON sp.mahangsx = hsx.mahangsx
GROUP BY hsx.tenhang
 

--Câu 19
CREATE VIEW cau19_lab2_2 AS
SELECT sp.masp, sp.tensp, SUM(np.soluongN * np.dongiaN) AS tongtien
FROM Nhap np
INNER JOIN Sanpham sp ON np.masp = sp.masp
WHERE YEAR(np.ngaynhap) = 2018
GROUP BY sp.masp, sp.tensp
 

--Câu 20
CREATE VIEW cau20_lab2_2 AS
SELECT TOP 100 sp.masp, sp.tensp, SUM(x.soluongX) AS TongSoLuongXuat
FROM SanPham sp
INNER JOIN Xuat x ON sp.masp = x.masp
INNER JOIN Hangsx hsx ON sp.mahangsx = hsx.mahangsx
WHERE YEAR(x.ngayxuat) = 2018 AND hsx.tenhang = 'Samsung'
GROUP BY sp.masp, sp.tensp
HAVING SUM(x.soluongX) > 10000
ORDER BY TongSoLuongXuat DESC
 
--Câu 21
CREATE VIEW cau21_lab2_2 AS
SELECT phong, COUNT(*) AS soluong_nam
FROM NhanVien 
WHERE gioitinh = N'Nam'
GROUP BY phong
 

--Câu 22
CREATE VIEW cau22_lab2_2 AS
SELECT hsx.tenhang, SUM(np.soluongN) AS tong_soluong_nhap
FROM Hangsx hsx JOIN Sanpham sp ON hsx.mahangsx = sp.mahangsx
		   JOIN Nhap np ON sp.masp = np.masp
WHERE YEAR(np.ngaynhap) = 2018
GROUP BY hsx.tenhang
 

--Câu 23
CREATE VIEW cau23_lab2_2 AS
SELECT nv.manv, nv.tennv, SUM(soluongX * giaban) AS tong_tien_xuat
FROM Xuat x
JOIN SanPham sp ON x.masp = sp.masp
JOIN NhanVien nv ON x.manv = nv.manv
WHERE YEAR(ngayxuat) = 2018
GROUP BY nv.manv, nv.tennv
 

--Câu 24
CREATE VIEW cau24_lab2_2 AS
SELECT manv, SUM(soluongN*dongiaN) as TongTienNhap
FROM Nhap 
WHERE MONTH(ngaynhap) = 8 AND YEAR(ngaynhap) = 2018
GROUP BY manv
HAVING SUM(soluongN*dongiaN) > 100000
 


--Câu 25
CREATE VIEW cau25_lab2_2 AS
SELECT *
FROM SanPham
WHERE masp NOT IN (
  SELECT masp
  FROM Xuat
)
 

--Câu 26
CREATE VIEW cau26_lab2_2 AS
SELECT sp.*
FROM SanPham sp
INNER JOIN Xuat x ON sp.masp = x.masp
WHERE YEAR(sp.mota) = 2018 AND YEAR(x.ngayxuat) = 2018
 

--Câu 27
CREATE VIEW cau27_lab2_2 AS
SELECT nv.tennv 
FROM Nhap np JOIN Xuat x ON np.manv = x.manv
JOIN Nhanvien nv ON np.manv = nv.manv
GROUP BY nv.manv, NV.tennv
 



--Câu 28
CREATE VIEW cau28_lab2_2 AS
SELECT tennv
FROM Nhap np JOIN Xuat x ON np.manv = x.manv JOIN Nhanvien nv ON np.manv = nv.manv
WHERE np.manv NOT IN (SELECT DISTINCT manv FROM Nhap)
AND x.manv NOT IN (SELECT DISTINCT manv FROM Xuat)
GROUP BY nv.manv, NV.tennv

 

