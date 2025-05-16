-- Question 1: Achieving 1NF
-- The original ProductDetail table violates 1NF because the Products column contains multiple values.
-- Solution: Each row should represent a single product for an order.

-- 1NF Table Definition
DROP TABLE IF EXISTS ProductDetail_1NF;
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(50)
);

-- Insert transformed data (one product per row)
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product) VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');

-- Question 2: Achieving 2NF
-- The original OrderDetails table is in 1NF but not 2NF due to partial dependency:
-- CustomerName depends only on OrderID, not the full composite key (OrderID, Product).

-- Solution: Split into two tables to remove partial dependencies.

-- Orders table: stores OrderID and CustomerName (OrderID is unique)
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- OrderProducts table: stores OrderID, Product, and Quantity
DROP TABLE IF EXISTS OrderProducts;
CREATE TABLE OrderProducts (
    OrderID INT,
    Product VARCHAR(50),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert data into Orders table
INSERT INTO Orders (OrderID, CustomerName) VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- Insert data into OrderProducts table
INSERT INTO OrderProducts (OrderID, Product, Quantity) VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);

-- Now, CustomerName depends only on OrderID (in Orders table), and OrderProducts table has no partial dependencies.