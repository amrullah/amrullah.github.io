-- Databricks notebook source
-- MAGIC %md
-- MAGIC <div style="text-align: center; line-height: 0; padding-top: 9px;">
-- MAGIC   <img src="https://learningjournal.github.io/pub-resources/logos/scholarnest_academy.jpg" alt="ScholarNest Academy" style="width: 1400px">
-- MAGIC </div>

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####Outer Join
-- MAGIC 1. Left Outer Join
-- MAGIC 2. Right Outer Join 
-- MAGIC 3. Full Outer Join 
-- MAGIC
-- MAGIC #####Left Outer Join
-- MAGIC Take all records form left (first) table and matching records from right(second) table
-- MAGIC
-- MAGIC <img src ='https://learningjournal.github.io/pub-resources/images/left_outer.jpg' alt="Left Outer Join" style="width: 300px">
-- MAGIC
-- MAGIC ```
-- MAGIC SELECT expression 
-- MAGIC FROM source_1 AS alias_1
-- MAGIC     LEFT [OUTER] JOIN source_2 AS alias_2
-- MAGIC     ON join_criteria
-- MAGIC ```
-- MAGIC <br>
-- MAGIC
-- MAGIC #####Right Outer Join
-- MAGIC Take all records from right (second) table and matching records from left(first) table
-- MAGIC
-- MAGIC <img src ='https://learningjournal.github.io/pub-resources/images/right_outer.jpg' alt="Right Outer Join" style="width: 300px">
-- MAGIC
-- MAGIC ```
-- MAGIC SELECT expression 
-- MAGIC FROM source_1 AS alias_1
-- MAGIC     RIGHT [OUTER] JOIN source_2 AS alias_2
-- MAGIC     ON join_criteria
-- MAGIC ```
-- MAGIC <br>
-- MAGIC
-- MAGIC #####Full Outer Join
-- MAGIC Take all records from both (left/first and right/second) table
-- MAGIC
-- MAGIC <img src ='https://learningjournal.github.io/pub-resources/images/full_outer.jpg' alt="Full Outer Join" style="width: 300px">
-- MAGIC
-- MAGIC ```
-- MAGIC SELECT expression 
-- MAGIC FROM source_1 AS alias_1
-- MAGIC     FULL [OUTER] JOIN source_2 AS alias_2
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
-- MAGIC Q1. List all bookings made by a person named Darren Smith as the following.
-- MAGIC ```
-- MAGIC member_id | first_name | last_name | address | facility_id | slots
-- MAGIC ---------------------------------------------------------------------
-- MAGIC ```
-- MAGIC
-- MAGIC Ensure the following
-- MAGIC 1. Show the details of all persons named Darren Smith even if they have not made any bookings
-- MAGIC 2. Sort the result by number of slots (highers first)
-- MAGIC 3. List the person with no bookings at the top

-- COMMAND ----------

SELECT m.member_id, m.first_name, m.last_name, m.address, b.facility_id, b.slots
FROM club_db.members as  m
    LEFT JOIN club_db.bookings b ON m.member_id = b.member_id
WHERE m.first_name = "Darren" AND m.last_name = "Smith"
ORDER BY b.slots DESC NULLS FIRST

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q2. Show me a bookings report for Darren Smith as the following.
-- MAGIC
-- MAGIC ```
-- MAGIC facility_name | slots | booking_amount | start_time | member_id | member_name | telephone | address
-- MAGIC ------------------------------------------------------------------------------------------------------
-- MAGIC ```
-- MAGIC The report must meet the following criteria.
-- MAGIC
-- MAGIC 1. Show the details of all persons named Darren Smith even if they have not made any bookings
-- MAGIC 2. Sort the result by number of slots (highers first)
-- MAGIC 3. List the person with no bookings at the top

-- COMMAND ----------

SELECT f.facility_name, b.slots, 
        b.slots * f.member_cost as booking_amount,
        b.start_time, m.member_id, 
        m.first_name || " " || m.last_name as member_name, m.telephone, m.address 
FROM club_db.bookings b
    JOIN club_db.facilities f ON b.facility_id = f.facility_id
    RIGHT JOIN club_db.members m ON b.member_id = m.member_id
WHERE m.first_name = "Darren" AND m.last_name = "Smith"
ORDER BY b.slots DESC NULLS FIRST, member_name 

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q3. Prepare a facility booking report as the following
-- MAGIC ```
-- MAGIC facility_name | member_cost | gest_cost | start_time | slots
-- MAGIC ---------------------------------------------------------------
-- MAGIC ```
-- MAGIC Ensure the following
-- MAGIC 1. All club facilities must be listed in the report
-- MAGIC 2. Consider only bookings for more than 10 slots

-- COMMAND ----------

SELECT f.facility_name, f.member_cost, f.guest_cost,
       b.start_time, b.slots
FROM club_db.facilities as f
LEFT JOIN (SELECT * FROM club_db.bookings WHERE slots > 10) as b
ON f.facility_id = b.facility_id

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q4. Prepare a member bookings report as the following
-- MAGIC ```
-- MAGIC booking_id | facility_name | slots | first_name | last_name | address
-- MAGIC ```
-- MAGIC Ensure the following
-- MAGIC 1. Consider only regular memebrs (not guest) and direct members(not recomended by any other member)
-- MAGIC 2. Consider only bookings for more than 8 hours
-- MAGIC 3. Ensure all regular and direct members are listed even if they have no 8 hour bookings
-- MAGIC 4. Ensure all 8 hour bookings are listed even if they are not made by regular and direct members
-- MAGIC 5. Sort the report by slots and first name in ascending order

-- COMMAND ----------

WITH m as (SELECT * FROM club_db.members WHERE member_id !=0 AND recommended_by IS NULL),
     b as (SELECT * FROM club_db.bookings WHERE slots > 8)
SELECT b.booking_id, f.facility_name, b.slots, 
       m.first_name, last_name, address
FROM m FULL JOIN b ON m.member_id = b.member_id
       LEFT JOIN club_db.facilities f ON b.facility_id = f.facility_id
ORDER BY slots ASC NULLS LAST, first_name ASC NULLS LAST

-- COMMAND ----------

-- MAGIC %md
-- MAGIC &copy; 2021-2025 <a href="https://www.scholarnest.com/">ScholarNest</a>. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC Databricks, Databricks Cloud and the Databricks logo are trademarks of the <a href="https://www.databricks.com/">Databricks Inc</a>.<br/>
-- MAGIC <br/>
-- MAGIC <a href="https://www.scholarnest.in/pages/privacy">Privacy Policy</a> | <a href="https://www.scholarnest.in/pages/terms">Terms of Use</a> | <a href="https://www.scholarnest.in/pages/contact">Contact Us</a>