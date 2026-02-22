-- Databricks notebook source
-- MAGIC %md
-- MAGIC <div style="text-align: center; line-height: 0; padding-top: 9px;">
-- MAGIC   <img src="https://learningjournal.github.io/pub-resources/logos/scholarnest_academy.jpg" alt="ScholarNest Academy" style="width: 1400px">
-- MAGIC </div>

-- COMMAND ----------

-- DBTITLE 1,Clean Previous Executions
-- MAGIC %run ./utils/clean-practice-project

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q1. Create corp_db database

-- COMMAND ----------

CREATE DATABASE IF NOT EXISTS corp_db

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q2. Create employees table

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS corp_db.employees (
    emp_id STRING,
    emp_name STRING,    
    emp_dept STRING,
    emp_salary DOUBLE,
    emp_years_in_org INT,
    emp_age INT
)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q3. Create products table

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS corp_db.products(
    product_id INT,
    product_name STRING,
    product_cost DOUBLE,
    qty_available INT,
    qty_sold INT,
    product_category STRING
)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q4. Create clients table

-- COMMAND ----------


CREATE TABLE IF NOT EXISTS corp_db.clients(
    cl_name STRING,
    cl_age INT,
    cl_profession STRING,
    cl_retention INT,
    product_id INT,
    total_puchase DOUBLE,
    cl_phone STRING,
    emp_id STRING
)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC &copy; 2021-2025 <a href="https://www.scholarnest.com/">ScholarNest</a>. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC Databricks, Databricks Cloud and the Databricks logo are trademarks of the <a href="https://www.databricks.com/">Databricks Inc</a>.<br/>
-- MAGIC <br/>
-- MAGIC <a href="https://www.scholarnest.in/pages/privacy">Privacy Policy</a> | <a href="https://www.scholarnest.in/pages/terms">Terms of Use</a> | <a href="https://www.scholarnest.in/pages/contact">Contact Us</a>