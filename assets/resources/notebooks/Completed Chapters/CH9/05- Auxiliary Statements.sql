-- Databricks notebook source
-- MAGIC %md
-- MAGIC <div style="text-align: center; line-height: 0; padding-top: 9px;">
-- MAGIC   <img src="https://learningjournal.github.io/pub-resources/logos/scholarnest_academy.jpg" alt="ScholarNest Academy" style="width: 1400px">
-- MAGIC </div>

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####Auxiliary Statements in SQL
-- MAGIC Auxiliary SQL statements are to provide additional capabilities to SQL beyond the reporting and query.
-- MAGIC
-- MAGIC Primary Auxiliary Statements.
-- MAGIC 1. Collect and check the statistics of a table and column
-- MAGIC 2. Cache and uncache tables
-- MAGIC 3. Change the default timezone
-- MAGIC 4. Show commands
-- MAGIC 5. Describe commands

-- COMMAND ----------

-- DBTITLE 1,Clean Previous Executions
-- MAGIC %run ./utils/clean-microproject

-- COMMAND ----------

-- DBTITLE 1,Setup Database and Tables
-- MAGIC %python
-- MAGIC DB.setup(spark)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q1. How to analyze and compute statistics for a table?
-- MAGIC Do the following.
-- MAGIC 1. Show statistics of the club_db.bookings table.
-- MAGIC 2. Show statistics of a club_db.bookings table column.
-- MAGIC 3. Analyze and compute statistics on the club_db.bookings table and all the columns.
-- MAGIC 4. Show statistics of the club_db.bookings table.
-- MAGIC 5. Show statistics of a club_db.bookings table column.

-- COMMAND ----------

DESCRIBE EXTENDED club_db.bookings

-- COMMAND ----------

DESCRIBE TABLE EXTENDED club_db.bookings booking_id

-- COMMAND ----------

ANALYZE TABLE club_db.bookings COMPUTE STATISTICS FOR ALL COLUMNS

-- COMMAND ----------

DESCRIBE EXTENDED club_db.bookings

-- COMMAND ----------

DESCRIBE TABLE EXTENDED club_db.bookings booking_id

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q2. How to cache a table into the RAM for faster queries on the table?\
-- MAGIC Cache the club_db.members table.
-- MAGIC
-- MAGIC Note: This command might not work due to limitations of serverless cluster

-- COMMAND ----------

CACHE TABLE club_db.members

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q3. How to remove table from the cache to release server memory (RAM)?\
-- MAGIC Remove club_db.members table from cache.
-- MAGIC
-- MAGIC Note: This command might not work due to limitations of serverless cluster

-- COMMAND ----------

UNCACHE TABLE club_db.members

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q4. How to clear all tables from the RAM?\
-- MAGIC Write command to remove all he tables from the cache if there are any?
-- MAGIC
-- MAGIC Note: This command might not work due to limitations of serverless cluster

-- COMMAND ----------

CLEAR CACHE

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q5. How to change the session time zone for your database?\
-- MAGIC Do the following.
-- MAGIC 1. Show timestamp data using the current session timezone.
-- MAGIC 2. Change timezone to America/Los_Angeles.
-- MAGIC 3. Show timstamp data using the current session timestamp.

-- COMMAND ----------

SELECT booking_id, start_time FROM club_db.bookings LIMIT 3

-- COMMAND ----------

SET TIME ZONE 'America/Los_Angeles'

-- COMMAND ----------

SELECT booking_id, start_time FROM club_db.bookings LIMIT 3

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q6. How can you list all the database?

-- COMMAND ----------

SHOW DATABASES

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q7. How can you list all the tables in a database?\
-- MAGIC Show the list of all tables in club_db.

-- COMMAND ----------

SHOW TABLES IN club_db

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q8. How can you list all the columns in a table?\
-- MAGIC Show list of all columns in club_db.members

-- COMMAND ----------

SHOW COLUMNS IN club_db.members

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q9. How can you see the CREATE TABLE statement used to create the table?\
-- MAGIC Show the create table statement for club_db.members table.

-- COMMAND ----------

SHOW CREATE TABLE club_db.members

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q10. How can you list all the views in a database?\
-- MAGIC Show the list of all views in club_db.

-- COMMAND ----------

SHOW VIEWS IN club_db

-- COMMAND ----------

-- MAGIC %md
-- MAGIC &copy; 2021-2025 <a href="https://www.scholarnest.in/">ScholarNest</a>. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC Databricks, Databricks Cloud and the Databricks logo are trademarks of the <a href="https://www.databricks.com/">Databricks Inc</a>.<br/>
-- MAGIC <br/>
-- MAGIC <a href="https://www.scholarnest.in/pages/privacy">Privacy Policy</a> | <a href="https://www.scholarnest.in/pages/terms">Terms of Use</a> | <a href="https://www.scholarnest.in/pages/contact">Contact Us</a>