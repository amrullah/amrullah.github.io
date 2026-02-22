-- Databricks notebook source
-- MAGIC %md
-- MAGIC <div style="text-align: center; line-height: 0; padding-top: 9px;">
-- MAGIC   <img src="https://learningjournal.github.io/pub-resources/logos/scholarnest_academy.jpg" alt="ScholarNest Academy" style="width: 1400px">
-- MAGIC </div>

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####Set Operations in SQL
-- MAGIC Set operations are used to vertically combine two data sets of same structure into a single one. 
-- MAGIC
-- MAGIC Set Operators
-- MAGIC 1. UNION and UNION ALL
-- MAGIC 2. INTERSECT and INTERSECT ALL
-- MAGIC 3. EXCEPT and EXCEPT ALL

-- COMMAND ----------

-- DBTITLE 1,Clean Previous Executions
-- MAGIC %run ./utils/clean-microproject

-- COMMAND ----------

-- DBTITLE 1,Setup Database and Tables
-- MAGIC %python
-- MAGIC DB.setup(spark)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q1. You are given potential_users and registered_users table in ramco_db.\
-- MAGIC Combine both into a single data set. Ensure to list all users including duplicate records.

-- COMMAND ----------

SELECT * FROM ramco_db.potential_users
UNION ALL
SELECT * FROM ramco_db.registered_users

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q2. You are given potential_users and registered_users table in ramco_db.\
-- MAGIC Combine both into a single data set. Ensure to list only unique records.

-- COMMAND ----------

SELECT * FROM ramco_db.potential_users
UNION
SELECT * FROM ramco_db.registered_users

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q3. You are given potential_users and registered_users table in ramco_db.\
-- MAGIC List users found in both the data sets.

-- COMMAND ----------

SELECT * FROM ramco_db.potential_users
INTERSECT
SELECT * FROM ramco_db.registered_users

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q4. You are given potential_users and registered_users table in ramco_db.\
-- MAGIC List all potential users that are not in registered users.

-- COMMAND ----------

SELECT * FROM ramco_db.potential_users
EXCEPT
SELECT * FROM ramco_db.registered_users

-- COMMAND ----------

-- MAGIC %md
-- MAGIC &copy; 2021-2025 <a href="https://www.scholarnest.in/">ScholarNest</a>. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC Databricks, Databricks Cloud and the Databricks logo are trademarks of the <a href="https://www.databricks.com/">Databricks Inc</a>.<br/>
-- MAGIC <br/>
-- MAGIC <a href="https://www.scholarnest.in/pages/privacy">Privacy Policy</a> | <a href="https://www.scholarnest.in/pages/terms">Terms of Use</a> | <a href="https://www.scholarnest.in/pages/contact">Contact Us</a>