CREATE DATABASE QUANLYDIEM;
GO

USE QUANLYDIEM;
GO

CREATE TABLE LOPHOC ( 
	MALOP CHAR(5) PRIMARY KEY,
	TENLOP NVARCHAR(100),
	TONGSO INT);
GO

CREATE TABLE SINHVIEN (
	MASV CHAR(5) PRIMARY KEY,
	TENSV NVARCHAR(100),
	NGAYSINH DATE,
	GIOITINH NVARCHAR(5),
	MALOP CHAR(5) REFERENCES LOPHOC(MALOP)
	); 
GO

CREATE TABLE MONHOC (
	MAMH CHAR(5) PRIMARY KEY,
	TENMH NVARCHAR(100),
	SOTC INT);
GO

CREATE TABLE DIEM (
	MASV CHAR(5) REFERENCES SINHVIEN(MASV),
	MAMH CHAR(5) REFERENCES MONHOC(MAMH),
	DIEM DECIMAL(4,2),
	CONSTRAINT PK_DIEM PRIMARY KEY (MASV, MAMH));
GO

INSERT INTO LOPHOC VALUES 
('L01', N'CÔNG NGHỆ THÔNG TIN',40),
('L02', N'KẾ TOÁN', 35),
('L03', N'QUẢN TRỊ KINH DOANH', 45),
('L04', N'TÀI CHÍNH NGÂN HÀNG', 30);

DELETE LOPHOC;
GO
SELECT * FROM LOPHOC;
INSERT INTO SINHVIEN (MASV, TENSV, NGAYSINH, GIOITINH,MALOP) VALUES
('SV01', N'Nguyễn Văn An', '2003-05-10', N'Nam', 'L01'),
('SV02', N'Trần Thị Bình', '2002-08-15', N'Nữ', 'L01'),
('SV03', N'Lê Văn Cường', '2001-12-20', N'Nam', 'L02'),
('SV04', N'Phạm Thị Dung', '2004-03-25', N'Nữ', 'L02'),
('SV05', N'Hoàng Văn Em', '2000-07-30', N'Nam', 'L03'),
('SV06', N'Nguyễn Thị Hà', '2003-03-12', N'Nữ', 'L03'),
('SV07', N'Trần Văn Hùng', '2002-11-05', N'Nam', 'L01'),
('SV08', N'Lê Thị Lan', '2001-06-18', N'Nữ', 'L04');
GO
SELECT * FROM SINHVIEN;

INSERT INTO MONHOC VALUES
('MH01', N'Cơ sở dữ liệu', 3),
('MH02', N'Lập trình SQL', 3),
('MH03', N'Khoa học dữ liệu', 4),
('MH04', N'Toán cao cấp', 3),
('MH05', N'Kinh tế vi mô', 2);

INSERT INTO DIEM VALUES
('SV01', 'MH01', 8.5),
('SV01', 'MH02', 9.0),
('SV01', 'MH03', 7.5),
('SV01', 'MH04', 6.5),

('SV02', 'MH01', 7.0),
('SV02', 'MH02', 8.0),
('SV02', 'MH03', 9.0),

('SV03', 'MH01', 5.5),
('SV03', 'MH02', 6.0),
('SV03', 'MH04', 7.0),

('SV04', 'MH01', 9.0),
('SV04', 'MH02', 8.5),
('SV04', 'MH03', 9.5),

('SV05', 'MH01', 4.0),
('SV05', 'MH02', 5.0),
('SV05', 'MH05', 6.0),

('SV06', 'MH01', 8.0),
('SV06', 'MH03', 8.5),
('SV06', 'MH04', 9.0),

('SV07', 'MH01', 6.0),
('SV07', 'MH02', 7.0),
('SV07', 'MH03', 5.0),

('SV08', 'MH01', 9.5),
('SV08', 'MH04', 8.0);

ALTER TABLE SINHVIEN
ADD CONSTRAINT FK_SINHVIEN_LOPHOC
FOREIGN KEY (MALOP) REFERENCES LOPHOC(MALOP);
GO

ALTER TABLE DIEM
ADD CONSTRAINT FK_DIEM_SINHVIEN
FOREIGN KEY (MASV) REFERENCES SINHVIEN (MASV);
GO

ALTER TABLE DIEM
ADD CONSTRAINT FK_DIEM_MONHOC
FOREIGN KEY (MAMH) REFERENCES MONHOC (MAMH);
GO
--DANG 1
--1. Liệt kê toàn bộ thông tin của các sinh viên trong bảng SINHVIEN.
SELECT * FROM SINHVIEN;
--2.Liệt kê mã sinh viên, họ tên và ngày sinh của tất cả sinh viên. 
SELECT MASV, TENSV, NGAYSINH FROM SINHVIEN;
--3.Liệt kê danh sách các mã lớp không trùng nhau mà sinh viên đang theo học. 
SELECT DISTINCT MALOP FROM SINHVIEN;
--4. Liệt kê danh sách các môn học, chỉ hiển thị tên môn học và số tín chỉ. 
SELECT TENMH, SOTC
FROM MONHOC;
--5.Hiển thị 3 sinh viên đầu tiên trong bảng SINHVIEN bằng TOP. 
SELECT TOP 3 * FROM SINHVIEN;
--6.Liệt kê 5 sinh viên có ngày sinh gần đây nhất. 
SELECT TOP 5 * 
FROM SINHVIEN
ORDER BY NGAYSINH DESC;

--DANG 2. WHERE – AND – OR – NOT 
--7. Tìm danh sách sinh viên thuộc lớp L01.
SELECT * 
FROM SINHVIEN
WHERE MALOP = 'L01';
--8.Tìm các sinh viên có giới tính Nam. 
SELECT * 
FROM SINHVIEN
WHERE GIOITINH = 'Nam';
--9.tìm các sinh viên nữ thuộc lớp L01. 
select *
FROM SINHVIEN
WHERE GIOITINH = N'Nữ' AND MALOP = 'L01';
--10.  Tìm các sinh viên nam hoặc sinh viên thuộc lớp L02.
SELECT *
FROM SINHVIEN
WHERE GIOITINH = 'Nam' OR MALOP = 'L02';
--11. Tìm các sinh viên không thuộc lớp L01.
SELECT *
FROM SINHVIEN
WHERE MALOP != 'L01';
--12.  Tìm sinh viên có ngày sinh trước ngày 01/01/2003.
SELECT * 
FROM SINHVIEN
WHERE NGAYSINH < '2003-01-01';
--13.  Tìm sinh viên nữ sinh trong năm 2003.
SELECT * 
FROM SINHVIEN
WHERE GIOITINH = N'Nữ' AND YEAR(NGAYSINH) = 2003;
--14.Tìm sinh viên thuộc lớp L01 hoặc L03, đồng thời có giới tính Nam.
SELECT *
FROM SINHVIEN 
WHERE MALOP IN ('L01', 'L03') AND GIOITINH = 'Nam';

--DANG 3
--15 
SELECT *
FROM SINHVIEN
ORDER BY NGAYSINH ASC;
--16
SELECT *
FROM SINHVIEN
ORDER BY NGAYSINH DESC;
--17
SELECT *
FROM SINHVIEN
WHERE YEAR(NGAYSINH) BETWEEN 2001 AND 2003;
--18
SELECT * 
FROM SINHVIEN 
WHERE MALOP IN ('L01', 'L02', 'L04');
--19
SELECT *
FROM MONHOC
WHERE SOTC BETWEEN 3 AND 4;
--20
SELECT *
FROM SINHVIEN
ORDER BY TENSV ASC;

--DANG 4
--21
SELECT *
FROM SINHVIEN
WHERE TENSV LIKE N'Nguyễn %';
--22
SELECT *
FROM SINHVIEN
WHERE TENSV LIKE N'% Lan';
--23
SELECT *
FROM SINHVIEN
WHERE TENSV LIKE N'%Văn%';
--24
SELECT *
FROM SINHVIEN
WHERE TENSV LIKE 'T%' OR TENSV LIKE 'L%';
--25
SELECT *
FROM SINHVIEN
WHERE TENSV NOT IN
	(SELECT TENSV FROM SINHVIEN WHERE TENSV LIKE N' Nguyễn%');

--PHAN III
--DANG 5
--26
SELECT COUNT (*) AS SOLUONGSV
FROM SINHVIEN;
--27
SELECT SUM(SOTC) AS TONGSOTINCHI
FROM MONHOC;
--28
SELECT MAX(DIEM) AS DIEMCAONHAT, MIN(DIEM) AS DIEMTHAPNHAT
FROM DIEM;
--29.Tính điểm trung bình của toàn bộ các lượt đánh giá môn học.
SELECT AVG(DIEM) AS DIEMTBTOANBO
FROM DIEM;
--30. Đếm số lượng sinh viên nam và số lượng sinh viên nữ. 
SELECT 
	COUNT (CASE WHEN GIOITINH = 'Nam' THEN 1 END) AS SLSVNAM,
	COUNT (CASE WHEN GIOITINH = N'Nữ' THEN 1 END) AS SLSVNU
FROM SINHVIEN;

--Dạng 6. GROUP BY – HAVING 
--31. Thống kê số lượng sinh viên theo từng lớp.
SELECT MALOP, COUNT(MASV) AS SOLUONGSV
FROM SINHVIEN
GROUP BY MALOP;
--32. Thống kê số lượng sinh viên theo giới tính. 
SELECT GIOITINH, COUNT(MASV) AS SOLUONG
FROM SINHVIEN
GROUP BY GIOITINH;
--33. Tính điểm trung bình của từng sinh viên. 
SELECT S.TENSV, ROUND(AVG(D.DIEM*1.0),2) AS DIEMTB
FROM SINHVIEN S
JOIN DIEM D ON D.MASV = S.MASV
GROUP BY S.TENSV;
--34. Tính điểm trung bình của từng môn học. 
SELECT M.TENMH, AVG(D.DIEM) AS DIEMTBMON
FROM MONHOC M
JOIN DIEM D ON D.MAMH = M.MAMH
GROUP BY M.TENMH;
--35. Liệt kê các môn học có từ 5 sinh viên trở lên có điểm. 
SELECT M.TENMH, COUNT(DISTINCT D.MASV) AS SOLUONGSV
FROM MONHOC M
JOIN DIEM D ON D.MAMH=M.MAMH
WHERE D.DIEM IS NOT NULL --LOAI BO NHUNG DONG CHUA CO DIEM
GROUP BY M.TENMH 
HAVING COUNT(DISTINCT D.MASV)>=5;
--36. Liệt kê những lớp có số lượng sinh viên lớn hơn 2. 
SELECT L.TENLOP, COUNT(MASV) AS SOLUONGSV
FROM LOPHOC L
JOIN SINHVIEN S ON S.MALOP=L.MALOP
GROUP BY L.TENLOP
HAVING COUNT(S.MASV)>2;
--37. Tìm các sinh viên có điểm trung bình lớn hơn 7.5.
SELECT S.MASV, S.TENSV, AVG(DIEM) AS DIEMTB
FROM SINHVIEN S
JOIN DIEM D ON D.MASV=S.MASV
GROUP BY S.MASV, S.TENSV
HAVING AVG(DIEM) > 7.5;
--38. Tìm các môn học có điểm trung bình lớn hơn 7. 
SELECT M.TENMH, AVG(D.DIEM) AS DIEMTBMON
FROM MONHOC M
JOIN DIEM D ON D.MAMH=M.MAMH
GROUP BY M.TENMH
HAVING AVG(D.DIEM) > 7;
--39. Thống kê số lượng sinh viên đạt điểm từ 8 trở lên theo từng môn học.
SELECT M.TENMH, COUNT(D.MASV) AS SOLUONGSV
FROM DIEM D
JOIN MONHOC M ON M.MAMH = D.MAMH
WHERE D.DIEM >=8
GROUP BY M.TENMH;
--40. Tìm những lớp có số lượng sinh viên nam lớn hơn 1. 
SELECT L.TENLOP, COUNT(S.MASV) AS SOLUONGSVNAM
FROM LOPHOC L
JOIN SINHVIEN S ON S.MALOP=L.MALOP
WHERE S.GIOITINH = 'Nam'
GROUP BY L.TENLOP
HAVING COUNT(S.MASV) > 1;

--PHẦN IV. TRUY VẤN NHIỀU BẢNG – JOIN 
--Dạng 7. INNER JOIN
--41. Liệt kê mã sinh viên, họ tên và tên lớp của từng sinh viên. 
SELECT S.MASV, S.TENSV, L.TENLOP
FROM SINHVIEN S
JOIN LOPHOC L ON L.MALOP=S.MALOP;
--42. Liệt kê mã sinh viên, họ tên, tên môn học và điểm số của sinh viên. 
SELECT S.MASV, S.TENSV, M.TENMH, D.DIEM
FROM SINHVIEN S
JOIN DIEM D ON D.MASV=S.MASV
JOIN MONHOC M ON M.MAMH=D.MAMH;
--43. Liệt kê thông tin sinh viên gồm mã sinh viên, họ tên, tên lớp, tên môn học và điểm số. 
SELECT S.MASV, S.TENSV, L.TENLOP, M.TENMH, D.DIEM
FROM SINHVIEN S
JOIN DIEM D ON D.MASV = S.MASV
JOIN LOPHOC L ON L.MALOP = S.MALOP
JOIN MONHOC M ON M.MAMH = D.MAMH;
--44. Tìm danh sách sinh viên có điểm môn Cơ sở dữ liệu lớn hơn hoặc bằng 8.
SELECT S.TENSV, M.TENMH, D.DIEM
FROM SINHVIEN S
JOIN DIEM D ON D.MASV = S.MASV
JOIN MONHOC M ON D.MAMH = M.MAMH
WHERE M.TENMH = N'Cơ sở dữ liệu' OR D.DIEM >=8;
--45. Liệt kê sinh viên học môn Lập trình SQL và có điểm từ 7 trở lên. 
SELECT S.TENSV, M.TENMH, D.DIEM
FROM SINHVIEN S
JOIN DIEM D ON D.MASV = S.MASV
JOIN MONHOC M ON D.MAMH = M.MAMH
WHERE M.TENMH = N'Lập trình SQL' AND D.DIEM >=7;
--46. Liệt kê họ tên sinh viên, tên môn học và điểm, sắp xếp theo điểm giảm dần. 
SELECT S.TENSV, M.TENMH, D.DIEM
FROM SINHVIEN S
JOIN DIEM D ON D.MASV=S.MASV
JOIN MONHOC M ON M.MAMH=D.MAMH
ORDER BY DIEM DESC;
--47. Tìm điểm trung bình của từng sinh viên, kèm theo họ tên và tên lớp.
SELECT S.TENSV, AVG(D.DIEM) AS DIEMTRUNGBINH, L.TENLOP
FROM SINHVIEN S
JOIN DIEM D ON D.MASV=S.MASV
JOIN LOPHOC L ON L.MALOP=S.MALOP
GROUP BY S.TENSV, L.TENLOP;
--48. Tính điểm trung bình của từng lớp.
SELECT L.TENLOP, AVG(D.DIEM) AS DIEMTBLOP
FROM LOPHOC L
JOIN SINHVIEN S ON S.MALOP=L.MALOP
JOIN DIEM D ON D.MASV = S.MASV
GROUP BY L.TENLOP;

--PHẦN V. TRUY VẤN CON – SUBQUERY
--Dạng 8. IN – NOT IN
--49. Tìm danh sách sinh viên thuộc lớp có tên là Công nghệ thông tin bằng truy vấn CON
SELECT *
FROM SINHVIEN
WHERE MALOP IN (
	SELECT MALOP
	FROM LOPHOC
	WHERE TENLOP = N'Công nghệ thông tin');
--50. Tìm danh sách sinh viên không thuộc lớp Công nghệ thông tin bằng NOT IN. 
SELECT *
FROM SINHVIEN
WHERE MALOP NOT IN (
	SELECT MALOP
	FROM LOPHOC
	WHERE TENLOP = N'Công nghệ thông tin');
--51. Tìm sinh viên đã có ít nhất một môn học được ghi nhận điểm.
SELECT *
FROM SINHVIEN
WHERE MASV IN (
	SELECT MASV 
	FROM DIEM);
--52. Tìm sinh viên chưa có điểm ở bất kỳ môn học nào.
SELECT *
FROM SINHVIEN
WHERE MASV NOT IN (
	SELECT MASV 
	FROM DIEM);
--53. Tìm sinh viên có điểm môn Cơ sở dữ liệu lớn hơn 8.
SELECT *
FROM SINHVIEN
WHERE MASV IN (
	SELECT MASV
	FROM DIEM D
	JOIN MONHOC M ON M.MAMH=D.MAMH
	WHERE M.TENMH = N'Cơ sở dữ liệu' AND D.DIEM > 8);
--54. Tìm sinh viên có điểm cao nhất trong bảng DIEM.
SELECT * 
FROM SINHVIEN S
JOIN DIEM D ON S.MASV=D.MASV
WHERE D.DIEM IN (
	SELECT MAX(DIEM)
	FROM DIEM);

--Dạng 9. SOME – ANY – ALL 
--55. Tìm các sinh viên có điểm cao hơn ít nhất một điểm số trong môn Toán cao CAP
SELECT *
FROM SINHVIEN S
JOIN DIEM D ON D.MASV=S.MASV
WHERE D.DIEM > SOME (
	SELECT DIEM
	FROM DIEM
	JOIN MONHOC ON MONHOC.MAMH=DIEM.MAMH
	WHERE MONHOC.TENMH = N'Toán cao cấp');
--56. Tìm các sinh viên có điểm cao hơn tất cả điểm số của môn Kinh tế vi mô. 
SELECT *
FROM SINHVIEN S
JOIN DIEM D ON D.MASV=S.MASV
WHERE D.DIEM > ALL (
	SELECT DIEM
	FROM DIEM
	JOIN MONHOC ON MONHOC.MAMH=DIEM.MAMH
	WHERE MONHOC.TENMH = N'Kinh tế vi mô');
--57. Tìm các sinh viên có điểm bằng điểm cao nhất trong bảng DIEM bằng ALL. 
SELECT * 
FROM SINHVIEN S
JOIN DIEM D ON S.MASV = D.MASV
WHERE D.DIEM >= ALL (SELECT DIEM FROM DIEM);
--58. Tìm những sinh viên có điểm môn Cơ sở dữ liệu cao hơn ít nhất một sinh viên thuộc lớp L02.
SELECT *
FROM SINHVIEN S
JOIN DIEM D ON D.MASV=S.MASV
JOIN MONHOC M ON M.MAMH=D.MAMH
WHERE M.TENMH = N'Cơ sở dữ liệu'AND D.DIEM > ANY (
	SELECT DIEM
	FROM DIEM D
	JOIN SINHVIEN S ON S.MASV = D.MASV
	JOIN MONHOC M ON M.MAMH=D.MAMH
	WHERE S.MALOP = 'L02' AND M.TENMH = N'Cơ sở dữ liệu');
--59. Tìm những sinh viên có điểm môn Cơ sở dữ liệu cao hơn tất cả sinh viên thuộc lớp L02.
SELECT *
FROM SINHVIEN S
JOIN DIEM D ON D.MASV=S.MASV
JOIN MONHOC M ON M.MAMH=D.MAMH
WHERE M.TENMH = N'Cơ sở dữ liệu'AND D.DIEM > ALL (
	SELECT DIEM
	FROM DIEM D
	JOIN SINHVIEN S ON S.MASV = D.MASV
	JOIN MONHOC M ON M.MAMH=D.MAMH
	WHERE S.MALOP = 'L02' AND M.TENMH = N'Cơ sở dữ liệu');
--Dạng 10. EXISTS
--60. Tìm các lớp học có ít nhất một sinh viên. 
SELECT *
FROM LOPHOC L
JOIN SINHVIEN S ON S.MALOP = L.MALOP
WHERE EXISTS (SELECT 1 FROM SINHVIEN WHERE S.MALOP = L.MALOP);
--61. Tìm các lớp học chưa có sinh viên nào.
SELECT *
FROM LOPHOC L
JOIN SINHVIEN S ON S.MALOP = L.MALOP
WHERE NOT EXISTS (SELECT 1 FROM SINHVIEN WHERE S.MALOP = L.MALOP);
--62. Tìm các sinh viên có ít nhất một môn học đạt điểm từ 9 trở lên.
SELECT *
FROM SINHVIEN S
WHERE EXISTS 
(SELECT 1 FROM DIEM D WHERE D.MASV = S.MASV AND D.DIEM >=9);
--63. Tìm các sinh viên đã học môn Cơ sở dữ liệu.
SELECT *
FROM SINHVIEN S
WHERE EXISTS 
(SELECT 1 
FROM DIEM D 
JOIN MONHOC M ON M.MAMH=D.MAMH
WHERE D.MASV = S.MASV AND M.TENMH=N'Cơ sở dữ liệu');
--64. Tìm các môn học có ít nhất một sinh viên đạt điểm dưới 5. 
SELECT *
FROM MONHOC M
WHERE EXISTS (
	SELECT 1 
	FROM DIEM D 
	WHERE D.DIEM <5 AND D.MAMH = M.MAMH);

--PHẦN VI. TRUY VẤN TẬP HỢP
--Dạng 11. EXCEPT – INTERSECT
--65. Liệt kê mã sinh viên đã có điểm bằng INTERSECT.
SELECT MASV
FROM SINHVIEN
INTERSECT
SELECT MASV FROM DIEM;
--66. Liệt kê mã sinh viên chưa có điểm bằng EXCEPT. 
SELECT MASV
FROM SINHVIEN
EXCEPT
SELECT MASV FROM DIEM;
--67. Tìm sinh viên đã học cả môn Cơ sở dữ liệu và môn Lập trình SQL bằng INTERSECT.
SELECT S.MASV
FROM SINHVIEN S
JOIN DIEM D ON D.MASV=S.MASV
JOIN MONHOC M ON M.MAMH = D.MAMH
WHERE M.TENMH = N'Cơ sở dữ liệu'

INTERSECT

SELECT S.MASV
FROM SINHVIEN S
JOIN DIEM D ON D.MASV=S.MASV
JOIN MONHOC M ON M.MAMH = D.MAMH
WHERE M.TENMH = N'Lập trình SQL';
--68. Tìm sinh viên đã học môn Cơ sở dữ liệu nhưng chưa học môn Khoa học dữ liệu bằng EXCEPT.
SELECT S.MASV
FROM SINHVIEN S
JOIN DIEM D ON D.MASV=S.MASV
JOIN MONHOC M ON M.MAMH = D.MAMH
WHERE M.TENMH = N'Cơ sở dữ liệu'

EXCEPT

SELECT S.MASV
FROM SINHVIEN S
JOIN DIEM D ON D.MASV=S.MASV
JOIN MONHOC M ON M.MAMH = D.MAMH
WHERE M.TENMH = N'Khoa học dữ liệu';

--PHẦN VII.   TẬP TỔNG HỢP
--70. Liệt kê danh sách sinh viên có điểm trung bình từ 8 trở lên, bao gồm mã sinh viên, họ tên, tên lớp và điểm trung bình. 
SELECT S.MASV, S.TENSV, AVG(D.DIEM) AS DIEMTB
FROM SINHVIEN S
JOIN DIEM D ON D.MASV = S.MASV
GROUP BY S.MASV, S.TENSV
HAVING AVG(D.DIEM) >=8;
--71. Tìm sinh viên có điểm trung bình cao nhất trong toàn trường.
SELECT S.TENSV, AVG(D.DIEM) AS DIEMTB
FROM SINHVIEN S
JOIN DIEM D ON D.MASV=S.MASV
GROUP BY S.TENSV
HAVING AVG(D.DIEM) >= ALL (SELECT AVG(DIEM) FROM DIEM GROUP BY MASV);
--72. Tìm môn học có điểm trung bình cao nhất. 
SELECT M.MAMH, M.TENMH, AVG(D.DIEM) AS DIEMTB
FROM MONHOC M
JOIN DIEM D ON D.MAMH=M.MAMH
GROUP BY M.MAMH, M.TENMH
HAVING AVG(D.DIEM) >= ALL (SELECT AVG(DIEM) FROM DIEM GROUP BY MAMH);
--73. Tìm những sinh viên có điểm tất cả các môn đã học đều từ 5 trở lên.
SELECT S.TENSV
FROM SINHVIEN S
JOIN DIEM D ON D.MASV=S.MASV
GROUP BY S.TENSV
HAVING MIN(D.DIEM) >= 5;
--74. Tìm những sinh viên có ít nhất một môn học bị điểm dưới 5.
SELECT S.TENSV
FROM SINHVIEN S
WHERE EXISTS (
	SELECT 1
	FROM DIEM D
	WHERE D.MASV = S.MASV AND D.DIEM < 5);
--75. Tìm sinh viên học nhiều môn nhất.
SELECT S.TENSV, COUNT(M.TENMH) AS SOMONHOC
FROM SINHVIEN S
JOIN DIEM D ON D.MASV=S.MASV
JOIN MONHOC M ON M.MAMH=D.MAMH
GROUP BY S.TENSV
HAVING COUNT(M.MAMH) >= ALL (
	SELECT COUNT(MAMH) 
	FROM DIEM
	GROUP BY MASV
	);
--76. Thống kê số sinh viên tham gia học từng môn, sắp xếp theo số lượng giảm dần. 
SELECT M.TENMH, COUNT(D.MASV) AS SOLUONGSV
FROM MONHOC M
LEFT JOIN DIEM D ON D.MAMH = M.MAMH
GROUP BY M.TENMH
ORDER BY SOLUONGSV DESC;
--77. Tìm lớp có điểm trung bình cao nhất.
SELECT TOP 1 WITH TIES L.MALOP, L.TENLOP, AVG(D.DIEM) AS DIEMTBLOP
FROM LOPHOC L
JOIN SINHVIEN S ON S.MALOP = L.MALOP
JOIN DIEM D ON D.MASV = S.MASV
GROUP BY L.MALOP, L.TENLOP
ORDER BY DIEMTBLOP DESC;
--78. Liệt kê những sinh viên chưa học môn Khoa học dữ liệu.
SELECT MASV, TENSV
FROM SINHVIEN 

EXCEPT 

SELECT S.MASV, S.TENSV
FROM SINHVIEN S
JOIN DIEM D ON D.MASV = S.MASV
JOIN MONHOC M ON M.MAMH = D.MAMH
WHERE M.TENMH = N'Khoa học dữ liệu';
--79. Tìm những sinh viên có điểm trung bình cao hơn điểm trung bình chung của toàn bộ sinh viên. 
SELECT S.MASV, S.TENSV, AVG(D.DIEM) AS DIEMTB
FROM SINHVIEN S
JOIN DIEM D ON D.MASV = S.MASV
GROUP BY S.MASV, S.TENSV
HAVING AVG(D.DIEM) > (
	SELECT AVG(DIEM)
	FROM DIEM)
--80. Liệt kê danh sách sinh viên có điểm cao nhất ở từng môn học, bao gồm mã sinh viên, họ tên, tên môn học và điểm.
SELECT S.MASV, S.TENSV, M.TENMH, D1.DIEM
FROM MONHOC M
JOIN DIEM D1 ON D1.MAMH = M.MAMH
JOIN SINHVIEN S ON S.MASV = D1.MASV
WHERE  D1.DIEM >= ALL (
	SELECT MAX(D2.DIEM) AS DIEMCAONHAT
	FROM MONHOC M
	JOIN DIEM D2 ON D2.MAMH = D1.MAMH
	)
ORDER BY S.MASV;








SELECT * FROM DIEM;
SELECT * FROM SINHVIEN;
SELECT * FROM LOPHOC;