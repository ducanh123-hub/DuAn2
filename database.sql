-- SCRIPT KHỞI TẠO CƠ SỞ DỮ LIỆU HOTEL MANAGEMENT
-- Hệ quản trị cơ sở dữ liệu: SQL Server

USE master;
GO

-- 1. Xóa cơ sở dữ liệu cũ nếu đã tồn tại để tránh xung đột
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'HotelManagement')
BEGIN
    ALTER DATABASE HotelManagement SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE HotelManagement;
END
GO

-- 2. Tạo mới cơ sở dữ liệu
CREATE DATABASE HotelManagement;
GO

USE HotelManagement;
GO

-- ==========================================
-- 3. TẠO BẢNG HỆ THỐNG PHÂN QUYỀN & NGƯỜI DÙNG
-- ==========================================

-- Bảng Vai trò (Role)
CREATE TABLE Role (
    RoleID INT PRIMARY KEY IDENTITY(1,1),
    RoleName NVARCHAR(50) NOT NULL,
    Description NVARCHAR(255) NULL,
    Status NVARCHAR(50) DEFAULT 'Active'
);
GO

-- Bảng Người dùng (User)
CREATE TABLE [User] (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    RoleID INT NOT NULL,
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Phone NVARCHAR(20) NULL,
    Password NVARCHAR(255) NOT NULL,
    Gender NVARCHAR(10) NULL,
    Date DATE NULL,
    CCCD NVARCHAR(20) NULL,
    Address NVARCHAR(255) NULL,
    Nationality NVARCHAR(50) NULL,
    Status NVARCHAR(50) DEFAULT 'Active',
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (RoleID) REFERENCES Role(RoleID) ON DELETE CASCADE
);
GO

-- ==========================================
-- 4. TẠO BẢNG PHÒNG & LOẠI PHÒNG
-- ==========================================

-- Bảng Loại phòng (Room_Category)
CREATE TABLE Room_Category (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500) NULL,
    BasePrice DECIMAL(18,2) NOT NULL,
    MaxPeople INT DEFAULT 2,
    Status NVARCHAR(50) DEFAULT 'Available',
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO

-- Bảng Chi tiết phòng (Room)
CREATE TABLE Room (
    RoomID INT PRIMARY KEY IDENTITY(1,1),
    CategoryID INT NOT NULL,
    RoomNumber NVARCHAR(20) UNIQUE NOT NULL,
    RoomName NVARCHAR(100) NOT NULL,
    Price DECIMAL(18,2) NOT NULL,
    Acreage DECIMAL(10,2) NULL, -- Diện tích m2
    Bed INT DEFAULT 1,
    Area NVARCHAR(50) NULL, -- Vị trí/Khu vực phòng
    Description NVARCHAR(500) NULL,
    Status NVARCHAR(50) DEFAULT 'Available',
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CategoryID) REFERENCES Room_Category(CategoryID) ON DELETE CASCADE
);
GO

-- ==========================================
-- 5. TẠO BẢNG KHUYẾN MÃI & ĐẶT PHÒNG
-- ==========================================

-- Bảng Mã giảm giá (Voucher)
CREATE TABLE Voucher (
    VoucherID INT PRIMARY KEY IDENTITY(1,1),
    VoucherCode NVARCHAR(50) UNIQUE NOT NULL,
    VoucherName NVARCHAR(100) NOT NULL,
    DiscountType NVARCHAR(20) NOT NULL, -- 'Percentage' hoặc 'Amount'
    DiscountValue DECIMAL(18,2) NOT NULL,
    MaxDiscount DECIMAL(18,2) NULL,
    MinOrderValue DECIMAL(18,2) NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    Quantity INT DEFAULT 0,
    Status NVARCHAR(50) DEFAULT 'Active',
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO

-- Bảng Đơn đặt phòng (Booking)
CREATE TABLE Booking (
    BookingID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    RoomID INT NOT NULL,
    VoucherID INT NULL,
    BookingCode NVARCHAR(50) UNIQUE NOT NULL,
    CheckInDate DATE NOT NULL,
    CheckOutDate DATE NOT NULL,
    Adults INT DEFAULT 1,
    Children INT DEFAULT 0,
    RoomPrice DECIMAL(18,2) NOT NULL,
    ServicePrice DECIMAL(18,2) DEFAULT 0,
    DiscountAmount DECIMAL(18,2) DEFAULT 0,
    TotalAmount DECIMAL(18,2) NOT NULL,
    BookingStatus NVARCHAR(50) DEFAULT 'Pending', -- 'Pending', 'Confirmed', 'Cancelled'
    PaymentStatus NVARCHAR(50) DEFAULT 'Unpaid',   -- 'Paid', 'Unpaid'
    Note NVARCHAR(500) NULL,
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES [User](UserID),
    FOREIGN KEY (RoomID) REFERENCES Room(RoomID),
    FOREIGN KEY (VoucherID) REFERENCES Voucher(VoucherID)
);
GO

-- Bảng Chi tiết đơn đặt phòng (BookingDetail)
CREATE TABLE BookingDetail (
    BookingDetailID INT PRIMARY KEY IDENTITY(1,1),
    BookingID INT NOT NULL,
    RoomID INT NOT NULL,
    RoomPrice DECIMAL(18,2) NOT NULL,
    NumberOfNights INT NOT NULL,
    Subtotal DECIMAL(18,2) NOT NULL,
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID) ON DELETE CASCADE,
    FOREIGN KEY (RoomID) REFERENCES Room(RoomID)
);
GO


-- ==========================================
-- 6. CHÈN DỮ LIỆU MẪU (SEED DATA)
-- ==========================================

-- Chèn dữ liệu Vai trò (Role)
INSERT INTO Role (RoleName, Description, Status) VALUES 
('Admin', N'Quản trị viên hệ thống', 'Active'),
('Employee', N'Nhân viên khách sạn', 'Active'),
('Customer', N'Khách hàng đăng ký', 'Active');
GO

-- Chèn dữ liệu Người dùng (User)
-- Mật khẩu ở dạng văn bản thuần: '123456'
INSERT INTO [User] (RoleID, FullName, Email, Phone, Password, Gender, Date, CCCD, Address, Nationality, Status) VALUES 
(1, N'Nguyễn Văn Admin', 'admin@gmail.com', '0987654321', '123456', N'Nam', '1990-01-01', '012345678901', N'Hà Nội', N'Việt Nam', 'Active'),
(2, N'Trần Thị Nhân Viên', 'nhanvien@gmail.com', '0912345678', '123456', N'Nữ', '1995-05-15', '012345678902', N'Đà Nẵng', N'Việt Nam', 'Active'),
(3, N'Lê Minh Khách Hàng', 'customer@gmail.com', '0901234567', '123456', N'Nam', '2000-10-20', '012345678903', N'TP Hồ Chí Minh', N'Việt Nam', 'Active');
GO

-- Chèn dữ liệu Loại phòng (Room_Category)
INSERT INTO Room_Category (CategoryName, Description, BasePrice, MaxPeople, Status) VALUES 
(N'Standard (STD)', N'Phòng tiêu chuẩn ấm cúng, đầy đủ tiện nghi cơ bản', 500000, 2, 'Available'),
(N'Deluxe (DLX)', N'Phòng cao cấp, không gian rộng rãi hướng phố', 800000, 2, 'Available'),
(N'Suite (SUT)', N'Phòng tổng thống siêu sang trọng, dịch vụ cao cấp nhất', 1500000, 4, 'Available');
GO

-- Chèn dữ liệu Phòng (Room)
INSERT INTO Room (CategoryID, RoomNumber, RoomName, Price, Acreage, Bed, Area, Description, Status) VALUES 
(1, '101', N'Standard Room 101', 500000, 25.0, 1, N'Tầng 1', N'Phòng Standard giường đơn hướng vườn', 'Available'),
(1, '102', N'Standard Room 102', 500000, 25.0, 1, N'Tầng 1', N'Phòng Standard giường đơn hướng phố', 'Available'),
(2, '201', N'Deluxe City View 201', 800000, 35.0, 2, N'Tầng 2', N'Phòng Deluxe 2 giường đôi hướng thành phố', 'Available'),
(2, '202', N'Deluxe Garden View 202', 850000, 35.0, 2, N'Tầng 2', N'Phòng Deluxe 2 giường đôi hướng sân vườn', 'Available'),
(3, '301', N'Presidential Suite 301', 1500000, 60.0, 2, N'Tầng 3', N'Phòng Suite Tổng thống ban công toàn cảnh biển', 'Available');
GO

-- Chèn dữ liệu Mã giảm giá (Voucher)
INSERT INTO Voucher (VoucherCode, VoucherName, DiscountType, DiscountValue, MaxDiscount, MinOrderValue, StartDate, EndDate, Quantity, Status) VALUES 
('WELCOME2026', N'Khuyến mãi thành viên mới', 'Percentage', 10.0, 200000, 500000, '2026-01-01', '2026-12-31', 100, 'Active'),
('DISCOUNT100K', N'Giảm trực tiếp 100k', 'Amount', 100000, 100000, 800000, '2026-01-01', '2026-12-31', 50, 'Active');
GO

-- Chèn dữ liệu mẫu Đặt phòng (Booking)
INSERT INTO Booking (UserID, RoomID, VoucherID, BookingCode, CheckInDate, CheckOutDate, Adults, Children, RoomPrice, ServicePrice, DiscountAmount, TotalAmount, BookingStatus, PaymentStatus, Note) VALUES 
(3, 1, NULL, 'BK000001', '2026-08-10', '2026-08-12', 2, 0, 500000, 0, 0, 1000000, 'Pending', 'Unpaid', N'Khách đặt phòng Standard tầng 1 qua web');
GO

-- Chèn dữ liệu mẫu Chi tiết đặt phòng (BookingDetail)
INSERT INTO BookingDetail (BookingID, RoomID, RoomPrice, NumberOfNights, Subtotal) VALUES 
(1, 1, 500000, 2, 1000000);
GO

PRINT '========== DỮ LIỆU ĐÃ ĐƯỢC KHỞI TẠO THÀNH CÔNG ==========';
