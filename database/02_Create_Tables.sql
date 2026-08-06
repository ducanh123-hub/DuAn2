CREATE TABLE Role(
                     RoleID INT IDENTITY(1,1) PRIMARY KEY,
                     RoleName NVARCHAR(50) NOT NULL UNIQUE,
                     Description NVARCHAR(255),
                     Status NVARCHAR(20) DEFAULT N'Active'
);

CREATE TABLE Permission(
                           PermissionID INT IDENTITY(1,1) PRIMARY KEY,
                           PermissionName NVARCHAR(100) NOT NULL,
                           PermissionCode VARCHAR(100) NOT NULL UNIQUE,
                           Description NVARCHAR(255),
                           Status NVARCHAR(20) DEFAULT N'Active'
);

CREATE TABLE Role_Permission(
                                RoleID INT NOT NULL,
                                PermissionID INT NOT NULL,
                                PRIMARY KEY(RoleID, PermissionID),
                                FOREIGN KEY(RoleID) REFERENCES Role(RoleID),
                                FOREIGN KEY(PermissionID) REFERENCES Permission(PermissionID)
);

CREATE TABLE [User](
                       UserID INT IDENTITY(1,1) PRIMARY KEY,
    RoleID INT NOT NULL,
    FullName NVARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(20),
    Password VARCHAR(255) NOT NULL,
    Gender NVARCHAR(10),
    Date DATE,
    CCCD VARCHAR(20),
    Address NVARCHAR(255),
    Nationality NVARCHAR(50),
    Status NVARCHAR(20) DEFAULT N'Active',
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME,
    FOREIGN KEY(RoleID) REFERENCES Role(RoleID)
    );

CREATE TABLE Room_Category(
                              CategoryID INT IDENTITY(1,1) PRIMARY KEY,
                              CategoryName NVARCHAR(100) NOT NULL UNIQUE,
                              Description NVARCHAR(500),
                              BasePrice DECIMAL(18,2) NOT NULL,
                              MaxPeople INT NOT NULL,
                              Status NVARCHAR(20) DEFAULT N'Active',
                              CreatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE Room(
                     RoomID INT IDENTITY(1,1) PRIMARY KEY,
                     CategoryID INT NOT NULL,
                     RoomNumber VARCHAR(20) NOT NULL UNIQUE,
                     RoomName NVARCHAR(100) NOT NULL,
                     Price DECIMAL(18,2) NOT NULL,
                     Acreage DECIMAL(10,2),
                     Bed INT,
                     Area NVARCHAR(100),
                     Description NVARCHAR(1000),
                     Status NVARCHAR(30) DEFAULT N'Còn trống',
                     CreatedAt DATETIME DEFAULT GETDATE(),
                     UpdatedAt DATETIME,
                     FOREIGN KEY(CategoryID) REFERENCES Room_Category(CategoryID)
);

CREATE TABLE Room_Image(
                           ImageID INT IDENTITY(1,1) PRIMARY KEY,
                           RoomID INT NOT NULL,
                           ImageURL VARCHAR(500) NOT NULL,
                           IsMain BIT DEFAULT 0,
                           SortOrder INT DEFAULT 1,
                           FOREIGN KEY(RoomID) REFERENCES Room(RoomID)
);

CREATE TABLE Service_Category(
                                 ServiceCategoryID INT IDENTITY(1,1) PRIMARY KEY,
                                 CategoryName NVARCHAR(100) NOT NULL UNIQUE,
                                 Description NVARCHAR(255),
                                 Status NVARCHAR(20) DEFAULT N'Active'
);

CREATE TABLE Service(
                        ServiceID INT IDENTITY(1,1) PRIMARY KEY,
                        ServiceCategoryID INT NOT NULL,
                        ServiceName NVARCHAR(100) NOT NULL,
                        Description NVARCHAR(500),
                        Price DECIMAL(18,2) NOT NULL,
                        Status NVARCHAR(20) DEFAULT N'Active',
                        FOREIGN KEY(ServiceCategoryID) REFERENCES Service_Category(ServiceCategoryID)
);

CREATE TABLE Voucher(
                        PromotionID INT IDENTITY(1,1) PRIMARY KEY,
                        Code VARCHAR(50) NOT NULL UNIQUE,
                        Name NVARCHAR(100) NOT NULL,
                        Description NVARCHAR(500),
                        DiscountType NVARCHAR(20) NOT NULL,
                        DiscountValue DECIMAL(18,2) NOT NULL,
                        MinOrderAmount DECIMAL(18,2) DEFAULT 0,
                        MaxDiscountAmount DECIMAL(18,2),
                        UsageLimit INT,
                        UsedCount INT DEFAULT 0,
                        StartDate DATE NOT NULL,
                        EndDate DATE NOT NULL,
                        Status NVARCHAR(20) DEFAULT N'Active',
                        CreatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE System_Setting(
                               SettingID INT IDENTITY(1,1) PRIMARY KEY,
                               HotelName NVARCHAR(200),
                               Address NVARCHAR(500),
                               Phone VARCHAR(20),
                               Email VARCHAR(100),
                               CheckinTime TIME,
                               CheckoutTime TIME,
                               CancelPolicy NVARCHAR(2000),
                               PaymentMethods NVARCHAR(500),
                               OtherSetting NVARCHAR(2000),
                               UpdatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE Booking(
                        BookingID INT IDENTITY(1,1) PRIMARY KEY,
                        UserID INT NOT NULL,
                        VoucherID INT NULL,
                        BookingCode VARCHAR(30) NOT NULL UNIQUE,
                        BookingDate DATETIME DEFAULT GETDATE(),
                        CheckinDate DATE NOT NULL,
                        CheckoutDate DATE NOT NULL,
                        GuestCount INT NOT NULL,
                        TotalAmount DECIMAL(18,2) DEFAULT 0,
                        DiscountAmount DECIMAL(18,2) DEFAULT 0,
                        FinalAmount DECIMAL(18,2) DEFAULT 0,
                        CancelReason NVARCHAR(500),
                        CancelDate DATETIME,
                        Status NVARCHAR(40) DEFAULT N'Chờ xác nhận',
                        Note NVARCHAR(1000),
                        CreatedAt DATETIME DEFAULT GETDATE(),
                        UpdatedAt DATETIME,
                        FOREIGN KEY(UserID) REFERENCES [User](UserID),
                        FOREIGN KEY(VoucherID) REFERENCES Voucher(PromotionID)
);

CREATE TABLE Booking_Detail(
                               DetailID INT IDENTITY(1,1) PRIMARY KEY,
                               BookingID INT NOT NULL,
                               RoomID INT NOT NULL,
                               Price DECIMAL(18,2) NOT NULL,
                               Quantity INT NOT NULL DEFAULT 1,
                               Discount DECIMAL(18,2) DEFAULT 0,
                               TotalPrice DECIMAL(18,2) NOT NULL,
                               FOREIGN KEY(BookingID) REFERENCES Booking(BookingID),
                               FOREIGN KEY(RoomID) REFERENCES Room(RoomID)
);

CREATE TABLE Service_Usage(
                              UsageID INT IDENTITY(1,1) PRIMARY KEY,
                              BookingID INT NOT NULL,
                              ServiceID INT NOT NULL,
                              Quantity INT NOT NULL DEFAULT 1,
                              UnitPrice DECIMAL(18,2) NOT NULL,
                              TotalPrice DECIMAL(18,2) NOT NULL,
                              Note NVARCHAR(500),
                              FOREIGN KEY(BookingID) REFERENCES Booking(BookingID),
                              FOREIGN KEY(ServiceID) REFERENCES Service(ServiceID)
);

CREATE TABLE Payment(
                        PaymentID INT IDENTITY(1,1) PRIMARY KEY,
                        BookingID INT NOT NULL,
                        Method NVARCHAR(50) NOT NULL,
                        Amount DECIMAL(18,2) NOT NULL,
                        PaidAmount DECIMAL(18,2) DEFAULT 0,
                        PaymentDate DATETIME DEFAULT GETDATE(),
                        Status NVARCHAR(30) DEFAULT N'Chờ thanh toán',
                        TransactionCode VARCHAR(100),
                        RefundAmount DECIMAL(18,2) DEFAULT 0,
                        Refunda BIT DEFAULT 0,
                        Approved BIT DEFAULT 0,
                        RefundReason NVARCHAR(500),
                        Note NVARCHAR(500),
                        FOREIGN KEY(BookingID) REFERENCES Booking(BookingID)
);

CREATE TABLE Invoice(
                        InvoiceID INT IDENTITY(1,1) PRIMARY KEY,
                        BookingID INT NOT NULL,
                        InvoiceCode VARCHAR(50) NOT NULL UNIQUE,
                        InvoiceDate DATETIME DEFAULT GETDATE(),
                        TotalRoom DECIMAL(18,2) DEFAULT 0,
                        Tax DECIMAL(18,2) DEFAULT 0,
                        Discount DECIMAL(18,2) DEFAULT 0,
                        TotalAmount DECIMAL(18,2) DEFAULT 0,
                        PaidAmount DECIMAL(18,2) DEFAULT 0,
                        DueAmount DECIMAL(18,2) DEFAULT 0,
                        Status NVARCHAR(30) DEFAULT N'Chưa thanh toán',
                        EmployeeID INT NULL,
                        CreatedAt DATETIME DEFAULT GETDATE(),
                        FOREIGN KEY(BookingID) REFERENCES Booking(BookingID),
                        FOREIGN KEY(EmployeeID) REFERENCES [User](UserID)
);

CREATE TABLE Review(
                       ReviewID INT IDENTITY(1,1) PRIMARY KEY,
                       UserID INT NOT NULL,
                       RoomID INT NOT NULL,
                       BookingID INT NOT NULL,
                       Rating INT NOT NULL,
                       Comment NVARCHAR(1000),
                       Reply NVARCHAR(1000),
                       ReplyAt DATETIME,
                       Status NVARCHAR(30) DEFAULT N'Chờ duyệt',
                       CreatedAt DATETIME DEFAULT GETDATE(),
                       FOREIGN KEY(UserID) REFERENCES [User](UserID),
                       FOREIGN KEY(RoomID) REFERENCES Room(RoomID),
                       FOREIGN KEY(BookingID) REFERENCES Booking(BookingID),
                       CHECK(Rating BETWEEN 1 AND 5)
);

CREATE TABLE Room_Favorite(
                              FavoriteID INT IDENTITY(1,1) PRIMARY KEY,
                              UserID INT NOT NULL,
                              RoomID INT NOT NULL,
                              CreatedAt DATETIME DEFAULT GETDATE(),
                              UNIQUE(UserID, RoomID),
                              FOREIGN KEY(UserID) REFERENCES [User](UserID),
                              FOREIGN KEY(RoomID) REFERENCES Room(RoomID)
);

CREATE TABLE Notification(
                             NotifyID INT IDENTITY(1,1) PRIMARY KEY,
                             UserID INT NOT NULL,
                             Title NVARCHAR(200) NOT NULL,
                             Content NVARCHAR(1000),
                             Type NVARCHAR(50),
                             IsRead BIT DEFAULT 0,
                             CreatedAt DATETIME DEFAULT GETDATE(),
                             FOREIGN KEY(UserID) REFERENCES [User](UserID)
);

CREATE TABLE Contact(
                        ContactID INT IDENTITY(1,1) PRIMARY KEY,
                        UserID INT NULL,
                        Subject NVARCHAR(200),
                        Content NVARCHAR(2000) NOT NULL,
                        Status NVARCHAR(30) DEFAULT N'Chưa xử lý',
                        CreatedAt DATETIME DEFAULT GETDATE(),
                        FOREIGN KEY(UserID) REFERENCES [User](UserID)
);

CREATE TABLE System_Log(
                           LogID INT IDENTITY(1,1) PRIMARY KEY,
                           UserID INT NULL,
                           Action NVARCHAR(100) NOT NULL,
                           Description NVARCHAR(1000),
                           IpAddress VARCHAR(50),
                           CreatedAt DATETIME DEFAULT GETDATE(),
                           FOREIGN KEY(UserID) REFERENCES [User](UserID)
);
GO