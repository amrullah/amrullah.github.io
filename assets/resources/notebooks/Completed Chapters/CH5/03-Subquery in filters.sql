-- Databricks notebook source
-- MAGIC %md
-- MAGIC <div style="text-align: center; line-height: 0; padding-top: 9px;">
-- MAGIC   <img src="https://learningjournal.github.io/pub-resources/logos/scholarnest_academy.jpg" alt="ScholarNest Academy" style="width: 1400px">
-- MAGIC </div>

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####Subquery Filter
-- MAGIC ```
-- MAGIC SELECT expression 
-- MAGIC FROM source
-- MAGIC WHERE expression operator (SELECT expression FROM source WHERE ...)
-- MAGIC ```
-- MAGIC
-- MAGIC Type of operators
-- MAGIC 1. Single value
-- MAGIC 2. List of values

-- COMMAND ----------

-- DBTITLE 1,Clean Previous Executions
-- MAGIC %run ./utils/clean-microproject

-- COMMAND ----------

-- DBTITLE 1,Setup Database and Tables
-- MAGIC %python
-- MAGIC DB.setup(spark)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q1. Show me a list of all bookings made by Tracy Smith for more than 5 slots.

-- COMMAND ----------

SELECT * FROM club_db.bookings
WHERE slots > 5
AND member_id = (
  SELECT member_id 
  FROM club_db.members 
  WHERE first_name = "Tracy" AND last_name = "Smith"
) 

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q2. Show me a list of all bookings made by Darren Smith for more than 5 slots.

-- COMMAND ----------

SELECT * FROM club_db.bookings
WHERE slots > 5
AND member_id IN (
  SELECT member_id 
  FROM club_db.members 
  WHERE first_name = "Darren" AND last_name = "Smith"
) 

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q3. Show me a list of all Court bookings made by Tracy Smith.

-- COMMAND ----------

SELECT * FROM club_db.bookings
WHERE facility_id IN (
  SELECT facility_id FROM club_db.facilities 
  WHERE facility_name LIKE "%Court%"
) AND member_id = (
  SELECT member_id 
  FROM club_db.members 
  WHERE first_name = "Tracy" AND last_name = "Smith"
)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q4. Find the members who never made any bookings.

-- COMMAND ----------

SELECT * FROM club_db.members
WHERE member_id NOT IN (
  SELECT member_id FROM club_db.bookings
)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC &copy; 2021-2025 <a href="https://www.scholarnest.com/">ScholarNest</a>. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC Databricks, Databricks Cloud and the Databricks logo are trademarks of the <a href="https://www.databricks.com/">Databricks Inc</a>.<br/>
-- MAGIC <br/>
-- MAGIC <a href="https://www.scholarnest.in/pages/privacy">Privacy Policy</a> | <a href="https://www.scholarnest.in/pages/terms">Terms of Use</a> | <a href="https://www.scholarnest.in/pages/contact">Contact Us</a>