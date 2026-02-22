-- Databricks notebook source
-- MAGIC %md
-- MAGIC <div style="text-align: center; line-height: 0; padding-top: 9px;">
-- MAGIC   <img src="https://learningjournal.github.io/pub-resources/logos/scholarnest_academy.jpg" alt="ScholarNest Academy" style="width: 1400px">
-- MAGIC </div>

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####SQL Execution Flow
-- MAGIC
-- MAGIC Remember this
-- MAGIC
-- MAGIC <img src ='https://learningjournal.github.io/pub-resources/images/sql_execution_flow.jpg' alt="SQL Execution Flow" style="width: 150px">
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
-- MAGIC Q1. Create total booking summary for Tim Rownam for year 2022?
-- MAGIC
-- MAGIC Report should look as the following.
-- MAGIC ```
-- MAGIC member_name | facility_name   | total_booking_amount
-- MAGIC ------------------------------------------------------
-- MAGIC Tim Rownam  | Massage Room 1  | 6160
-- MAGIC Tim Rownam  | Massage Room 2  | 140
-- MAGIC Tim Rownam  | Tennis Court 1  | 90
-- MAGIC Tim Rownam  | Tennis Court 2  | 90
-- MAGIC ```
-- MAGIC We are not interested in zero earning facilities

-- COMMAND ----------

SELECT member_name, facility_name,
       sum(booking_amount) AS total_booking_amount 
FROM club_db.club_bookings
WHERE member_name = "Tim Rownam" 
      AND year(start_time) = 2022
GROUP BY member_name, facility_name
HAVING total_booking_amount > 0
ORDER BY total_booking_amount DESC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q2. Who are the top 5 members by total booking amount for year 2022?
-- MAGIC
-- MAGIC 1. Prepare a facility wise breakup report for top 5 booking members.
-- MAGIC 2. List only those facilities earning more than $300 total revenue. 

-- COMMAND ----------

WITH top5 AS (SELECT member_name, 
                    sum(booking_amount) AS total_booking_amount 
              FROM club_db.club_bookings
              WHERE member_id != 0 AND year(start_time) = 2022
              GROUP BY member_name
              ORDER BY total_booking_amount DESC
              LIMIT 5)
SELECT member_name, facility_name, 
       sum(booking_amount) AS total_booking_amount
FROM club_db.club_bookings b
WHERE EXISTS(SELECT true FROM top5 t WHERE t.member_name = b.member_name)       
GROUP BY member_name, facility_name
HAVING total_booking_amount > 300
ORDER BY b.member_name, total_booking_amount DESC              

-- COMMAND ----------

-- MAGIC %md
-- MAGIC &copy; 2021-2025 <a href="https://www.scholarnest.com/">ScholarNest</a>. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC Databricks, Databricks Cloud and the Databricks logo are trademarks of the <a href="https://www.databricks.com/">Databricks Inc</a>.<br/>
-- MAGIC <br/>
-- MAGIC <a href="https://www.scholarnest.in/pages/privacy">Privacy Policy</a> | <a href="https://www.scholarnest.in/pages/terms">Terms of Use</a> | <a href="https://www.scholarnest.in/pages/contact">Contact Us</a>