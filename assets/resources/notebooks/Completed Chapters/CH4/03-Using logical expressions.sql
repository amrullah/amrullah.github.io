-- Databricks notebook source
-- MAGIC %md
-- MAGIC <div style="text-align: center; line-height: 0; padding-top: 9px;">
-- MAGIC   <img src="https://learningjournal.github.io/pub-resources/logos/scholarnest_academy.jpg" alt="ScholarNest Academy" style="width: 1400px">
-- MAGIC </div>

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####Comparision operators
-- MAGIC 1. Equality=>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =, ==
-- MAGIC 2. Not Equal=>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   !=
-- MAGIC 3. Greater=>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  >
-- MAGIC 4. Less=>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   <
-- MAGIC 5. Greater or Eual=>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   >=
-- MAGIC 6. Less or Equal=>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   <=
-- MAGIC 7. Pattern=>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   like
-- MAGIC
-- MAGIC ####Logical operators
-- MAGIC 1. AND=>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   AND, &
-- MAGIC 2. OR=>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   OR, ^
-- MAGIC 3. NOT=>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   NOT, !
-- MAGIC
-- MAGIC
-- MAGIC
-- MAGIC ```sql
-- MAGIC       SELECT expression
-- MAGIC       FROM table_name
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
-- MAGIC Facility Name | Monthly Maintainance | High Maintainance
-- MAGIC ----------------------------------------------------------
-- MAGIC ```
-- MAGIC A facility is a High Maintainance if the annual maintainance cost is above 1000.

-- COMMAND ----------

SELECT facility_name as `Facility Name`, 
       monthly_maintainance as `Monthly Maintainance`,
       monthly_maintainance * 12 > 1000 as `High Maintainance`
FROM club_db.facilities

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q2: Show a list of facilities as the following.
-- MAGIC ```
-- MAGIC Facility Name | Intial Investment | Annual Maintainance | High Maintainance
-- MAGIC ----------------------------------------------------------------------------------
-- MAGIC ```
-- MAGIC A facility is a High Maintainance when it satisfies both the conditions 
-- MAGIC 1. Annual maintainance cost is more than 2000
-- MAGIC 2. Annual maintainance cost is more than depriciation (25% of initial investment)
-- MAGIC
-- MAGIC Hint: Consider using a CTE for computing High Maintainance

-- COMMAND ----------

WITH raw_cte AS (SELECT facility_name as `Facility Name`,
                initial_outlay as `Intial Investment`,
                monthly_maintainance * 12 as `Annual Maintainance`,
                initial_outlay * 0.25 as Depriciation
          FROM club_db.facilities)
SELECT `Facility Name`, `Intial Investment`, `Annual Maintainance`,
        `Annual Maintainance` > Depriciation  AND
        `Annual Maintainance` > 2000 as `High Maintainance`
FROM raw_cte          


-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q3: Show a list of facilities as the following.
-- MAGIC ```
-- MAGIC Facility Name | Intial Investment | Large Facility
-- MAGIC -------------------------------------------------------
-- MAGIC ```
-- MAGIC A facility is large if it is a Court or a Room

-- COMMAND ----------

SELECT facility_name as `Facility Name`,
       initial_outlay as `Intial Investment`,
       facility_name LIKE "%Court%" OR
       facility_name LIKE "%Room%" as `Large Facility`
FROM club_db.facilities

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q4: Show a list of facilities as the following.
-- MAGIC ```
-- MAGIC Facility Name | Intial Investment | 3X Facility
-- MAGIC ---------------------------------------------------
-- MAGIC ```
-- MAGIC A facility is a 3X facility when guest charges are more than 3 times of the member charges

-- COMMAND ----------

SELECT facility_name as `Facility Name`,
       initial_outlay as `Intial Investment`,
       guest_cost > 3 * member_cost as `3X Facility`
FROM club_db.facilities

-- COMMAND ----------

-- MAGIC %md
-- MAGIC &copy; 2021-2025 <a href="https://www.scholarnest.com/">ScholarNest</a>. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC Databricks, Databricks Cloud and the Databricks logo are trademarks of the <a href="https://www.databricks.com/">Databricks Inc</a>.<br/>
-- MAGIC <br/>
-- MAGIC <a href="https://www.scholarnest.in/pages/privacy">Privacy Policy</a> | <a href="https://www.scholarnest.in/pages/terms">Terms of Use</a> | <a href="https://www.scholarnest.in/pages/contact">Contact Us</a>