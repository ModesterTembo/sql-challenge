--Creating the tables

CREATE TABLE employees ( 
	emp_no INT PRIMARY KEY, 
	emp_title_id VARCHAR(10) NOT NULL, 
	birth_date DATE NOT NULL, 
	first_name VARCHAR(50) NOT NULL, 
	last_name VARCHAR(50) NOT NULL, 
	sex CHAR(1) NOT NULL, 
	hire_date DATE NOT NULL 
);

CREATE TABLE departments (
	dept_no VARCHAR(10) PRIMARY KEY,
	dept_name VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS dept_emp ( 
	emp_no INT, 
	dept_no VARCHAR(8), 
	PRIMARY KEY (emp_no, dept_no), 
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no), 
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no) 
);

CREATE TABLE titles (
	title_id VARCHAR(10) PRIMARY KEY,
	title VARCHAR(255)
);

CREATE TABLE salaries (
	emp_no INT,
	salary INT,
	PRIMARY KEY (emp_no), 
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)	
);

CREATE TABLE IF NOT EXISTS dept_manager ( 
	emp_no INT, 
	dept_no VARCHAR(4), 
	PRIMARY KEY (emp_no, dept_no), 
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no), 
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no) 
);

INSERT INTO dept_manager (dept_no, emp_no)
VALUES ('d001', 110022),
('d001', 110039),
('d002', 110085),
('d002', 110114),
('d003', 110183),
('d003', 110228),
('d004', 110303),
('d004', 110344),
('d004', 110386),
('d004', 110420),
('d005', 110511),
('d005', 110567),
('d006', 110725),
('d006', 110765),
('d006', 110800),
('d006', 110854),
('d007', 111035),
('d007', 111133),
('d008', 111400),
('d008', 111534),
('d009', 111692),
('d009', 111784),
('d009', 111877),
('d009', 111939);

--List the employee number, last name, first name, sex, and salary of each employee.

SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary 
FROM employees e 
JOIN salaries s ON e.emp_no = s.emp_no;

--List the first name, last name, and hire date for the employees who were hired in 1986.

SELECT first_name, last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) =1986;

--List the manager of each department along with their department number, department name, employee number, last name, and first name.

SELECT dm.dept_no, d.dept_name, dm.emp_no, e.last_name,e.first_name
FROM dept_manager dm
JOIN employees e ON dm.emp_no=e.emp_no
JOIN departments d ON dm.dept_no = d.dept_no;

--Department number for each employee with employee number, last name, first name, and department name

SELECT de.dept_no, e.emp_no, e.last_name, e.first_name, d.dept_name 
FROM dept_emp de 
JOIN employees e ON de.emp_no = e.emp_no 
JOIN departments d ON de.dept_no = d.dept_no;

--First name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B
SELECT first_name, last_name, sex 
FROM employees 
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--Each employee in the Sales department, including their employee number, last name, and first name
SELECT e.emp_no, e.last_name, e.first_name 
FROM employees e 
JOIN dept_emp de ON e.emp_no = de.emp_no 
JOIN departments d ON de.dept_no = d.dept_no 
WHERE d.dept_name = 'Sales';

--Each employee in the Sales and Development departments, including their employee number, last name, first name, and department name

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name 
FROM employees e 
JOIN dept_emp de ON e.emp_no = de.emp_no 
JOIN departments d ON de.dept_no = d.dept_no 
WHERE d.dept_name IN ('Sales', 'Development');

--Frequency counts of all employee last names in descending order
SELECT last_name, COUNT(*) AS frequency 
FROM employees 
GROUP BY last_name 
ORDER BY frequency DESC;