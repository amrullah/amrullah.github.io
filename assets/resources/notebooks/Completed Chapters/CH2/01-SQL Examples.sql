-- Databricks notebook source
-- MAGIC %md
-- MAGIC <div style="text-align: center; line-height: 0; padding-top: 9px;">
-- MAGIC   <img src="https://learningjournal.github.io/pub-resources/logos/scholarnest_academy.jpg" alt="ScholarNest Academy" style="width: 1400px">
-- MAGIC </div>

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####Cleanup previous executions

-- COMMAND ----------

-- MAGIC %run ./utils/cleanup-sql-db

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####Create Database

-- COMMAND ----------

CREATE DATABASE IF NOT EXISTS sql_db

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####Create Table in your database

-- COMMAND ----------

CREATE OR REPLACE TABLE sql_db.diamonds(
    carat DOUBLE,
    clarity STRING,
    color STRING,
    cut STRING,
    depth STRING,
    price DOUBLE)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####Load data into your table

-- COMMAND ----------

INSERT INTO sql_db.diamonds 
SELECT * FROM json.`/Volumes/dev/scholarnest/sql_data/diamonds.json`

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####Answer a business question
-- MAGIC #####Q: Show me the average price for each colour in decending order

-- COMMAND ----------

SELECT color, avg(price) AS avg_price
FROM sql_db.diamonds
GROUP BY color
ORDER BY avg_price DESC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####Manipulate data
-- MAGIC #####Increate the dimond price by 10%

-- COMMAND ----------

UPDATE sql_db.diamonds SET price =  price + (price * 0.10)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####Answer a business question
-- MAGIC #####Q: Show me the average price for each colour in decending order

-- COMMAND ----------

SELECT color, avg(price) AS avg_price
FROM sql_db.diamonds
GROUP BY color
ORDER BY avg_price DESC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC &copy; 2021-2024 <a href="https://www.scholarnest.in/">ScholarNest</a>. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC Databricks, Databricks Cloud and the Databricks logo are trademarks of the <a href="https://www.databricks.com/">Databricks Inc</a>.<br/>
-- MAGIC <br/>
-- MAGIC <a href="https://www.scholarnest.in/pages/privacy">Privacy Policy</a> | <a href="https://www.scholarnest.in/pages/terms">Terms of Use</a> | <a href="https://www.scholarnest.in/pages/contact">Contact Us</a>