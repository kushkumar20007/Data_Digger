# 🔍 Data Digger — SQL Database Project (MySQL)

Data Digger is a hands-on relational database project built around a small e-commerce system. Instead of working with isolated SQL queries, this project connects **customers**, **orders**, **products**, and **order details** into a realistic, connected database structure. It is designed to strengthen practical MySQL skills through data insertion, retrieval, updates, deletion, filtering, and aggregate analysis.

---

## 📌 Objective

Data Digger is a hands-on relational database project built around a small e-commerce system.
Instead of working with isolated SQL queries, this project connects customers, orders, products, and order details into a realistic database structure. It is designed to strengthen practical MySQL skills through data insertion, retrieval, updates, deletion, filtering, and aggregate analysis.

---

## 🗂️ Project Structure

| File | Description |
|---|---|
| `data_digger.sql` | Complete SQL script — schema creation, data insertion, queries, updates & deletes |
| `README.md` | Project documentation (this file) |

---

## 🏗️ Database Schema

The database `data_digger` contains **4 relational tables**:

### 1. `Customers`

| Column | Type | Constraint |
|---|---|---|
| CustomerID | INT | PRIMARY KEY |
| Name | VARCHAR(100) | NOT NULL |
| Email | VARCHAR(100) | — |
| Address | VARCHAR(100) | — |

### 2. `Products`

| Column | Type | Constraint |
|---|---|---|
| ProductID | INT | PRIMARY KEY |
| ProductName | VARCHAR(100) | NOT NULL |
| Price | DECIMAL(10,2) | — |
| Stock | INT | — |

### 3. `Orders`

| Column | Type | Constraint |
|---|---|---|
| OrderID | INT | PRIMARY KEY |
| CustomerID | INT | FOREIGN KEY → Customers(CustomerID) |
| OrderDate | DATE | — |
| TotalAmount | DECIMAL(10,2) | — |

### 4. `OrderDetails`

| Column | Type | Constraint |
|---|---|---|
| OrderDetailID | INT | PRIMARY KEY |
| OrderID | INT | FOREIGN KEY → Orders(OrderID) |
| ProductID | INT | FOREIGN KEY → Products(ProductID) |
| Quantity | INT | — |
| SubTotal | DECIMAL(10,2) | — |

### 🔗 Entity Relationship

```
Customers (1) ──< Orders (many)
Orders (1) ──< OrderDetails (many)
Products (1) ──< OrderDetails (many)
```

---

## ⚙️ Setup Instructions

1. Open MySQL Workbench / CLI / any MySQL client.
2. Run the full script:
   ```bash
   mysql -u root -p < data_digger.sql
   ```
3. This will create the `data_digger` database, all 4 tables, insert sample data, and run every query in order.
4. All date-based outputs below are calculated relative to **CURDATE() = 2026-09-11**. Since `OrderDate` uses `DATE_SUB(CURDATE(), INTERVAL n DAY)`, your actual output dates will shift with the day you run the script — only the *day-offset logic* stays the same.

---
## 🎥 Video Demonstration

[![Watch Video](https://img.shields.io/badge/🎥-Watch_Video-red?style=for-the-badge)](https://drive.google.com/file/d/13LwT6KuQNcvGsNKGj6dXQN4nBAsPU3RU/view?usp=sharing)

## 📊 Initial Seed Data

### Customers (5 rows inserted)

| CustomerID | Name | Email | Address |
|---|---|---|---|
| 1 | Alice | alice@gmail.com | Ahmedabad |
| 2 | Omprakash | omprakash@gmail.com | Gujarat |
| 3 | Rahul | rahul@gmail.com | Patna |
| 4 | Priya | priya@gmail.com | Delhi |
| 5 | Aman | aman@gmail.com | Mumbai |

### Products (5 rows inserted)

| ProductID | ProductName | Price | Stock |
|---|---|---|---|
| 101 | Laptop | 55,000.00 | 10 |
| 102 | Keyboard | 1,200.00 | 25 |
| 103 | Mouse | 700.00 | 30 |
| 104 | Headphones | 1,800.00 | 15 |
| 105 | USB Cable | 500.00 | 0 |

### Orders (5 rows inserted)

Dates shown are relative to CURDATE() = `2026-09-11`.


| OrderID | CustomerID | OrderDate (CURDATE − n days) | TotalAmount |
|---|---|---|---|
| 1001 | 1 | 2026-09-09  (−2 days) | 56,200.00 |
| 1002 | 2 | 2026-09-06  (−5 days) | 2,500.00 |
| 1003 | 3 | 2026-09-01  (−10 days) | 1,800.00 |
| 1004 | 4 | 2026-08-22  (−20 days) | 55,700.00 |
| 1005 | 1 | 2026-08-02  (−40 days) | 700.00 |

### OrderDetails (7 rows inserted)

| OrderDetailID | OrderID | ProductID | Quantity | SubTotal |
|---|---|---|---|---|
| 1 | 1001 | 101 | 1 | 55,000.00 |
| 2 | 1001 | 102 | 1 | 1,200.00 |
| 3 | 1002 | 103 | 2 | 1,400.00 |
| 4 | 1002 | 104 | 1 | 1,800.00 |
| 5 | 1003 | 104 | 1 | 1,800.00 |
| 6 | 1004 | 101 | 1 | 55,000.00 |
| 7 | 1004 | 103 | 1 | 700.00 |

---

## 🔎 Query-by-Query Documentation

Every query from `data_digger.sql` is explained below in the **same order** it appears in the script, along with its actual output table.

### 1. Fetch all customers

**Query:**

```sql
SELECT * FROM Customers;
```

*Returns every row from the Customers table.*

**Output:**

| CustomerID | Name | Email | Address |
|---|---|---|---|
| 1 | Alice | alice@gmail.com | Ahmedabad |
| 2 | Omprakash | omprakash@gmail.com | Gujarat |
| 3 | Rahul | rahul@gmail.com | Patna |
| 4 | Priya | priya@gmail.com | Delhi |
| 5 | Aman | aman@gmail.com | Mumbai |


### 2. Find a customer by name

**Query:**

```sql
SELECT * FROM Customers WHERE Name = 'Alice';
```

*Filters Customers where Name = 'Alice'.*

**Output:**

| CustomerID | Name | Email | Address |
|---|---|---|---|
| 1 | Alice | alice@gmail.com | Ahmedabad |


### 3. List products sorted by price (high → low)

**Query:**

```sql
SELECT * FROM Products ORDER BY Price DESC;
```

*Sorts all products by Price in descending order.*

**Output:**

| ProductID | ProductName | Price | Stock |
|---|---|---|---|
| 101 | Laptop | 55,000.00 | 10 |
| 104 | Headphones | 1,800.00 | 15 |
| 102 | Keyboard | 1,200.00 | 25 |
| 103 | Mouse | 700.00 | 30 |
| 105 | USB Cable | 500.00 | 0 |


### 4. Products within a price range

**Query:**

```sql
SELECT * FROM Products WHERE Price BETWEEN 500 AND 2000;
```

*Filters products priced between ₹500 and ₹2000 (inclusive).*

**Output:**

| ProductID | ProductName | Price | Stock |
|---|---|---|---|
| 102 | Keyboard | 1,200.00 | 25 |
| 103 | Mouse | 700.00 | 30 |
| 104 | Headphones | 1,800.00 | 15 |
| 105 | USB Cable | 500.00 | 0 |


### 5. Most expensive & cheapest product

**Query:**

```sql
SELECT
    MAX(Price) AS Most_Expensive,
    MIN(Price) AS Cheapest
FROM Products;
```

*Aggregate query — finds highest and lowest product price.*

**Output:**

| Most_Expensive | Cheapest |
|---|---|
| 55,000.00 | 500.00 |


### 6. Orders placed by a specific customer

**Query:**

```sql
SELECT * FROM Orders WHERE CustomerID = 1;
```

*Returns all orders placed by CustomerID = 1 (Alice).*

**Output:**

| OrderID | CustomerID | OrderDate | TotalAmount |
|---|---|---|---|
| 1001 | 1 | 2026-09-09 | 56,200.00 |
| 1005 | 1 | 2026-08-02 | 700.00 |


### 7. Orders placed in the last 30 days

**Query:**

```sql
SELECT * FROM Orders WHERE OrderDate >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);
```

*Uses date filtering; excludes Order 1005 since it was placed 40 days ago (before the 30-day cutoff of 2026-08-02).*

**Output:**

| OrderID | CustomerID | OrderDate | TotalAmount |
|---|---|---|---|
| 1001 | 1 | 2026-09-09 | 56,200.00 |
| 1002 | 2 | 2026-09-06 | 2,500.00 |
| 1003 | 3 | 2026-09-01 | 1,800.00 |
| 1004 | 4 | 2026-08-22 | 55,700.00 |


### 8. Order amount statistics

**Query:**

```sql
SELECT
    MAX(TotalAmount) AS Highest_Order,
    MIN(TotalAmount) AS Lowest_Order,
    AVG(TotalAmount) AS Average_Order
FROM Orders;
```

*Aggregate query across all 5 orders (highest, lowest, average order value).*

**Output:**

| Highest_Order | Lowest_Order | Average_Order |
|---|---|---|
| 56,200.00 | 700.00 | 23,380.00 |


### 9. Items within a specific order

**Query:**

```sql
SELECT * FROM OrderDetails WHERE OrderID = 1001;
```

*Returns line items belonging to Order 1001 (Laptop + Keyboard).*

**Output:**

| OrderDetailID | OrderID | ProductID | Quantity | SubTotal |
|---|---|---|---|---|
| 1 | 1001 | 101 | 1 | 55,000.00 |
| 2 | 1001 | 102 | 1 | 1,200.00 |


### 10. Total revenue generated

**Query:**

```sql
SELECT SUM(SubTotal) AS Total_Revenue
FROM OrderDetails;
```

*Sums SubTotal across every order line item to get total revenue.*

**Output:**

| Total_Revenue |
|---|
| 116,900.00 |


### 11. Top 3 best-selling products

**Query:**

```sql
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
```

*JOIN + GROUP BY + ORDER BY + LIMIT — a classic sales-ranking query.*

**Output:**

| ProductID | ProductName | Total_Sold |
|---|---|---|
| 103 | Mouse | 3 |
| 101 | Laptop | 2 |
| 104 | Headphones | 2 |


### 12. Number of times a product was ordered

**Query:**

```sql
SELECT
    ProductID,
    COUNT(*) AS Times_Sold
FROM OrderDetails
WHERE ProductID = 104
GROUP BY ProductID;
```

*Counts how many separate order lines contain ProductID 104 (Headphones).*

**Output:**

| ProductID | Times_Sold |
|---|---|
| 104 | 2 |


### 13. Total quantity sold for a product

**Query:**

```sql
SELECT
    ProductID,
    SUM(Quantity) AS Total_Quantity_Sold
FROM OrderDetails
WHERE ProductID = 104
GROUP BY ProductID;
```

*Sums the Quantity column (not row count) for ProductID 104.*

**Output:**

| ProductID | Total_Quantity_Sold |
|---|---|
| 104 | 2 |


---

## ✏️ Update Queries

### 1. Update a customer's address

**Query:**
```sql
UPDATE Customers
SET Address = 'Nikol, Ahmedabad'
WHERE CustomerID = 2;
```

**Rows affected:** `1`

**Before:**

| CustomerID | Name | Email | Address |
|---|---|---|---|
| 2 | Omprakash | omprakash@gmail.com | Gujarat |

**After:**

| CustomerID | Name | Email | Address |
|---|---|---|---|
| 2 | Omprakash | omprakash@gmail.com | Nikol, Ahmedabad |


### 2. Update a product's price

**Query:**
```sql
UPDATE Products
SET Price = 1500.00
WHERE ProductID = 102;
```

**Rows affected:** `1`

**Before:**

| ProductID | ProductName | Price | Stock |
|---|---|---|---|
| 102 | Keyboard | 1,200.00 | 25 |

**After:**

| ProductID | ProductName | Price | Stock |
|---|---|---|---|
| 102 | Keyboard | 1,500.00 | 25 |


### 3. Correct an order's total amount

**Query:**
```sql
UPDATE Orders
SET TotalAmount = 57000.00
WHERE OrderID = 1001;
```

**Rows affected:** `1`

**Before:**

| OrderID | CustomerID | OrderDate | TotalAmount |
|---|---|---|---|
| 1001 | 1 | 2026-09-09 | 56,200.00 |

**After:**

| OrderID | CustomerID | OrderDate | TotalAmount |
|---|---|---|---|
| 1001 | 1 | 2026-09-09 | 57,000.00 |


---

## 🗑️ Delete Queries

### 1. Remove a customer

**Query:**
```sql
DELETE FROM Customers
WHERE CustomerID = 5;
```

**Rows affected:** `1` — Customer *Aman* (CustomerID 5) is removed.

### 2. Remove an out-of-stock product

**Query:**
```sql
DELETE FROM Products
WHERE ProductID = 105
AND Stock = 0;
```

**Rows affected:** `1` — *USB Cable* (ProductID 105, Stock = 0) is removed since the condition matched.

### 3. Remove an order

**Query:**
```sql
DELETE FROM Orders
WHERE OrderID = 1005;
```

**Rows affected:** `1` — Order 1005 is removed.

---

## 📈 Final Database State (after all Updates & Deletes)

### Customers

| CustomerID | Name | Email | Address |
|---|---|---|---|
| 1 | Alice | alice@gmail.com | Ahmedabad |
| 2 | Omprakash | omprakash@gmail.com | Nikol, Ahmedabad |
| 3 | Rahul | rahul@gmail.com | Patna |
| 4 | Priya | priya@gmail.com | Delhi |

### Products

| ProductID | ProductName | Price | Stock |
|---|---|---|---|
| 101 | Laptop | 55,000.00 | 10 |
| 102 | Keyboard | 1,500.00 | 25 |
| 103 | Mouse | 700.00 | 30 |
| 104 | Headphones | 1,800.00 | 15 |

### Orders

| OrderID | CustomerID | OrderDate | TotalAmount |
|---|---|---|---|
| 1001 | 1 | 2026-09-09 | 57,000.00 |
| 1002 | 2 | 2026-09-06 | 2,500.00 |
| 1003 | 3 | 2026-09-01 | 1,800.00 |
| 1004 | 4 | 2026-08-22 | 55,700.00 |

---

## 🧠 Key SQL Concepts Practiced

- `CREATE DATABASE` / `CREATE TABLE` with `PRIMARY KEY` & `FOREIGN KEY` constraints
- Multi-table relational design (1-to-many relationships)
- `INSERT INTO ... VALUES` (bulk inserts)
- Filtering with `WHERE`, `BETWEEN`, and date functions (`CURDATE()`, `DATE_SUB()`)
- Sorting with `ORDER BY`
- Aggregate functions: `MAX()`, `MIN()`, `AVG()`, `SUM()`, `COUNT()`
- `JOIN` across related tables
- `GROUP BY` with `LIMIT` for top-N analysis
- `UPDATE ... SET ... WHERE`
- `DELETE ... WHERE` with compound conditions

---

## 🛠️ Tech Stack

- **Database:** MySQL
- **Language:** SQL (DDL, DML, DQL)
- **Documentation & simulation:** Python (`sqlite3`) — used to compute and verify every query's exact output for this README

---

## 🚀 Possible Future Enhancements

- Add a `Categories` table and link it to `Products`
- Add stored procedures for placing a new order end-to-end
- Add views for common reports (e.g., monthly revenue, low-stock alerts)
- Add indexes on `Orders.CustomerID` and `OrderDetails.OrderID` for performance

👨‍💻 Author
Name: Kush Kumar
