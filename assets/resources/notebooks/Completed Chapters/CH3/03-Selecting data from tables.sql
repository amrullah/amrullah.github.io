-- Databricks notebook source
-- MAGIC %md
-- MAGIC <div style="text-align: center; line-height: 0; padding-top: 9px;">
-- MAGIC   <img src="https://learningjournal.github.io/pub-resources/logos/scholarnest_academy.jpg" alt="ScholarNest Academy" style="width: 1400px">
-- MAGIC </div>

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####Cleanup previous executions

-- COMMAND ----------

-- MAGIC %run ./utils/setup-my-db

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####Most basic structure of a SQL query
-- MAGIC         
-- MAGIC ```sql
-- MAGIC       SELECT expression
-- MAGIC       FROM source
-- MAGIC       [WHERE] condition
-- MAGIC       [ORDER BY]
-- MAGIC       [LIMIT/OFFSET]
-- MAGIC ```
-- MAGIC Example:
-- MAGIC ```sql
-- MAGIC       SELECT id, first_name, last_name
-- MAGIC       FROM my_db.customers
-- MAGIC       WHERE id=101   
-- MAGIC ```

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####Selecting Records
-- MAGIC 1. Select from a table
-- MAGIC 2. Select from other sources

-- COMMAND ----------

-- MAGIC %python
-- MAGIC DB.setup_table(spark) #Create my_db.diamonds table and load data into table

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####1. Show Table Data 
-- MAGIC SELECT everything from a table

-- COMMAND ----------

SELECT * 
FROM my_db.diamonds

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####2. SELECT required columns only 
-- MAGIC SELECT clarity, cut and price 

-- COMMAND ----------

SELECT clarity, cut, price 
FROM my_db.diamonds

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####3. Change column order in the results 
-- MAGIC SELECT cut, clarity and price

-- COMMAND ----------

SELECT cut, clarity, price
FROM my_db.diamonds

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####4. Change column names in results 
-- MAGIC SELECT clarity and price as diamond_clarity and unit_price

-- COMMAND ----------

SELECT clarity as diamond_clarity, price as unit_price
FROM my_db.diamonds

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####5. Filtering records 
-- MAGIC SELECT all columns WHERE cut is "Very Good"

-- COMMAND ----------

SELECT *
FROM my_db.diamonds
WHERE cut = "Very Good"

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####6. Filtering records 
-- MAGIC SELECT all columns WHERE cut is "Very Good" AND price is more than 500

-- COMMAND ----------

SELECT * FROM my_db.diamonds
WHERE cut = "Very Good" AND price > 500

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####7. Filtering records 
-- MAGIC SELECT all columns WHERE cut is "Very Good" OR clarity is "VS1"

-- COMMAND ----------

SELECT * FROM my_db.diamonds
WHERE cut = "Very Good" OR clarity = "VS1"

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####8. Showing the result in sorrted order 
-- MAGIC SELECT "Very Good" cut in descending price ORDER

-- COMMAND ----------

SELECT * FROM my_db.diamonds
WHERE cut = "Very Good"
ORDER BY price DESC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####9. Showing the result in sorrted order 
-- MAGIC SELECT "Very Good" cut in ascending price ORDER

-- COMMAND ----------

SELECT * FROM my_db.diamonds
WHERE cut = "Very Good"
ORDER BY price ASC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####10. Limiting the results 
-- MAGIC SELECT top 5 most expensive "Very Good" cuts

-- COMMAND ----------

SELECT * FROM my_db.diamonds
WHERE cut = "Very Good"
ORDER BY price DESC
LIMIT 5

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####11. Skipping the records 
-- MAGIC SELECT 3rd, 4th, and 5th most expesive "Very Good" cuts

-- COMMAND ----------

SELECT * FROM my_db.diamonds
WHERE cut = "Very Good"
ORDER BY price DESC
LIMIT 3
OFFSET 2

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####12. Selecting from other sources
-- MAGIC SELECT all records from a JSON file present at /FileStore/sql-data/diamonds.json

-- COMMAND ----------

SELECT * 
FROM JSON.`/Volumes/dev/scholarnest/sql_data/diamonds.json`

-- COMMAND ----------

-- MAGIC %md
-- MAGIC &copy; 2021-2024 <a href="https://www.scholarnest.in/">ScholarNest</a>. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC Databricks, Databricks Cloud and the Databricks logo are trademarks of the <a href="https://www.databricks.com/">Databricks Inc</a>.<br/>
-- MAGIC <br/>
-- MAGIC <a href="https://www.scholarnest.in/pages/privacy">Privacy Policy</a> | <a href="https://www.scholarnest.in/pages/terms">Terms of Use</a> | <a href="https://www.scholarnest.in/pages/contact">Contact Us</a>