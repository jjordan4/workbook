-- Stored Procedures (Sprocs)
-- Validating Parameter Values

USE [A01-School]
GO

/* ********* SPROC Template ************
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'SprocName')
    DROP PROCEDURE SprocName
GO
CREATE PROCEDURE SprocName
    -- Parameters here
AS
    -- Body of procedure here
RETURN
GO
************************************** */


-- 1. Create a stored procedure called AddClub that will add a new club to the database. (No validation is required).
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'AddClub')
    DROP PROCEDURE AddClub
GO
-- sp_help Club -- Running the sp_help stored procedure will give you information about a table, sproc, etc.
CREATE PROCEDURE AddClub
    -- Parameters here
    @ClubId     varchar(10),
    @ClubName   varchar(50)
AS
    -- Body of procedure here
    -- Should put some validation here.....

    INSERT INTO Club(ClubId, ClubName)
    VALUES (@ClubId, @ClubName)
RETURN
GO

AddClub 'ABC', 'After Bachaloriate Club'
GO
AddClub ABD, Another_Boring_Disaster
GO


-- 1.b. Modify the AddClub procedure to ensure that the club name and id are actually supplied. Use the RAISERROR() function to report that this data is required.
ALTER PROCEDURE AddClub
    -- Parameters here
    @ClubId     varchar(10),
    @ClubName   varchar(50)
AS
    -- Body of procedure here
    IF @ClubId IS NULL OR @ClubName IS NULL
    BEGIN
        RAISERROR('Club ID and Name are required', 16, 1)
    END
    ELSE
    BEGIN
        INSERT INTO Club(ClubId, ClubName)
        VALUES (@ClubId, @ClubName)
    END
RETURN
GO

AddClub null,null
GO

-- 2. Make a stored procedure that will find a club based on the first two or more characters of the club's ID. Call the procedure "FindStudentClubs"
-- The following stored procedure does the query, but without validation
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'FindStudentClubs')
    DROP PROCEDURE FindStudentClubs
GO
CREATE PROCEDURE FindStudentClubs
    @PartialID      varchar(10)
AS
    -- Body of procedure here
    SELECT  ClubID, ClubName
    FROM    Club
    WHERE   ClubId LIKE @PartialID + '%'
RETURN
GO
-- Testing with different data types

EXEC FindStudentClubs 'C' -- Good data
EXEC FindStudentClubs NULL  -- What do you predict the result will be?(Bad data)
EXEC FindStudentClubs ''    -- What do you predict the result will be?(Unusual data)
GO
ALTER PROCEDURE FindStudentClubs
    @PartialID      varchar(10)
AS
    -- Body of procedure here
    IF @PartialID IS NULL OR LEN(@PartialID) < 2
    BEGIN   -- {
        RAISERROR('The partial ID must be two or more characters', 16, 1)
        -- The 16 is the error number and the 1 is the severity
    END     -- }
    SELECT  ClubID, ClubName
    FROM    Club
    WHERE   ClubId LIKE @PartialID + '%'
RETURN
GO
EXEC FindStudentClubs ''    -- What do you predict the result will be?
GO
-- The above change did not stop the select.
-- To fix it, we need the ELSE side of the IF validation
ALTER PROCEDURE FindStudentClubs -- Third time's the charm ;)
    @PartialID      varchar(10)
AS
    -- Body of procedure here
    IF @PartialID IS NULL OR LEN(@PartialID) < 2
    BEGIN   -- {
        RAISERROR('The partial ID must be two or more characters', 16, 1)
        -- The 16 is the error number and the 1 is the severity
    END     -- }
    ELSE
    BEGIN
        SELECT  ClubID, ClubName
        FROM    Club
        WHERE   ClubId LIKE @PartialID + '%'
    END
RETURN
GO
EXEC FindStudentClubs ''    -- What do you predict the result will be?
EXEC FindStudentClubs 'NA'  -- Should give good results with no errors.


-- 3. Create a stored procedure that will change the mailing address for a student. Call it ChangeMailingAddress.
--    Make sure all the parameter values are supplied before running the UPDATE (ie: no NULLs).
-- sp_help Student
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'ChangeMailingAddress')
    DROP PROCEDURE ChangeMailingAddress
GO
CREATE PROCEDURE ChangeMailingAddress
    -- Parameters here
    @StudentId  int,
    @Street     varchar(35), -- Model the type/size of parameters to match what's needed in the database tables
    @City       varchar(30),
    @Province   char(2),
    @PostalCode char(6)
AS
    -- Body of procedure here
    -- Validate
    IF (@StudentId IS NULL OR @Street IS NULL OR @City IS NULL OR @Province IS NULL or @PostalCode IS NULL)
    BEGIN --  { A...
        RAISERROR('All parameters require a value (NULL is not accepted)', 16, 1)
    END   -- ...A }
    ELSE
    BEGIN -- { B...
        UPDATE  Student
        SET     StreetAddress = @Street
               ,City = @City
               ,Province = @Province
               ,PostalCode = @PostalCode
        WHERE   StudentId = @StudentId 
    END   -- ...B }
RETURN

-- 4. Create a stored procedure that allows us to make corrections to a student's name. It should take in the student ID and the corrected name (first/last) of the student. Call the stored procedure CorrectStudentName. Validate that the student exists before attempting to change the name.
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'CorrectStudentName')
    DROP PROCEDURE CorrectStudentName
GO
CREATE PROCEDURE CorrectStudentName
    @StudentId      int,
    @FirstName      varchar(25),
    @LastName       varchar(35)
AS
    IF @StudentId IS NULL OR @FirstName IS NULL OR @LastName IS NULL
        RAISERROR('All parameters are required.', 16, 1)
    ELSE IF NOT EXISTS (SELECT StudentID FROM Student WHERE StudentID = @StudentId)
        RAISERROR('That student id does not exist', 16, 1)
    ELSE
        UPDATE  Student
        SET     FirstName = @FirstName,
                LastName = @LastName
        WHERE   StudentID = @StudentId
RETURN
GO



-- 5. Create a stored procedure that will remove a student from a club. Call it RemoveFromClub.

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'RemoveFromClub')
    DROP PROCEDURE RemoveFromClub
GO
CREATE PROCEDURE RemoveFromClub
    -- Parameters here
    @StudentId int,
    @ClubId varchar(10)
AS
    -- Body of procedure here
    if(@StudentId IS NULL OR @ClubId IS NULL)
    RAISERROR('StudentID and ClubID are required',16,1)
    ELSE
    DELETE FROM Activity WHERE StudentID = @StudentId AND ClubId = @ClubId
RETURN
GO

-- Query-based Stored Procedures
-- 6. Create a stored procedure that will display all the staff and their position in the school.
--    Show the full name of the staff member and the description of their position.
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'Liststaffpositions')
    DROP PROCEDURE Liststaffpositions
GO
CREATE PROCEDURE Liststaffpositions
    -- Parameters here
AS
    -- Body of procedure here
    SELECT FirstName + ' ' + LastName AS 'StaffMember',
           PositionDescription
    FROM Position P
     INNER JOIN Staff S ON P.PositionID = S.PositionID
RETURN
GO

-- 7. Display all the final course marks for a given student. Include the name and number of the course
--    along with the student's mark.
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'StudentMarks')
    DROP PROCEDURE StudentMarks
GO
CREATE PROCEDURE StudentMarks
    -- Parameters here
    @StudentID int
AS
    -- Body of procedure here
    SELECT CourseName,
           C.CourseId,
           Mark
    FROM Registration R
    INNER JOIN Course C ON R.CourseId = C.CourseId
    WHERE StudentID = @StudentID
RETURN
GO

-- 8. Display the students that are enrolled in a given course on a given semester.
--    Display the course name and the student's full name and mark.
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'CourseList')
    DROP PROCEDURE CourseList
GO
CREATE PROCEDURE CourseList
    -- Parameters here
    @CourseID char (7),
    @semester char (5)
AS
    -- Body of procedure here
    IF @CourseID IS NULL OR @semester IS NULL
           RAISERROR('Course and Semester are required',16,1)
    SELECT CourseName,
           FirstName + ''+ LastName,
           Mark
    FROM Course C
    INNER JOIN Registration R ON R.CourseId = C.CourseId
    INNER JOIN Student S ON S.StudentID = R.StudentID
    WHERE C.CourseId = @CourseID
    AND R.Semester = @semester
RETURN
GO
-- To test this , pick a course and semester
-- SELECT * FROM Registration -- DMIT170 2004J
EXEC CourseList 'DMIT170', '2004J'
EXEC CourseList 'DMIT170', NULL
EXEC CourseList  NULL, '2004J'
-- Just Columns no data
EXEC CourseList 'FAKE170', '2004J'
EXEC CourseList 'DMIT170', '2034J'
-- 9. The school is running out of money! Find out who still owes money for the courses they are enrolled in.
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'BillCollectorWorkSheet')
    DROP PROCEDURE BillCollectorWorkSheet
GO
CREATE PROCEDURE BillCollectorWorkSheet
    -- Parameters here
AS
    -- Body of procedure here
    SELECT FirstName + ' '+ LastName as 'Student',
           R.CourseId
    FROM Student S
         INNER JOIN Registration R ON S.StudentID = R.StudentID
    WHERE BalanceOwing > 0
RETURN
GO

EXEC BillCollectorWorkSheet