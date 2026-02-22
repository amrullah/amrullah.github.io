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
-- MAGIC Q1. Who are the top 5 members by total booking amount for year 2022?
-- MAGIC
-- MAGIC Prepare a report as the following.
-- MAGIC ```
-- MAGIC member_name     | total_booking_amount
-- MAGIC ---------------------------------------
-- MAGIC Tim Rownam      | 6480
-- MAGIC Tim Boothe      | 3644
-- MAGIC Gerald Butters  | 3343
-- MAGIC Burton Tracy    | 2953
-- MAGIC David Jones     | 2651
-- MAGIC ```

-- COMMAND ----------

SELECT concat_ws(" ", m.first_name, m.last_name) as member_name, 
       sum(b.slots * f.member_cost) AS total_booking_amount 
FROM club_db.members AS m NATURAL JOIN club_db.bookings AS b NATURAL JOIN club_db.facilities AS f
WHERE m.member_id != 0 AND year(b.start_time) = 2022
GROUP BY member_name
ORDER BY total_booking_amount DESC
LIMIT 5

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q2. Who are the top 5 members by total booking amount for year 2022?
-- MAGIC
-- MAGIC Prepare a report as the following.
-- MAGIC ```
-- MAGIC member_name     | total_booking_amount
-- MAGIC ---------------------------------------
-- MAGIC Tim Rownam      | 6480
-- MAGIC Tim Boothe      | 3644
-- MAGIC Gerald Butters  | 3343
-- MAGIC Burton Tracy    | 2953
-- MAGIC David Jones     | 2651
-- MAGIC ```

-- COMMAND ----------

SELECT member_name, 
       sum(booking_amount) AS total_booking_amount 
FROM club_db.club_bookings
WHERE member_id != 0 AND year(start_time) = 2022
GROUP BY member_name
ORDER BY total_booking_amount DESC
LIMIT 5

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q3. Create total booking summary for Tim Rownam for year 2022?
-- MAGIC
-- MAGIC Report should look similar to the following.
-- MAGIC ```
-- MAGIC member_name | facility_name   | total_booking_amount
-- MAGIC ------------------------------------------------------
-- MAGIC Tim Rownam  | Massage Room 1  | 6160
-- MAGIC Tim Rownam  | Massage Room 2  | 140
-- MAGIC Tim Rownam  | Tennis Court 1  | 90
-- MAGIC Tim Rownam  | Tennis Court 2  | 90
-- MAGIC ```

-- COMMAND ----------

SELECT member_name, facility_name,
       sum(booking_amount) AS total_booking_amount 
FROM club_db.club_bookings
WHERE member_name = "Tim Rownam" AND year(start_time) = 2022
GROUP BY member_name, facility_name
ORDER BY total_booking_amount DESC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q4. Who are the top 5 members by total booking amount for year 2022?
-- MAGIC
-- MAGIC Prepare a facility wise breakup report for top 5 booking members.

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
ORDER BY b.member_name, total_booking_amount DESC              

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q5. What is monthly revenue from guests for the year 2022?
-- MAGIC
-- MAGIC Prepare a report similar to the following.
-- MAGIC ```
-- MAGIC month_2022  | total_revenue
-- MAGIC ------------------------------
-- MAGIC July        | 15317.5
-- MAGIC August      | 30312.5
-- MAGIC September   | 43466.5
-- MAGIC ```

-- COMMAND ----------

SELECT date_format(start_time, "MMMM") AS month_2022, 
       sum(booking_amount) total_revenue
FROM club_db.club_bookings
WHERE member_id = 0 AND year(start_time) = 2022
GROUP BY month_2022 

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q6. Prepare an earnings report from members by area and facility for the year 2022.
-- MAGIC
-- MAGIC The report should similar to the following.
-- MAGIC ```
-- MAGIC area            | facility_name   | total_revenue
-- MAGIC -------------------------------------------------
-- MAGIC Boston          | Massage Room 1  | 18970
-- MAGIC Boston          | Massage Room 2  | 1190
-- MAGIC Boston          | Squash Court    | 973
-- MAGIC Boston          | Tennis Court 1  | 2790
-- MAGIC New York        | Massage Room 1  | 1260
-- MAGIC New York        | Massage Room 2  | 140
-- MAGIC North Reading   | Massage Room 1  | 2590
-- MAGIC North Reading   | Squash Court    | 56
-- MAGIC
-- MAGIC ```

-- COMMAND ----------

SELECT area, facility_name, sum(booking_amount) total_revenue
FROM club_db.club_bookings
WHERE member_id != 0 AND year(start_time) = 2022
GROUP BY area, facility_name
ORDER BY area, facility_name

-- COMMAND ----------

-- MAGIC %md
-- MAGIC &copy; 2021-2025 <a href="https://www.scholarnest.com/">ScholarNest</a>. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC Databricks, Databricks Cloud and the Databricks logo are trademarks of the <a href="https://www.databricks.com/">Databricks Inc</a>.<br/>
-- MAGIC <br/>
-- MAGIC <a href="https://www.scholarnest.in/pages/privacy">Privacy Policy</a> | <a href="https://www.scholarnest.in/pages/terms">Terms of Use</a> | <a href="https://www.scholarnest.in/pages/contact">Contact Us</a>