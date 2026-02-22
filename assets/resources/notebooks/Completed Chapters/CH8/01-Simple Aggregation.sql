-- Databricks notebook source
-- MAGIC %md
-- MAGIC <div style="text-align: center; line-height: 0; padding-top: 9px;">
-- MAGIC   <img src="https://learningjournal.github.io/pub-resources/logos/scholarnest_academy.jpg" alt="ScholarNest Academy" style="width: 1400px">
-- MAGIC </div>

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####Introduction to Aggregation
-- MAGIC Aggregation in SQL is implemented using functions
-- MAGIC
-- MAGIC #####Types of Aggregation
-- MAGIC 1. Simple Aggregation
-- MAGIC 2. Grouped Aggregation
-- MAGIC 3. Multilevel Aggregation
-- MAGIC 4. Window Aggregation
-- MAGIC
-- MAGIC #####Comonly used aggregate functions
-- MAGIC 1. count(*), count(expr), count(DISTINCT expr)
-- MAGIC 2. min(expr), max(expr), avg(expr), sum(expr)
-- MAGIC

-- COMMAND ----------

-- DBTITLE 1,Clean Previous Executions
-- MAGIC %run ./utils/clean-microproject

-- COMMAND ----------

-- DBTITLE 1,Setup Database and Tables
-- MAGIC %python
-- MAGIC DB.setup(spark)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q1. How many members are there in our club?

-- COMMAND ----------

SELECT count(*) 
FROM club_db.members
WHERE member_id !=0

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q2. How many club members are recommended by someone?

-- COMMAND ----------

SELECT count(recommended_by)
FROM club_db.members

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q3. How many club members are recommending others?

-- COMMAND ----------

SELECT count(DISTINCT recommended_by)
FROM club_db.members

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q4. What is the minimum and maximum of guest and member charges?

-- COMMAND ----------

SELECT min(guest_cost) min_guest_charge, 
       max(guest_cost) max_guest_charge,
       min(member_cost) min_member_charge,
       max(member_cost) max_member_charge
FROM club_db.facilities

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q5. You are given a table for facility bookings. 
-- MAGIC
-- MAGIC Calculate total earnings and average booking value.

-- COMMAND ----------

WITH club_bookings AS (
  SELECT b.booking_id, 
         if(m.member_id = 0, "Guest Member", concat_ws(" ", m.first_name, m.last_name)) AS member_name,
         f.facility_name, b.start_time, 
         if(b.member_id = 0, b.slots * f.guest_cost, b.slots * f.member_cost) AS booking_amount
  FROM club_db.bookings AS b NATURAL JOIN club_db.facilities AS f
      NATURAL JOIN club_db.members AS m)
SELECT sum(booking_amount) AS total_earning,
       avg(booking_amount) AS avg_booking_value
FROM club_bookings      

-- COMMAND ----------

-- MAGIC %md
-- MAGIC &copy; 2021-2025 <a href="https://www.scholarnest.com/">ScholarNest</a>. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC Databricks, Databricks Cloud and the Databricks logo are trademarks of the <a href="https://www.databricks.com/">Databricks Inc</a>.<br/>
-- MAGIC <br/>
-- MAGIC <a href="https://www.scholarnest.in/pages/privacy">Privacy Policy</a> | <a href="https://www.scholarnest.in/pages/terms">Terms of Use</a> | <a href="https://www.scholarnest.in/pages/contact">Contact Us</a>