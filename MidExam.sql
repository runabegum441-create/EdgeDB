-- Part A - Basic SQL


-- 1. Create Departments table
CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL,
    location VARCHAR(100) DEFAULT 'Dhaka'
);


-- 2. Insert a record into Departments
INSERT INTO Departments (dept_id, dept_name, location)
VALUES (101, 'IT', 'Chattogram');


-- 3. Retrieve all employees who earn more than 50,000
SELECT * FROM Employees
WHERE salary > 50000;


-- 4. Display all distinct job designations from Employees
SELECT DISTINCT designation FROM Employees;


-- 5. Delete all employees working in department 103
DELETE FROM Employees
WHERE dept_id = 103;




-- Part B - Intermediate SQL


-- 1. Display emp_name, dept_name, and location for all employees
SELECT e.emp_name, d.dept_name, d.location
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id;


-- 2. List all employees who are not assigned to any project
SELECT e.*
FROM Employees e
LEFT JOIN Assignments a ON e.emp_id = a.emp_id
WHERE a.emp_id IS NULL;


-- 3. Find average salary by department (only > 60,000)
SELECT d.dept_name, AVG(e.salary) as avg_salary
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name
HAVING AVG(e.salary) > 60000;


-- 4. Display proj_name and total hours worked per project
SELECT p.proj_name, SUM(a.hours_worked) as total_hours
FROM Projects p
JOIN Assignments a ON p.proj_id = a.proj_id
GROUP BY p.proj_name;


-- 5. List employees earning more than their department's average
SELECT e.emp_name, e.salary, d.dept_name, dept_avg.avg_salary
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id
JOIN (
    SELECT dept_id, AVG(salary) as avg_salary
    FROM Employees
    GROUP BY dept_id
) dept_avg ON e.dept_id = dept_avg.dept_id
WHERE e.salary > dept_avg.avg_salary;




-- Part C - Applied Query


-- Identify departments with high-budget projects
SELECT 
    d.dept_name,
    COUNT(p.proj_id) as number_of_projects,
    SUM(p.budget) as total_budget
FROM Departments d
JOIN Projects p ON d.dept_id = p.dept_id
GROUP BY d.dept_name
HAVING COUNT(p.proj_id) > 2 AND SUM(p.budget) > 5000000
ORDER BY total_budget DESC;




-- Additional: Create all tables with complete schema
CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL,
    location VARCHAR(100) DEFAULT 'Dhaka'
);


CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    designation VARCHAR(100),
    salary DECIMAL(10, 2),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);


CREATE TABLE Projects (
    proj_id INT PRIMARY KEY,
    proj_name VARCHAR(100) NOT NULL,
    dept_id INT,
    budget DECIMAL(15, 2),
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);


CREATE TABLE Assignments (
    emp_id INT,
    proj_id INT,
    hours_worked DECIMAL(5, 2),
    PRIMARY KEY (emp_id, proj_id),
    FOREIGN KEY (emp_id) REFERENCES Employees(emp_id),
    FOREIGN KEY (proj_id) REFERENCES Projects(proj_id)
);