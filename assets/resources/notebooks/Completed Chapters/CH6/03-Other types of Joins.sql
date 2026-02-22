-- Databricks notebook source
-- MAGIC %md
-- MAGIC <div style="text-align: center; line-height: 0; padding-top: 9px;">
-- MAGIC   <img src="https://learningjournal.github.io/pub-resources/logos/scholarnest_academy.jpg" alt="ScholarNest Academy" style="width: 1400px">
-- MAGIC </div>

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####Other Types of joins
-- MAGIC 1. Natural Join - Automatically create join criteria on the same column names (Applies to Inner and Outer Joins)
-- MAGIC 2. Cross Join - Join without any join criteria (all possible combinations)
-- MAGIC 3. Self Join - Join a table with itself (Applies to Inner, Outer, and Cross Joins)
-- MAGIC 4. Semi Join - Take records from the left side when it matches with the right side (Correlated EXISTS)
-- MAGIC 5. Anti Join - Take records from the left side when it doesn not match with the right side (Correlated NOT EXISTS)
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
-- MAGIC Q1. Show me a facility bookings report as the following. (Prefer Natural Join)
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
    NATURAL JOIN club_db.members m 
    NATURAL JOIN club_db.facilities f
WHERE m.last_name = "Smith"
      AND b.slots > 5
ORDER BY m.first_name, booking_amount DESC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q2. Prepare a member bookings report as the following (Prefer Natural Join)
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
FROM m NATURAL FULL JOIN b 
       NATURAL LEFT JOIN club_db.facilities f 
ORDER BY slots ASC NULLS LAST, first_name ASC NULLS LAST

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q3. How many bookings are possible when each member is booking a facility exactly once in a month?\
-- MAGIC Show all possible combinations

-- COMMAND ----------

SELECT first_name, last_name, facility_name
FROM club_db.members CROSS JOIN club_db.facilities
WHERE member_id > 0

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q4. Prepare a report for members and who recomended them as the following
-- MAGIC ```
-- MAGIC member_id | Member Name | Recomended By
-- MAGIC --------------------------------------------
-- MAGIC ```

-- COMMAND ----------

SELECT m.member_id, m.first_name || ' ' || m.last_name as `Member Name`, 
       r.first_name || ' ' || r.last_name as `Recommended By`
FROM club_db.members m
JOIN club_db.members r ON m.recommended_by = r.member_id

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q5. Prepare a list of members who made at least one booking. (Use EXISTS)
-- MAGIC ```
-- MAGIC member_id | first_name | last_name | address
-- MAGIC -----------------------------------------------
-- MAGIC ```

-- COMMAND ----------

SELECT m.member_id, m.first_name, m.last_name, m.address
FROM club_db.members m
WHERE EXISTS (SELECT true FROM club_db.bookings b WHERE b.member_id = m.member_id)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q6. Prepare a list of members who made at least one booking. (Use SEMI Join)
-- MAGIC ```
-- MAGIC member_id | first_name | last_name | address
-- MAGIC -----------------------------------------------
-- MAGIC ```

-- COMMAND ----------

SELECT * 
FROM club_db.members m
SEMI JOIN club_db.bookings b ON m.member_id = b.member_id

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q7. Prepare a list of members who never made any bookings. (Use NOT EXISTS)
-- MAGIC ```
-- MAGIC member_id | first_name | last_name | address
-- MAGIC -----------------------------------------------
-- MAGIC ```

-- COMMAND ----------

SELECT m.member_id, m.first_name, m.last_name, m.address
FROM club_db.members m
WHERE NOT EXISTS (SELECT true FROM club_db.bookings b WHERE b.member_id = m.member_id)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q8. Prepare a list of members who never made any bookings. (Use ANTI Join)
-- MAGIC ```
-- MAGIC member_id | first_name | last_name | address
-- MAGIC -----------------------------------------------
-- MAGIC ```

-- COMMAND ----------

SELECT * 
FROM club_db.members m
ANTI JOIN club_db.bookings b ON m.member_id = b.member_id

-- COMMAND ----------

-- MAGIC %md
-- MAGIC &copy; 2021-2025 <a href="https://www.scholarnest.com/">ScholarNest</a>. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC Databricks, Databricks Cloud and the Databricks logo are trademarks of the <a href="https://www.databricks.com/">Databricks Inc</a>.<br/>
-- MAGIC <br/>
-- MAGIC <a href="https://www.scholarnest.in/pages/privacy">Privacy Policy</a> | <a href="https://www.scholarnest.in/pages/terms">Terms of Use</a> | <a href="https://www.scholarnest.in/pages/contact">Contact Us</a>