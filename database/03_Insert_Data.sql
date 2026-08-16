INSERT INTO Role(RoleName,Description,Status) VALUES
                                                  (N'Quản lý',N'Quản lý toàn bộ hệ thống',N'Active'),
                                                  (N'Nhân viên',N'Nhân viên khách sạn',N'Active'),
                                                  (N'Khách hàng',N'Khách hàng đặt phòng',N'Active');

INSERT INTO Permission(PermissionName,PermissionCode,Description,Status) VALUES
                                                                             (N'Xem phòng','ROOM_VIEW',N'Xem danh sách và chi tiết phòng',N'Active'),
                                                                             (N'Quản lý phòng','ROOM_MANAGE',N'Thêm sửa xóa phòng',N'Active'),
                                                                             (N'Quản lý đặt phòng','BOOKING_MANAGE',N'Quản lý đơn đặt phòng',N'Active'),
                                                                             (N'Quản lý người dùng','USER_MANAGE',N'Quản lý tài khoản',N'Active'),
                                                                             (N'Quản lý thanh toán','PAYMENT_MANAGE',N'Quản lý thanh toán',N'Active'),
                                                                             (N'Quản lý khuyến mãi','VOUCHER_MANAGE',N'Quản lý voucher',N'Active'),
                                                                             (N'Quản lý đánh giá','REVIEW_MANAGE',N'Quản lý đánh giá',N'Active'),
                                                                             (N'Quản lý hệ thống','SYSTEM_MANAGE',N'Cấu hình hệ thống',N'Active'),
                                                                             (N'Xem báo cáo','REPORT_VIEW',N'Thống kê báo cáo',N'Active');

INSERT INTO Role_Permission(RoleID,PermissionID) VALUES
                                                     (1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(1,9),
                                                     (2,1),(2,3),(2,5),(2,7),
                                                     (3,1);

INSERT INTO [User] (RoleID, FullName, Email, Phone, Password, Gender, Date, CCCD, Address, Nationality, Status, OTPCode, OTPExpiredAt)
VALUES
    (1, N'Nguyễn Văn Quản Lý', 'admin@luxuryhotel.com', '0901000001', '123456', N'Nam', '1990-01-15', '001090000001', N'Hà Nội', N'Việt Nam', 'Active', NULL, NULL),
    (2, N'Trần Thị Nhân Viên', 'staff@luxuryhotel.com', '0901000002', '123456', N'Nữ', '1998-05-20', '001098000002', N'Hà Nội', N'Việt Nam', 'Active', NULL, NULL),
    (3, N'Nguyễn Văn An', 'an@gmail.com', '0901000003', '123456', N'Nam', '2000-03-10', '001100000003', N'Hà Nội', N'Việt Nam', 'Active', NULL, NULL),
    (3, N'Trần Thị Bình', 'binh@gmail.com', '0901000004', '123456', N'Nữ', '2001-07-25', '001101000004', N'Hải Phòng', N'Việt Nam', 'Active', NULL, NULL),
    (3, N'Lê Văn Cường', 'cuong@gmail.com', '0901000005', '123456', N'Nam', '1999-11-12', '001099000005', N'Đà Nẵng', N'Việt Nam', 'Active', NULL, NULL),
    (3, N'Phạm Thị Dung', 'dung@gmail.com', '0901000006', '123456', N'Nữ', '2002-02-18', '001102000006', N'TP. Hồ Chí Minh', N'Việt Nam', 'Pending', '123456', DATEADD(MINUTE, 5, GETDATE()));

INSERT INTO Room_Category(CategoryName,Description,BasePrice,MaxPeople,Status) VALUES
                                                                                   (N'Standard',N'Phòng tiêu chuẩn',500000,2,N'Active'),
                                                                                   (N'Deluxe',N'Phòng cao cấp',800000,3,N'Active'),
                                                                                   (N'Suite',N'Phòng Suite',1200000,4,N'Active'),
                                                                                   (N'Family',N'Phòng gia đình',1500000,6,N'Active');

INSERT INTO Room(CategoryID,RoomNumber,RoomName,Price,Acreage,Bed,Area,Description,Status) VALUES
                                                                                               (1,'101',N'Standard 101',500000,25,1,N'Tầng 1',N'Phòng tiêu chuẩn, đầy đủ tiện nghi cơ bản',N'Còn trống'),
                                                                                               (1,'102',N'Standard 102',500000,25,1,N'Tầng 1',N'Phòng tiêu chuẩn, đầy đủ tiện nghi cơ bản',N'Còn trống'),
                                                                                               (1,'103',N'Standard 103',500000,25,1,N'Tầng 1',N'Phòng tiêu chuẩn, đầy đủ tiện nghi cơ bản',N'Còn trống'),
                                                                                               (1,'104',N'Standard 104',500000,25,1,N'Tầng 1',N'Phòng tiêu chuẩn, đầy đủ tiện nghi cơ bản',N'Còn trống'),
                                                                                               (1,'105',N'Standard 105',500000,25,1,N'Tầng 1',N'Phòng tiêu chuẩn, đầy đủ tiện nghi cơ bản',N'Còn trống'),
                                                                                               (1,'106',N'Standard 106',500000,25,1,N'Tầng 1',N'Phòng tiêu chuẩn, đầy đủ tiện nghi cơ bản',N'Còn trống'),
                                                                                               (2,'201',N'Deluxe 201',800000,35,2,N'Tầng 2',N'Phòng Deluxe rộng rãi, tiện nghi đầy đủ',N'Còn trống'),
                                                                                               (2,'202',N'Deluxe 202',800000,35,2,N'Tầng 2',N'Phòng Deluxe rộng rãi, tiện nghi đầy đủ',N'Còn trống'),
                                                                                               (2,'203',N'Deluxe 203',800000,35,2,N'Tầng 2',N'Phòng Deluxe rộng rãi, tiện nghi đầy đủ',N'Còn trống'),
                                                                                               (2,'204',N'Deluxe 204',800000,35,2,N'Tầng 2',N'Phòng Deluxe rộng rãi, tiện nghi đầy đủ',N'Còn trống'),
                                                                                               (2,'205',N'Deluxe 205',800000,35,2,N'Tầng 2',N'Phòng Deluxe rộng rãi, tiện nghi đầy đủ',N'Còn trống'),
                                                                                               (2,'206',N'Deluxe 206',800000,35,2,N'Tầng 2',N'Phòng Deluxe rộng rãi, tiện nghi đầy đủ',N'Còn trống'),
                                                                                               (2,'207',N'Deluxe 207',800000,35,2,N'Tầng 2',N'Phòng Deluxe rộng rãi, tiện nghi đầy đủ',N'Còn trống'),
                                                                                               (2,'208',N'Deluxe 208',800000,35,2,N'Tầng 2',N'Phòng Deluxe rộng rãi, tiện nghi đầy đủ',N'Còn trống'),
                                                                                               (3,'301',N'Suite 301',1200000,50,2,N'Tầng 3',N'Phòng Suite cao cấp',N'Còn trống'),
                                                                                               (3,'302',N'Suite 302',1200000,50,2,N'Tầng 3',N'Phòng Suite cao cấp',N'Còn trống'),
                                                                                               (3,'303',N'Suite 303',1200000,50,2,N'Tầng 3',N'Phòng Suite cao cấp',N'Còn trống'),
                                                                                               (3,'304',N'Suite 304',1200000,50,2,N'Tầng 3',N'Phòng Suite cao cấp',N'Còn trống'),
                                                                                               (3,'305',N'Suite 305',1200000,50,2,N'Tầng 3',N'Phòng Suite cao cấp',N'Còn trống'),
                                                                                               (3,'306',N'Suite 306',1200000,50,2,N'Tầng 3',N'Phòng Suite cao cấp',N'Còn trống'),
                                                                                               (3,'307',N'Suite 307',1200000,50,2,N'Tầng 3',N'Phòng Suite cao cấp',N'Còn trống'),
                                                                                               (4,'401',N'Family 401',1500000,60,3,N'Tầng 4',N'Phòng Family rộng rãi, thiết kế hiện đại, phù hợp cho gia đình hoặc nhóm bạn. Không gian thoáng mát, đầy đủ tiện nghi, mang đến trải nghiệm nghỉ dưỡng thoải mái.',N'Còn trống'),
                                                                                               (4,'402',N'Family 402',1500000,60,3,N'Tầng 4',N'Phòng Family rộng rãi, thiết kế hiện đại, phù hợp cho gia đình hoặc nhóm bạn. Không gian thoáng mát, đầy đủ tiện nghi, mang đến trải nghiệm nghỉ dưỡng thoải mái.',N'Còn trống'),
                                                                                               (4,'403',N'Family 403',1500000,60,3,N'Tầng 4',N'Phòng Family rộng rãi, thiết kế hiện đại, phù hợp cho gia đình hoặc nhóm bạn. Không gian thoáng mát, đầy đủ tiện nghi, mang đến trải nghiệm nghỉ dưỡng thoải mái.',N'Còn trống'),
                                                                                               (4,'404',N'Family 404',1500000,60,3,N'Tầng 4',N'Phòng Family rộng rãi, thiết kế hiện đại, phù hợp cho gia đình hoặc nhóm bạn. Không gian thoáng mát, đầy đủ tiện nghi, mang đến trải nghiệm nghỉ dưỡng thoải mái.',N'Còn trống'),
                                                                                               (4,'405',N'Family 405',1500000,60,3,N'Tầng 4',N'Phòng Family rộng rãi, thiết kế hiện đại, phù hợp cho gia đình hoặc nhóm bạn. Không gian thoáng mát, đầy đủ tiện nghi, mang đến trải nghiệm nghỉ dưỡng thoải mái.',N'Còn trống'),
                                                                                               (4,'406',N'Family 406',1500000,60,3,N'Tầng 4',N'Phòng Family rộng rãi, thiết kế hiện đại, phù hợp cho gia đình hoặc nhóm bạn. Không gian thoáng mát, đầy đủ tiện nghi, mang đến trải nghiệm nghỉ dưỡng thoải mái.',N'Còn trống'),
                                                                                               (4,'407',N'Family 407',1500000,60,3,N'Tầng 4',N'Phòng Family rộng rãi, thiết kế hiện đại, phù hợp cho gia đình hoặc nhóm bạn. Không gian thoáng mát, đầy đủ tiện nghi, mang đến trải nghiệm nghỉ dưỡng thoải mái.',N'Còn trống');
GO
INSERT INTO Room_Image(RoomID,ImageURL,IsMain,SortOrder) VALUES
(1,'/images/room101-1.jpg',1,1),
(1,'/images/room101-2.jpg',0,2),
(2,'/images/room102-1.jpg',1,1),
(3,'/images/room201-1.jpg',1,1),
(3,'/images/room201-2.jpg',0,2),
(4,'/images/room202-1.jpg',1,1),
(5,'/images/room301-1.jpg',1,1),
(6,'/images/room401-1.jpg',1,1);

INSERT INTO Service_Category(CategoryName,Description,Status) VALUES
                                                                  (N'Ăn uống',N'Dịch vụ ăn uống',N'Active'),
                                                                  (N'Giặt ủi',N'Dịch vụ giặt ủi',N'Active'),
                                                                  (N'Khác',N'Dịch vụ khác',N'Active');

INSERT INTO Room_Image(RoomID,ImageURL,IsMain,SortOrder) VALUES
                                                             (1,'/images/room101-1.jpg',1,1),
                                                             (1,'/images/room101-2.jpg',0,2),
                                                             (2,'/images/room102-1.jpg',1,1),
                                                             (3,'/images/room201-1.jpg',1,1),
                                                             (3,'/images/room201-2.jpg',0,2),
                                                             (4,'/images/room202-1.jpg',1,1),
                                                             (5,'/images/room301-1.jpg',1,1),
                                                             (6,'/images/room401-1.jpg',1,1);

INSERT INTO Service(ServiceCategoryID,ServiceName,Description,Price,Status) VALUES
                                                                                (1,N'Bữa sáng',N'Bữa sáng tại khách sạn',100000,N'Active'),
                                                                                (1,N'Nước uống',N'Nước uống',30000,N'Active'),
                                                                                (2,N'Giặt quần áo',N'Dịch vụ giặt quần áo',50000,N'Active'),
                                                                                (3,N'Đưa đón sân bay',N'Dịch vụ đưa đón',300000,N'Active');

INSERT INTO Voucher(Code,Name,Description,DiscountType,DiscountValue,MinOrderAmount,MaxDiscountAmount,UsageLimit,UsedCount,StartDate,EndDate,Status) VALUES
                                                                                                                                                         ('WELCOME10',N'Giảm 10%',N'Khuyến mãi khách hàng mới',N'Percent',10,500000,300000,100,0,'2026-01-01','2026-12-31',N'Active'),
                                                                                                                                                         ('SUMMER20',N'Giảm 20%',N'Khuyến mãi mùa hè',N'Percent',20,1000000,500000,100,0,'2026-05-01','2026-08-31',N'Active');

INSERT INTO System_Setting(HotelName,Address,Phone,Email,CheckinTime,CheckoutTime,CancelPolicy,PaymentMethods,OtherSetting) VALUES
    (N'Hotel Management',N'Hà Nam, Việt Nam','0900000000','hotel@gmail.com','14:00','12:00',
     N'Hủy trước 24 giờ hoàn 100%; hủy trong 3 ngày hoàn 50%; quá 3 ngày không hoàn tiền',
     N'Tiền mặt, Chuyển khoản, Thanh toán tại quầy',
     N'Banner: Chào mừng đến khách sạn; Tiện nghi: WiFi, Điều hòa, TV, Tủ lạnh; Bản đồ: Hà Nam');

INSERT INTO Booking(UserID,VoucherID,BookingCode,BookingDate,CheckinDate,CheckoutDate,GuestCount,TotalAmount,DiscountAmount,FinalAmount,Status,Note) VALUES
    (3,1,'BK20260001','2026-08-04 10:00:00','2026-08-10','2026-08-12',2,1000000,100000,900000,N'Chờ xác nhận',N'Phòng tầng thấp');

INSERT INTO Booking_Detail(BookingID,RoomID,Price,Quantity,Discount,TotalPrice) VALUES
    (1,1,500000,2,0,1000000);

INSERT INTO Service_Usage(BookingID,ServiceID,Quantity,UnitPrice,TotalPrice,Note) VALUES
    (1,1,2,100000,200000,N'Bữa sáng 2 ngày');

INSERT INTO Payment(BookingID,Method,Amount,PaidAmount,PaymentDate,Status,TransactionCode,RefundAmount,Refunda,Approved,RefundReason,Note) VALUES
    (1,N'Tiền mặt',900000,0,'2026-08-04 10:05:00',N'Chờ thanh toán',NULL,0,0,0,NULL,N'Thanh toán tại quầy');

INSERT INTO Invoice(BookingID,InvoiceCode,InvoiceDate,TotalRoom,Tax,Discount,TotalAmount,PaidAmount,DueAmount,Status,EmployeeID) VALUES
    (1,'INV20260001','2026-08-04 10:10:00',1000000,0,100000,900000,0,900000,N'Chưa thanh toán',2);

INSERT INTO Review(UserID,RoomID,BookingID,Rating,Comment,Reply,ReplyAt,Status) VALUES
    (3,1,1,5,N'Phòng sạch sẽ, dịch vụ tốt',NULL,NULL,N'Chờ duyệt');

INSERT INTO Room_Favorite(UserID,RoomID,CreatedAt) VALUES
    (3,3,'2026-08-04 10:20:00');

INSERT INTO Notification(UserID,Title,Content,Type,IsRead) VALUES
                                                               (3,N'Đặt phòng thành công',N'Đơn đặt phòng BK20260001 đã được tạo',N'Booking',0),
                                                               (3,N'Khuyến mãi mới',N'Khách sạn đang có chương trình giảm giá',N'Promotion',0);

INSERT INTO Contact(UserID,Subject,Content,Status) VALUES
    (3,N'Hỏi thông tin phòng',N'Tôi muốn hỏi thêm thông tin về phòng Deluxe',N'Chưa xử lý');

INSERT INTO System_Log(UserID,Action,Description,IpAddress) VALUES
                                                                (1,N'LOGIN',N'Đăng nhập hệ thống','127.0.0.1'),
                                                                (2,N'LOGIN',N'Đăng nhập hệ thống','127.0.0.1');
GO

