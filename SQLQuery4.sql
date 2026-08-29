CREATE DATABASE test2;
GO

USE test2;
GO

CREATE TABLE employees
(
    id INT PRIMARY KEY,
    name VARCHAR(30),
    salary DECIMAL(10,2)
);
GO

ALTER TABLE employees
ADD dapertment VARCHAR(30);
GO

-- Rename dapertment to DeptName
EXEC sp_rename 'employees.dapertment', 'DeptName', 'COLUMN';
GO

CREATE TABLE project
(
    project_id INT PRIMARY KEY,
    project_name VARCHAR(30)
);
GO

CREATE TABLE EmployeeProjects
(
    id INT,
    project_id INT,

    PRIMARY KEY (id, project_id),

    CONSTRAINT FK_EmployeeProjects_Employees
        FOREIGN KEY (id)
        REFERENCES employees(id),

    CONSTRAINT FK_EmployeeProjects_Projects
        FOREIGN KEY (project_id)
        REFERENCES project(project_id)
);
GO

-- Remove the foreign key relationships
ALTER TABLE EmployeeProjects
DROP CONSTRAINT FK_EmployeeProjects_Employees;
GO

ALTER TABLE EmployeeProjects
DROP CONSTRAINT FK_EmployeeProjects_Projects;
GO

ALTER TABLE employees
ADD CONSTRAINT UQ_Employees_Name
UNIQUE (name);
GO

CREATE TABLE customers
(
    customar_id INT PRIMARY KEY,
    f_name VARCHAR(30),
    l_name VARCHAR(30),
    e_mail VARCHAR(30),
    statues VARCHAR(30)
);
GO

ALTER TABLE customers
ADD CONSTRAINT UQ_Customers_Name
UNIQUE (f_name, l_name);
GO

ALTER TABLE customers
ADD CONSTRAINT DF_Customers_Status
DEFAULT 'Active' FOR statues;
GO

CREATE TABLE orders
(
    order_id INT PRIMARY KEY,
    order_data DATETIME,
    TotalAmount DECIMAL(10,2)
);
GO

ALTER TABLE orders
ADD CONSTRAINT CK_Orders_TotalAmount
CHECK (TotalAmount > 0);
GO

CREATE SCHEMA sales;
GO

ALTER SCHEMA sales
TRANSFER dbo.orders;
GO

EXEC sp_rename 'sales.orders', 'sales_orders';
GO


-- 1
SELECT *
FROM employees;

-- 2
SELECT name, salary
FROM employees;

-- 3
SELECT DISTINCT DeptName
FROM employees;

-- 4
SELECT TOP 5 *
FROM employees;

-- 5
SELECT *
FROM employees
ORDER BY salary DESC;

-- 6
SELECT *
FROM employees
ORDER BY id
OFFSET 2 ROWS
FETCH NEXT 10 ROWS ONLY;

-- 7
SELECT AVG(salary) AS AverageSalary
FROM employees;

-- 8
SELECT MAX(salary) AS MaximumSalary,
       MIN(salary) AS MinimumSalary
FROM employees;

-- 9
SELECT TOP 3 salary
FROM employees
ORDER BY salary DESC;

-- 10
SELECT *
FROM employees
ORDER BY name ASC;

-- 11
SELECT *
FROM employees
ORDER BY salary DESC
OFFSET 1 ROWS
FETCH NEXT 5 ROWS ONLY;

-- 12
SELECT SUM(salary) AS TotalSalary
FROM employees;

-- 13
SELECT *
FROM employees
WHERE salary BETWEEN 40000 AND 60000
ORDER BY salary ASC;