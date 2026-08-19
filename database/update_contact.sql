ALTER TABLE Contact ADD FullName NVARCHAR(100);
ALTER TABLE Contact ADD Email NVARCHAR(100);
ALTER TABLE Contact ADD Phone NVARCHAR(20);
GO
EXEC sp_rename 'Contact.Content', 'Message', 'COLUMN';
GO
