---------------------------INITIALIZE DB---------------------------
CREATE DATABASE PROJ_330_INSTRUCTOR_EVAL
GO
USE PROJ_330_INSTRUCTOR_EVAL

CREATE TABLE tblSTUDENT_TYPE(
    StudentTypeID    INT IDENTITY (1,1) primary key,
    StudentTypeName varchar(30) not null,
    StudentTypeDescr varchar(100) not null
)
GO
CREATE TABLE tblINSTRUCTOR_TYPE(
    InstructorTypeID    INT IDENTITY (1,1) primary key,
    InstructorTypeName varchar(30) not null,
    InstructorTypeDescr varchar(100) not null
)
GO
CREATE TABLE tblGENDER(
    GenderID INT IDENTITY (1,1) primary key,
    GenderName varchar(20) not null
)
GO
CREATE TABLE tblQUARTER(
    QuarterID INT IDENTITY (1,1) primary key,
    QuarterName varchar(20) not null
)
GO
CREATE TABLE tblCOLLEGE(
    CollegeID INT IDENTITY (1,1) primary key,
    CollegeName varchar(30) not null,
    CollegeDescr varchar(120) not null,
)
GO
CREATE TABLE tblDEPARTMENT(
    DepartmentID INT IDENTITY (1,1) primary key,
    DepartmentName varchar(50) not null,
    DepartmentDescr varchar(130) not null,
    CollegeID int FOREIGN KEY
        REFERENCES tblCOLLEGE(CollegeID) not null
)
GO
CREATE TABLE tblDETAIL(
    DetailID INT IDENTITY (1,1) primary key,
    DetailName varchar(100) not null,
    DetailDescr varchar(200) not null
)

CREATE TABLE tblINSTRUCTOR(
    InstructorID INT IDENTITY (1,1) primary key,
    InstructorFname varchar(30) not null,
    InstructorLname varchar(30) not null,
    InstructorDOB date not null,
    StartDate date not null,
    EndDate date,
    GenderID int FOREIGN KEY
        REFERENCES tblGENDER(GenderID) not null,
    InstructorEmail varchar(50) not null,
    InstructorType int FOREIGN KEY
        REFERENCES tblINSTRUCTOR_TYPE(InstructorTypeID) not null
)
GO
CREATE TABLE tblCOURSE(
    CourseID INT IDENTITY (1,1) primary key,
    CourseName varchar(20) not null,
    Credits int not null,
    DepartmentID INT FOREIGN KEY
        REFERENCES tblDEPARTMENT(DepartmentID) not null,
    CourseDescr varchar(130) not null
)
GO
CREATE TABLE tblCLASS(
    ClassID INT IDENTITY (1,1) primary key,
    CourseID INT FOREIGN KEY
        REFERENCES tblCOURSE(CourseID) not null,
    YEAR int not null,
    QuarterID INT FOREIGN KEY
        REFERENCES tblQuarter(QuarterID) not null
)
GO
CREATE TABLE tblSTUDENT(
    StudentID INT IDENTITY (1,1) primary key,
    StudentFname varchar(30) not null,
    StudentLname varchar(30) not null,
    StudentDOB date not null,
    StudentEmail varchar(50) not null,
    GenderID INT FOREIGN KEY
        REFERENCES tblGENDER(GenderID) not null,
    StudentTypeID INT FOREIGN KEY
        REFERENCES tblSTUDENT_TYPE(StudentTypeID) not null
)
GO
CREATE TABLE tblCLASS_LIST(
    ClassID INT FOREIGN KEY
        REFERENCES tblClass(ClassID) not null,
    StudentID INT FOREIGN KEY
        REFERENCES tblStudent(StudentID) not null
)

CREATE TABLE tblEVALUATION(
    EvaluationID INT IDENTITY (1,1) primary key,
    ClassID INT FOREIGN KEY
        REFERENCES tblClass(ClassID) not null
)
GO
CREATE TABLE tblEVALUATION_DETAIL(
    EvaluationID INT FOREIGN KEY
        REFERENCES tblEVALUATION(EvaluationID) not null,
    DetailID INT FOREIGN KEY
        REFERENCES tblDETAIL(DetailID) not null,
    Rating int not null
)
GO
CREATE TABLE tblINSTRUCTOR_CLASS(
    InstructorID INT FOREIGN KEY
        REFERENCES tblINSTRUCTOR(InstructorID) not null,
    ClassID INT FOREIGN KEY
        REFERENCES tblCLASS(ClassID) not null
)
GO
INSERT INTO tblQUARTER(QuarterName)
    VALUES('Spring'),
          ('Summer'),
          ('Autumn'),
          ('Winter')
GO
INSERT INTO tblGENDER(GenderName)
    VALUES('Male'),
          ('Female')
GO
INSERT INTO tblCOLLEGE(CollegeName, CollegeDescr)
    VALUES('Arts and Sciences', 'Science and arts are in this college'),
        ('Built Environments', 'Have you ever wanted to build an environment?'),
        ('Business (Foster)', 'Boats, Paccar pasta, frats, $$$ right?, cool suit, idk what to do with my life but my parents say no art'),
        ('Dentistry', 'teeth'),
        ('Education', 'Whoa thats pretty meta dude'),
        ('Engineering', 'Its all good Im DTC bro'),
        ('Environment', 'Have you ever wanted to not build an environment?'),
        ('Graduate', 'We taking them back to school'),
        ('Information School', 'Please let me in! Thanks'),
        ('Law', 'Im not messing with this one'),
        ('Medicine', 'Thats what that big building is for'),
        ('Nursing', 'If you didnt want to do the stuff in the one above'),
        ('Pharmacy', 'Ditto, but make more money'),
        ('Public Affairs (Evans School)', 'My dad had a public affair'),
        ('Public Health', 'Coronavirus has entered the chat'),
        ('Social Work', 'Im a social media manager')
GO
INSERT INTO tblINSTRUCTOR_TYPE(InstructorTypeName, InstructorTypeDescr)
    VALUES('Lecturer', 'They do lectures'),
           ('Assistant Professor', 'They assist professors'),
           ('Associate Professor', 'Not a direct professor, but associated'),
           ('Full Professor', 'Real professors'),
           ('Teaching Assistant','Hi Alex'),
           ('Senior Lecturer', 'Old lecturer?')
GO
INSERT INTO tblDETAIL(DetailName, DetailDescr)
VALUES('Course: Whole', 'The course as a whole (content, instruction, assignments, management...)'),
      ('Course: Content', 'The content of the course was interesting and valuable'),
      ('Instructor: Contribution', 'The instructor participated actively in the class to make a better experience'),
      ('Instructor: Effectiveness', 'The instructors contributions were effective towards learning an understanding course content'),
      ('Instructor: Exams', 'The instructor administered more exams than usual'),
      ('Instructor: Workload', 'The instructor required a high level of workload/standard of work'),
      ('Instructor: Availability', 'The instructor was available through class, office hours or other way to assist students'),
      ('Instructor Knowledge', 'The instructor seemed knowledgeable in the filed relevant to the class '),
      ('Instructor: Bathroom Breaks', 'The instructor rarely went to the bathroom'),
      ('Instructor: Name-Remembering', 'The instructor could remember everyones name in the class after a week of instruction'),
      ('Instructor: Story telling', 'The instructor told crazy werid stories about their childhood that were not related to the class'),
      ('Instructor: Height', 'The instructor was tall')
GO
INSERT INTO tblSTUDENT_TYPE(StudentTypeName, StudentTypeDescr)
VALUES('Undergraduate', 'Have not graduated yet, some never will'),
       ('Graduate', 'These students have already graduated I think, I never understood this idk'),
       ('PHD', 'Do you know that Kanye West song where he has the PHD')


USE PROJ_330_INSTRUCTOR_EVAL
--CONNOR
-------------------------------STORED PROCEDURES-------------------------------

--Populate tblInstructor
CREATE PROCEDURE uspPopulateInstructor
    @Fname varchar(30),
    @Lname varchar(30),
    @DOB date,
    @StartDate date,
    @EndDate date,
    @Gender varchar(20),
    @Email varchar(50),
    @InstructorType varchar(30)
AS
   DECLARE @ITPK int = (SELECT tIT.InstructorTypeID
                        FROM tblINSTRUCTOR_TYPE tIT
                        WHERE tIT.InstructorTypeName = @InstructorType )
    DECLARE @GPK int = (SELECT tG.GenderID
                        FROM tblGENDER tG
                        WHERE tG.GenderName = @Gender)
BEGIN TRANSACTION t1
    INSERT INTO tblINSTRUCTOR(InstructorFname, InstructorLname, InstructorDOB, StartDate, EndDate, GenderID, InstructorEmail, InstructorType)
        VALUES(@Fname, @Lname, @DOB, @StartDate, @EndDate, @GPK, @Email, @ITPK)
COMMIT TRANSACTION t1

--Populate tblClass
CREATE PROCEDURE uspPopulateClass
    @CourseName varchar(20),
    @YEAR int,
    @QuarterName varchar(20)
AS
    DECLARE @CPK int = (SELECT tC.CourseID
                        FROM tblCOURSE tC
                        WHERE tC.CourseName = @CourseName)
    DECLARE @QPK int = (SELECT tQ.QuarterID
                        FROM tblQUARTER tQ
                        WHERE tQ.QuarterName = @QuarterName)
BEGIN TRANSACTION t1
    INSERT INTO tblCLASS(CourseID, YEAR, QuarterID)
        VALUES(@CPK, @YEAR, @QPK)
COMMIT TRANSACTION t1

--Populate tblStudent
CREATE PROCEDURE uspPopulateStudent
    @Fname varchar(30),
    @Lname varchar(30),
    @DOB date,
    @Gender varchar(20),
    @Email varchar(50),
    @StudentType varchar(30)
AS
    DECLARE @GPK int = (SELECT tG.GenderID
                        FROM tblGENDER tG
                        WHERE tG.GenderName = @Gender)
    DECLARE @STPK int = (SELECT tST.StudentTypeID
                        FROM tblSTUDENT_TYPE tST
                        WHERE tST.StudentTypeName = @StudentType)
BEGIN TRANSACTION t1
    INSERT INTO tblSTUDENT(StudentFname, StudentLname, StudentDOB, StudentEmail, GenderID, StudentTypeID)
        VALUES(@Fname, @Lname, @DOB, @Email, @GPK, @STPK)
COMMIT TRANSACTION t1

------------------------------------QUERIES------------------------------------
--Which department has the highest rated professors teaching their courses on average?
CREATE VIEW vwInstructorEvalAvgByDepartment
    AS
SELECT tD.DepartmentName, AVG(tI.InstructorEvalAvg) AS deptEvalAvg
FROM tblDEPARTMENT tD
    JOIN tblCOURSE C on tD.DepartmentID = C.DepartmentID
    JOIN tblCLASS tC on C.CourseID = tC.CourseID
    JOIN tblINSTRUCTOR_CLASS tIC on tC.ClassID = tIC.ClassID
    JOIN tblINSTRUCTOR tI on tIC.InstructorID = tI.InstructorID
    GROUP BY tD.DepartmentName

--Average evaluations of math classes by age of full professors Connor, ADDED
CREATE VIEW vwMathProfsAvgEvalByAge
  AS
SELECT YEAR(GETDATE()) -YEAR(tI.InstructorDOB) AS Age, AVG(tI.InstructorEvalAvg) AS EvalAvg
FROM tblINSTRUCTOR tI
    JOIN tblINSTRUCTOR_CLASS tIC on tI.InstructorID = tIC.InstructorID
    JOIN tblCLASS tC on tIC.ClassID = tC.ClassID
    JOIN tblCOURSE tC2 on tC.CourseID = tC2.CourseID
    JOIN tblDEPARTMENT D on tC2.DepartmentID = D.DepartmentID
    JOIN tblINSTRUCTOR_TYPE tIT on tI.InstructorType = tIT.InstructorTypeID
WHERE D.DepartmentName = 'Mathematics'
    AND tIT.InstructorTypeName = 'Full Professor'
GROUP BY(YEAR(GETDATE()) -YEAR(tI.InstructorDOB))


---------------------------------BUSINESS RULES--------------------------------
--Students named Palash and John cannot be placed in a class together (ClassList)
CREATE FUNCTION fnNoPalashJohnClass()
RETURNS INT
AS
    BEGIN
        DECLARE @Ret int = 0
        IF EXISTS(SELECT *
                FROM tblCLASS tC
                    JOIN tblCLASS_LIST tCL on tC.ClassID = tCL.ClassID
                    JOIN tblSTUDENT tS on tCL.StudentID = tS.StudentID
                    JOIN (SELECT tC.ClassID -- Subquery to see if John is in a class, and then cross reference those classes with...
                        FROM tblCLASS tC
                            JOIN tblCLASS_LIST tCL on tC.ClassID = tCL.ClassID
                            JOIN tblSTUDENT tS on tCL.StudentID = tS.StudentID
                        WHERE tS.StudentFname = 'John') AS subq1 ON tC.ClassID = subq1.ClassID
                WHERE tS.StudentFname = 'Palash') --Palash, so if one exists they would both be in the class_list
            BEGIN
                SET @Ret = 1
            end
        RETURN @Ret
    end
ALTER TABLE tblCLASS_LIST
ADD CONSTRAINT CK_PalashAndJohn
CHECK(dbo.fnNoPalashJohnClass() = 0)
--Students cannot be named Connor Voelk and take an informatics class taught by Greg Hay (tblStudent)
CREATE FUNCTION fnNoConnorVoelkWithGregHayInfo()
RETURNS INT
AS
    BEGIN
        DECLARE @Ret int = 0
        IF EXISTS(SELECT *
                FROM tblSTUDENT tS
                    JOIN tblCLASS_LIST tCL on tS.StudentID = tCL.StudentID
                    JOIN tblCLASS tC on tCL.ClassID = tC.ClassID
                    JOIN tblCOURSE t on tC.CourseID = t.CourseID
                    JOIN tblDEPARTMENT tD on t.DepartmentID = tD.DepartmentID
                    JOIN tblINSTRUCTOR_CLASS tIC on tC.ClassID = tIC.ClassID
                    JOIN tblINSTRUCTOR tI on tIC.InstructorID = tI.InstructorID
                WHERE tS.StudentFname = 'Connor'
                    AND tS.StudentLname = 'Voelk'
                    AND tD.DepartmentName = 'Informatics'
                    AND tI.InstructorLname = 'Hay'
                    AND tI.InstructorFname = 'Greg')
            BEGIN
                SET @Ret = 1
            end
        RETURN @Ret
    end
ALTER TABLE tblCLASS_LIST
ADD CONSTRAINT CK_NoConnorVoelkWithGregHayInfo
CHECK (dbo.fnNoConnorVoelkWithGregHayInfo() = 0)

--------------------------------COMPUTED COLUMNS-------------------------------
--Evaluations average evaluating for that class (In the evaluation table) - Connor
CREATE FUNCTION fnAvgEval(@EvaluationPK INT)
RETURNS numeric (3, 2)
AS
    BEGIN
        DECLARE @Ret numeric (3, 2) = (SELECT AVG(tED.Rating) AS AvgEval
                        FROM tblEvaluation tE
                            JOIN tblEVALUATION_DETAIL tED on tE.EvaluationID = tED.EvaluationID
                        WHERE tE.EvaluationID = @EvaluationPK
                        GROUP BY tE.EvaluationID)
        RETURN @Ret
    end

ALTER TABLE tblEVALUATION
ADD AvgEvaluation
AS (dbo.fnAvgEval(EvaluationID))
--Average amount of students each instructor has had in their classes-Connor
CREATE FUNCTION fnAvgEnrolled(@InstructorPK INT)
RETURNS numeric(9,4)
    AS
    BEGIN
        DECLARE @Ret numeric(9,4) = (SELECT CAST( AVG(tC.NumEnrolled) AS numeric(9,4))
                                     FROM tblINSTRUCTOR tI
                                        JOIN tblINSTRUCTOR_CLASS tIC on tI.InstructorID = tIC.InstructorID
                                        JOIN tblCLASS tC on tIC.ClassID = tC.ClassID
                                     WHERE tI.InstructorID = @InstructorPK
                                     GROUP BY tI.InstructorID)
        RETURN @Ret
    end

ALTER TABLE tblINSTRUCTOR
ADD AvgStudentsEnrolled
AS (dbo.fnAvgEnrolled(InstructorID))

----------------------------------POPULATIONS----------------------------------
EXEC uspPopulateStudent
    'Rita', 'Corndog', '10/12/2001', 'Female','rita@uw.edu', 'undergraduate'
EXEC uspPopulateInstructor
    'Kion', 'Asgha', '12/31/1994', '1/1/2019', '6/20/2030', 'male', 'as@uw.edu', 'Assistant Professor'
EXEC uspPopulateClass
    'PHARM 301', '2020', 'Summer'

--JILL
-------------------------------STORED PROCEDURES-------------------------------
--Populates Course
CREATE PROCEDURE uspPopCourse
@Dept varchar(50),
@Name varchar(20),
@Cred int,
@Desc varchar(130)
AS
DECLARE @D_ID INT
SET @D_ID = (SELECT DepartmentID FROM tblDEPARTMENT WHERE DepartmentName = @Dept)
INSERT INTO tblCOURSE(CourseName, Credits, DepartmentID, CourseDescr)
VALUES (@Name, @Cred, @D_ID, @Desc)

CREATE PROCEDURE uspPopClassList
@Year int,
@Quarter varchar(30),
@Course varchar(30),
@Fname varchar(30),
@Lname varchar(30),
@DOB date
AS
DECLARE @C_ID INT
DECLARE @S_ID INT
DECLARE @Q_ID INT = (SELECT QuarterID FROM tblQUARTER WHERE QuarterName = @Quarter)
DECLARE @CR_ID INT = (SELECT CourseID FROM tblCOURSE WHERE CourseName = @Course)
SET @C_ID = (SELECT ClassID FROM tblCLASS WHERE YEAR = @Year AND QuarterID = @Q_ID AND CourseID = @CR_ID)
SET @S_ID = (SELECT StudentID FROM tblSTUDENT WHERE StudentFname = @Fname AND StudentLname = @Lname AND StudentDOB = @DOB)
INSERT INTO tblCLASS_LIST(ClassID, StudentID)
VALUES (@C_ID, @S_ID)

------------------------------------QUERIES------------------------------------
CREATE VIEW vwfemGreg420
    AS
SELECT InstructorID, COUNT(*) as FemaleGregMath420
FROM tblINSTRUCTOR I
    JOIN tblGENDER G on I.GenderID = G.GenderID
    JOIN tblSTUDENT S on G.GenderID = S.GenderID
    JOIN tblCLASS_LIST CL on S.StudentID = CL.StudentID
    JOIN tblCLASS C on CL.ClassID = C.ClassID
    JOIN tblCOURSE CO on C.CourseID = CO.CourseID
WHERE I.InstructorFname = 'Gregory' AND I.InstructorLname = 'Hay' AND G.GenderName = 'Female' AND CO.CourseName = 'MATH 420'
GROUP BY InstructorID

-- Which instructor has the most ratings?
-- tblEVALUATION details all the ratings. not every group of them. is that ok? donno
CREATE VIEW vwmostRatings
    AS
SELECT TOP 1 WITH TIES I.InstructorFname, I.InstructorLname, COUNT(ED.Rating) AS NumRatings
FROM tblINSTRUCTOR I
    JOIN tblINSTRUCTOR_CLASS IC on I.InstructorID = IC.InstructorID
    JOIN tblCLASS C on IC.ClassID = C.ClassID
    JOIN tblEVALUATION E on C.ClassID = E.ClassID
    JOIN tblEVALUATION_DETAIL ED on E.EvaluationID = ED.EvaluationID
    JOIN tblDETAIL D on ED.DetailID = D.DetailID
GROUP BY I.InstructorFname, I.InstructorLname
ORDER BY NumRatings DESC

---------------------------------BUSINESS RULES--------------------------------
-- Students over the age of 69 cannot register for a class
CREATE FUNCTION fn_NoOver69()
RETURNS INT
AS
BEGIN
    DECLARE @Ret INT = 0
    IF EXISTS(
        SELECT *
        FROM tblSTUDENT
        WHERE StudentDOB < (SELECT DateAdd(year, -69, GetDate()))
    )
    BEGIN
        SET @Ret = 1
    end
RETURN @Ret
end
GO
ALTER TABLE tblCLASS_LIST
ADD CONSTRAINT CK_noOverNice
CHECK (dbo.fn_NoOver69() = 0)

-- Classes called MATH 069 [nice] cannot be offered winter quarter
CREATE FUNCTION fn_noWinMath069()
RETURNS INT
AS
BEGIN
    DECLARE @Ret INT = 0
    IF EXISTS(
        SELECT *
        FROM tblCOURSE CO
            JOIN tblCLASS C on CO.CourseID = C.CourseID
            JOIN tblQUARTER Q on C.QuarterID = Q.QuarterID
        WHERE CO.CourseName = 'MATH 069' AND Q.QuarterName = 'Winter'
    )
    BEGIN
        SET @Ret = 1
    end
RETURN @Ret
end
GO
ALTER TABLE tblCLASS
ADD CONSTRAINT CK_noWinNice
CHECK (dbo.fn_noWinMath069() = 0)

--------------------------------COMPUTED COLUMNS-------------------------------
-- What is the highest rated professor of each department
-- https://stackoverflow.com/questions/8050854/how-to-find-maximum-avg/8050885
-- I don't use this ^ but not sure if I did it right so just saving it for later
CREATE FUNCTION fn_highestRated(@PKID INT)
RETURNS INT
AS
BEGIN
    DECLARE @Ret INT = (
        SELECT TOP 1 I.InstructorID--No ties because we want one in the column
        FROM tblINSTRUCTOR I
            JOIN tblINSTRUCTOR_CLASS IC on I.InstructorID = IC.InstructorID
            JOIN tblCLASS C on IC.ClassID = C.ClassID
            JOIN tblCOURSE CR ON Cr.CourseID = C.CourseID
            JOIN tblDEPARTMENT D ON CR.DepartmentID = D.DepartmentID
            JOIN tblEVALUATION E on C.ClassID = E.ClassID
            JOIN tblEVALUATION_DETAIL ED on E.EvaluationID = ED.EvaluationID
        WHERE D.DepartmentID = @PKID
            GROUP BY I.InstructorID
        ORDER BY AVG(ED.Rating) DESC
    )
RETURN @Ret
end
GO
ALTER TABLE tblDEPARTMENT
ADD HighestRatedInstr AS (dbo.fn_highestRated(DepartmentID))

-- Total number of classes taught by each professor
CREATE FUNCTION fn_totalTaught(@PKID INT)
RETURNS INT
AS
BEGIN
    DECLARE @Ret INT = (
        SELECT COUNT(*)
        FROM tblCLASS
        JOIN tblINSTRUCTOR_CLASS tIC on tblCLASS.ClassID = tIC.ClassID
        JOIN tblINSTRUCTOR tI on tIC.InstructorID = tI.InstructorID
        WHERE tI.InstructorID = @PKID
    )
RETURN @Ret
end
GO
ALTER TABLE tblINSTRUCTOR
ADD TotalClassesTaught AS (dbo.fn_totalTaught(InstructorID))

----------------------------------POPULATIONS----------------------------------
EXEC uspPopCourse
'Mathematics', 'MATH 069', '5', 'Easy math class'


EXEC uspPopClassList
'2008', 'Spring', 'MATH 069', 'Jill', 'Nguyen', '1999-06-08'

EXEC uspPopCourse
'Mathematics', 'MATH 069', '5', 'Easy math class'
GO
EXEC uspPopCourse
'Mathematics', 'MATH 124', '5', 'calc 1 boi'
GO
EXEC uspPopCourse
'Informatics', 'INFO 200', '5', 'intro 2 info'
GO
EXEC uspPopCourse
'Informatics', 'INFO 201', '5', 'r r r r r'
GO
EXEC uspPopCourse
'Computer Science', 'CSE 142', '4', 'WEEDOUT AHHHHHH'
GO
EXEC uspPopCourse
'Computer Science', 'CSE 143', '5', 'weedout for people who werent weeded out'
GO
EXEC uspPopCourse
'Education', 'EDUC 260', '1', 'inspire high school dreams'
GO
EXEC uspPopCourse
'Oral Health Sciences', 'ESS 101', '5', 'this is not the right department but i wanted to add rocks for jocks'
GO
EXEC uspPopCourse
'Electrical Engineering', 'E E 205', '4', 'idk what signal conditioning is'
GO
EXEC uspPopCourse
'Economics', 'ECON 200', '5', 'micro'
GO
EXEC uspPopCourse
'Economics', 'ECON 201', '5', 'macro'
GO
EXEC uspPopCourse
'Pharmacy','PHARM 301','3','its not all about drugs apparently'
GO

-- @Year int,
-- @Quarter varchar(30),
-- @Course varchar(30),
-- @Fname varchar(30),
-- @Lname varchar(30),
-- @DOB date
EXEC uspPopClassList
'2008', 'Spring', 'MATH 069', 'Connor', 'Voelk', '1999-12-13'
GO
EXEC uspPopClassList
'2008','Spring','INFO 200','John','Rosen','1998-05-07'
GO
EXEC uspPopClassList
'2010','Autumn','INFO 201','Jill','Nguyen','1999-06-08'
GO
EXEC uspPopClassList
'2019','Autumn','CSE 142','Connor','Voelk','1999-12-13'
GO
EXEC uspPopClassList
'2007','Winter','CSE 142','Jeremy','LastName','1978-10-04'
GO
EXEC uspPopClassList
'2007','Winter','CSE 142','George','Washington','1992-06-09'
GO
EXEC uspPopClassList
'2008','Spring','MATH 069','Young','Greg','2001-04-21'
GO
EXEC uspPopClassList
'2010','Autumn','INFO 201','Young','Greg','2001-04-21'
GO
EXEC uspPopClassList
'2008','Autumn','INFO 200','Young','Greg','2001-04-21'
GO
EXEC uspPopClassList
'2020','Summer','PHARM 301','Young','Greg','2001-04-21'
GO
EXEC uspPopClassList
'2008','Spring','INFO 200','Billy','Bob','1993-02-24'
GO
EXEC uspPopClassList
'2015','Spring','PHARM 301','Palash','Gujrathi','2000-03-14'
GO

--JOHN
-------------------------------STORED PROCEDURES-------------------------------
--instructor_class
create procedure uspInstructor_Class
@fname varchar(50),
@lname varchar(50),
@dob datetime,
@coursename varchar(50),
@quarter varchar(30),
@year int

as

declare @i int = (select instructorid from tblinstructor
where InstructorFname = @fname and InstructorLname = @lname and InstructorDOB = @dob)
declare @qid int =(select QuarterID from tblQUARTER
    where QuarterName = @quarter)

declare @c int = (select c.classid from tblclass c join tblcourse co on c.courseid = co.courseid
where coursename = @coursename and [year] = @year and QuarterID = @qid)

insert into tblinstructor_class(InstructorID, ClassID)
VALUES(@i, @c)


--evaluation
create procedure uspEvaluation
@fname varchar(50),
@lname varchar(50),
@dob datetime,
@coursename varchar(50),
@quarter varchar(30),
@year int

as
declare @qid int =(select QuarterID from tblQUARTER
    where QuarterName = @quarter)
declare @c2 int = (select c.classid from tblclass c
join tblcourse co on c.courseid = co.courseid
join tblinstructor_class ic on ic.classid = c.classid
join tblinstructor i on ic.instructorid = i.instructorid
where InstructorFname = @fname and InstructorLname = @lname and InstructorDOB = @dob
and coursename = @coursename and [year] = @year and QuarterID = @qid)

insert into tblevaluation(classid)
values(@c2)

------------------------------------QUERIES------------------------------------
--what is the average difference of age between instructors and students in each course? - John
CREATE VIEW vwAvgAgeDiffBtwnInstrStu
AS
select avg(datediff(year, i.instructordob, s.StudentDOB)) AS avgDif, course.coursename
from tblSTUDENT s
join tblclass_list cl on cl.studentid = s.studentid
join tblclass c on c.classid = cl.classid
join tblcourse course on course.courseid = c.courseid
join tblinstructor_class ic on ic.classid = c.classid
join tblinstructor i on ic.instructorid = i.instructorid
group by course.coursename

--Which professor had the largest positive difference in average rating between 1988 and 2018? - John
CREATE VIEW vwMostImproved
AS
select top 1 i.instructorfname, i.instructorlname, (avg(ed.rating) - sq.avgRating) as rdiff
from tblevaluation_detail ed
join tblevaluation e on ed.evaluationid = e.evaluationid
join tblclass c on c.classid = e.classid
join tblinstructor_class ic on ic.classid = c.classid
join tblinstructor i on i.instructorid = ic.instructorid
join(
	select i.instructorid, avg(ed.rating) as AvgRating
	from tblevaluation_detail ed
	join tblevaluation e on ed.evaluationid = e.evaluationid
	join tblclass c on c.classid = e.classid
	join tblinstructor_class ic on ic.classid = c.classid
	join tblinstructor i on i.instructorid = ic.instructorid
	where YEAR = '1988'
	group by i.instructorid
) as sq on sq.instructorid = i.instructorid
where YEAR = '2018'
group by i.instructorid, i.instructorfname, i.instructorlname, sq.avgRating
order by rdiff desc

---------------------------------BUSINESS RULES--------------------------------
-- Instructors named Greg Hay cannot get lower than 5 stars - John

USE PROJ_330_INSTRUCTOR_EVAL

CREATE FUNCTION fn_gregrating()
RETURNS int
AS
BEGIN
	DECLARE @Ret int = 0
	IF EXISTS(
		select * from tblevaluation_detail ed
		join tblevaluation e on e.evaluationid = ed.evaluationid
		join tblclass c on c.classid = e.classid
		join tblinstructor_class ic on c.classid = ic.classid
		join tblinstructor i on ic.instructorid = i.instructorid
		where instructorfname = 'Greg' and instructorlname = 'Hay'
		and ed.rating <> 5
		)
		BEGIN
			SET @Ret = 1
		END
	RETURN @Ret
END

ALTER TABLE tblEVALUATION_DETAIL
ADD CONSTRAINT CK_gregrating
CHECK(dbo.fn_gregrating() = 0)


-- PhD students can't be in MATH 069. - John

CREATE FUNCTION fn_phd69()
RETURNS int
AS
BEGIN
	DECLARE @Ret int = 0
	IF EXISTS(
		select * from tblstudent s
		join tblclass_list cl on s.studentid = cl.studentid
		join tblclass c on c.classid = cl.classid
		join tblcourse co on co.courseid = c.courseid
		join tblstudent_type st on st.studenttypeid = s.studentid
		where coursename = 'MATH 069' and StudentTypeName = 'PhD'
		)
		BEGIN
			SET @Ret  = 1
		END
	RETURN @Ret
END

ALTER TABLE tblclass_list
ADD CONSTRAINT CK_phd69
CHECK(dbo.fn_phd69() = 0)

--------------------------------COMPUTED COLUMNS-------------------------------
--Average number of credits taught by each instructor each quarter [outside of summer]. - John
create function calc_InstructorCreditAvg (@PK int)
returns numeric(8,2)
as
begin
	declare @ret numeric(8,2) = (select avg(sq.avgcred)
	from tblinstructor i
	join tblinstructor_class ic on i.instructorid = ic.instructorid
	join tblclass c on c.classid = ic.classid
	join tblquarter q on q.quarterid = c.quarterid
	join(select cl.ClassID, avg(credits) as avgcred
	    from tblcourse co
		join tblclass cl on cl.courseid = co.courseid
		join tblquarter q on cl.quarterid = q.quarterid
	    where q.quartername <> 'Summer'
		group by cl.ClassID
		) as sq on c.classid = sq.classid
	where i.instructorid = @PK
	group by i.instructorid)
	return @ret
end

alter table tblinstructor
add InstructorCreditAvg
as (dbo.calc_InstructorCreditAvg(instructorid))


--Average rating for each professor. - John ADDED
create function calc_InstructorEvalAvg (@PK int)
returns numeric(8,2)
as
begin
	declare @ret numeric(8,2) = (
	select avg(rating) from tblevaluation_detail ed
	join tblevaluation e on ed.evaluationid = e.evaluationid
	join tblclass c on c.classid = e.classid
	join tblinstructor_class ic on ic.classid = c.classid
	join tblinstructor i on ic.instructorid = i.instructorid
	where i.instructorid = @PK
	group by i.instructorid
)
	return @ret
end

alter table tblInstructor
add InstructorEvalAvg
as (dbo.calc_InstructorEvalAvg(instructorid))

----------------------------------POPULATIONS----------------------------------
EXEC uspInstructor_Class
'Greg', 'Hay', '1921-07-12','INFO 330','Winter' ,'2020'

EXEC uspEvaluation
'Greg', 'Hay', '1921-07-12', 'INFO 330', 'Winter', '2020'

--PALASH
-------------------------------STORED PROCEDURES-------------------------------
CREATE PROCEDURE uspEvaluationDetail
@EvalID int,
@DetailName varchar(100),
@Rating int
AS
DECLARE @D_ID INT

SET @D_ID = (SELECT D.DetailID
             FROM tblDETAIL D
             WHERE D.DetailName = @DetailName)

BEGIN TRANSACTION Evaluation_tran
INSERT INTO tblEVALUATION_DETAIL(EvaluationID, DetailID, Rating)
VALUES(@EvalID, @D_ID, @Rating)
COMMIT TRANSACTION Evaluation_tran
Go


-- Stored Procedure Department

CREATE PROCEDURE uspDepartment
@CollegeName varchar(30),
@DepartmentName varchar(50),
@DepartmentDescr varchar(130)
AS
DECLARE @C_ID INT
SET @C_ID = (SELECT C.CollegeID
             FROM tblCollege C
             WHERE C.CollegeName = @CollegeName)

BEGIN TRANSACTION depttran
INSERT INTO tblDEPARTMENT(DepartmentName, DepartmentDescr, CollegeID)
values(@DepartmentName, @DepartmentDescr, @C_ID)
COMMIT TRANSACTION depttran
Go


------------------------------------QUERIES------------------------------------
-- How many students took class Math 124 in 2002 took classes in 2004 taught by professors rated on average greater than 3.5
CREATE VIEW vwMath124instr34
AS
SELECT S.StudentID, S.StudentFname, S.StudentLname
FROM tblSTUDENT S
JOIN tblCLASS_LIST CL ON S.StudentID = CL.StudentID
JOIN tblCLASS C ON CL.ClassID = C.ClassID
JOIN tblCOURSE CR ON C.CourseID = CR.CourseID
JOIN tblEVALUATION E ON C.ClassID = E.ClassID
JOIN tblINSTRUCTOR_CLASS IC ON C.ClassID = IC.ClassID
JOIN tblINSTRUCTOR I ON IC.InstructorID = I.InstructorID
WHERE CR.CourseName = 'Math 124'
AND C.YEAR = '2002'
AND S.StudentID IN
    (SELECT S.StudentID
     FROM tblSTUDENT S
     JOIN tblCLASS_LIST CL ON S.StudentID = CL.StudentID
     JOIN tblCLASS C ON CL.ClassID = C.ClassID
     JOIN tblEVALUATION E ON C.ClassID = E.ClassID
     JOIN tblINSTRUCTOR_CLASS IC ON C.ClassID = IC.ClassID
     JOIN tblINSTRUCTOR I ON IC.InstructorID = I.InstructorID
     WHERE I.InstructorEvalAvg >= '3.5'
     AND C.YEAR = '2004')

--Which was the highest rated instructor for classes in 2004 - 2006 that has taught over 10 classes.
CREATE VIEW vwBestInstructorEver
AS
SELECT TOP 1 with TIES I.InstructorFname, I.InstructorLname, AVG(ED.Rating) AS TotalRating
FROM tblINSTRUCTOR I
JOIN tblINSTRUCTOR_CLASS IC on I.InstructorID = IC.InstructorID
JOIN tblCLASS C on IC.ClassID = C.ClassID
JOIN tblEVALUATION E on C.ClassID = E.ClassID
JOIN tblEVALUATION_DETAIL ED on E.EvaluationID = ED.EvaluationID
JOIN tblDETAIL D on ED.DetailID = D.DetailID
WHERE C.YEAR >= '2004' AND C.YEAR <= '2006'
AND I.InstructorID IN
(
SELECT I.InstructorID
FROM tblINSTRUCTOR I
JOIN tblINSTRUCTOR_CLASS IC on I.InstructorID = IC.InstructorID
JOIN tblCLASS C on IC.ClassID = C.ClassID
GROUP BY I.InstructorID
HAVING COUNT(*) >= 10
)
GROUP BY I.InstructorFname, I.InstructorLname
ORDER BY TotalRating DESC


---------------------------------BUSINESS RULES--------------------------------

CREATE FUNCTION fn_ratingRule()
RETURNS INT
AS
BEGIN
    DECLARE @Ret INT = 0
    IF EXISTS(
        SELECT *
        FROM tblEVALUATION_DETAIL
        WHERE Rating NOT BETWEEN '0'AND '5'
    )
    BEGIN
        SET @Ret = 1
    end
RETURN @Ret
end

GO

ALTER TABLE tblEVALUATION_DETAIL
ADD CONSTRAINT CK_rating
CHECK (dbo.fn_ratingRule() = 0)


-- MATH 124 cannot be taught by Gregory Hay
CREATE FUNCTION fn_Math124_Greg_hey()
RETURNS INT
AS
BEGIN
    DECLARE @Ret INT = 0
    IF EXISTS(
        SELECT *
        FROM tblCOURSE CR
        JOIN tblCLASS C ON CR.CourseID = C.CourseID
        JOIN tblINSTRUCTOR_CLASS IC ON C.ClassID = IC.ClassID
        JOIN tblINSTRUCTOR I ON IC.InstructorID = I.InstructorID
        WHERE CR.CourseName = 'MATH 124'
        AND I.InstructorFname = 'Greg'
        AND I.InstructorLname = 'Hay'
    )
    BEGIN
        SET @Ret = 1
    end
RETURN @Ret
end
GO
ALTER TABLE tblINSTRUCTOR_CLASS
ADD CONSTRAINT CK_MATH124
CHECK (dbo.fn_Math124_Greg_hey() = 0)


--------------------------------COMPUTED COLUMNS-------------------------------
CREATE FUNCTION fn_highestRatedClass(@PKID INT)
RETURNS INT
AS
BEGIN
    DECLARE @Ret INT = (
        SELECT TOP 1 CR.CourseID
        FROM tblCOURSE CR
        JOIN tblCLASS C ON CR.CourseID = C.CourseID
        JOIN tblINSTRUCTOR_CLASS IC ON C.ClassID = IC.ClassID
        JOIN tblINSTRUCTOR I ON IC.InstructorID = I.InstructorID
        JOIN tblEVALUATION E on C.ClassID = E.ClassID
        JOIN tblEVALUATION_DETAIL ED on E.EvaluationID = ED.EvaluationID
        WHERE I.InstructorID = @PKID
        GROUP BY CR.CourseID
        ORDER BY AVG(Rating) DESC
    )
RETURN @Ret
end
GO
ALTER TABLE tblINSTRUCTOR
ADD HighestRatedCourse AS (dbo.fn_highestRatedClass(InstructorID))

-- Number of students in a class (Just count class list) - Palash ADDED
CREATE FUNCTION fn_NumOfStudentsEnrolled(@PKID INT)
RETURNS INT
AS
BEGIN
    DECLARE @Ret INT = (
        SELECT Count(*) AS TotalStudents
        FROM tblCLASS_LIST CL
        JOIN tblCLASS C on CL.ClassID = C.ClassID
        WHERE C.ClassID = @PKID
    )
RETURN @Ret
end

ALTER TABLE tblCLASS
ADD NumEnrolled AS (dbo.fn_NumOfStudentsEnrolled(ClassID))


----------------------------------POPULATIONS----------------------------------
EXECUTE uspEvaluationDetail
'4', 'Instructor: Workload', '2'

INSERT INTO tblEVALUATION_DETAIL
    VALUES
EXECUTE uspDepartment
'Arts and Sciences', 'Mathematics', '1+1=2'
GO
EXEC uspDepartment
 'Arts and Sciences', 'Economics', 'Foster Rejects'
GO
EXECUTE uspDepartment
 'Built Environments', 'Architecture', 'We build stuff'
GO
EXECUTE uspDepartment
 'Business (Foster)', 'Finance & Business Economics', 'We love money'
GO
EXECUTE uspDepartment
 'Engineering', 'Computer Science', 'We get the most funding'
GO
EXECUTE uspDepartment
 'Dentistry', 'Department of Oral Health Sciences', 'We judge you by looking at your teeth'
GO
EXECUTE uspDepartment
 'Education', 'Department of Education', 'We teach how to teach'
GO
EXECUTE uspDepartment
 'Engineering', 'Department of Electrical Engineering', 'We are Computer Engineering Rejects'
GO
EXECUTE uspDepartment
 'Environment', 'Aquatic and Fishery Sciences', 'We have the farthest building on campus'
GO
EXECUTE uspDepartment
 'Law', 'Law', 'Dont mess with us'
GO
 EXECUTE uspDepartment
 'Information School', 'Informatics', 'Grades dont matter to us'
 GO
    EXECUTE uspDepartment
 'Medicine', 'Microbiology', 'Best STEM open major'
    GO
    EXECUTE uspDepartment
 'Nursing', 'Nursing', 'Same as College of Medicine'
    GO
EXECUTE uspDepartment
 'Pharmacy', 'Pharmacy', 'We want people to get sick'