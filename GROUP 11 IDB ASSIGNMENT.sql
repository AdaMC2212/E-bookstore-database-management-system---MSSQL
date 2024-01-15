Create Database GRP11;

Use GRP11;

Create table Member
(MemberID nvarchar(50) Not Null Primary Key,
Name nvarchar(50),
Address nvarchar(50),
Contact nvarchar(50));

Create Table Publisher
(PublisherID nvarchar(50) NOT NULL PRIMARY KEY,
Name nvarchar(50),
Address nvarchar(50),
Contact nvarchar(50));

Create Table Book
(BookID nvarchar(50) NOT NULL PRIMARY KEY, 
Name nvarchar(50), 
Genre nvarchar(50), 
Price decimal(10,2), 
Stock int, 
Author nvarchar(50), 
PublisherID nvarchar(50) FOREIGN KEY REFERENCES Publisher(PublisherID) );

Create table Rating
(RatingID nvarchar(50) Not Null Primary Key,
Score int,
Feedback nvarchar(50),
MemberID nvarchar(50) Foreign Key References Member(MemberID),
BookID nvarchar(50) Foreign Key References Book(BookID));

Create Table ShoppingCart
(CartID nvarchar(50) NOT NULL PRIMARY KEY,
Quantity int,  
Total decimal(10,2),
CheckOut_Status nvarchar(50) NOT NULL,
BookID nvarchar(50) FOREIGN KEY REFERENCES Book(BookID),
MemberID nvarchar(50) FOREIGN KEY REFERENCES Member(MemberID)); 

Create Table ManagerOrder
(OrderID nvarchar(50) NOT NULL PRIMARY KEY,
Quantity int,  
PublisherID nvarchar(50) FOREIGN KEY REFERENCES Publisher(PublisherID));

CREATE TABLE Payment 
(PaymentID nvarchar(50) NOT NULL PRIMARY KEY,
Date DATE NOT NULL,
PaymentStatus nvarchar(50),
PaymentMethod nvarchar(50),
CartID nvarchar(50) FOREIGN KEY REFERENCES ShoppingCart(CartID));

CREATE TABLE Delivery 
(DeliveryID nvarchar(50) NOT NULL PRIMARY KEY,
DeliveryStatus nvarchar(50),
EstimatedDeliveryDate DATE,
MemberID nvarchar(50) FOREIGN KEY REFERENCES Member(MemberID),
PaymentID nvarchar(50) FOREIGN KEY REFERENCES Payment(PaymentID));

CREATE TABLE OrderBook_Bridge
(ID nvarchar(50) NOT NULL PRIMARY KEY,
BookID nvarchar(50) FOREIGN KEY REFERENCES Book(BookID),
OrderID nvarchar(50) FOREIGN KEY REFERENCES ManagerOrder(OrderID));

Insert Into Publisher values
('P01', 'Literary', 'Puchong', '60134567890'),
('P02', 'Smart Publishing', 'Penang', '60123689356'),
('P03', 'Royal Books', 'Johor', '60195628353'),
('P04', 'Perfect Note Records', 'Klang', '60112983456'),
('P05', 'Book Company', 'Bukit Jalil', '60182937364');

Insert Into Book values
('B01', 'Annabelle', 'Horror', '20.50', '50', 'Anna', 'P01'),
('B02', 'Harry Potter', 'Magical', '85.50', '80', 'Rowling', 'P01'),
('B03', 'Jurrasic Park', 'Adventure', '35.50', '40', 'Lucy', 'P01'),
('B04', 'Star Wars', 'Science Fiction', '30.00', '50', 'Stella', 'P02'),
('B05', 'Hunger Games', 'Science Fiction', '20.00', '60', 'Julia', 'P03'),
('B06', 'Science World', 'Science Fiction', '20.50', '70', 'Lynn', 'P04'),
('B07', 'Percy Jackson', 'Adventure', '35.00', '40', 'Mag', 'P05'),
('B08', 'Romeo and Juliet', 'Romance', '25.00', '30', 'Jazz', 'P05');

insert into Member values
('M01','Adam','Cheras','60162177328'),
('M02','Hayley','Bukit Jalil','60162135454'),
('M03','Harry','Subang','60123829336'),
('M04','James','Puchong','60162118164'),
('M05','Sebastian','Kuala Lumpur','60162360469');

insert into Rating values
('R01','6','Good','M01','B01'),
('R02','8','Very good','M01','B02'),
('R03','8','Very good','M03','B03'),
('R04','2','Very bad','M04','B04'),
('R05','3','Very bad','M05','B05'),
('R06','4','Bad','M04','B05'),
('R07','10','Very Good','M01','B03'),
('R08','9','Very Good','M03','B06'),
('R09','9','Very Good','M04','B06'),
('R10','9','Very Good','M05','B06');

INSERT INTO Payment VALUES 
('G1', '17 February 2023', 'Paid', 'TNG', 'A1'),
('G2', '15 June 2023', 'Pending', 'Debit Card', 'A2'),
('G3', '22 August 2023', 'Pending', 'Debit Card', 'A3'),
('G4', '14 February 2023', 'Paid', 'Online Transfer', 'A4'),
('G5', '20 May 2023', 'Paid', 'TNG', 'A5'),
('G6', '21 May 2023', 'Paid', 'Debit Card', 'A6');

INSERT INTO Delivery VALUES 
('D1', 'Delivered', '20 February 2023', 'M01', 'G1'),
('D2', 'Packed', '20 June 2023', 'M02', 'G2'),
('D3', 'Delivered', '30 August 2023', 'M03', 'G3'),
('D4', 'Delivered', '20 February 2023', 'M04', 'G4'),
('D5', 'Packed', '31 May 2023', 'M05', 'G5'),
('D6', 'Packed', '1 June 2023', 'M01', 'G6');

Insert Into ManagerOrder values
('D01', '55', 'P01'),
('D02', '35', 'P02'),
('D03', '30', 'P03'),
('D04', '25', 'P04'),
('D05', '15', 'P05'),
('D06', '10', 'P01');

Insert Into OrderBook_Bridge values
('1', 'B01', 'D01'),
('2', 'B02', 'D02'),
('3', 'B03', 'D03'),
('4', 'B04', 'D04'),
('5', 'B05', 'D05'),
('6', 'B06', 'D06');
 
Insert Into ShoppingCart values
('A1','2','41','Yes','B01','M01'),
('A2','3','256.5','Yes','B02','M04'),
('A3','1','35.5','No','B03','M03'),
('A4','1','30','Yes','B04','M04'),
('A5','4','20','No','B05','M05'),
('A6','5','20.5','Yes','B06','M04'),
('A7','1','20.5','Yes','B06','M03'),
('A8','1','20.5','Yes','B06','M04'),
('A9','1','20.5','Yes','B06','M05'),
('A10','1','85.5','No','B02','M01'),
('A11','1','35.5','No','B03','M01');

--Q1
Select Publisher.PublisherID, Publisher.Name,
COUNT(BookID) as BookNum 
From Publisher
Left Join Book On Publisher.PublisherID = Book.PublisherID
Group By Publisher.PublisherID, Publisher.Name;

--Q2
SELECT CartID, Quantity, Total,Checkout_Status, BookID, MemberID
FROM ShoppingCart
WHERE Checkout_Status = 'No'
ORDER BY MemberID;

--Q3
SELECT Book.BookID, Book.Name, AVG(Rating.Score) as avg_rating 
FROM Book
INNER JOIN Rating ON Book.BookID = Rating.BookID
GROUP BY Book.BookID, Book.Name

HAVING AVG(Rating.Score) = 
(SELECT MAX(avg_rating) 
FROM (SELECT AVG(Score) as avg_rating 
FROM Rating GROUP BY BookID) as rating_averages)

--Q4
SELECT Member.MemberID, Member.Name, COUNT(*) AS total_Feedback
FROM Member
INNER JOIN Rating ON Member.MemberID = Rating.MemberID
GROUP BY Member.MemberID, Member.Name;

--Q5
SELECT Publisher.PublisherID, Publisher.Name, COUNT(Book.BookID) as BookNum
FROM Publisher
LEFT JOIN Book on Publisher.PublisherID = Book.PublisherID
WHERE Book.PublisherID 
IN (SELECT PublisherID FROM Book GROUP BY PublisherID

HAVING COUNT(Book.BookID) = 
(SELECT MAX(BookCount)
FROM 
(SELECT COUNT(Book.BookID) as BookCount 
FROM Book 
GROUP BY PublisherID) a))
GROUP BY Publisher.PublisherID, Publisher.Name;
--------------------------------------------------------------------------------
SELECT Publisher.PublisherID, Publisher.Name, COUNT(Book.BookID) as BookNum
FROM Publisher
LEFT JOIN Book on Publisher.PublisherID = Book.PublisherID
GROUP BY Publisher.PublisherID, Publisher.Name

HAVING COUNT(Book.BookID) = 
(SELECT MAX(most_book) 
FROM 
(SELECT COUNT(Book.BookID) as most_book 
FROM Publisher
LEFT JOIN Book on Publisher.PublisherID = Book.PublisherID
GROUP BY Publisher.PublisherID, Publisher.Name) a)

--Q6
SELECT Publisher.Name, SUM(ManagerOrder.Quantity) AS TotalBooksOrdered
FROM ManagerOrder
JOIN Publisher ON ManagerOrder.PublisherID = Publisher.PublisherID
JOIN OrderBook_Bridge ON ManagerOrder.OrderID = OrderBook_Bridge.OrderID
JOIN Book ON OrderBook_Bridge.BookID = Book.BookID
GROUP BY Publisher.Name;

--Q7
Select Genre, SUM(Stock) as max_stock
From Book
GROUP BY Genre

HAVING SUM(Stock) = 
(SELECT MAX(sum_stock) 
FROM 
(SELECT SUM(Stock) as sum_stock 
FROM Book 
GROUP BY Genre)a)

--Q8
Select Book.BookID, Book.Name, MAX(BestSelling.TotalBook) as TotalBook
From Book 
JOIN (SELECT BookID, SUM(Quantity) as TotalBook 
FROM ShoppingCart
WHERE CheckOut_Status = 'Yes' 
GROUP BY BookID) as BestSelling 
on Book.BookID = BestSelling.BookID
GROUP BY Book.BookID, Book.Name

HAVING MAX(BestSelling.TotalBook) = 
(SELECT MAX(TotalBook) FROM 
(SELECT SUM(Quantity) as TotalBook FROM ShoppingCart 
WHERE CheckOut_Status = 'Yes' 
GROUP BY BookID)b)
-------------------------------------------------------------------------------
Select Book.BookID, Book.Name, SUM(ShoppingCart.Quantity) as TotalBook
From Book 
JOIN ShoppingCart on ShoppingCart.BookID = Book.BookID
WHERE CheckOut_Status = 'Yes'
GROUP BY Book.BookID, Book.Name

HAVING SUM(ShoppingCart.Quantity) = 
(SELECT MAX(sum_stock) 
FROM 
(SELECT SUM(ShoppingCart.Quantity) as sum_stock 
FROM Book 
JOIN ShoppingCart on ShoppingCart.BookID = Book.BookID
WHERE CheckOut_Status = 'Yes' 
GROUP BY Book.BookID, Book.Name) a)

--Q9
SELECT Member.MemberID, Member.Name, MAX(ShoppingCartTotal.TotalSpent) as TotalSpent
FROM Member
LEFT JOIN (SELECT MemberID, SUM(Total) as TotalSpent FROM ShoppingCart
WHERE CheckOut_Status = 'Yes' GROUP BY MemberID) as ShoppingCartTotal 
on Member.MemberID = ShoppingCartTotal.MemberID
GROUP BY Member.MemberID, Member.Name

HAVING SUM(ShoppingCartTotal.TotalSpent) = 
(SELECT MAX(TotalSpent) FROM 
(SELECT SUM(Total) as TotalSpent FROM ShoppingCart 
WHERE CheckOut_Status = 'Yes' GROUP BY MemberID) as MaxTotalSpent)
-----------------------------------------------------------------------------------
SELECT Member.MemberID, Member.Name, SUM(ShoppingCart.Total) as TotalSpent
FROM Member
JOIN ShoppingCart on ShoppingCart.MemberID = Member.MemberID
WHERE CheckOut_Status = 'Yes'
GROUP BY Member.MemberID, Member.Name

HAVING SUM(ShoppingCart.Total) = 
(SELECT MAX(member_spent) 
FROM 
(SELECT SUM(ShoppingCart.Total) as member_spent
FROM Member 
JOIN ShoppingCart on ShoppingCart.MemberID = Member.MemberID
WHERE CheckOut_Status = 'Yes' 
GROUP BY Member.MemberID, Member.Name) a)

--Q10
SELECT Member.MemberID, Member.Name
FROM Member
LEFT JOIN ShoppingCart ON Member.MemberID = ShoppingCart.MemberID
WHERE ShoppingCart.CartID IS NULL;

--Q11
SELECT Book.Name AS BookName, ShoppingCart.BookID, ShoppingCart.MemberID, Delivery.DeliveryStatus
FROM ShoppingCart
LEFT JOIN Payment ON ShoppingCart.CartID = Payment.CartID
LEFT JOIN Delivery ON Payment.PaymentID = Delivery.PaymentID
LEFT JOIN Book ON ShoppingCart.BookID = Book.BookID
WHERE ShoppingCart.CheckOut_Status = 'Yes' AND Delivery.DeliveryStatus = 'Packed';

--Q12
SELECT Member.MemberID, Member.Name, COUNT(ShoppingCart.CartID) AS NumOrders
FROM Member
LEFT JOIN ShoppingCart ON Member.MemberID = ShoppingCart.MemberID
WHERE ShoppingCart.CheckOut_Status = 'Yes'
GROUP BY Member.MemberID, Member.Name
HAVING COUNT(Member.MemberID) > 2;











--Qxtra(book have no rating)
SELECT Book.BookID,Book.Name,COUNT(Rating.RatingID)as NumofRating
From Book
LEFT JOIN Rating ON Book.BookID = Rating.BookID
WHERE Rating.RatingID is NULL
GROUP BY Book.BookID,Book.Name









--Qxtra2(member dont give rating)
SELECT Member.MemberID, Member.Name, COUNT(Rating.RatingID) AS NumofFeedback
From Member
LEFT JOIN Rating ON Member.MemberID = Rating.MemberID
WHERE Rating.RatingID is NULL
GROUP BY Member.MemberID, Member.Name

--Qxtra3(book no one buy)
SELECT Book.BookID,Book.Name,COUNT(ShoppingCart.CartID)as NumofPeopleBuy
From Book
LEFT JOIN ShoppingCart ON Book.BookID = ShoppingCart.BookID
WHERE ShoppingCart.CheckOut_Status = 'No' or ShoppingCart.CartID is NULL
GROUP BY Book.BookID,Book.Name

--Qxtra4(rating > 5)
SELECT Member.MemberID, Member.Name, COUNT(Rating.RatingID) as NumofRatingBiggerThan5
From Member
LEFT JOIN Rating on Member.MemberID = Rating.MemberID
WHERE Rating.Score > 5
GROUP BY Member.MemberID, Member.Name

--(3 rating > 5)
HAVING COUNT (Rating.RatingID) > 2 

--(how many people give rating > 5)
SELECT COUNT(MemberID) AS NumofMembersGiveRatingMoreThan5
FROM
(SELECT (MemberID)
From 
Rating WHERE Score > 5
GROUP BY MemberID)a

--Qxtra5(people use debit card)
SELECT Member.MemberID, Member.Name, COUNT(PaymentID) as NumofDebitCardUsed
From Member
JOIN ShoppingCart ON Member.MemberID = ShoppingCart.MemberID
JOIN Payment ON ShoppingCart.CartID = Payment.CartID
Where PaymentMethod = 'Debit Card'
GROUP BY Member.MemberID, Member.Name

--(how many people use debitcard)
SELECT COUNT (PaymentMethod)
From
(SELECT PaymentMethod 
From Payment
JOIN ShoppingCart ON ShoppingCart.CartID = Payment.CartID
JOIN Member ON Member.MemberID = ShoppingCart.MemberID
Where PaymentMethod = 'Debit Card'
GROUP BY Member.MemberID,PaymentMethod
)a

