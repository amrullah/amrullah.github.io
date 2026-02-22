-- Databricks notebook source
-- MAGIC %md
-- MAGIC <div style="text-align: center; line-height: 0; padding-top: 9px;">
-- MAGIC   <img src="https://learningjournal.github.io/pub-resources/logos/scholarnest_academy.jpg" alt="ScholarNest Academy" style="width: 1400px">
-- MAGIC </div>

-- COMMAND ----------

-- DBTITLE 1,Clean Previous Executions
-- MAGIC %run ./utils/clean-practice-project

-- COMMAND ----------

-- DBTITLE 1,Setup Database Tables
-- MAGIC %python
-- MAGIC DB.setupCorpDB(spark)
-- MAGIC DB.loadCorpDB(spark)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q1. List the names of all the lawyers who are the clients of '001S' employee.
-- MAGIC
-- MAGIC Expected Output:
-- MAGIC ```
-- MAGIC   cl_name 
-- MAGIC   ----------
-- MAGIC   Lily	 
-- MAGIC   Rahul	 
-- MAGIC ```

-- COMMAND ----------

SELECT cl_name 
FROM corp_db.clients 
WHERE cl_profession = 'Lawyer' 
AND emp_id = '001S'

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q2. List the names of all those clients who are in their 20s and have been visiting the shop for less than 10 months. (i.e retention < 10)
-- MAGIC
-- MAGIC Expected Output:
-- MAGIC ```
-- MAGIC   cl_name 
-- MAGIC   ----------
-- MAGIC   Will	 
-- MAGIC   Tony	 
-- MAGIC   Tom	 
-- MAGIC   Rick	 
-- MAGIC ```
-- MAGIC

-- COMMAND ----------

SELECT cl_name 
FROM corp_db.clients 
WHERE cl_age BETWEEN 20 AND 29 
AND cl_retention < 10

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q3. The company is planning to launch a promotional offer and wants the names and phone numbers of all the clients who are not student and being catered by the employees '001S' and '002S' only.
-- MAGIC
-- MAGIC Expected Output:
-- MAGIC ```
-- MAGIC   cl_name   | cl_phone  
-- MAGIC   ---------------------
-- MAGIC   Lily      | +88 85642 
-- MAGIC   Stuart    | +88 22365 
-- MAGIC   Sana      | +91 74112 
-- MAGIC   Rachel    | +88 85651 
-- MAGIC   Luke      | +1 99486  
-- MAGIC   Ankit     | +91 99756 
-- MAGIC   Brad      | +88 85655 
-- MAGIC   Rahul     | +91 42355
-- MAGIC ```

-- COMMAND ----------

SELECT cl_name, cl_phone 
FROM corp_db.clients 
WHERE cl_profession != 'Student' 
AND emp_id IN ('001S', '002S');

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q4. It is promotion cycle for Marketing and Logistics department.\
-- MAGIC List the details of all those employees who are either in Marketing or Logistics department and have a salary greater than $50,000 but less than $80,000.\
-- MAGIC They should have also spent at least 2 years in the organisation.
-- MAGIC
-- MAGIC Expected Output:
-- MAGIC ```
-- MAGIC   emp_name  | emp_id  | emp_dept    | emp_salary  | emp_years_in_org  | emp_age
-- MAGIC   ------------------------------------------------------------------------
-- MAGIC   Shaun     | 001L    | Logistics   | 53000       | 2                 | 25   
-- MAGIC   Prateek   | 001M    | Marketing   | 75000       | 3                 | 27   
-- MAGIC ``````

-- COMMAND ----------

SELECT * 
FROM corp_db.employees 
WHERE emp_dept IN ('Marketing', 'Logistics') 
AND emp_salary > 50000 AND emp_salary < 80000
AND emp_years_in_org >= 2

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q5. List the details of all the clients who are from India. (Indian phone number starts with +91)
-- MAGIC
-- MAGIC Expected Output:
-- MAGIC ```
-- MAGIC     ----------------------------------------------------------------------------------------------------------------------------
-- MAGIC     cl_name |   cl_age  |   cl_profession   |   cl_retention    |   product_id  |   total_puchase   |   cl_phone    |   emp_id
-- MAGIC     ----------------------------------------------------------------------------------------------------------------------------
-- MAGIC     Tanvee  |   36      |   Doctor          |   16              |   10          |   8400            |   +91 78524   |   003S
-- MAGIC     Sachin  |   32      |   Actor           |   2               |   1           |   1200            |   +91 45688   |   003S
-- MAGIC     Sana    |   33      |   Architect       |   10              |   7           |   9800            |   +91 74112   |   001S
-- MAGIC     Ankit   |   35      |   Engineer        |   2               |   4           |   4200            |   +91 99756   |   002S
-- MAGIC     Rahul   |   29      |   Lawyer          |   15              |   8           |   9200            |   +91 42355   |   001S
-- MAGIC     ----------------------------------------------------------------------------------------------------------------------------
-- MAGIC ```

-- COMMAND ----------

SELECT * 
FROM corp_db.clients 
WHERE cl_phone LIKE '+91%';

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q6. Each department has a different employee id pattern such as the employees of the logistics department have their employee ids ending with the letter 'L'. Similary tabulate the unique letter associated at the end to the employee ids of each department along with that department name.
-- MAGIC
-- MAGIC Expected Output:
-- MAGIC ```
-- MAGIC   -------------------
-- MAGIC   dept  | emp_dept
-- MAGIC   -------------------
-- MAGIC   L     | Logistics  
-- MAGIC   T     | Operations 
-- MAGIC   M     | Marketing  
-- MAGIC   A     | Admin     
-- MAGIC   S     | Sales      
-- MAGIC   -------------------
-- MAGIC ```

-- COMMAND ----------

SELECT right(emp_id, 1) AS dept, emp_dept 
FROM corp_db.employees
GROUP BY dept, emp_dept

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q7. List the average age of the employees in each department.\
-- MAGIC Round the average age to only 2 places of decimal. 
-- MAGIC Amend the column names so that it is reader friendly.
-- MAGIC
-- MAGIC Expected Output:
-- MAGIC ```
-- MAGIC   --------------------------
-- MAGIC   Department |Average Age   
-- MAGIC   --------------------------
-- MAGIC   Logistics  |24.33       
-- MAGIC   Marketing  |27.67       
-- MAGIC   Operations |28.67       
-- MAGIC   Admin      |33       
-- MAGIC   Sales      |29       
-- MAGIC   --------------------------
-- MAGIC ```

-- COMMAND ----------

SELECT emp_dept AS Department, 
       round(avg(emp_age),2) AS `Average Age` 
FROM corp_db.employees
GROUP BY emp_dept

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q8. List the total sale made by each sales employee for those clients who are shopping for more than 5 months with the company.
-- MAGIC
-- MAGIC Expected Output:
-- MAGIC ```
-- MAGIC   emp_id  |sum  
-- MAGIC   ---------------
-- MAGIC   002S    |10200  
-- MAGIC   001S    |33620  
-- MAGIC   003S    |23140  
-- MAGIC   ----------------
-- MAGIC ```

-- COMMAND ----------

SELECT emp_id, sum(total_puchase) 
FROM corp_db.clients
WHERE cl_retention >= 5
GROUP BY emp_id

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q9. Your marketing team wants to segment customers based on their purchase history. Write an SQL query to calculate the average order amount (Total Purchase divided by Retention) for each customer and display only those customers whose average order amount exceeds $1000.
-- MAGIC
-- MAGIC Expected Output:
-- MAGIC ```
-- MAGIC   cl_name |Avg Order Per Month
-- MAGIC   -------------------------------
-- MAGIC   Luke    |1124.000000000000  
-- MAGIC   Brad    |1600.000000000000  
-- MAGIC   Ankit   |2100.000000000000	  
-- MAGIC ```

-- COMMAND ----------

SELECT cl_name, 
       avg(total_puchase/cl_retention) AS `Avg Order Per Month`
FROM corp_db.clients
GROUP BY cl_name
HAVING `Avg Order Per Month` > 1000

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q10. List the total sale (product_cost * qty_sold) of each product category present in the company.
-- MAGIC
-- MAGIC Expected Output:
-- MAGIC ```
-- MAGIC   product_category  |Total Sale  
-- MAGIC   -------------------------------
-- MAGIC   Hair Care         |481250   
-- MAGIC   Food              |545910 
-- MAGIC   Beverage          |47575  
-- MAGIC   Body Care         |186500   
-- MAGIC ```

-- COMMAND ----------

SELECT product_category, 
       sum(product_cost * qty_sold) AS `Total Sale`
FROM corp_db.products
GROUP BY product_category

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q11. I want to find the sales employee who booked the most sale in value. List the name of that employee and his/her employee id.
-- MAGIC
-- MAGIC Expected Output:
-- MAGIC ```
-- MAGIC   emp_name  |emp_id |sum
-- MAGIC   --------------------------
-- MAGIC   Rob       |001S   |40820
-- MAGIC ```

-- COMMAND ----------

SELECT e.emp_name, c.emp_id, sum(c.total_puchase) AS sum
FROM corp_db.employees e
LEFT JOIN corp_db.clients c ON c.emp_id = e.emp_id
GROUP BY e.emp_name, c.emp_id
ORDER BY sum DESC LIMIT 1

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q12. List the top 5 performing product details in the company based the quantities of product sold.
-- MAGIC
-- MAGIC Expected Output:
-- MAGIC ```
-- MAGIC   product_id  |product_name |product_cost |qty_available  |qty_sold |product_category 
-- MAGIC   -----------------------------------------------------------------------------------
-- MAGIC   10          |Rice         |130          |1500           |2315     |Food   
-- MAGIC   3           |Biscuit      |60           |1088           |1100     |Food   
-- MAGIC   12          |Spices       |60           |1050           |1050     |Food   
-- MAGIC   11          |Pulses       |80           |1320           |1005     |Food   
-- MAGIC   7           |Hair Oil     |150          |650            |965      |Hair Care  
-- MAGIC ```

-- COMMAND ----------

SELECT * 
FROM corp_db.products 
ORDER BY qty_sold DESC LIMIT 5

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q13. List the names of employee who are earning 2nd and 3rd highest salaries in the organisation.
-- MAGIC
-- MAGIC Expected Output:
-- MAGIC ```
-- MAGIC   emp_name 
-- MAGIC   -----------
-- MAGIC   Abdul	 
-- MAGIC   Sam	
-- MAGIC ```

-- COMMAND ----------

SELECT emp_name 
FROM corp_db.employees 
ORDER BY emp_salary DESC LIMIT 2 OFFSET 1

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q14. The company is curating a competition. Write a query to list one random individual from each department to participate in the challenge.
-- MAGIC
-- MAGIC Expected Output:
-- MAGIC ```
-- MAGIC   emp_dept    |emp_name 
-- MAGIC   -------------------------
-- MAGIC   Logistics   |Lisa 
-- MAGIC   Admin       |Abdul  
-- MAGIC   Sales       |Rob  
-- MAGIC   Operations  |Laila  
-- MAGIC   Marketing   |Prateek 
-- MAGIC   -------------------------
-- MAGIC   Results may vary due to physical data order and limit clause without order by
-- MAGIC ```

-- COMMAND ----------

SELECT DISTINCT emp_dept, emp_name 
FROM corp_db.employees LIMIT 5

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q15. The organisation is planning to curate a training for 3 of the most recent joined employees. List the names of those 3 employees.
-- MAGIC
-- MAGIC Expected Output:
-- MAGIC ```
-- MAGIC   emp_name  
-- MAGIC   -----------
-- MAGIC   Tanya 
-- MAGIC   Lisa  
-- MAGIC   Rita  
-- MAGIC ```

-- COMMAND ----------

SELECT emp_name 
FROM corp_db.employees 
ORDER BY emp_years_in_org ASC LIMIT 3

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q16. You want to present a report to the stakeholders regarding the bottom 5 perfoming products in terms of quantity sold. Write a query to view the product name and their quantities sold. Make the columns in readable format as the report goes to the stakeholders.
-- MAGIC
-- MAGIC Expected Output:
-- MAGIC ```
-- MAGIC   Product Name  |Quantity Sold
-- MAGIC   -----------------------------
-- MAGIC   Noodles       |88 
-- MAGIC   Hair Gel      |230  
-- MAGIC   Toothbrush    |230  
-- MAGIC   Soap          |495  
-- MAGIC   Butter        |500  
-- MAGIC ```

-- COMMAND ----------

SELECT product_name AS `Product Name`, qty_sold AS `Quantity Sold`
FROM corp_db.products 
ORDER BY qty_sold ASC LIMIT 5

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q17. Retrieve the employees who have been with the organization for more than 5 years and have a salary higher than the average salary of all employees.
-- MAGIC
-- MAGIC Expected Output:
-- MAGIC ```
-- MAGIC   emp_name  |emp_id |emp_dept |emp_salary |emp_yearsinorg |emp_age  
-- MAGIC   ------------------------------------------------------------------
-- MAGIC   Shaily    |001A   |Admin    |105000     |7              |33   
-- MAGIC   Sam       |003A   |Admin    |89000      |6              |35 
-- MAGIC ```

-- COMMAND ----------

SELECT * 
FROM corp_db.employees
WHERE emp_years_in_org > 5 AND emp_salary > (
    SELECT avg(emp_salary) FROM corp_db.employees
)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q18. I want to find the names of all employees who have the same salary as that of the employee '002S'.\
-- MAGIC Make sure that the salary's numerical value is directly not used in the query.
-- MAGIC
-- MAGIC Expected Output:
-- MAGIC ```
-- MAGIC emp_name 
-- MAGIC -----------
-- MAGIC Abhay
-- MAGIC ```

-- COMMAND ----------

SELECT emp_name 
FROM corp_db.employees
WHERE emp_salary = (SELECT emp_salary FROM corp_db.employees WHERE emp_id = '002S')
AND emp_id != '002S'

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q19. The company wants to analyze the inventory turnover rate for each product category. Write an SQL query to calculate the inventory turnover rate (quantity sold / quantity available) for each product category, and display only those categories where the turnover rate exceeds 0.8.
-- MAGIC
-- MAGIC Expected Output:
-- MAGIC ```
-- MAGIC product_category  |turnover_rate
-- MAGIC ---------------------------------------
-- MAGIC Food              |1.0253893026404874
-- MAGIC Hair Care         |0.8275439313445034
-- MAGIC ---------------------------------------
-- MAGIC ```

-- COMMAND ----------

SELECT product_category, 
       (sum(qty_sold))/(sum(qty_available)) AS turnover_rate
FROM corp_db.products
GROUP BY product_category
HAVING turnover_rate > 0.8

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q20. it is month end stock checking season. I want to list all the details of the product which are below the minimum available in the store for each category.
-- MAGIC
-- MAGIC Expected Output:
-- MAGIC ```
-- MAGIC product_id  |product_name |product_cost |qty_available  |qty_sold |product_category
-- MAGIC --------------------------------------------------------------------------------------
-- MAGIC 4           |Noodles      |120          |420            |88       |Food
-- MAGIC 7           |Hair Oil     |150          |650            |965      |Hair Care
-- MAGIC 8           |Deodrant     |100          |550            |750      |Body Care
-- MAGIC 15          |Juices       |50           |675            |500      |Beverage
-- MAGIC ```

-- COMMAND ----------

SELECT * 
FROM corp_db.products 
WHERE qty_available IN (SELECT min(qty_available) FROM corp_db.products	GROUP BY product_category)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC &copy; 2021-2025 <a href="https://www.scholarnest.com/">ScholarNest</a>. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC Databricks, Databricks Cloud and the Databricks logo are trademarks of the <a href="https://www.databricks.com/">Databricks Inc</a>.<br/>
-- MAGIC <br/>
-- MAGIC <a href="https://www.scholarnest.in/pages/privacy">Privacy Policy</a> | <a href="https://www.scholarnest.in/pages/terms">Terms of Use</a> | <a href="https://www.scholarnest.in/pages/contact">Contact Us</a>