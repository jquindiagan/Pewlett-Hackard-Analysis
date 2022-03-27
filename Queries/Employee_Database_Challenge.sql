-- STARTER CODE: Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (______) _____,
______,
______,
______

INTO nameyourtable
FROM _______
WHERE _______
ORDER BY _____, _____ DESC;


-- DELIVERABLE 1

-- 1-5. Create a new table from Employees and Titles
SELECT em.emp_no,
    em.first_name,
    em.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
INTO retirement_titles
FROM employees as em
LEFT JOIN titles as ti
ON em.emp_no = ti.emp_no
WHERE (em.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY em.emp_no;


-- 8-13. Create a new table with no duplicate rows
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirement_titles as rt
WHERE rt.to_date = ('9999-01-01')
ORDER BY rt.emp_no;


-- 16-19. Retrieve # of employees by most recent job title who are about to retire
SELECT COUNT(ut.title), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY COUNT(ut.title) DESC;


-- DELIVERABLE 2

-- 1-9. Create a Mentorship Eligibility table that holds the employees who are eligible to participate in a mentorship program
SELECT DISTINCT ON (em.emp_no) em.emp_no,
	em.first_name,
	em.last_name,
	em.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentorship_eligibility
FROM employees as em
LEFT JOIN dept_emp as de
ON em.emp_no = de.emp_no
LEFT JOIN titles as ti
ON em.emp_no = ti.emp_no
WHERE (de.to_date = ('9999-01-01')) AND (em.birth_date BETWEEN ('1965-01-01') AND ('1965-12-31'))
ORDER BY em.emp_no;


-- DELIVERABLE 3

-- Retrieve # of mentorship eligibility employees by title
SELECT COUNT(me.title), me.title
FROM mentorship_eligibility as me
GROUP BY me.title
ORDER BY COUNT(me.title) DESC;


-- Retrieve count of unique titles
SELECT COUNT(ut.emp_no), ut.title
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY COUNT(ut.title) DESC;


-- Retrieve count of total titles
SELECT COUNT(rt.emp_no), rt.title
FROM retirement_titles as rt
GROUP BY rt.title
ORDER BY COUNT(rt.title) DESC;


-- Retrieve # of mentorship eligibility employees by title
SELECT COUNT(me.title), me.title
FROM mentorship_eligibility as me
GROUP BY me.title
ORDER BY COUNT(me.title) DESC;


-- Retrive count of mentorship eligible employees by department
SELECT COUNT(me.emp_no),
	dp.dept_name
FROM mentorship_eligibility as me
LEFT JOIN dept_emp as de
ON me.emp_no = de.emp_no
LEFT JOIN departments as dp
ON de.dept_no = dp.dept_no
WHERE (de.to_date = '9999-01-01')
GROUP BY dp.dept_name
ORDER BY COUNT(me.emp_no) DESC;


-- Retrive count of retiring employees by department
SELECT COUNT(ut.emp_no),
	dp.dept_name
FROM unique_titles as ut
LEFT JOIN dept_emp as de
ON ut.emp_no = de.emp_no
LEFT JOIN departments as dp
ON de.dept_no = dp.dept_no
WHERE (de.to_date = '9999-01-01')
GROUP BY dp.dept_name
ORDER BY COUNT(ut.emp_no) DESC;