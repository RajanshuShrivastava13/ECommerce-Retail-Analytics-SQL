-- =========================================================================
-- PROJECT: ONLINE RETAIL & E-COMMERCE BUSINESS ANALYTICS
-- DATABASE ENGINE: MySQL
-- DEVELOPER: RAJANSHU SHRIVASTAVA
-- =========================================================================

-- -------------------------------------------------------------------------
-- PART 1: SCHEMA DESIGN & DATA MODELING (DDL & DML)
-- -------------------------------------------------------------------------

-- 1. Create Tables with Constraints
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL
);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    CategoryID INT,
    Stock INT NOT NULL DEFAULT 0,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderItems (
    OrderItemID INT AUTO_INCREMENT PRIMARY KEY, 
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- 2. Insert Mock Data
INSERT INTO Categories VALUES (1, 'Electronics'), (2, 'Clothing'), (3, 'Home Decor');

INSERT INTO Customers VALUES 
(101, 'Rajanshu Shrivastava', 'Shahdol'),
(102, 'Astha Shrivastava', 'Bhopal'),
(103, 'Amit Sharma', 'Indore'),
(104, 'Vikram Malhotra', 'Delhi'),
(105, 'Suresh Patel', 'Mumbai');

INSERT INTO Products VALUES 
(501, 'Laptop', 65000.00, 1, 15),
(502, 'Smartphone', 25000.00, 1, 30),
(503, 'T-Shirt', 1200.00, 2, 50),
(504, 'Jeans', 2500.00, 2, 0), 
(505, 'Coffee Table', 8500.00, 3, 5);

INSERT INTO Orders VALUES 
(9001, 101, '2026-05-01'),
(9002, 102, '2026-05-12'),
(9003, 101, '2026-05-15'),
(9004, 103, '2026-05-20'),
(9005, 104, '2026-05-28');

INSERT INTO OrderItems (OrderID, ProductID, Quantity) VALUES 
(9001, 501, 1), (9001, 503, 2), (9002, 502, 1), 
(9003, 502, 2), (9004, 505, 1), (9005, 501, 1);


-- -------------------------------------------------------------------------
-- PART 2: CORE BUSINESS INTELLIGENCE QUERIES
-- -------------------------------------------------------------------------

-- Query 1: Customer Order History
SELECT OrderID, OrderDate FROM Orders WHERE CustomerID = 101;

-- Query 2: Revenue Generated per Product
SELECT p.ProductName, SUM(oi.Quantity * p.Price) AS TotalSales
FROM OrderItems oi
INNER JOIN Products p ON oi.ProductID = p.ProductID
GROUP p.ProductName;

-- Query 3: Average Order Value (AOV) via CTE
WITH OrderTotals AS (
    SELECT oi.OrderID, SUM(oi.Quantity * p.Price) AS OrderAmount
    FROM OrderItems oi
    INNER JOIN Products p ON oi.ProductID = p.ProductID
    GROUP BY oi.OrderID
)
SELECT AVG(OrderAmount) AS AverageOrderValue FROM OrderTotals;

-- Query 4: Top Customers by Total Spending
SELECT c.CustomerName, SUM(oi.Quantity * p.Price) AS TotalSpent
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
INNER JOIN OrderItems oi ON o.OrderID = oi.OrderID
INNER JOIN Products p ON oi.ProductID = p.ProductID
GROUP BY c.CustomerName
ORDER BY TotalSpent DESC
LIMIT 5;

-- Query 5: Out of Stock Inventory Alert
SELECT ProductName, Stock FROM Products WHERE Stock = 0;