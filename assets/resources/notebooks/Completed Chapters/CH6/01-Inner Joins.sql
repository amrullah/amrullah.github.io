-- Databricks notebook source
-- MAGIC %md
-- MAGIC <div style="text-align: center; line-height: 0; padding-top: 9px;">
-- MAGIC   <img src="https://learningjournal.github.io/pub-resources/logos/scholarnest_academy.jpg" alt="ScholarNest Academy" style="width: 1400px">
-- MAGIC </div>

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####Inner Join
-- MAGIC <br>
-- MAGIC
-- MAGIC <img src ='https://learningjournal.github.io/pub-resources/images/inner_join.jpg' alt="Left Outer Join" style="width: 300px">
-- MAGIC
-- MAGIC ```
-- MAGIC SELECT expression 
-- MAGIC FROM source_1 AS alias_1
-- MAGIC     [INNER] JOIN source_2 AS alias_2
-- MAGIC     ON join_criteria
-- MAGIC ```
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
-- MAGIC Q1. Show me a facility bookings report as the following.
-- MAGIC ```
-- MAGIC member_id | first_name | last_name | facility_id | slots | start_time
-- MAGIC ---------------------------------------------------------------------------
-- MAGIC ```
-- MAGIC The report must meet the following criteria.
-- MAGIC 1. Facility bookings made by a person whose last name is Smith
-- MAGIC 2. He has booked more than 5 slots in a single booking
-- MAGIC 3. Report should be sorted by first name of the member in ascending order and number of slots in descending order

-- COMMAND ----------

SELECT m.member_id, m.first_name, m.last_name, b.facility_id, b.slots, b.start_time
FROM club_db.bookings b
    INNER JOIN club_db.members m
    ON b.member_id=m.member_id
WHERE m.last_name = "Smith"
      AND b.slots > 5
ORDER BY m.first_name, b.slots DESC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q2. Show me a facility bookings report as the following.
-- MAGIC ```
-- MAGIC member_id | first_name | last_name | facility_name | slots | booking_amount | start_time
-- MAGIC --------------------------------------------------------------------------------------------
-- MAGIC ```
-- MAGIC The report must meet the following criteria.
-- MAGIC 1. Facility bookings made by a person whose last name is Smith
-- MAGIC 2. He has booked more than 5 slots in a single booking
-- MAGIC 3. Report should be sorted by first name of the member in ascending order and booking amount in descending order

-- COMMAND ----------

SELECT m.member_id, m.first_name, m.last_name, f.facility_name, b.slots, 
        b.slots * f.member_cost as booking_amount,
        b.start_time
FROM club_db.bookings b
    JOIN club_db.members m ON b.member_id = m.member_id
    JOIN club_db.facilities f ON b.facility_id = f.facility_id
WHERE m.last_name = "Smith"
      AND b.slots > 5
ORDER BY m.first_name, booking_amount DESC


-- COMMAND ----------

-- MAGIC %md
-- MAGIC &copy; 2021-2025 <a href="https://www.scholarnest.com/">ScholarNest</a>. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC Databricks, Databricks Cloud and the Databricks logo are trademarks of the <a href="https://www.databricks.com/">Databricks Inc</a>.<br/>
-- MAGIC <br/>
-- MAGIC <a href="https://www.scholarnest.in/pages/privacy">Privacy Policy</a> | <a href="https://www.scholarnest.in/pages/terms">Terms of Use</a> | <a href="https://www.scholarnest.in/pages/contact">Contact Us</a>