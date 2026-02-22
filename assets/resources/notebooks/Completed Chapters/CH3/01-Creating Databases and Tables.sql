-- Databricks notebook source
-- MAGIC %md
-- MAGIC <div style="text-align: center; line-height: 0; padding-top: 9px;">
-- MAGIC   <img src="https://learningjournal.github.io/pub-resources/logos/scholarnest_academy.jpg" alt="ScholarNest Academy" style="width: 1400px">
-- MAGIC </div>

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####Working with Database
-- MAGIC 1. Show all databases
-- MAGIC 2. Create a Database
-- MAGIC 3. Describe a Database
-- MAGIC 4. Drop a Database

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####Clean previous executions

-- COMMAND ----------

-- MAGIC %run ./utils/cleanup-my-db

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####1. Show all databases

-- COMMAND ----------

SHOW DATABASES

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####2. Create a Database

-- COMMAND ----------

CREATE DATABASE IF NOT EXISTS test_db

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####3. Describe a Database

-- COMMAND ----------

DESCRIBE DATABASE EXTENDED test_db

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####4. Drop a Database

-- COMMAND ----------

DROP DATABASE IF EXISTS test_db CASCADE

-- COMMAND ----------

-- MAGIC %md
-- MAGIC %md
-- MAGIC ####Working with Tables
-- MAGIC 1. Create a table
-- MAGIC 2. Show all tables in a databases
-- MAGIC 3. Describe a table
-- MAGIC 4. Alter a table
-- MAGIC 5. Drop a table

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####1. Create a table

-- COMMAND ----------

CREATE DATABASE IF NOT EXISTS my_db;

CREATE TABLE IF NOT EXISTS my_db.facilities(
  id INT,
  name STRING,
  cost DOUBLE
)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####2. Show all tables in a databases

-- COMMAND ----------

SHOW TABLES IN my_db

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####3. Describe a table

-- COMMAND ----------

DESCRIBE TABLE my_db.facilities

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####4. Alter a table
-- MAGIC 1. Rename Table
-- MAGIC 2. Add new column
-- MAGIC 3. Drop existing column
-- MAGIC 4. Rename a column 

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####4.1 Rename Table

-- COMMAND ----------

-- MAGIC %python
-- MAGIC DB.enableRename(spark)

-- COMMAND ----------

ALTER TABLE my_db.facilities RENAME TO my_db.facility;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####4.2 Add new column

-- COMMAND ----------

ALTER TABLE my_db.facility ADD COLUMNS (non_member_cost DOUBLE)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####4.3 Drop existing column

-- COMMAND ----------

-- MAGIC %python
-- MAGIC DB.enableDrop(spark)

-- COMMAND ----------

ALTER TABLE my_db.facility DROP COLUMNS (non_member_cost, cost);

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####4.4 Rename a column 

-- COMMAND ----------

ALTER TABLE my_db.facility RENAME COLUMN id TO facility_id;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####5. Drop a table

-- COMMAND ----------

DROP TABLE IF EXISTS my_db.facility;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC &copy; 2021-2024 <a href="https://www.scholarnest.in/">ScholarNest</a>. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC Databricks, Databricks Cloud and the Databricks logo are trademarks of the <a href="https://www.databricks.com/">Databricks Inc</a>.<br/>
-- MAGIC <br/>
-- MAGIC <a href="https://www.scholarnest.in/pages/privacy">Privacy Policy</a> | <a href="https://www.scholarnest.in/pages/terms">Terms of Use</a> | <a href="https://www.scholarnest.in/pages/contact">Contact Us</a>