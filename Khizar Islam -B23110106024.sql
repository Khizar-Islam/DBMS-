-- Khizar islam , 2nd Assignment
CREATE DATABASE CarShowroomDB;

CREATE TABLE Customers (
    CustomerID SERIAL PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    City VARCHAR(50),
    State VARCHAR(50),
    JoinDate DATE
);

CREATE TABLE Cars (
    CarID SERIAL PRIMARY KEY,
    Model VARCHAR(50) NOT NULL,
    Brand VARCHAR(50) NOT NULL,
    Year INTEGER,
    Price DECIMAL(10, 2),
    InventoryCount INTEGER DEFAULT 0
);

CREATE TABLE Sales (
    SalesID SERIAL PRIMARY KEY,
    CustomerID INTEGER REFERENCES Customers(CustomerID),
    CarID INTEGER REFERENCES Cars(CarID),
    SaleDate DATE NOT NULL,
    SalePrice DECIMAL(10, 2),
    SalespersonID INTEGER
);

CREATE TABLE Salespersons (
    SalespersonID SERIAL PRIMARY KEY,
    SalespersonName VARCHAR(100) NOT NULL,
    DepartmentName VARCHAR(50),
    HireDate DATE
);

CREATE TABLE ServiceRecords (
    RecordID SERIAL PRIMARY KEY,
    CarID INTEGER REFERENCES Cars(CarID),
    ServiceDate DATE NOT NULL,
    ServiceType VARCHAR(100),
    Cost DECIMAL(10, 2),
    TechnicianID INTEGER
);

-- Add foreign key constraint for SalespersonID in Sales table
ALTER TABLE Sales 
ADD CONSTRAINT fk_salesperson 
FOREIGN KEY (SalespersonID) REFERENCES Salespersons(SalespersonID);

-- Insert Sample Data
INSERT INTO Customers (CustomerName, City, State, JoinDate) VALUES
('John Smith', 'New York', 'NY', '2023-01-15'),
('Sarah Johnson', 'Los Angeles', 'CA', '2023-02-20'),
('Michael Brown', 'Chicago', 'IL', '2023-03-10'),
('Emma Davis', 'Houston', 'TX', '2023-04-05'),
('William Wilson', 'Phoenix', 'AZ', '2023-05-12'),
('Olivia Martinez', 'Philadelphia', 'PA', '2023-06-18'),
('James Anderson', 'San Antonio', 'TX', '2023-07-22'),
('Isabella Taylor', 'San Diego', 'CA', '2023-08-30'),
('Alexander Thomas', 'Dallas', 'TX', '2023-09-14'),
('Sophia Jackson', 'San Jose', 'CA', '2023-10-25');

INSERT INTO Cars (Model, Brand, Year, Price, InventoryCount) VALUES
('Accord', 'Honda', 2023, 28000.00, 5),
('Camry', 'Toyota', 2023, 27500.00, 8),
('Model 3', 'Tesla', 2023, 45000.00, 3),
('Civic', 'Honda', 2023, 24000.00, 10),
('RAV4', 'Toyota', 2023, 32000.00, 6),
('Model Y', 'Tesla', 2023, 55000.00, 2),
('CR-V', 'Honda', 2023, 31000.00, 7),
('Corolla', 'Toyota', 2023, 23000.00, 12),
('F-150', 'Ford', 2023, 40000.00, 4),
('Mustang', 'Ford', 2023, 38000.00, 3);

INSERT INTO Salespersons (SalespersonName, DepartmentName, HireDate) VALUES
('Robert Johnson', 'New Cars', '2022-01-10'),
('Lisa Chen', 'Used Cars', '2022-03-15'),
('David Miller', 'New Cars', '2022-06-20'),
('Jennifer Garcia', 'Luxury Cars', '2022-09-05'),
('Mark Thompson', 'New Cars', '2023-01-12');

INSERT INTO Sales (CustomerID, CarID, SaleDate, SalePrice, SalespersonID) VALUES
(1, 1, '2023-02-01', 27500.00, 1),
(2, 3, '2023-03-15', 44000.00, 4),
(3, 2, '2023-04-10', 27000.00, 3),
(4, 5, '2023-05-20', 31500.00, 1),
(5, 4, '2023-06-25', 23500.00, 2),
(6, 7, '2023-07-30', 30500.00, 3),
(7, 1, '2023-08-15', 27800.00, 1),
(8, 6, '2023-09-05', 54000.00, 4),
(9, 9, '2023-10-10', 39500.00, 5),
(10, 8, '2023-11-20', 22500.00, 2),
(1, 2, '2023-12-01', 27200.00, 3),
(3, 10, '2023-12-15', 37500.00, 5);

INSERT INTO ServiceRecords (CarID, ServiceDate, ServiceType, Cost, TechnicianID) VALUES
(1, '2023-03-01', 'Oil Change', 50.00, 1),
(2, '2023-04-15', 'Tire Rotation', 40.00, 2),
(3, '2023-05-20', 'Battery Replacement', 200.00, 3),
(4, '2023-06-10', 'Brake Service', 350.00, 1),
(5, '2023-07-05', 'Oil Change', 55.00, 2),
(1, '2023-08-20', 'Annual Service', 500.00, 3),
(7, '2023-09-15', 'Transmission Service', 400.00, 1),
(8, '2023-10-01', 'Oil Change', 45.00, 2),
(9, '2023-11-10', 'Tire Replacement', 600.00, 3),
(10, '2023-12-05', 'Engine Tune-up', 300.00, 1);

-- 1.1 Find the total number of customers in the database
SELECT COUNT(*) AS total_customers FROM Customers;

-- 1.2 Calculate the average sale price of all car sales
SELECT ROUND(AVG(SalePrice), 2) AS average_sale_price FROM Sales;

-- 1.3 Find the most expensive car ever sold
SELECT c.Brand, c.Model, s.SalePrice AS highest_sale_price
FROM Sales s
JOIN Cars c ON s.CarID = c.CarID
WHERE s.SalePrice = (SELECT MAX(SalePrice) FROM Sales);

-- 1.4 Determine the total revenue generated in the showroom
SELECT SUM(SalePrice) AS total_revenue FROM Sales;

-- 1.5 Find the earliest and most recent sale dates
SELECT 
    MIN(SaleDate) AS earliest_sale_date,
    MAX(SaleDate) AS most_recent_sale_date
FROM Sales;

-- 2.1 Group cars by brand and count how many models each brand has
SELECT Brand, COUNT(*) AS model_count
FROM Cars
GROUP BY Brand
ORDER BY model_count DESC;

-- 2.2 Calculate the total sales amount for each salesperson
SELECT 
    sp.SalespersonName,
    COUNT(s.SalesID) AS total_sales,
    SUM(s.SalePrice) AS total_sales_amount
FROM Salespersons sp
LEFT JOIN Sales s ON sp.SalespersonID = s.SalespersonID
GROUP BY sp.SalespersonID, sp.SalespersonName
ORDER BY total_sales_amount DESC;

-- 2.3 Find the average sale price for each car model
SELECT 
    c.Brand,
    c.Model,
    COUNT(s.SalesID) AS sales_count,
    ROUND(AVG(s.SalePrice), 2) AS average_sale_price
FROM Cars c
LEFT JOIN Sales s ON c.CarID = s.CarID
GROUP BY c.CarID, c.Brand, c.Model
HAVING COUNT(s.SalesID) > 0
ORDER BY average_sale_price DESC;

-- 2.4 For each salesperson, find the average price of cars they sold
SELECT 
    sp.SalespersonName,
    COUNT(s.SalesID) AS cars_sold,
    ROUND(AVG(s.SalePrice), 2) AS average_price_per_sale
FROM Salespersons sp
LEFT JOIN Sales s ON sp.SalespersonID = s.SalespersonID
GROUP BY sp.SalespersonID, sp.SalespersonName
HAVING COUNT(s.SalesID) > 0
ORDER BY average_price_per_sale DESC;

-- 2.5 Find the count of cars by brand and color combination from the cars table
-- Note: Since color is not in our schema, we'll modify this to show cars by brand and year
SELECT 
    Brand,
    Year,
    COUNT(*) AS car_count
FROM Cars
GROUP BY Brand, Year
ORDER BY Brand, Year;

-- 3.1 Identify brands that offer more than five different car models
SELECT Brand, COUNT(*) AS model_count
FROM Cars
GROUP BY Brand
HAVING COUNT(*) > 5;

-- Note: With our sample data, no brand has more than 5 models, so let's adjust to > 2
SELECT Brand, COUNT(*) AS model_count
FROM Cars
GROUP BY Brand
HAVING COUNT(*) > 2
ORDER BY model_count DESC;

-- 3.2 List car models that have been sold more than 10 times
SELECT 
    c.Brand,
    c.Model,
    COUNT(s.SalesID) AS times_sold
FROM Cars c
JOIN Sales s ON c.CarID = s.CarID
GROUP BY c.CarID, c.Brand, c.Model
HAVING COUNT(s.SalesID) > 10;

-- Note: With our sample data, no model sold > 10 times, so let's adjust to >= 2
SELECT 
    c.Brand,
    c.Model,
    COUNT(s.SalesID) AS times_sold
FROM Cars c
JOIN Sales s ON c.CarID = s.CarID
GROUP BY c.CarID, c.Brand, c.Model
HAVING COUNT(s.SalesID) >= 2
ORDER BY times_sold DESC;

-- 3.3 Find salespersons whose average sale price is greater than 50,000
SELECT 
    sp.SalespersonName,
    COUNT(s.SalesID) AS total_sales,
    ROUND(AVG(s.SalePrice), 2) AS average_sale_price
FROM Salespersons sp
JOIN Sales s ON sp.SalespersonID = s.SalespersonID
GROUP BY sp.SalespersonID, sp.SalespersonName
HAVING AVG(s.SalePrice) > 50000
ORDER BY average_sale_price DESC;

-- Note: With our data, let's adjust to > 35,000
SELECT 
    sp.SalespersonName,
    COUNT(s.SalesID) AS total_sales,
    ROUND(AVG(s.SalePrice), 2) AS average_sale_price
FROM Salespersons sp
JOIN Sales s ON sp.SalespersonID = s.SalespersonID
GROUP BY sp.SalespersonID, sp.SalespersonName
HAVING AVG(s.SalePrice) > 35000
ORDER BY average_sale_price DESC;

-- 3.4 Identify months that had more than 20 sales
SELECT 
    TO_CHAR(SaleDate, 'YYYY-MM') AS sale_month,
    COUNT(*) AS sales_count
FROM Sales
GROUP BY TO_CHAR(SaleDate, 'YYYY-MM')
HAVING COUNT(*) > 20;

-- Note: With our data, let's adjust to >= 2
SELECT 
    TO_CHAR(SaleDate, 'YYYY-MM') AS sale_month,
    COUNT(*) AS sales_count
FROM Sales
GROUP BY TO_CHAR(SaleDate, 'YYYY-MM')
HAVING COUNT(*) >= 2
ORDER BY sale_month;

-- 3.5 Find service types where the average cost is greater than 500
SELECT 
    ServiceType,
    COUNT(*) AS service_count,
    ROUND(AVG(Cost), 2) AS average_cost
FROM ServiceRecords
GROUP BY ServiceType
HAVING AVG(Cost) > 500;

-- Note: With our data, let's adjust to > 300
SELECT 
    ServiceType,
    COUNT(*) AS service_count,
    ROUND(AVG(Cost), 2) AS average_cost
FROM ServiceRecords
GROUP BY ServiceType
HAVING AVG(Cost) > 300
ORDER BY average_cost DESC;
