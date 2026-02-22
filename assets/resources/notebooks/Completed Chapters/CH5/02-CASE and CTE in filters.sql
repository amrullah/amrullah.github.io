-- Databricks notebook source
-- MAGIC %md
-- MAGIC <div style="text-align: center; line-height: 0; padding-top: 9px;">
-- MAGIC   <img src="https://learningjournal.github.io/pub-resources/logos/scholarnest_academy.jpg" alt="ScholarNest Academy" style="width: 1400px">
-- MAGIC </div>

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####Conditional expression 
-- MAGIC
-- MAGIC Order of [WHEN boolean_expression THEN] is critical
-- MAGIC ```sql
-- MAGIC       CASE WHEN boolean_expression_1 THEN then_expression_1
-- MAGIC            [WHEN boolean_expression_2 THEN then_expression_2]
-- MAGIC            [WHEN boolean_expression_3 THEN then_expression_3]
-- MAGIC            .....
-- MAGIC            [ELSE else_expression]
-- MAGIC       END
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
-- MAGIC Q1. Prepare a list of all indore facilities as shown below.
-- MAGIC ```
-- MAGIC Facility Name  | Capital Investment  |  Annual Maintainance  | Facility Type
-- MAGIC -------------------------------------------------------------------------------
-- MAGIC ```
-- MAGIC 1. Capital investment is 25% of the initial outlay
-- MAGIC 2. A facility type can be determined using the following rule.
-- MAGIC     1. A Court is an Outdoor facility
-- MAGIC     2. A Squash is an Indore facility
-- MAGIC     3. A Room is a Private Room
-- MAGIC     4. All other facilities are Indore

-- COMMAND ----------

SELECT facility_name as `Facility Name`,
       initial_outlay * 0.25 as `Capital Investment`,
       monthly_maintainance * 12 as `Annual Maintainance`,
       CASE WHEN facility_name LIKE "%Squash%" THEN "Indore"
            WHEN facility_name LIKE "%Court%" THEN "Outdoor" 
         -- WHEN facility_name LIKE "%Squash%" THEN "Indore"           
            WHEN facility_name LIKE "%Room%" THEN "Private Room"
            ELSE "Indore" END as `Facility Type`
FROM club_db.facilities
WHERE CASE WHEN facility_name LIKE "%Squash%" THEN "Indore"
           WHEN facility_name LIKE "%Court%" THEN "Outdoor"
           WHEN facility_name LIKE "%Room%" THEN "Private Room"
           ELSE "Indore" END = "Indore"

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q2. Prepare a list of all indore facilities as shown below.
-- MAGIC ```
-- MAGIC Facility Name  | Capital Investment  |  Annual Maintainance  
-- MAGIC --------------------------------------------------------------
-- MAGIC ```
-- MAGIC 1. Capital investment is 25% of the initial outlay
-- MAGIC 2. A facility type can be determined using the following rule.
-- MAGIC     1. A Court is an Outdoor facility
-- MAGIC     2. A Squash is an Indore facility
-- MAGIC     3. A Room is a Private Room
-- MAGIC     4. All other facilities are Indore

-- COMMAND ----------

SELECT facility_name as `Facility Name`,
       initial_outlay * 0.25 as `Capital Investment`,
       monthly_maintainance * 12 as `Annual Maintainance`
FROM club_db.facilities
WHERE facility_name NOT LIKE "%Court%" AND facility_name NOT LIKE "%Room%" OR facility_name LIKE "%Squash%"

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q3. Prepare a list of all indore facilities as shown below.
-- MAGIC ```
-- MAGIC Facility Name  | Capital Investment  |  Annual Maintainance  | Total Cost 
-- MAGIC ---------------------------------------------------------------------------
-- MAGIC ```
-- MAGIC 1. Capital investment is 25% of the initial outlay
-- MAGIC 2. Total cost is Capital Investment + Annual Maintainance
-- MAGIC 3. A facility type can be determined using the following rule.
-- MAGIC     1. A Court is an Outdoor facility
-- MAGIC     2. A Squash is an Indore facility
-- MAGIC     3. A Room is a Private Room
-- MAGIC     4. All other facilities are Indore

-- COMMAND ----------

WITH temp_results as (
  SELECT facility_name as `Facility Name`,
       initial_outlay * 0.25 as `Capital Investment`,
       monthly_maintainance * 12 as `Annual Maintainance`,
       CASE WHEN facility_name LIKE "%Squash%" THEN "Indore"
            WHEN facility_name LIKE "%Court%" THEN "Outdoor"
            WHEN facility_name LIKE "%Room%" THEN "Private Room"
            ELSE "Indore" END as `Facility Type`
FROM club_db.facilities)
SELECT `Facility Name`,  `Capital Investment`, `Annual Maintainance`,
       `Capital Investment` + `Annual Maintainance` as `Total Cost`
FROM temp_results WHERE `Facility Type` = "Indore"

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q4: Prepare a recomended guest cost report for all the facilities.
-- MAGIC ```
-- MAGIC facility_name | guest_cost | reco_guest_cost
-- MAGIC -----------------------------------------------
-- MAGIC ```
-- MAGIC <em>"New guest cost"</em> can be calculated using the following formula.
-- MAGIC <br><br>
-- MAGIC ```
-- MAGIC round((monthly_maintainance + (initial_outlay * 0.25) / 12) * 0.07)
-- MAGIC ```
-- MAGIC <br>
-- MAGIC  Recomended guest cost is the higher value of the <em>"new guest cost"</em> and <em>"current guest cost"</em>.
-- MAGIC
-- MAGIC  We want to see only those facilities where recomendation is to increase the guest cost.

-- COMMAND ----------

WITH temp_result_1 as (
SELECT facility_name, guest_cost,
       round((monthly_maintainance + (initial_outlay * 0.25) / 12) * 0.07) as new_guest_cost       
FROM club_db.facilities
),
temp_result_2 as (
  SELECT facility_name, guest_cost, 
        CASE WHEN new_guest_cost > guest_cost THEN new_guest_cost 
             ELSE guest_cost 
        END as reco_guest_cost
FROM temp_result_1)
SELECT * FROM temp_result_2
WHERE reco_guest_cost > guest_cost

-- COMMAND ----------

-- MAGIC %md
-- MAGIC &copy; 2021-2025 <a href="https://www.scholarnest.com/">ScholarNest</a>. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC Databricks, Databricks Cloud and the Databricks logo are trademarks of the <a href="https://www.databricks.com/">Databricks Inc</a>.<br/>
-- MAGIC <br/>
-- MAGIC <a href="https://www.scholarnest.in/pages/privacy">Privacy Policy</a> | <a href="https://www.scholarnest.in/pages/terms">Terms of Use</a> | <a href="https://www.scholarnest.in/pages/contact">Contact Us</a>