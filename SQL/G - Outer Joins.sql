--Outer Joins Exercise
USE [A01-School]
GO

--1. Select All position descriptions and the staff ID's that are in those positions
SELECT  PositionDescription, StaffID
FROM    Position P -- Start with the Position table, because I want ALL position descriptions...
    LEFT OUTER JOIN Staff S ON P.PositionID = S.PositionID

--2. Select the Position Description and the count of how many staff are in those positions. Return the count for ALL positions.
--HINT: Count can use either count(*) which means the entire "row", or "all the columns".
--      Which gives the correct result in this question?
SELECT  PositionDescription,
        COUNT(StaffID) AS 'Number of Staff'
FROM    Position P
    LEFT OUTER JOIN Staff S ON P.PositionID = S.PositionID
GROUP BY P.PositionDescription
-- but -- The following version gives the WRONG results, so just DON'T USE *  !
SELECT PositionDescription, 
       Count(*) -- this is counting the WHOLE row (not just the Staff info)
FROM   Position P
    LEFT OUTER JOIN Staff S
        ON P.PositionID = S.PositionID
GROUP BY P.PositionDescription

--3. Select the average mark of ALL the students. Show the student names and averages.
SELECT  FirstName  + ' ' + LastName AS 'Student Name',
        AVG(Mark) AS 'Average'
FROM    Student S
    LEFT OUTER JOIN Registration R
        ON S.StudentID  = R.StudentID
GROUP BY FirstName, LastName

--4. Select the highest and lowest mark for each student. 
SELECT  FirstName  + ' ' + LastName AS 'Student Name',
        MAX(Mark) AS 'Highest',
		MIN(Mark) 'Lowest'
FROM    Student S
    LEFT OUTER JOIN Registration R
        ON S.StudentID  = R.StudentID
GROUP BY FirstName, LastName
--5. How many students are in each club? Display club name and count.
-- TODO: Student Answer Here...
SELECT ClubName,COUNT (StudentID) AS 'Number of students'
FROM Club C
  LEFT OUTER JOIN Activity A ON A.ClubId = C.ClubId
  GROUP BY C.ClubName
--6. How many times has each course been offered? Display the course ID and course name along with the number of times it has been offered.
-- TODO: Student Answer Here...
SELECT CO.CourseName,CO.CourseId,COUNT (Semester) AS 'Number of times offered '
FROM Course CO
LEFT OUTER JOIN Registration R ON R.CourseId = CO.CourseId
GROUP BY CO.CourseName,CO.CourseId
--7. How many courses have each of the staff taught? Display the full name and the count.
-- TODO: Student Answer Here...
SELECT S.FirstName + ' '+ S.LastName AS 'Staff Name', COUNT (CourseId) AS 'Number of courses taught'
FROM Staff S
LEFT OUTER JOIN Registration R ON R.StaffID = S.StaffID
GROUP BY S.FirstName + ' '+ S.LastName
--8. How many second-year courses have the staff taught? Include all the staff and their job position.
--   A second-year course is one where the number portion of the course id starts with a '2'.
-- TODO: Student Answer Here...
SELECT S.FirstName + ' '+ S.LastName AS 'Staff Name', P.PositionDescription, COUNT (CourseId) AS 'Course Count'
FROM Position P
LEFT OUTER JOIN Staff S On S.PositionID = P.PositionID
LEFT OUTER JOIN Registration R ON R.StaffID = S.StaffID
WHERE R.CourseId LIKE '____2%'
OR   R.CourseId IS NULL
GROUP BY PositionDescription, FirstName, LastName

--9. What is the average payment amount made by each student? Include all the students,
--   and display the students' full names.
-- TODO: Student Answer Here...

--10. Display the names of all students who have not made a payment.
-- TODO: Student Answer Here...

