# 📊 Data Digger --- E-Commerce SQL Database Project

> **A practical MySQL project for learning database design, CRUD
> operations, relationships, filtering, and business analytics.**

## 🚀 Project Overview

**Data Digger** is a hands-on relational database project built around a
small e-commerce system.

Instead of working with isolated SQL queries, this project connects
customers, orders, products, and order details into a realistic database
structure. It is designed to strengthen practical MySQL skills through
data insertion, retrieval, updates, deletion, filtering, and aggregate
analysis.

### 🎯 Learning Goals

By completing this project, you will practice:

-   Designing relational database tables
-   Creating **Primary Keys** and **Foreign Keys**
-   Performing **CRUD operations**
-   Using `WHERE`, `ORDER BY`, and date conditions
-   Working with aggregate functions such as `SUM()`, `AVG()`, `MAX()`,
    `MIN()`, and `COUNT()`
-   Understanding relationships between tables
-   Writing queries that answer real business questions
-   Building a clean and reusable SQL project for GitHub

------------------------------------------------------------------------

## 🧩 Database Architecture

The project contains four main tables:

``` text
                    ┌─────────────────┐
                    │    Customers    │
                    ├─────────────────┤
                    │ CustomerID  PK  │
                    │ Name            │
                    │ Email           │
                    │ Address         │
                    └────────┬────────┘
                             │
                             │ 1 : N
                             ▼
                    ┌─────────────────┐
                    │      Orders     │
                    ├─────────────────┤
                    │ OrderID     PK  │
                    │ CustomerID  FK  │
                    │ OrderDate       │
                    │ TotalAmount     │
                    └────────┬────────┘
                             │
                             │ 1 : N
                             ▼
                  ┌─────────────────────┐
                  │    OrderDetails     │
                  ├─────────────────────┤
                  │ OrderDetailID   PK  │
                  │ OrderID         FK  │
                  │ ProductID       FK  │
                  │ Quantity            │
                  │ SubTotal            │
                  └──────────┬──────────┘
                             │
                             │ N : 1
                             ▼
                    ┌─────────────────┐
                    │     Products    │
                    ├─────────────────┤
                    │ ProductID   PK  │
                    │ ProductName     │
                    │ Price           │
                    │ Stock           │
                    └─────────────────┘
```

### 🔗 Relationships

  -----------------------------------------------------------------------
  Relationship                        Meaning
  ----------------------------------- -----------------------------------
  Customers → Orders                  One customer can place many orders

  Orders → OrderDetails               One order can contain multiple
                                      items

  Products → OrderDetails             One product can appear in many
                                      order details

  Orders ↔ Products                   Many-to-many relationship resolved
                                      through `OrderDetails`
  -----------------------------------------------------------------------

------------------------------------------------------------------------

# 🗂️ Table Design

## 1. Customers

Stores information about people who purchase products.

  Column         Suggested Type   Key
  -------------- ---------------- -------------
  `CustomerID`   `INT`            Primary Key
  `Name`         `VARCHAR(100)`   ---
  `Email`        `VARCHAR(150)`   ---
  `Address`      `VARCHAR(255)`   ---

### Operations

-   Add at least 5 customers
-   Display all customers
-   Update a customer's address
-   Delete a customer using `CustomerID`
-   Find the customer whose name is `Alice`

------------------------------------------------------------------------

## 2. Orders

Stores customer purchase information.

  Column          Suggested Type    Key
  --------------- ----------------- -------------
  `OrderID`       `INT`             Primary Key
  `CustomerID`    `INT`             Foreign Key
  `OrderDate`     `DATE`            ---
  `TotalAmount`   `DECIMAL(10,2)`   ---

### Operations

-   Add at least 5 orders
-   Find all orders of a particular customer
-   Update an order's total amount
-   Delete an order using `OrderID`
-   Find orders from the last 30 days
-   Calculate highest, lowest, and average order values

------------------------------------------------------------------------

## 3. Products

Stores the products available in the e-commerce store.

  Column          Suggested Type    Key
  --------------- ----------------- -------------
  `ProductID`     `INT`             Primary Key
  `ProductName`   `VARCHAR(150)`    ---
  `Price`         `DECIMAL(10,2)`   ---
  `Stock`         `INT`             ---

### Operations

-   Add at least 5 products
-   Display products from highest to lowest price
-   Update the price of a product
-   Remove a product when stock reaches zero
-   Find products priced between ₹500 and ₹2,000
-   Find the most expensive and cheapest product

------------------------------------------------------------------------

## 4. OrderDetails

Connects orders with products and records quantities sold.

  Column            Suggested Type    Key
  ----------------- ----------------- -------------
  `OrderDetailID`   `INT`             Primary Key
  `OrderID`         `INT`             Foreign Key
  `ProductID`       `INT`             Foreign Key
  `Quantity`        `INT`             ---
  `SubTotal`        `DECIMAL(10,2)`   ---

### Operations

-   Add at least 5 order-detail records
-   Display all items belonging to a specific order
-   Calculate total revenue using `SUM()`
-   Find the top 3 most-ordered products
-   Count how many times a selected product was sold

------------------------------------------------------------------------

# 🛠️ Recommended SQL Setup

## Create Database

``` sql
CREATE DATABASE data_digger;
USE data_digger;
```

## Create Customers

``` sql
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(150),
    Address VARCHAR(255)
);
```

## Create Products

``` sql
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(150) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Stock INT NOT NULL
);
```

## Create Orders

``` sql
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
```

## Create OrderDetails

``` sql
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    SubTotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
```

------------------------------------------------------------------------

# 🔍 Query Challenge

Use these tasks as a practical SQL checklist.

### Customer Analysis

``` sql
SELECT * FROM Customers;
```

``` sql
SELECT * FROM Customers
WHERE Name = 'Alice';
```

``` sql
UPDATE Customers
SET Address = 'Ahmedabad, Gujarat'
WHERE CustomerID = 1;
```

------------------------------------------------------------------------

### Order Analysis

``` sql
SELECT *
FROM Orders
WHERE CustomerID = 1;
```

``` sql
SELECT MAX(TotalAmount) AS Highest_Order,
       MIN(TotalAmount) AS Lowest_Order,
       AVG(TotalAmount) AS Average_Order
FROM Orders;
```

``` sql
SELECT *
FROM Orders
WHERE OrderDate >= CURRENT_DATE - INTERVAL 30 DAY;
```

------------------------------------------------------------------------

### Product Analysis

``` sql
SELECT *
FROM Products
ORDER BY Price DESC;
```

``` sql
SELECT *
FROM Products
WHERE Price BETWEEN 500 AND 2000;
```

``` sql
SELECT MAX(Price) AS Most_Expensive,
       MIN(Price) AS Cheapest
FROM Products;
```

------------------------------------------------------------------------

### Revenue Analysis

``` sql
SELECT SUM(SubTotal) AS Total_Revenue
FROM OrderDetails;
```

``` sql
SELECT ProductID,
       SUM(Quantity) AS Total_Sold
FROM OrderDetails
GROUP BY ProductID
ORDER BY Total_Sold DESC
LIMIT 3;
```

``` sql
SELECT COUNT(*) AS Times_Sold
FROM OrderDetails
WHERE ProductID = 101;
```

------------------------------------------------------------------------

# 📈 Business Questions

The database can be used to answer questions such as:

1.  Who are our customers?
2.  Which customers have placed orders?
3.  What is the average order value?
4.  What was the highest-value order?
5.  Which products are between ₹500 and ₹2,000?
6.  Which product has the highest price?
7.  Which products are selling the most?
8.  How much total revenue has been generated?
9.  Which products have low or zero stock?
10. How many times has a particular product been sold?

------------------------------------------------------------------------

# 🧠 SQL Concepts Practiced

  Concept             Used For
  ------------------- -------------------------------
  `CREATE DATABASE`   Creating the project database
  `CREATE TABLE`      Designing tables
  `INSERT`            Adding records
  `SELECT`            Reading data
  `UPDATE`            Modifying data
  `DELETE`            Removing data
  `WHERE`             Filtering records
  `ORDER BY`          Sorting results
  `BETWEEN`           Filtering ranges
  `CURRENT_DATE`      Working with current dates
  `INTERVAL`          Date calculations
  `SUM()`             Total revenue
  `AVG()`             Average order value
  `MAX()`             Highest value
  `MIN()`             Lowest value
  `COUNT()`           Counting records
  `GROUP BY`          Grouping data
  Primary Key         Uniquely identifying records
  Foreign Key         Connecting related tables

------------------------------------------------------------------------

# 📁 Suggested Project Structure

``` text
Data-Digger/
│
├── README.md
├── database.sql
├── customers.sql
├── products.sql
├── orders.sql
├── order_details.sql
└── screenshots/
    ├── database.png
    ├── tables.png
    └── query-results.png
```

------------------------------------------------------------------------

# ▶️ How to Run

### Option 1 --- phpMyAdmin

1.  Open **phpMyAdmin**
2.  Create the `data_digger` database
3.  Open the **SQL** section
4.  Run the table-creation queries
5.  Insert sample records
6.  Execute the analysis queries

### Option 2 --- MySQL Command Line

``` sql
SOURCE database.sql;
```

Then select the database:

``` sql
USE data_digger;
```

------------------------------------------------------------------------

# 🧪 Project Workflow

``` text
Design Database
      ↓
Create Tables
      ↓
Define Primary & Foreign Keys
      ↓
Insert Sample Data
      ↓
Test CRUD Operations
      ↓
Run Filtering Queries
      ↓
Perform Aggregate Analysis
      ↓
Check Relationships
      ↓
Document Results
```

------------------------------------------------------------------------

# 💡 Possible Future Improvements

This project can later be extended with:

-   `Categories` table
-   `Payments` table
-   `Shipping` table
-   Customer order history
-   Product-category relationships
-   Monthly revenue reports
-   Best-selling product reports
-   Customer spending analysis
-   Views for frequently used reports
-   Stored procedures
-   Triggers
-   SQL joins for advanced reporting
-   A Python application connected to MySQL

------------------------------------------------------------------------

# 🎓 Skills Demonstrated

By completing **Data Digger**, you demonstrate practical knowledge of:

**MySQL • Relational Database Design • CRUD • Primary Keys • Foreign
Keys • Filtering • Sorting • Aggregate Functions • Date Queries • Data
Analysis • Database Relationships**

------------------------------------------------------------------------

## 👨‍💻 Author

kush kumar





