/*
SQL Assignment
COMP 5400
Due Date: Friday, March 22, 2019
1. Review the examples below and apply the codes and concepts to the EMPLOYEES
database provided for data manipulation.
2. You need to be innovative in deciding what data to retrieve to apply the example codes.
3. Write a report with a) data manipulation problem pertaining to the EMPLOYEES database,
b) corresponding SQL code in courier font face, and c) a summary of the output, e.g., first
five rows of the resultant table, number of rows and columns. Format your report in PDF
and upload the PDF on e-learn Dropbox.
4. Properly label (part and problem numbers shown below) and document (comment) all your
SQL codes in a single script and push it to your github repository.
5. Do not forget to share your github link in your final PDF report.
6. Point distribution
a. Creativity – 30%
b. Final report – 30%
c. SQL script with proper labels and documentations – 40%

PART – I
Note: The keywords written in uppercase are SQL keywords.
Problem 01: Retrieving Records: you have a table and want to see all of the data.
*/
SELECT *
FROM table_name;

/*
Discussion: ‘*’ will return every column of the table. Note that columns are typically the attributes of
the entity (row).
Problem 02: View only selective columns of the table.
*/

SELECT age, sex, salary
FROM table_name;

/*Discussion: Here, age, sex, salary are the names of columns of the table.
Problem 03: View only selective rows that satisfy certain conditions. For example, show the name,
age, and salary of employees whose age is greater than 35 years.

*/

SELECT name, age, salary
 FROM table_name
WHERE age>35;

/*
Note: Conditional operators such as =, <, >, <=, >=, !, <> are supported in SQL.
Problem 04: Display rows that satisfy multiple conditions. Following the WHERE clause use the OR
and AND statements. Show the employees who earn less than $2000 and are over 40 years of age or
who are females.
*/

SELECT *
 FROM table_name
WHERE (salary<2000 AND age>40)
 OR sex = Female;
 
 /*
Problem 05: Rename the columns and then view the table with the newly named column. Here, sal
and dept are the original column names in the table.
*/

SELECT sal AS Salary, dept AS Department
FROM table_name;

/*
Problem 06: Concatenating column values to combine multiple columns into one.

*/

SELECT concat(first_name, last_name) AS names
FROM table_name
WHERE Salary>2000;

/*
Problem 07: Implement IF-ELSE statement: for example: if the customer pays less than $100, more
than $100, and equal to $100, mark him as underpaid, overpaid, and paid, respectively.
*/

SELECT names, salary,
CASE WHEN salary <= 100 then ‘UNDERPAID’
WHEN salary >= 4000 then ‘OVERPAID’
ELSE ‘PAID’
END AS paymentStatus
FROM table_name;

/*
Problem 08: Limit the number of rows – show only top n rows of the table. Note that row represents
the entity/item/individual sample and columns represent the attributes. The SQL statements are
often different across different database platforms as you can see in the table below.
DB2 MySQL, PostgreSQL Oracle SQL Server
*/

Select
first
five
rows;
SELECT *
FROM table_name
FETCH FIRST 5
rows only;
SELECT *
FROM table_name
LIMIT 5;
SELECT *
FROM table_name
WHERE ROWNUM <=5;
SELECT top 5*
FROM
table_name;

/*
Problem 09: Returning n random records from a table

*/

SELECT name, age
FROM table_name
ORDER BY rand() limit 5;
/*
Note ORDER BY clause can accept a function’s return value and use it to change the order of the result
set. Here, the rand() function is performed first to get the random rows and then it is ordered to show
the first 5 rows in the randomly arranged rows.
Problem 10: Find all the rows that have NULL or missing entries in a particular column
*/

SELECT *
FROM table_name
WHERE column_name IS NULL;

/*
Note you can use IS NOT NULL to select columns free of NULL entries.
Problem 10: Transforming NULL entries into REAL values. Use COALESCE function to substitute real
values for NULL
*/

SELECT COALESCE (col_name, 0)
FROM table_name;

/*
Replaces all the null entries in column col_name by 0. Alternatively, you can use CASE (IF-ELSE
equivalent in SQL) as below
*/

SELECT CASE
WHEN col_name is NULL THEN 0
ELSE col_name 
END
From table_name;

/*
Problem 11: Search rows with specific patterns in a particular column. Below is an example of selecting
student name and age from the table belonging to 5th and 8th grade.
*/

SELECT name, age
FROM table_name
WHERE grade_num IN (5, 8);

/*
Problem 11: Use of wildcard operator % to search rows that have specific substring pattern.
*/

SELECT name, age
FROM table_name
WHERE grade_num (5, 8)
AND (name LIKE ‘%th%’ or name LIKE ‘%son’);
/*
The example above identifies the rows or students who belong to either 5th or 8th grade and have
“th” string in anywhere of their name string – use % on both sides. If you are looking for the substring
‘son’ at the end of the name (Davidson) use % followed by the substring.

PART – II

Sorting Query Results
Problem 01: Sort the rows based on ascending order of the salary (from lowest to highest)
*/

SELECT names, salary, age
FROM table_name
WHERE age>25
ORDER BY salary asc;

/*
Default is ascending order: ORDER BY salary
For descending order: ORDER BY salary desc
Note that you need to specify the column name based on which the ordering will be done. Instead,
you can use the column number after ORDER BY.

Problem 02: Sort the rows based on multiple fields or columns. For example, sort the table first based
on ascending order of the age and then descending order of the salary.
*/

SELECT names, salary
FROM table_name
ORDER BY age, salary desc;

/*
Warning: You can ORDER BY a column without displaying or selecting the column – see age was not
next to SELECT. However, when using GROUP BY or DISTINCT, you cannot ORDER BY columns without
having it next to SELECT.
Problem 03: Sort the rows based on the alphabetic order of substring in a column.
*/

SELECT name, age, salary
FROM table_name
ORDER BY SUBSTR (name, length(name) – 2);

/*
Here SUBSTR (column_name, start_index of the string). Where, length(name) – 2 → last two characters
of a string.
Problem 04: Order NULL entries of the salary field in descending order and non-null in ascending order.
We create a new field called is_null that contains the flag related to the NULL status – we use CASE to
implement IF-ELSE condition on the salary column
*/

SELECT name, age, salary
FROM (
SELECT name, age, salary,
CASE WHEN salary IS NULL THEN 0 ELSE 1 END AS is_null
FROM table_name
) x
ORDER BY is_null desc, salary
)

/*
Quiz: How do you place or push all NULL entries at the end
Problem 05: Sort rows based on a conditional logic. When Sex = Female, create a separate column to
display their salary in ascending order.
*/

SELECT name, age, sex, salary, new_col,
CASE WHEN sex = ‘FEMALE’ then new_col
else salary end as ordered
FROM table_name
ORDER BY ORDERED
/*
Problem 06: Find the age in years at the time of hire use the date of hire and the birth date of male
employees only.
*/

SELECT first_name, last_name, DATEDIFF(hire_date, birth_date)/365 AS
age_hire
FROM employees
WHERE gender = 'M' ;
/*
Problem 07: You cannot use field aliases in the WHERE clause as below.
INCORRECT
*/
SELECT first_name, DATEDIFF(hire_date, birth_date)/365 AS
age_hire
FROM employees
WHERE age_hire>28;
/*
CORRECT
*/
SELECT first_name, DATEDIFF(hire_date, birth_date)/365 AS
age_hire
FROM employees
WHERE (DATEDIFF(hire_date, birth_date)/365)>28;
/*
OR: You can create an internal table to make this happen as below
*/
SELECT *
FROM
(
SELECT
 first_name, DATEDIFF(hire_date, birth_date)/365 AS daysdiff
 FROM employees
) as INNERTABLE
WHERE daysdiff >28;

/*
PART – III

Multiple Tables
Problem 01: Stack one table on the top of other. Merge department name and employee name into
one column named name_and_dept and stack two tables together.
*/

SELECT name as name_and_dept, dept_no
FROM table_name
where deptno = 10
UNION ALL
SELECT dept_name, dept_no
FROM Table_02;

SELECT first_name as EmpFirstName, gender
FROM employees
where hire_date != 10-10-1992
UNION 
SELECT emp_no, dept_no
FROM dept_emp;
/*
UNION ALL combines rows from multiple tables into one result – provided that SELECT lists for both
tables must match in number and data type.
NOTE: UNION ALL includes duplicate entries if they exist – to filter out duplicates – use the UNION
operator instead. Additionally, UNION does data sorting – as it displays data in ascending order. So,
essentially UNION ALL + DISTINCT operations are equivalent to UNION operation.

Problem 02. You want to return rows from multiple tables by joining on a known common columns or
joining on columns that share common values. Say you want to know names of all students in the CS
department who live in Franklin – they are provided in two different tables- the name table tb_1 and
location table tb_2.
*/

SELECT tb_1.name, tb_2.location
FROM tb_1, tb_2
WHERE tb_1.t_number = tb_2.t_number;

SELECT first_name, last_name, gender, hire_date
FROM employees, dept_emp
WHERE first_name = last_name;
/*
Here t_number is the common column in both tables, which we used to map or bridge the two tables.
When joining two tables, you need to specify which column is coming from which table (tb_1.name or
tb_2.location).

Problem 03: Find the student t-numbers that are in the CS_dept table but not in the Sci_dept table.
*/
SELECT t_number
FROM CS_dept
WHERE t_number NOT IN (SELECT t_number FROM Sci_dept);

SELECT emp_no
FROM employees
WHERE emp_no NOT IN (SELECT emp_no FROM dept_emp);

SELECT emp_no, first_name, last_name
FROM employees
WHERE emp_no IN (SELECT emp_no FROM dept_emp);

/*
Note: We have SELECT inside another SELECT

Problem 04. Obtain the sum or aggregate values from the numeric columns. Create a column
displaying the sum of salaries or count of all female employees. From the salary table calculate the
total number of employees, total salaries, and average salaries.
*/
SELECT count(emp_no) as total_emp, sum(salary) as total_salary, 
avg(salary) as avg_salary
FROM salaries;

SELECT count(emp_no) as total_emp, sum(salary) as total_salary, 
avg(salary) as avg_salary
FROM salaries;

/*
PART IV

Topics:
• Inserting new records into your database
• Updating existing records
• Deleting records that you no longer want
*/
-- 4.1 Inserting a new record
-- Use INSERT statement with VALUES clause to insert one row at a time.
INSERT INTO table_name (col_1, col_2, col_4)
VALUES (1, 34, ‘Big’),
(2, 33, ‘Small’)
Order of the values in the VALUES list should match with the column list.
4.2 Inserting default values
Insert a row without specifying any value.
A table can be defined to take default values for specific columns. When we define a table, we can
set this as follows.
CREATE TABLE table_name (col_name INTEGER DEFAULT 0)
Here, a new table called table_name is created with a column named col_name that takes an integer
type input and the default is 0 when no value is specified.
When inserting a new row, you may specify the default value in general or for a specific column
INSERT INTO table_name (col_name) VALUES (DEFAULT)
Or
INSERT INTO table_name VALUES () // when all columns have a default value defined
4.3 Overriding a default value with NULL
CREATE TABLE table_name (col_1 INTEGER DEFAUL 0, col_2 VARCHAR(10))
INSERT INTO table_name (col_1, col_2) VALUES (null, ‘TSU_TIGERS’)
4.4 Copying rows from one table into another
Steps: Perform query in one table, take the query result to insert into another table
INSERT INTO table_new (std_id, name, gpa)
//Then

SELECT std_id, name, gpa
FROM table_old
WHERE name IN (‘John’,’Robert’);
/*
4.5 Copying table definitions (column names), but not the contents (rows)
CREATE TABLE table_name
AS
SELECT *
FROM table_old
WHERE 1 = 0

4.6 Update records in a table.
Say, you want to increase the salary of all employees who served more than 10 years by 10%.
UPDATE emp_table
SET sal = sal*1.10
WHERE srv_year > 10

4.7 Update records in a table corresponding to another table
Increase the salary of the employees who appear in another table named Emp_bonus
UPDATE main_table
SET sal = sal* 1.10
WHERE emp_ID IN (SELECT emp_ID FROM Emp_bonus)

4.8 Deleting specific records
Example, delete all the rows that have dept_no
DELETE FROM emp_table WHERE dept_no = 4

4.9 Delete records in the main that do not exist in another table
Delete those student records from main_table who do not appear in the new_table.
DELET FROM main_table
WHERE NOT EXISTS (
SELECT * FROM new_table
WHERE new_table.student_ID = main_table.student_ID)
OR
DELET FROM main_table
WHERE student_ID NOT IN (SELECT student_ID from new_table)

4.10 Delete duplicate records.
DELETE FROM table
WHERE ID NOT IN
(SELECT min (ID) FROM table GROUP BY Origin)
Or
SELECT Origin, min (ID)
 FROM table
GROUP BY Origin

4.11 Delete records from the main_table of students who failed more than or equal to 3 times and
appear in the table named fail_grade
DELETE FROM main_table
WHERE grade IN (SELECT *
FROM fail_grade
GROUP BY student_ID
ID Origin
1 Chicago
2 Chicago
3 Nashville
4 Nashville
5 Nashville
having count(*) >=3)
*/