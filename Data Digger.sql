CREATE DATABASE IF NOT EXISTS data_digger;
USE data_digger;

-- Tables ko dobara run karne ke liye
DROP TABLE IF EXISTS OrderDetails;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Customers;


-- 1. CUSTOMERS TABLE
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100),
    Address VARCHAR(100)
);


-- 2. PRODUCTS TABLE
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Price DECIMAL(10,2),
    Stock INT
);


-- 3. ORDERS TABLE
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),

    FOREIGN KEY (CustomerID)
    REFERENCES Customers(CustomerID)
);


-- 4. ORDER DETAILS TABLE
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    SubTotal DECIMAL(10,2),

    FOREIGN KEY (OrderID)
    REFERENCES Orders(OrderID),

    FOREIGN KEY (ProductID)
    REFERENCES Products(ProductID)
);

--table insert karne ke liye
INSERT INTO Customers
(CustomerID, Name, Email, Address)
VALUES
(1, 'Alice', 'alice@gmail.com', 'Ahmedabad'),
(2, 'Omprakash', 'omprakash@gmail.com', 'Gujarat'),
(3, 'Rahul', 'rahul@gmail.com', 'Patna'),
(4, 'Priya', 'priya@gmail.com', 'Delhi'),
(5, 'Aman', 'aman@gmail.com', 'Mumbai');

--Insert table product
INSERT INTO Products
(ProductID, ProductName, Price, Stock)
VALUES
(101, 'Laptop', 55000.00, 10),
(102, 'Keyboard', 1200.00, 25),
(103, 'Mouse', 700.00, 30),
(104, 'Headphones', 1800.00, 15),
(105, 'USB Cable', 500.00, 0);


--insert order table
INSERT INTO Orders
(OrderID, CustomerID, OrderDate, TotalAmount)
VALUES
(1001, 1, DATE_SUB(CURDATE(), INTERVAL 2 DAY), 56200.00),
(1002, 2, DATE_SUB(CURDATE(), INTERVAL 5 DAY), 2500.00),
(1003, 3, DATE_SUB(CURDATE(), INTERVAL 10 DAY), 1800.00),
(1004, 4, DATE_SUB(CURDATE(), INTERVAL 20 DAY), 55700.00),
(1005, 1, DATE_SUB(CURDATE(), INTERVAL 40 DAY), 700.00);



INSERT INTO OrderDetails
(OrderDetailID, OrderID, ProductID, Quantity, SubTotal)
VALUES
(1, 1001, 101, 1, 55000.00),
(2, 1001, 102, 1, 1200.00),
(3, 1002, 103, 2, 1400.00),
(4, 1002, 104, 1, 1800.00),
(5, 1003, 104, 1, 1800.00),
(6, 1004, 101, 1, 55000.00),
(7, 1004, 103, 1, 700.00);


--all column 
SELECT * FROM Customers;

SELECT * FROM Customers WHERE Name = 'Alice';

SELECT * FROM Products ORDER BY Price DESC;

SELECT * FROM Products WHERE Price BETWEEN 500 AND 2000;

SELECT
    MAX(Price) AS Most_Expensive,
    MIN(Price) AS Cheapest
FROM Products;


SELECT * FROM Orders WHERE CustomerID = 1;

SELECT * FROM Orders WHERE OrderDate >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);

SELECT
    MAX(TotalAmount) AS Highest_Order,
    MIN(TotalAmount) AS Lowest_Order,
    AVG(TotalAmount) AS Average_Order
FROM Orders;


SELECT * FROM OrderDetails WHERE OrderID = 1001;


SELECT SUM(SubTotal) AS Total_Revenue
FROM OrderDetails;

SELECT
    p.ProductID,
    p.ProductName,
    SUM(od.Quantity) AS Total_Sold
FROM OrderDetails od
JOIN Products p
    ON od.ProductID = p.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY Total_Sold DESC
LIMIT 3;

SELECT
    ProductID,
    COUNT(*) AS Times_Sold
FROM OrderDetails
WHERE ProductID = 104
GROUP BY ProductID;

SELECT
    ProductID,
    SUM(Quantity) AS Total_Quantity_Sold
FROM OrderDetails
WHERE ProductID = 104
GROUP BY ProductID;


--data ko Update 
UPDATE Customers
SET Address = 'Nikol, Ahmedabad'
WHERE CustomerID = 2;


UPDATE Products
SET Price = 1500.00
WHERE ProductID = 102;


UPDATE Orders
SET TotalAmount = 57000.00
WHERE OrderID = 1001;

DELETE FROM Customers
WHERE CustomerID = 5;



DELETE FROM Products
WHERE ProductID = 105
AND Stock = 0;


DELETE FROM Orders
WHERE OrderID = 1005;