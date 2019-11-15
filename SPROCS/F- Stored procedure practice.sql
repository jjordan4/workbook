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
    @ClubID varchar (10)
 
AS
    -- Body of procedure here
    -- Basic Validation - Parameter values are required
    --A) Make sure the ClubID is not NULL
    IF  @ClubID IS NULL 
    BEGIN
        RAISERROR('ClubID is required (cannot be null)', 16, 1)
    END
    ELSE
    BEGIN
    --B) Make sure the Club exists
    IF NOT EXISTS(SELECT ClubId FROM Club WHERE ClubId = @ClubID)
    BEGIN
         RAISERROR('that club does not exist', 16, 1)
    END
    ELSE
    BEGIN
    --Transaction:
    BEGIN TRANSACTION -- temporary
    --1) Remove members of club(from Activity)
    DELETE FROM Activity WHERE ClubId = @ClubID
    IF @@ERROR <> 0 -- then there's a problem with the delete
    BEGIN
      ROLLBACK TRANSACTION -- reverses the "temporary" changes to the database
      RAISERROR('Unable to remove members from the club', 16, 1)
        END
        ELSE
        BEGIN
    --2)Remove the club
    DELETE FROM Club WHERE ClubId = @ClubID
         IF @@ERROR <> 0 OR @@ROWCOUNT = 0 -- a problem 
        BEGIN
        ROLLBACK TRANSACTION -- reverses the "temporary" changes to the database
        RAISERROR('Unable to remove members from the club', 16, 1)
        END
        ELSE
        BEGIN
        COMMIT TRANSACTION -- Finalize all temp DML statments
    END
 END
 END     
 END      
RETURN
GO

EXEC

--SELECT * FROM Activity
--SELECT * FROM Club

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