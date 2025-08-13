-- Database schema for Employees, Departments, Projects, and Assignments


-- Create Departments table
CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL
);


-- Create Employees table
CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    designation VARCHAR(100),
    salary DECIMAL(10, 2),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);


-- Create Projects table
CREATE TABLE Projects (
    proj_id INT PRIMARY KEY,
    proj_name VARCHAR(100) NOT NULL,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);


-- Create Assignments table (junction table for Employees and Projects)
CREATE TABLE Assignments (
    emp_id INT,
    proj_id INT,
    hours_worked DECIMAL(5, 2),
    PRIMARY KEY (emp_id, proj_id),
    FOREIGN KEY (emp_id) REFERENCES Employees(emp_id),
    FOREIGN KEY (proj_id) REFERENCES Projects(proj_id)
);


-- Optional: Create indexes for better performance
CREATE INDEX idx_employees_dept ON Employees(dept_id);
CREATE INDEX idx_projects_dept ON Projects(dept_id);
CREATE INDEX idx_assignments_emp ON Assignments(emp_id);
CREATE INDEX idx_assignments_proj ON Assignments(proj_id);


-- Sample data insertion (optional)
INSERT INTO Departments (dept_id, dept_name) VALUES
(1, 'Human Resources'),
(2, 'Engineering'),
(3, 'Marketing'),
(4, 'Finance');


INSERT INTO Employees (emp_id, emp_name, designation, salary, dept_id) VALUES
(101, 'John Smith', 'Manager', 75000.00, 1),
(102, 'Jane Doe', 'Software Engineer', 65000.00, 2),
(103, 'Robert Johnson', 'Marketing Specialist', 55000.00, 3),
(104, 'Emily Davis', 'Accountant', 60000.00, 4),
(105, 'Michael Brown', 'Senior Engineer', 80000.00, 2);


INSERT INTO Projects (proj_id, proj_name, dept_id) VALUES
(201, 'Employee Portal', 2),
(202, 'Recruitment Drive', 1),
(203, 'Product Launch', 3),
(204, 'Budget Planning', 4),
(205, 'System Upgrade', 2);


INSERT INTO Assignments (emp_id, proj_id, hours_worked) VALUES
(102, 201, 120.50),
(105, 201, 80.25),
(101, 202, 60.00),
(103, 203, 150.75),
(104, 204, 95.50),
(102, 205, 75.00),
(105, 205, 110.25);