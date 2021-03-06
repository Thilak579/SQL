# Datasets used: employee_details.csv and Department_Details.csv
# Use subqueries to answer every question

CREATE SCHEMA IF NOT EXISTS Employee;
USE Employee;
# import csv files in Employee database.

SELECT * FROM DEPARTMENT_DETAILS;
SELECT * FROM EMPLOYEE_DETAILS;


#Q1. Retrive employee_id , first_name , last_name and salary details of those employees whose salary is greater than the average salary of all the employees.

select employee_id, first_name, last_name, salary
from employee_details
where salary>(select avg(salary)
from employee_details);

#Q2. Display first_name , last_name and department_id of those employee where the location_id of their department is 1700

select * from department_details; 

select first_name, last_name, department_id
from employee_details
where department_id in (select department_id
from department_details
where location_id=1700); 

#Q3. From the table employees_details, extract the employee_id, first_name, last_name, job_id and department_id who work in  any of the departments of Shipping, Executive and Finance.

select employee_id, first_name, last_name, job_id, department_id
from employee_details
where department_id in (select department_id
from department_details
where DEPARTMENT_NAME = 'Shipping'or DEPARTMENT_NAME ='Executive' or DEPARTMENT_NAME ='Finance');

#Q4. Extract employee_id, first_name, last_name,salary, phone_number and email of the CLERKS who earn more than the salary of any IT_PROGRAMMER.

select employee_id, first_name, last_name, salary, phone_number, email
from employee_details
where job_id='ST_CLERK' and salary>any(select salary
from employee_details
where job_id='IT_PROG');

#Q5. Extract employee_id, first_name, last_name,salary, phone_number, email of the AC_ACCOUNTANTs who earn a salary more than all the AD_VPs.

select employee_id, first_name, last_name, salary, phone_number, email
from employee_details
where job_id='AC_ACCOUNTANT' and salary>all(select salary
from employee_details
where job_id='AD_VP');

#Q6. Write a Query to display the employee_id, first_name, last_name, department_id of the employees who have been recruited in the recent half timeline since the recruiting began. 

with datedif as 
(select max(str_to_date(HIRE_DATE, '%d-%m-%Y')) as max, min(str_to_date(HIRE_DATE, '%d-%m-%Y')) as min
from employee_details)
select employee_id,first_name,last_name,department_id,hire_date from employee_details
where employee_id = any
(select employee_id
from employee_details, datedif
where datediff(max, (str_to_date(HIRE_DATE, '%d-%m-%Y'))) < (datediff(max, min)/2));

#Q7. Extract employee_id, first_name, last_name, phone_number, salary and job_id of the employees belonging to the 'Contracting' department 

select employee_id,first_name,last_name,phone_number,salary,job_id from employee_details where department_id in
(select department_id from department_details where department_name='Contracting');

#Q8. Extract employee_id, first_name, last_name, phone_number, salary and job_id of the employees who does not belong to 'Contracting' department

select employee_id,first_name,last_name,phone_number,salary,job_id 
from employee_details 
where department_id in (select department_id from department_details where department_name !='Contracting');

#Q9. Display the employee_id, first_name, last_name, job_id and department_id of the employees who were recruited first in the department

select employee_id,first_name,last_name,job_id,department_id
 from employee_details 
 where hire_date in (select min(hire_date) from employee_details group by department_id);

#Q10. Display the employee_id, first_name, last_name, salary and job_id of the employees who earn maximum salary for every job.

select employee_id,first_name,last_name,salary,job_id 
from employee_details 
where salary in (select max(salary) from employee_details group by job_id);