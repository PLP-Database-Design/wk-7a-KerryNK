-- Question 1: Achieving 1NF
-- Transform the ProductDetail table so each row represents a single product for an order.

-- Original Table (for reference)
-- ProductDetail(OrderID, CustomerName, Products)

-- 1NF Table:
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
-- Remove partial dependencies by splitting the table.

-- Original Table (for reference)
-- OrderDetails(OrderID, CustomerName, Product, Quantity)

-- Step 1: Create Orders table (OrderID, CustomerName)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Step 2: Create OrderProducts table (OrderID, Product, Quantity)
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