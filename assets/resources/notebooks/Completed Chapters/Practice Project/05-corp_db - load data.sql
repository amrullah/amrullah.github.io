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

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q1. Load employees table

-- COMMAND ----------

INSERT INTO corp_db.employees
SELECT emp_id, emp_name, emp_dept, emp_salary, emp_yearsinorg emp_years_in_org, emp_age
FROM read_files("/Volumes/dev/scholarnest/sql_data/corp/employees.csv", 
                          format => "csv", header => true, inferSchema => true)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q2. Load products table

-- COMMAND ----------

INSERT INTO corp_db.products
SELECT product_id, product_name, product_cost, qty_available, qty_sold, product_category
FROM read_files("/Volumes/dev/scholarnest/sql_data/corp/products.csv", 
                          format => "csv", header => true, inferSchema => true)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q3. Load clients table

-- COMMAND ----------

INSERT INTO corp_db.clients
SELECT cl_name, cl_age, cl_profession, cl_retention, product_id, total_puchase, cl_phone, emp_id
FROM read_files("/Volumes/dev/scholarnest/sql_data/corp/clients.csv", 
                          format => "csv", header => true, inferSchema => true)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC &copy; 2021-2025 <a href="https://www.scholarnest.com/">ScholarNest</a>. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC Databricks, Databricks Cloud and the Databricks logo are trademarks of the <a href="https://www.databricks.com/">Databricks Inc</a>.<br/>
-- MAGIC <br/>
-- MAGIC <a href="https://www.scholarnest.in/pages/privacy">Privacy Policy</a> | <a href="https://www.scholarnest.in/pages/terms">Terms of Use</a> | <a href="https://www.scholarnest.in/pages/contact">Contact Us</a>