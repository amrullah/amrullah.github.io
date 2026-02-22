-- Databricks notebook source
-- MAGIC %md
-- MAGIC <div style="text-align: center; line-height: 0; padding-top: 9px;">
-- MAGIC   <img src="https://learningjournal.github.io/pub-resources/logos/scholarnest_academy.jpg" alt="ScholarNest Academy" style="width: 1400px">
-- MAGIC </div>

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####Inserting and Manipulating Data
-- MAGIC 1. Insert Records
-- MAGIC     1. Insert using values
-- MAGIC     2. Insert using select
-- MAGIC 2. Update Records
-- MAGIC 3. Delete Records

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####Cleanup previous executions

-- COMMAND ----------

-- MAGIC %run ./utils/cleanup-my-db

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####1. Create a database and tables

-- COMMAND ----------

CREATE DATABASE IF NOT EXISTS my_db;

CREATE TABLE IF NOT EXISTS my_db.customer_leads(
  id INT,
  first_name STRING,
  last_name STRING,
  phone STRING
);

CREATE TABLE IF NOT EXISTS my_db.customers(
  id INT,
  full_name STRING,
  phone STRING
);

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####2. Insert single records using values

-- COMMAND ----------

INSERT INTO my_db.customer_leads (id, first_name, last_name, phone) 
VALUES (101, "Prashant", "Panday", "9998886660");

INSERT INTO my_db.customer_leads (id, first_name, last_name) 
VALUES (102, "David", "Turner");

INSERT INTO my_db.customer_leads
VALUES (103, "Smita", "Patel", "2222444490");

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####3. Insert multiple records using values

-- COMMAND ----------

INSERT INTO my_db.customer_leads (id, first_name, last_name, phone) 
VALUES (104, "Abdul", "Kadir", "9988112230"),
       (105, "Vikram", "Singh", null),
       (106, "July", "Macloskey", "7711234560");

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####4. Insert records using select

-- COMMAND ----------

INSERT INTO my_db.customers
SELECT id, concat(first_name, " ", last_name) AS full_name, phone 
FROM my_db.customer_leads
WHERE phone is NOT NULL;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####5. Update table data

-- COMMAND ----------

UPDATE my_db.customers 
SET full_name="Prashant Pandey", phone="9823456790"
WHERE id = 101;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####6. Delete record

-- COMMAND ----------

DELETE FROM my_db.customers WHERE id=103

-- COMMAND ----------

-- MAGIC %md
-- MAGIC &copy; 2021-2024 <a href="https://www.scholarnest.in/">ScholarNest</a>. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC Databricks, Databricks Cloud and the Databricks logo are trademarks of the <a href="https://www.databricks.com/">Databricks Inc</a>.<br/>
-- MAGIC <br/>
-- MAGIC <a href="https://www.scholarnest.in/pages/privacy">Privacy Policy</a> | <a href="https://www.scholarnest.in/pages/terms">Terms of Use</a> | <a href="https://www.scholarnest.in/pages/contact">Contact Us</a>