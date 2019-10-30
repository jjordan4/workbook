-- Insert Examples
USE [A01-School]
GO -- Execute the code up to this point as a single batch

/*  Notes:
    The syntax for the INSERT statement is

    INSERT INTO TableName(Comma, Separated, ListOf, ColumnNames)
    VALUES ('A', 'Value', 'Per', 'Column')

    The line above will insert a single row of data. Typically, this
    syntax is used for hard-coded values.
    To insert multiple rows of hard-coded values, follow this pattern:

    INSERT INTO TableName(Comma, Separated, ListOf, ColumnNames)
    VALUES ('A', 'Value', 'Per', 'Column'),
           ('Another', 'Row', 'Of', 'Values')
    
    Another syntax for the INSERT statement is to use a SELECT clause in place
    of the VALUES clause. This is used for zero-to-many possible rows to insert.

    INSERT INTO TableName(Comma, Separated, ListOf, ColumnNames)
    SELECT First, Second, Third, LastColumn
    FROM   SomeTable
*/

-- Insert Examples
-- 1. Let's add a new course called "Expert SQL". It will be a 90 hour course with a cost of $450.00
INSERT INTO Course(CourseId, CourseName, CourseHours, CourseCost)
VALUES ('DMIT777', 'Expert SQL', 90, 450.00)

-- 2. Let's add a new staff member, someone who's really good at SQL
-- SELECT * FROM STAFF
INSERT INTO Staff(FirstName, LastName, DateHired, PositionID)
SELECT 'Dan', 'Gilleland', GETDATE(), PositionID
       --, PositionDescription
FROM   Position
WHERE  PositionDescription = 'Instructor'
-- 2b. Let's get another instructor
INSERT INTO Staff(FirstName, LastName, DateHired, PositionID)
VALUES ('Shane', 'Bell', GETDATE(), 
        (SELECT PositionID
        FROM   Position
        WHERE  PositionDescription = 'Instructor'))
--2.c we have to open positions in the staff
Select PositionDescription
FROM Position
WHERE PositionID NOT IN (SELECT PositionID FROM Staff)
-- ADD Sheldon Murray as the new assistant dean.
INSERT INTO Staff (FirstName,LastName,DateHired,PositionID)
VALUES ('Sheldon','Murray',GETDATE(),
                       (SELECT PositionID
                        FROM Position
                        WHERE PositionDescription = 'Assistant Dean'
                                     ))

-- 3. There are three additional clubs being started at the school:
--      - START - Small Tech And Research Teams
--      - CALM - Coping And Lifestyle Management
--      - RACE - Rapid Acronym Creation Experts
--    SELECT * FROM Club
INSERT INTO Club(ClubId, ClubName)
VALUES ('START', 'Small Tech And Research Teams'),
       ('CALM', 'Coping And Lifestyle Management'),
       ('RACE', 'Rapid Acronym Creation Experts')

-- ======= Practice ========
-- 4. In your web browser, use https://randomuser.me/ to get information on three
--    people to add as new students. Write separate insert statement for each new student.
-- TODO: Student Answer Here....
-- SELECT * FROM Student
INSERT INTO Student (FirstName,LastName,Gender,StreetAddress,City,Province,PostalCode,Birthdate)
VALUES ('Hannah','Sanders','F','3684 Homestead RD', 'Edmonton','AB','H6Y2J8','1985/8/4'),
       ('Teresa','Carr','F','8596 E Little York RD', 'Edmonton','AB','H6K2J8','1951/6/10'),
       ('Seth','Smith','M','3634 Homestead RD', 'Edmonton','AB','H7Y2J8','1981/4/4')


-- 5. Enroll each of the students you've added into the DMIT104 course.
--    Use 'Dan Gilleland' as the instructor. At this point, their marks should be NULL.
-- SELECT * FROM Course
