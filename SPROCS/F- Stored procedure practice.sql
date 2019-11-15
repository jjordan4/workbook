--Stored Procedures (Sprocs)
-- Practice using stored procedures
/*
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'SprocName')
    DROP PROCEDURE SprocName
GO
CREATE PROCEDURE SprocName
    -- Parameters here
AS
    -- Body of procedure here
RETURN
GO
*/
--1. Create a stored procedure called DissolveClub that will accept a club ID as its parameter.Ensure that the club exists before attempting to dissolve the club. You are to dissolve the club by first removing all the members of the club and then removing the club itself.
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'DissolveClub')
    DROP PROCEDURE DissolveClub
GO
CREATE PROCEDURE DissolveClub
    -- Parameters here
    @ClubID varchar (10),
    @ClubName varchar (50),
    @StudentID int 
AS
    -- Body of procedure here
    -- Basic Validation - Parameter values are required

RETURN
GO

--2. Create a stored procedure called ArchivePayments.This stored procedure must transfer all payment records to the StudentPaymentArchive table. After archiving,delete the payment records.
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'StudentPaymentArchive')
    DROP TABLE StudentPaymentArchive
GO
CREATE TABLE StudentPaymentArchive
 (
   ArchiveId int
    CONSTRAINT PK_StudentPaymentArchive
    PRIMARY KEY
    IDENTITY (1,1)
                         NOT NULL,
  StudentID int          NOT NULL,
  FirstName varchar (25) NOT NULL,
  LastName varchar (35) NOT NULL,

  )

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'ArchivePayments')
    DROP PROCEDURE ArchivePayments
GO
CREATE PROCEDURE ArchivePayments
    -- Parameters here
AS
    -- Body of procedure here
RETURN
GO