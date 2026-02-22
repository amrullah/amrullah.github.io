-- Databricks notebook source
-- MAGIC %md
-- MAGIC <div style="text-align: center; line-height: 0; padding-top: 9px;">
-- MAGIC   <img src="https://learningjournal.github.io/pub-resources/logos/scholarnest_academy.jpg" alt="ScholarNest Academy" style="width: 1400px">
-- MAGIC </div>

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####Commonly used mathematical functions
-- MAGIC 1. round(expr, d)
-- MAGIC 2. abs(expr)
-- MAGIC 3. ceil(expr)
-- MAGIC 4. floor(expr)
-- MAGIC 5. least(expr, ...) 
-- MAGIC 6. greatest(xpr, ...)
-- MAGIC 7. pow(expr1, expr2)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q1. How can you create a CTE with some data to test a SQL idea?
-- MAGIC
-- MAGIC Create a CTE to produce the following data.
-- MAGIC ```
-- MAGIC   Name      | Age | Salary  | Department
-- MAGIC   ---------------------------------------
-- MAGIC   Prashant  | 45  | 5289    | Accounts
-- MAGIC   Sushant   | 42  | 3568    | Sales 
-- MAGIC   ---------------------------------------
-- MAGIC ```

-- COMMAND ----------

WITH my_table(Name, Age, Salary, Department) AS (
  SELECT *
  FROM VALUES ("Prashant", 45, 5289, "Accounts"),
              ("Sushant", 42, 3568, "Sales")
)
SELECT * FROM my_table 

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q2. Create a CTE as the following and test the round function on the salary.
-- MAGIC ```
-- MAGIC   Name      | Age | Salary   | Department
-- MAGIC   -----------------------------------------
-- MAGIC   Prashant  | 45  | 5289.87  | Accounts
-- MAGIC   Sushant   | 42  | 3568.34  | Sales 
-- MAGIC   -----------------------------------------
-- MAGIC ```

-- COMMAND ----------

WITH employee(Name, Age, Salary, Department) AS (
  SELECT *
  FROM VALUES ("Prashant", 45, 5289.87, "Accounts"),
              ("Sushant", 42, 3568.34, "Sales")
)
SELECT Name, Age, round(Salary, 0) AS Salary, Department 
FROM employee 

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q3. How can you test the round() function in the simplest possible way?

-- COMMAND ----------

SELECT round(5289.87, 0)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q4. Which function is used to get absolute value of a number?

-- COMMAND ----------

SELECT abs(-274.98)


-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q5. Which function is used to produce the floor value?

-- COMMAND ----------

SELECT floor(274.98, 0)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q6. Which function is used to produce the ceil value?

-- COMMAND ----------

SELECT ceil(274.98, 0)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q7. Which function is used to produce 2 to the power 5?

-- COMMAND ----------

SELECT pow(2, 5)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q8. Create a CTE as the following.
-- MAGIC ```
-- MAGIC   product | price | card_discount | employee_discount | coupon_discount
-- MAGIC   -------------------------------------------------------------------------
-- MAGIC   Laptop  | 53289 |     10        |       12          |       15
-- MAGIC   -------------------------------------------------------------------------
-- MAGIC ```
-- MAGIC 1. Write a SQL to calculate the discounted price for the Laptop.
-- MAGIC 2. Customer is eligible for all type of discounts but he/she can take whichever is maximum.

-- COMMAND ----------

WITH products(product, price, card_discount, employee_discount, coupon_discount) AS (
  SELECT *   FROM VALUES ("Laptop", 53289, 10, 12, 15)
)
SELECT product, price,
       price - price * greatest(card_discount, employee_discount, coupon_discount) / 100 AS discounted_price
FROM products

-- COMMAND ----------

-- MAGIC %md
-- MAGIC &copy; 2021-2025 <a href="https://www.scholarnest.com/">ScholarNest</a>. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC Databricks, Databricks Cloud and the Databricks logo are trademarks of the <a href="https://www.databricks.com/">Databricks Inc</a>.<br/>
-- MAGIC <br/>
-- MAGIC <a href="https://www.scholarnest.in/pages/privacy">Privacy Policy</a> | <a href="https://www.scholarnest.in/pages/terms">Terms of Use</a> | <a href="https://www.scholarnest.in/pages/contact">Contact Us</a>