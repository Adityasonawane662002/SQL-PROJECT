create database pms;
use pms;
-- Create employees table
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    dept_id INT,
    salary DECIMAL(10, 2),
    hiring_date DATE
);

-- Insert sample data for employees
INSERT INTO employees (emp_id, name, email, dept_id, salary, hiring_date) VALUES
(1, 'John Doe', 'john.doe@example.com', 1, 60000.00, '2020-01-15'),
(2, 'Jane Smith', 'jane.smith@example.com', 2, 55000.00, '2020-02-20'),
(3, 'Michael Johnson', 'michael.johnson@example.com', 1, 62000.00, '2019-11-10'),
(4, 'Emily Brown', 'emily.brown@example.com', 3, 58000.00, '2021-03-05'),
(5, 'David Davis', 'david.davis@example.com', 2, 54000.00, '2020-09-15'),
(6, 'Sarah Wilson', 'sarah.wilson@example.com', 1, 61000.00, '2018-08-20'),
(7, 'Matthew Taylor', 'matthew.taylor@example.com', 3, 59000.00, '2017-07-25'),
(8, 'Jennifer Martinez', 'jennifer.martinez@example.com', 2, 56000.00, '2019-06-30'),
(9, 'Christopher Anderson', 'christopher.anderson@example.com', 1, 63000.00, '2018-04-12'),
(10, 'Amanda Garcia', 'amanda.garcia@example.com', 3, 57000.00, '2017-02-05'),
(11, 'James Rodriguez', 'james.rodriguez@example.com', 2, 55000.00, '2020-10-10'),
(12, 'Linda Nguyen', 'linda.nguyen@example.com', 1, 64000.00, '2019-01-20'),
(13, 'Ryan King', 'ryan.king@example.com', 3, 58000.00, '2018-06-15'),
(14, 'Kimberly Thomas', 'kimberly.thomas@example.com', 2, 57000.00, '2017-09-30'),
(15, 'Eva Martinez', 'eva.martinez@example.com', 4, 55000.00, '2021-05-10');
desc employees;
select * from employees;
-- Create payroll table
CREATE TABLE payroll (
    payroll_id INT PRIMARY KEY,
    emp_id INT,
    pay_date DATE,
    hours_worked DECIMAL(5, 2),
    overtime_hours DECIMAL(5, 2),
    deductions DECIMAL(10, 2),
    bonus DECIMAL(10, 2)
);

-- Insert sample payroll data
INSERT INTO payroll (payroll_id, emp_id, pay_date, hours_worked, overtime_hours, deductions, bonus) VALUES
(1, 1, '2024-04-01', 160.00, 10.00, 500.00, 1000.00),
(2, 2, '2024-04-01', 150.00, 5.00, 450.00, 900.00),
(3, 3, '2024-04-01', 165.00, 12.00, 550.00, 1100.00),
(4, 4, '2024-04-01', 155.00, 8.00, 520.00, 950.00),
(5, 5, '2024-04-01', 145.00, 6.00, 480.00, 800.00),
(6, 6, '2024-04-01', 170.00, 14.00, 600.00, 1200.00),
(7, 7, '2024-04-01', 155.00, 8.00, 520.00, 950.00),
(8, 8, '2024-04-01', 150.00, 5.00, 450.00, 900.00),
(9, 9, '2024-04-01', 160.00, 10.00, 500.00, 1000.00),
(10, 10, '2024-04-01', 145.00, 6.00, 480.00, 800.00),
(11, 11, '2024-04-01', 155.00, 8.00, 520.00, 950.00),
(12, 12, '2024-04-01', 170.00, 14.00, 600.00, 1200.00),
(13, 13, '2024-04-01', 155.00, 8.00, 520.00, 950.00),
(14, 14, '2024-04-01', 150.00, 5.00, 450.00, 900.00),
(15, 15, '2024-04-01', 165.00, 12.00, 550.00, 1100.00);
desc payroll;
select * from payroll;
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);
INSERT INTO departments (department_id, department_name) VALUES
(1, 'Engineering'),
(2, 'Sales'),
(3, 'Marketing'),
(4, 'Human Resources');
SELECT * FROM departments;
-- Query 1: List all employees and their salaries
SELECT name , salary from employees;
-- Query 2: Calculate total salary expenditure
SELECT SUM(Salary) AS TotalSalaryExpenditure
FROM Employees;
-- Query 3: List employees with salary greater than the average salary
SELECT name , Salary
FROM Employees
WHERE Salary > (SELECT AVG(Salary) FROM Employees);
-- QUERY 4: Retrieve the highest salary among all employees.
SELECT MAX(Salary) As maxsalary from employees;
-- QUERY 5: . Retrieve the average salary of all employees
SELECT AVG(Salary) as averagesalary from employee;
-- SUBQUERIES 1 :Top Earners in Each Department:

SELECT department_name, name, salary
FROM (
    SELECT e.name, e.salary, d.department_name,
           ROW_NUMBER() OVER (PARTITION BY e.dept_id ORDER BY e.salary DESC) AS rn
    FROM employees e
    JOIN departments d ON e.dept_id = d.department_id
) AS ranked
WHERE rn = 1;
-- SUBQUERIES 2:Employees With Highest Overtime Hours:

SELECT e.name, p.overtime_hours
FROM employees e
JOIN payroll p ON e.emp_id = p.emp_id
ORDER BY p.overtime_hours DESC
LIMIT 5;
 -- subquerie 3:Average Salary of Employees in Each Department:
 
 SELECT department_name, AVG(salary) AS avg_salary
FROM employees e
JOIN departments d ON e.dept_id = d.department_id
GROUP BY department_name;

-- SUBQUERIES 4-Total Number of Employees in Each Department:

SELECT department_name, COUNT(*) AS num_employees
FROM employees e
JOIN departments d ON e.dept_id = d.department_id
GROUP BY department_name;

-- SUBQUERIES 5-Employees With Highest Overtime Hours
SELECT e.name, p.overtime_hours
FROM employees e
JOIN payroll p ON e.emp_id = p.emp_id
ORDER BY p.overtime_hours DESC
LIMIT 5;

-- JOINS Join to get employee details along with their payroll information:

SELECT e.emp_id, e.name, p.pay_date, p.hours_worked, p.overtime_hours, p.deductions, p.bonus
FROM employees e
JOIN payroll p ON e.emp_id = p.emp_id;

-- JOINS 2. Join to get employee details along with their department name:
SELECT e.emp_id, e.name, d.department_name
FROM employees e
JOIN departments d ON e.dept_id = d.department_id;
-- JOINS 3 Join to get payroll details along with employee and department information:
SELECT e.name, d.department_name, p.pay_date, p.hours_worked, p.overtime_hours, p.deductions, p.bonus
FROM payroll p
JOIN employees e ON p.emp_id = e.emp_id
JOIN departments d ON e.dept_id = d.department_id;
-- JOINS 4 Join to get the total number of employees in each department along with their department names:
SELECT d.department_name, COUNT(e.emp_id) AS num_employees
FROM departments d
LEFT JOIN employees e ON d.department_id = e.dept_id
GROUP BY d.department_name;

-- JOIN 5 Join to get the total salary expense for each department:

SELECT d.department_name, SUM(e.salary) AS total_salary_expense
FROM departments d
JOIN employees e ON d.department_id = e.dept_id
GROUP BY d.department_name;






 


