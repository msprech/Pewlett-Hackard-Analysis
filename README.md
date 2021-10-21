# Pewlett-Hackard-Analysis

## Overview 

This analysis for Pewlett Hackard sought to determine how many employees would meet certain criteria to qualify for a retirement package in the upcoming years, as well as how many vaccancies would need to be accounted for. Specifically we looked at who was eligible for retirement, how many positions would need to be filled, and how many of those positions would require additional training or skills. 

This report reflects our findings on;
* How many employees are eligible for retirement in total?
* How many employees are retiring per title?
* How many employees are eligible to participate in a proposed mentorship program?
* What does this data mean for the future of Pewlett Hackard? 

## Results 

An initial list of retiring employees showed a possible 133,776 retirement-eligible employees. However, this datapoint is misleading as this figure included duplicates of employees who had held multiple roles or titles within the company. 

I created the following code to create a table of employees eligible for retirement by using the DISTINCT ON function to delete duplicate references to individual employees. The results showed that 90,398 employees are eligible for retirement within the company. 

```
SELECT DISTINCT ON(rt.emp_no)rt.emp_no, 
  rt.first_name, 
  rt.last_name, 
  rt.title
INTO unique_titles 
FROM retirement_titles as rt 
ORDER BY emp_no ASC, to_date DESC;
```
I then expanded on the above code using the COUNT function to document how concentrated the retirement percentages were within each professional title throughout the company. Senior Engineers had the largest number of retirement-eligible employees with 29,414 employees, closely followed by Senior Staff at 28,254 employees. The resulting retiring titles table is displayed below.    

![retirement screenshot](https://github.com/msprech/Pewlett-Hackard-Analysis/blob/af65e9d55b1ac92db1a366aa0c1dc27e6517dc05/Screen%20Shot%202021-10-21%20at%204.25.26%20PM.png)

The following code was used to calculate how many employees are eligible for the proposed mentorship program. 

```
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
```
1,549 employees qualified for the new program. 


## Summary 

As this turnover rate is extremely high and seemingly necessary to run the company, Pewlett Hackard will need to recruit and hire a number of employees comparable to the 90,398 possible retiring employees. 

Attention will need to be paid in particular to employees who will qualify for Senior positions, as the current 1,549 employees who qualify for the mentorship program are not sufficient to meet the needs of such a high turnover rate. 

Additional analysis should include further study into ongoing hiring and firing rates, as well as an investigation into the resources of length of time necessary to qualify employees for the mentorship program or the upcoming vaccancies themselves. 
