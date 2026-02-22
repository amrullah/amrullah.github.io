-- Databricks notebook source
-- MAGIC %md
-- MAGIC <div style="text-align: center; line-height: 0; padding-top: 9px;">
-- MAGIC   <img src="https://learningjournal.github.io/pub-resources/logos/scholarnest_academy.jpg" alt="ScholarNest Academy" style="width: 1400px">
-- MAGIC </div>

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####Conditional expression 
-- MAGIC
-- MAGIC ```sql
-- MAGIC       CASE WHEN boolean_expression THEN then_expression
-- MAGIC            [WHEN boolean_expression THEN then_expression]
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
-- MAGIC Q1: Show a list of facilities as the following.
-- MAGIC
-- MAGIC ```
-- MAGIC Facility Name | Monthly Maintainance | Maintainance Type
-- MAGIC ----------------------------------------------------------
-- MAGIC ```
-- MAGIC A facility Maintainance type High if the annual maintainance cost is above 1000

-- COMMAND ----------

-- DBTITLE 1,Recommended Syntax
SELECT facility_name as `Facility Name`, 
       monthly_maintainance as `Monthly Maintainance`,
       CASE WHEN monthly_maintainance * 12 > 1000 THEN "High" END as `Maintainance Type`
FROM club_db.facilities

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q2: Show a list of facilities as the following.
-- MAGIC
-- MAGIC ```
-- MAGIC Facility Name | Monthly Maintainance | Maintainance Type
-- MAGIC ----------------------------------------------------------
-- MAGIC ```
-- MAGIC A facility Maintainance type is High if the annual maintainance cost is above 1000 else it is Low

-- COMMAND ----------

SELECT facility_name as `Facility Name`, 
       monthly_maintainance as `Monthly Maintainance`,
       CASE WHEN monthly_maintainance * 12 > 1000 THEN "High" ELSE "Low" END as `Maintainance Type`
FROM club_db.facilities

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q2: Show a list of facilities as the following.
-- MAGIC ```
-- MAGIC Facility Name | Intial Investment | Annual Maintainance | Maintanance Type
-- MAGIC ----------------------------------------------------------------------------------
-- MAGIC ```
-- MAGIC Maintainance type is High when it satisfies both the conditions else it is Low 
-- MAGIC 1. Annual maintainance cost is more than depriciation (25% of initial investment)
-- MAGIC 2. Annual maintainance cost is more than 2000
-- MAGIC
-- MAGIC Prefer using a CTE for this query

-- COMMAND ----------

WITH raw_cte AS (SELECT facility_name as `Facility Name`,
                initial_outlay as `Intial Investment`,
                monthly_maintainance * 12 as `Annual Maintainance`,
                initial_outlay * 0.25 as Depriciation
          FROM club_db.facilities)
SELECT `Facility Name`, `Intial Investment`, `Annual Maintainance`,
        CASE WHEN `Annual Maintainance` > Depriciation  AND
        `Annual Maintainance` > 2000 THEN "High" ELSE "Low" END as `Maintainance Type`
FROM raw_cte          


-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q3: Show a list of facilities as the following.
-- MAGIC ```
-- MAGIC Facility Name | Intial Investment | Facility Type
-- MAGIC -------------------------------------------------------
-- MAGIC ```
-- MAGIC 1. A facility type is "Outdoor Court" if it is a Court but not Squash.
-- MAGIC 2. The type is "Indore Court" if it is Squash.
-- MAGIC 3. The type is "Private Room" if it is a Room.
-- MAGIC 3. Else it is an "Indore"

-- COMMAND ----------

SELECT facility_name as `Facility Name`,
       initial_outlay as `Intial Investment`,
       CASE WHEN facility_name LIKE "%Court%" AND facility_name NOT LIKE "%Squash%" THEN "Outdoor Court"
            WHEN facility_name LIKE "%Squash%" THEN "Indore Court"
            WHEN facility_name LIKE "%Room%" THEN "Private Room"
            ELSE "Indore" END as `Facility Type`
FROM club_db.facilities

-- COMMAND ----------

-- MAGIC %md
-- MAGIC &copy; 2021-2025 <a href="https://www.scholarnest.com/">ScholarNest</a>. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC Databricks, Databricks Cloud and the Databricks logo are trademarks of the <a href="https://www.databricks.com/">Databricks Inc</a>.<br/>
-- MAGIC <br/>
-- MAGIC <a href="https://www.scholarnest.in/pages/privacy">Privacy Policy</a> | <a href="https://www.scholarnest.in/pages/terms">Terms of Use</a> | <a href="https://www.scholarnest.in/pages/contact">Contact Us</a>