-- Databricks notebook source
-- MAGIC %md
-- MAGIC <div style="text-align: center; line-height: 0; padding-top: 9px;">
-- MAGIC   <img src="https://learningjournal.github.io/pub-resources/logos/scholarnest_academy.jpg" alt="ScholarNest Academy" style="width: 1400px">
-- MAGIC </div>

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####Selecting Columns
-- MAGIC 1. Select all columns from the table
-- MAGIC 3. Select desired columns only
-- MAGIC 4. Change column order in the results
-- MAGIC 5. Change column names in results
-- MAGIC 6. Remove duplicates from results
-- MAGIC         
-- MAGIC ```sql
-- MAGIC       SELECT expression
-- MAGIC       FROM table_name
-- MAGIC ```
-- MAGIC

-- COMMAND ----------

-- DBTITLE 1,Clean previous executions
-- MAGIC %run ./utils/clean-microproject

-- COMMAND ----------

-- DBTITLE 1,Setup Database and Tables
-- MAGIC %python
-- MAGIC DB.setup(spark)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####1. Select all columns from the table
-- MAGIC Q: List all club members

-- COMMAND ----------

SELECT * FROM club_db.members

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####2. Select desired columns only
-- MAGIC Q: Show name, address, zipcode, and phone number of all members

-- COMMAND ----------

SELECT first_name, address, zip_code, telephone FROM club_db.members

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####3. Change column order in the results
-- MAGIC Q: Show facility name, guest cost, and member cost

-- COMMAND ----------

SELECT facility_name, guest_cost, member_cost FROM club_db.facilities

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####4. Change column names in results
-- MAGIC Q: Create a list of members as the following
-- MAGIC
-- MAGIC ```
-- MAGIC  Member Name | Address | Zip Code | Contact No
-- MAGIC ----------------------------------------------------
-- MAGIC ```

-- COMMAND ----------

SELECT first_name as `Member Name`, 
       address as Address, 
       zip_code as `Zip Code`, 
       telephone as `Contact No`
FROM club_db.members

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####5. Remove duplicates from results
-- MAGIC Q: List unique member names

-- COMMAND ----------

SELECT DISTINCT first_name, last_name 
FROM club_db.members

-- COMMAND ----------

-- MAGIC %md
-- MAGIC &copy; 2021-2025 <a href="https://www.scholarnest.com/">ScholarNest</a>. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC Databricks, Databricks Cloud and the Databricks logo are trademarks of the <a href="https://www.databricks.com/">Databricks Inc</a>.<br/>
-- MAGIC <br/>
-- MAGIC <a href="https://www.scholarnest.in/pages/privacy">Privacy Policy</a> | <a href="https://www.scholarnest.in/pages/terms">Terms of Use</a> | <a href="https://www.scholarnest.in/pages/contact">Contact Us</a>