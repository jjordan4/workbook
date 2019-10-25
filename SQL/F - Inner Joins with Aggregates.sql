--Inner Joins With Aggregates Exercises
USE [A01-School]
GO

--1. How many staff are there in each position? Select the number and Position Description
SELECT  PositionDescription,                    --  <-- non-aggregate
        COUNT(S.StaffID) AS 'Number of Staff'   --  <-- aggregate
FROM    Staff S
    INNER JOIN Position P ON P.PositionID = S.PositionID
GROUP BY PositionDescription 
 -- There are 7 positions but i only see 6 because im using an inner join

--2. Select the average mark for each course. Display the CourseName and the average mark. Sort the results by average in descending order.
SELECT  CourseName, AVG(Mark) AS 'Average Mark'
FROM    Registration R
    INNER JOIN Course C ON R.CourseId = C.CourseId
GROUP BY CourseName
ORDER BY 'Average Mark' DESC

--3. How many payments where made for each payment type. Display the PaymentTypeDescription and the count.
 -- TODO: Student Answer Here... 
 SELECT P.PaymentTypeDescription , COUNT (PaymentID) AS 'Number of Payments'
 FROM PaymentType AS P
   INNER JOIN Payment PA ON PA.PaymentTypeID = P.PaymentTypeID
 GROUP BY P.PaymentTypeDescription
 
--4. Select the average Mark for each student. Display the Student Name and their average mark. Use table aliases in your FROM & JOIN clause.
SELECT  S.FirstName  + ' ' + S.LastName AS 'Student Name',
        AVG(R.Mark)                     AS 'Average'
FROM    Registration R
        INNER JOIN Student S
            ON S.StudentID = R.StudentID
GROUP BY    S.FirstName  + ' ' + S.LastName  -- Since my non-aggregate is an expression,
                                             -- I am using the same expression in my GROUP BY

--5. Select the same data as question 4 but only show the student names and averages that are > 80. (HINT: Remember the HAVING clause?)
 -- TODO: Student Answer Here... 
 SELECT  S.FirstName  + ' ' + S.LastName AS 'Student Name',
        AVG(R.Mark)                     AS 'Average'
FROM    Registration R
        INNER JOIN Student S
            ON S.StudentID = R.StudentID
GROUP BY    S.FirstName  + ' ' + S.LastName 
HAVING AVG (R.Mark) > 80 
 
--6.what is the highest, lowest and average payment amount for each payment type Description? 
 -- TODO: Student Answer Here... 
 SELECT PT.PaymentTypeDescription, AVG (Amount) AS 'Average', MAX (Amount) AS 'Highest', MIN (Amount) AS 'Lowest'
 FROM PaymentType PT
 INNER JOIN Payment P ON P.PaymentTypeID = PT.PaymentTypeID
 GROUP BY PT.PaymentTypeDescription


--7. Which clubs have 3 or more students in them? Display the Club Names.
 -- TODO: Student Answer Here... 
 SELECT C.ClubName, COUNT (StudentID) AS 'Number of students'
 FROM Club C
 INNER JOIN Activity A ON A.ClubId = c.ClubId
 GROUP BY C.ClubName
 HAVING COUNT (StudentID) >= 3