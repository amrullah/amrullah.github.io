-- Databricks notebook source
-- MAGIC %md
-- MAGIC <div style="text-align: center; line-height: 0; padding-top: 9px;">
-- MAGIC   <img src="https://learningjournal.github.io/pub-resources/logos/scholarnest_academy.jpg" alt="ScholarNest Academy" style="width: 1400px">
-- MAGIC </div>

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####Pivoting data sets
-- MAGIC Pivoting is a two dimentional analysis of a data set.
-- MAGIC
-- MAGIC Example
-- MAGIC ```
-- MAGIC   Customers   | Product 1 | Product 2 | Product 3
-- MAGIC   -----------------------------------------------
-- MAGIC   Customer 1  |    xxx    |    xxx    |    xxx    
-- MAGIC   Customer 2  |    xxx    |    xxx    |    xxx    
-- MAGIC   Customer 3  |    xxx    |    xxx    |    xxx    
-- MAGIC   -----------------------------------------------
-- MAGIC ```
-- MAGIC
-- MAGIC Pivot Syntax
-- MAGIC ```
-- MAGIC   SELECT * FROM pivot_data
-- MAGIC   PIVOT ( aggregate_function()
-- MAGIC           FOR column_field_name IN ( column_values ) 
-- MAGIC         )
-- MAGIC ```
-- MAGIC

-- COMMAND ----------

-- DBTITLE 1,Clean Previous Executions
-- MAGIC %run ./utils/clean-microproject

-- COMMAND ----------

-- DBTITLE 1,Setup Database and Tables
-- MAGIC %python
-- MAGIC DB.setup(spark)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q1. You have a sales table.\
-- MAGIC Write SQL to create a pivot report as the following.
-- MAGIC 1. Rows: Customer Name
-- MAGIC 2. Columns: Products (Steel Door 4x7, Steel TMT 550, Steel Window 8x4)
-- MAGIC 3. Summary: Total Sales
-- MAGIC
-- MAGIC The Pivot table should look as the following.
-- MAGIC ```
-- MAGIC   customer_name           | Steel Door 4x7  | Steel TMT 550   | Steel Window 8x4
-- MAGIC   ---------------------------------------------------------------------------------
-- MAGIC   Super Trading Company   | 385947          | 182942          | 338650
-- MAGIC   One Distributors        | null            | 154012          | 283160
-- MAGIC   Great Enterprises       | 285143          | 150209          | 330401
-- MAGIC ```

-- COMMAND ----------

WITH pivot_data AS (SELECT customer_name, product_name, amount FROM ramco_db.sales)
SELECT * FROM pivot_data
PIVOT ( sum(amount)
          FOR product_name IN ( "Steel Door 4x7", "Steel TMT 550", "Steel Window 8x4" ) 
      )

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q2. You have a sales table.\
-- MAGIC Write SQL to create a pivot report as the following.
-- MAGIC 1. Rows: Customer Name
-- MAGIC 2. Columns: Products (Steel Door 4x7, Steel TMT 550, Steel Window 8x4)
-- MAGIC 3. Summary: Average units sold

-- COMMAND ----------

WITH pivot_data AS (SELECT customer_name, product_name, units FROM ramco_db.sales)
SELECT * FROM pivot_data
PIVOT ( avg(units)
        FOR product_name IN ( "Steel Door 4x7","Steel TMT 550", "Steel Window 8x4" ) 
      )

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q3. You have a sales table.\
-- MAGIC Write SQL to create a pivot report as the following.
-- MAGIC 1. Rows: Products
-- MAGIC 2. Columns: Customers (Super Trading Company, One Distributors, Great Enterprises)
-- MAGIC 3. Summary: Total Sales

-- COMMAND ----------

WITH pivot_data AS (SELECT customer_name, product_name, amount FROM ramco_db.sales)
SELECT * FROM pivot_data
  PIVOT ( sum(amount)
          FOR customer_name IN ("Super Trading Company", "One Distributors", "Great Enterprises") 
        ) 

-- COMMAND ----------

-- MAGIC %md
-- MAGIC %md
-- MAGIC Q4. You have a sales table.\
-- MAGIC Write SQL to create a pivot report as the following.
-- MAGIC 1. Rows: Customer Name
-- MAGIC 2. Columns: Products (Door/Window, Steel TMT)
-- MAGIC 3. Summary: Total Sales
-- MAGIC
-- MAGIC Consolidate all door and window products under Door/Window and all steel sales under Steel TMT.

-- COMMAND ----------

WITH pivot_data AS (SELECT customer_name, 
                           CASE WHEN product_name LIKE "%Door%" OR product_name LIKE "%Window%" THEN "Door/Window"
                                WHEN product_name LIKE "%TMT%" THEN "Steel TMT"
                                ELSE "Other"
                           END AS product_name, 
                           amount FROM ramco_db.sales)
SELECT * FROM pivot_data
  PIVOT ( sum(amount)
          FOR product_name IN ("Door/Window", "Steel TMT" ) 
        )

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q5. You have annual sales table.
-- MAGIC Write SQL to create a pivot report as the following.
-- MAGIC
-- MAGIC Sample Report
-- MAGIC ```
-- MAGIC   Product |Sales_2022   |Sales_2021   |Sales_2020
-- MAGIC   --------------------------------------------------
-- MAGIC   Laptop  |78920        |93847        |23967
-- MAGIC   Mobile  |6730         |9730         |8730
-- MAGIC ```

-- COMMAND ----------

WITH annual_sales(year, product, sales) AS(
  SELECT * FROM 
  VALUES(2018, "Laptop", 24967),
        (2018, "Mobile", 7730),
        (2019, "Laptop", 63847),
        (2019, "Mobile", 4730),
        (2020, "Laptop", 23967),
        (2020, "Mobile", 8730),
        (2021, "Laptop", 93847),
        (2021, "Mobile", 9730),
        (2022, "Laptop", 78920),
        (2022, "Mobile", 6730)
)
SELECT * FROM annual_sales
PIVOT ( sum(sales)
        FOR year IN ( 2022 AS Sales_2022, 2021 AS Sales_2021, 2020 AS Sales_2020) 
      )

-- COMMAND ----------

-- MAGIC %md
-- MAGIC &copy; 2021-2025 <a href="https://www.scholarnest.in/">ScholarNest</a>. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC Databricks, Databricks Cloud and the Databricks logo are trademarks of the <a href="https://www.databricks.com/">Databricks Inc</a>.<br/>
-- MAGIC <br/>
-- MAGIC <a href="https://www.scholarnest.in/pages/privacy">Privacy Policy</a> | <a href="https://www.scholarnest.in/pages/terms">Terms of Use</a> | <a href="https://www.scholarnest.in/pages/contact">Contact Us</a>