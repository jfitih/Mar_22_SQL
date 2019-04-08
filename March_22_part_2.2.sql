 /*                                    PART – II 
                             Sorting Query Results 
 
Problem 01: Sort the rows based on 
ascending order of the salary 
(from lowest to highest) 


SELECT names, salary, age FROM table_name WHERE age>25 ORDER BY salary asc

 */
 
SELECT * 
FROM employees 
WHERE birth_date>05/13/156 
ORDER BY birth_date asc; 

SELECT * 
FROM departments 
WHERE dept_no<01 
ORDER BY dept_no asc; 

SELECT * 
FROM dept_emp 
WHERE emp_no>00 
ORDER BY emp_no asc; 

SELECT * 
FROM dept_manager 
WHERE emp_no>00 
ORDER BY emp_no desc; 

SELECT * 
FROM salaries 
WHERE emp_no>00 
ORDER BY emp_no asc; 

SELECT * 
FROM titles 
WHERE emp_no>00 
ORDER BY emp_no asc; 

SELECT * 
FROM employees 
WHERE birth_date>05/13/156 
ORDER BY birth_date asc; 

/* 
Default is ascending order: 
ORDER BY salary For descending 
order: ORDER BY salary desc 
 
Note that you need to specify 
the column name based on which 
the ordering will be done. 
Instead, you can use the 
column number after ORDER BY. 
 
Problem 02: Sort the rows based 
on multiple fields or columns. 
For example, sort the table 
first based on ascending 
order of the age and then 
descending order of the salary. 

 */
 
 
SELECT names, salary 
FROM table_name ORDER BY age, salary desc; 

SELECT * 
FROM employees  ORDER BY emp_no desc;

SELECT first_name, last_name, emp_no
FROM employees ORDER BY emp_no desc;

SELECT * 
FROM departments  ORDER BY dept_no desc;

SELECT * 
FROM departments join employees ORDER BY dept_no desc;
/* 
Warning: You can ORDER BY 
a column without displaying 
or selecting the column – 
see age was not next to SELECT. 
However, when using GROUP BY 
or DISTINCT, you cannot 
ORDER BY columns without 
having it next to SELECT.  
 
Problem 03: Sort the rows 
based on the alphabetic 
order of substring in a column. 

 */
/* 
SELECT name, age, salary 
FROM table_name 
ORDER BY SUBSTR (name, length(name) – 2); 


SELECT distinct first_name, last_name, salary
FROM employees , salaries
Where salary < 0 
ORDER BY SUBSTR (first_name, last_name, salary length(first_name) – 2); */

SELECT distinct first_name 
FROM employees 
WHERE emp_no > 75 
ORDER BY RIGHT(first_name,3),emp_no;

 
-- Here SUBSTR (column_name, start_index of the string). 
-- Where, length(name) – 2 → last two characters of a string.  

/* 
Problem 04: Order NULL entries 
of the salary field in 
descending order and 
non-null in ascending order.
 We create a new field called 
 is_null that contains the 
 flag related to the 
 NULL status – we use 
 CASE to implement 
 IF-ELSE condition 
 on the salary column  
 */
 
 
/* 
SELECT name, age, salary 
FROM ( SELECT name, age, salary,  
CASE WHEN salary IS NULL THEN 0 ELSE 1 END AS is_null 
FROM table_name ) x 
ORDER BY is_null desc, salary ); 
*/


SELECT * 
FROM ( SELECT salary, 
CASE 
WHEN salary_s IS NULL THEN 0 ELSE 1 END AS salary
FROM salaries ) x
ORDER BY is_null desc, salary ; 
# order by case when salary is null then 1 else 0 end, salary;
/* 
Quiz: How do you place or push all NULL entries at the end 
 
Problem 05: Sort rows based 
on a conditional logic. 
When Sex = Female, create 
a separate column to 
display their salary
 in ascending order.  
 */
SELECT name, age, sex, salary, new_col,  
CASE WHEN sex = ‘FEMALE’ then new_col  else salary end as ordered 
FROM table_name 
ORDER BY ORDERED; 


SELECT *,   
CASE WHEN gender = 'F' then gender else emp_no end as ordered 
FROM employees 
ORDER BY ORDERED; 
 
 /*
Problem 06: Find the age 
in years at the time of 
hire use the date of hire 
and the birth date of 
male employees only. 
 */
SELECT first_name, last_name, DATEDIFF(hire_date, birth_date)/365 AS age_hire  
FROM  employees 
WHERE gender = 'M' ; 

SELECT first_name, last_name, DATEDIFF(hire_date > 02-14-1991, birth_date < 02-14-1992)/365 AS age_hire  
FROM  employees 
WHERE gender = 'M' ; 
 
 /*
Problem 07: You cannot use 
field aliases in the WHERE 
clause as below. 
 
INCORRECT 
 */
SELECT first_name, DATEDIFF(hire_date > 02-14-1991, birth_date < 02-14-1992)/365 AS hire_date  
FROM  employees
WHERE birth_date >28; 
 
# CORRECT  
 
SELECT first_name, DATEDIFF(hire_date = 02-14-1992, birth_date < 02-14-1991)/365 AS  age_hire  
FROM  employees 
WHERE (DATEDIFF(hire_date = 02-14-1992, birth_date < 02-14-1991)/365)>28; 
 
-- OR: You can create an internal table to make this happen as below 
 
 
SELECT   *  
FROM (  SELECT     first_name, DATEDIFF(hire_date < 12-23-1992, birth_date > 02-23-1992)/365 AS daysdiff    
FROM employees ) as INNERTABLE 
WHERE daysdiff >28; 
 
 