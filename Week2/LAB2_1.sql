--Câu 1
select * from Hangsx;
select * from Nhanvien;
select * from Nhap;
select * from SanPham;
select * from Xuat;

--Câu 2
SELECT sp.masp, sp.tensp, hs.tenhang, sp.soluong, sp.mausac, sp.giaban, sp.donvitinh, sp.mota
FROM Sanpham sp
JOIN Hangsx hs ON sp.mahangsx = hs.mahangsx;

--câu 3
SELECT masp, tensp, tenhang, soluong, mausac, giaban, donvitinh, mota
FROM Sanpham
INNER JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
WHERE Hangsx.tenhang = 'Samsung' AND soluong > 0;

--Câu 4
SELECT * FROM Nhanvien 
WHERE gioitinh = N'Nữ' AND phong = N'Kế toán';

--Câu 5
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
SELECT hdx.sohdx, sp.masp, sp.tensp, hsx.tenhang, hdx.soluongX, sp.giaban, (hdx.soluongX * sp.giaban) as tienxuat, sp.mausac, sp.donvitinh, hdx.ngayxuat, nv.tennv, nv.phong
FROM Xuat hdx
INNER JOIN SanPham sp ON hdx.masp = sp.masp
INNER JOIN Hangsx hsx ON sp.mahangsx = hsx.mahangsx
INNER JOIN NhanVien nv ON hdx.manv = nv.manv
WHERE MONTH(hdx.ngayxuat) = 10 AND YEAR(hdx.ngayxuat) = 2018
ORDER BY hdx.ngayxuat ASC;

--Câu 7
SELECT N.sohdn, N.masp, S.tensp, N.soluongN, N.dongiaN, N.ngaynhap, NV.tennv, NV.phong
FROM Nhap N
JOIN Sanpham S ON N.masp = S.masp
JOIN Nhanvien NV ON N.manv = NV.manv
JOIN Hangsx H ON S.mahangsx = H.mahangsx
WHERE YEAR(N.ngaynhap) = 2017 AND H.tenhang = 'Samsung';

--Câu 8
SELECT TOP 10 Xuat.sohdx, SanPham.tensp, Xuat.soluongX
FROM Xuat
INNER JOIN SanPham ON Xuat.masp = SanPham.masp
WHERE YEAR(Xuat.ngayxuat) = 2020
ORDER BY Xuat.soluongX DESC;

--Câu 9
SELECT TOP 10 SanPham.masp, SanPham.tensp, SanPham.giaban
FROM SanPham
ORDER BY SanPham.giaban DESC;

--Câu 10
SELECT Sanpham.masp, Sanpham.tensp, Sanpham.giaban, Sanpham.donvitinh, Hangsx.tenhang
FROM Sanpham
INNER JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
WHERE Hangsx.tenhang = 'Samsung' AND Sanpham.giaban >= 100000 AND Sanpham.giaban <= 500000;

--Câu 11
SELECT SUM(Nhap.soluongN * SanPham.giaban) AS TongTienNhap
FROM Nhap
JOIN SanPham ON Nhap.masp = SanPham.masp
JOIN Hangsx ON SanPham.mahangsx = Hangsx.mahangsx
WHERE Hangsx.tenhang = 'Samsung' AND YEAR(Nhap.ngaynhap) = 2018;

--Câu 12
SELECT SUM(Xuat.soluongX * SanPham.giaban) AS TongTienXuat
FROM Xuat
JOIN SanPham ON Xuat.masp = SanPham.masp
WHERE Xuat.ngayxuat = '2018-09-02'

--Câu 13
SELECT top 1 sohdn, ngaynhap
FROM Nhap
WHERE YEAR(ngaynhap) = 2018
ORDER BY soluongN * dongiaN DESC

--Câu 14
SELECT TOP 10 SanPham.tensp, SUM(Nhap.soluongN) AS TongSoLuongNhap
FROM Nhap
JOIN SanPham ON Nhap.masp = SanPham.masp
WHERE YEAR(Nhap.ngaynhap) = 2019
GROUP BY SanPham.tensp
ORDER BY SUM(Nhap.soluongN) DESC

--Câu 15
SELECT SanPham.masp, SanPham.tensp
FROM Nhap
JOIN SanPham ON Nhap.masp = SanPham.masp
JOIN Hangsx ON SanPham.mahangsx = Hangsx.mahangsx
JOIN NhanVien ON Nhap.manv = NhanVien.manv
WHERE Hangsx.tenhang = 'Samsung' AND NhanVien.manv = 'NV01'

--Câu 16
SELECT Nhap.sohdn, Nhap.masp, Nhap.soluongN, Nhap.ngaynhap
FROM Nhap
JOIN Xuat ON Nhap.masp = Xuat.masp AND Nhap.sohdn = Xuat.sohdx
WHERE Nhap.masp = 'SP02' AND Xuat.manv = 'NV02';

--Câu 17
SELECT Nhanvien.manv, Nhanvien.tennv
FROM Nhanvien
JOIN Xuat ON Nhanvien.manv = Xuat.manv
WHERE Xuat.masp = 'SP02' AND Xuat.ngayxuat = '2020-03-02';