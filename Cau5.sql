INSERT INTO NHANVIEN (MaNV, HoNV, TenNV, TenLot, NgSinh, DiaChi, Phai, Luong, Phong)
VALUES ('123', 'Đinh', 'Tiến', 'Bá', '1982-02-27', 'Mộ Đức', 'Nam', NULL, '4'),
('234', 'Nguyễn', 'Tùng', 'Thanh', '1956-08-12', 'Sơn Tịnh', 'Nam', NULL, '5'),
('345', 'Bùi', 'Vũ', 'Thúy', NULL, 'Tư Nghĩa', 'Nữ', NULL, '4'),
('456', 'Lê', 'Nhàn', 'Thị', '1962-07-12', 'Mộ Đức', 'Nữ', NULL, '4'),
('567', 'Nguyễn', 'Hùng', 'Mạnh', '1985-03-25', 'Sơn Tịnh', 'Nam', NULL, '5'),
('678', 'Trần', 'Quang', 'Hồng', NULL, 'Bình Sơn', 'Nam', NULL, '5'),
('789', 'Trần', 'Tâm', 'Thanh', '1972-06-17', 'Tp Quảng Ngãi', 'Nam', NULL, '5'),
('890', 'Cao', 'Huyền', 'Thanh', NULL, 'Tư Nghĩa', 'Nữ', NULL, '1'),
('901', 'Vương', 'Quyền', 'Ngọc', '1980-12-12', 'Mộ Đức', 'Nam', NULL, '1');


INSERT INTO PHONGBAN (MaPhg, TenPhg) VALUES (1, 'Quản lý');
INSERT INTO PHONGBAN (MaPhg, TenPhg) VALUES (4, 'Điều hành');
INSERT INTO PHONGBAN (MaPhg, TenPhg) VALUES (5, 'Nghiên cứu');



INSERT INTO DEAN (MaDA, TenDA, DDiemDA) VALUES (1, 'Nâng cao chất lượng muối Sa Huỳnh', '20');
INSERT INTO DEAN (MaDA, TenDA, DDiemDA) VALUES (10, 'Xây dựng nhà máy chế biến thủy sản Dung Quất', '15');
INSERT INTO DEAN (MaDA, TenDA, DDiemDA) VALUES (2, 'Phát triển hạ tầng mạng Tp Quảng Ngãi', '18');
INSERT INTO DEAN (MaDA, TenDA, DDiemDA) VALUES (20, 'Truyền tải cáp quang Tp Quảng Ngãi', '16');
INSERT INTO DEAN (MaDA, TenDA, DDiemDA) VALUES (3, 'Tin học hóa trường học Ba Tơ', '12');
INSERT INTO DEAN (MaDA, TenDA, DDiemDA) VALUES (30, 'Đào tạo nhân lực Tịnh Phong', '14');



INSERT INTO PHANCONG (MaNV, MaDA, ThoiGian)
VALUES 
(123, 1, 33),
(123, 2, 8),
(345, 10, 10),
(345, 20, 10),
(345, 3, 10),
(456, 1, 20),
(456, 2, 20),
(678, 3, 40),
(789, 10, 35),
(789, 20, 30),
(789, 30, 5);


INSERT INTO THANNHAN (MaNV, TenTN, NgaySinh, Phai, QuanHe)
VALUES 
(123, 'Châu', '2005-10-30', 'Nữ', 'Con gái'),
(123, 'Duy', '2001-10-25', 'Nam', 'Con trai'),
(123, 'Phương', '1985-10-30', 'Nữ', 'Vợ chồng'),
(234, 'Thanh', '1980-04-05', 'Nữ', 'Con gái'),
(345, 'Dương', '1956-10-30', 'Nam', 'Vợ chồng'),
(345, 'Khang', '1982-10-25', 'Nam', 'Con trai'),
(456, 'Hùng', '1987-01-01', 'Nam', 'Con trai'),
(901, 'Thương', '1989-04-05', 'Nữ', 'Vợ chồng');
