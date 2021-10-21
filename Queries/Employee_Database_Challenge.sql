--retrieve emp_no, first_name, and last_name columns from employees table 
--retrieve title, from_date, to_date from titles table
SELECT(
	e.emp_no, 
	e.first_name, 
	e.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
--new table retirement titles 
INTO retirement_titles
FROM employees as e 
INNER JOIN titles as ti
ON e.emp_no = ti.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no);

SELECT * FROM retirement_titles


SELECT * FROM employees;

SELECT DISTINCT ON(rt.emp_no) rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
INTO unique_titles
FROM retirement_titles as rt
ORDER BY emp_no ASC, to_date DESC;

SELECT * FROM unique_titles

--retrieve number of employees by most recent job title who are about to retire
SELECT COUNT(ut.emp_no), ut.title
INTO retiring_titles
FROM unique_titles as ut 
GROUP BY ut.title
ORDER BY COUNT(ut.emp_no) DESC

SELECT * FROM retiring_titles

--mentorship eligibility table w current employees born 1/1/1965-12/31/1965
SELECT DISTINCT ON(e.emp_no)e.emp_no,
	e.first_name, 
	e.last_name, 
	e.birth_date,
	de.from_date, 
	de.to_date, 
	ti.title
INTO mentorship_eligibility
FROM employees as e
	INNER JOIN dept_emp as de
	ON e.emp_no = de.emp_no
	INNER JOIN titles as ti
	ON e.emp_no = ti.emp_no
WHERE (de.to_date = '9999-01-01')
	AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no