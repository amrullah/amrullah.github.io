-- Databricks notebook source
-- MAGIC %md
-- MAGIC <div style="text-align: center; line-height: 0; padding-top: 9px;">
-- MAGIC   <img src="https://learningjournal.github.io/pub-resources/logos/scholarnest_academy.jpg" alt="ScholarNest Academy" style="width: 1400px">
-- MAGIC </div>

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####Corelated Query Filter
-- MAGIC ```
-- MAGIC SELECT expression 
-- MAGIC FROM source as a
-- MAGIC WHERE [NOT] EXISTS (
-- MAGIC     SELECT true FROM source as b
-- MAGIC     WHERE corelated_expression_on_a_b)
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
-- MAGIC Q1. Show me a list of facilities getting a single booking worth more than $50 from members.

-- COMMAND ----------

SELECT f.* 
FROM club_db.facilities AS f
WHERE EXISTS (
    SELECT true FROM club_db.bookings AS b
    WHERE b.member_id !=0
    AND b.facility_id = f.facility_id
    AND f.member_cost * b.slots > 50
)


-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q2. Show me a list of facilities getting a single booking worth more than $50 from members or guests.

-- COMMAND ----------

SELECT f.* FROM club_db.facilities AS f
WHERE EXISTS (
  SELECT true FROM club_db.bookings AS b
  WHERE b.facility_id = f.facility_id
  AND CASE WHEN b.member_id = 0 THEN f.guest_cost ELSE f.member_cost END * b.slots > 50
)


-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q3. Show me a list of all bookings where a single booking amount is more than $200 from guests.

-- COMMAND ----------

SELECT * FROM club_db.bookings AS b
WHERE b.member_id = 0 
AND EXISTS (
        SELECT true FROM club_db.facilities AS f
        WHERE b.facility_id = f.facility_id
              AND b.slots * f.guest_cost > 200
)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC &copy; 2021-2025 <a href="https://www.scholarnest.com/">ScholarNest</a>. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC Databricks, Databricks Cloud and the Databricks logo are trademarks of the <a href="https://www.databricks.com/">Databricks Inc</a>.<br/>
-- MAGIC <br/>
-- MAGIC <a href="https://www.scholarnest.in/pages/privacy">Privacy Policy</a> | <a href="https://www.scholarnest.in/pages/terms">Terms of Use</a> | <a href="https://www.scholarnest.in/pages/contact">Contact Us</a>