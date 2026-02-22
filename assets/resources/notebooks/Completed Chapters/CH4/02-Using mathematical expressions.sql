-- Databricks notebook source
-- MAGIC %md
-- MAGIC <div style="text-align: center; line-height: 0; padding-top: 9px;">
-- MAGIC   <img src="https://learningjournal.github.io/pub-resources/logos/scholarnest_academy.jpg" alt="ScholarNest Academy" style="width: 1400px">
-- MAGIC </div>

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####Mathematical operators
-- MAGIC 1. Addition=>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +
-- MAGIC 2. Subtraction=>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  -
-- MAGIC 3. Dicision=>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   /
-- MAGIC 4. Multiplication=>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   *
-- MAGIC 5. Remainder/Mod=>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   %
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
-- MAGIC Q1: What was the cost of first year for setting up our club facilities? \
-- MAGIC Create a report as the following.
-- MAGIC ```
-- MAGIC Facility Name | Initial Investment | Monthly Maintainance | Annual Maintanance | First Year Cost
-- MAGIC ---------------------------------------------------------------------------------------------------
-- MAGIC ```

-- COMMAND ----------

SELECT facility_name as `Facility Name`, 
       initial_outlay as `Initial Investment`, 
       monthly_maintainance as `Monthly Maintainance`,
       (monthly_maintainance * 12) as `Annual Maintainance`,
       (initial_outlay + monthly_maintainance * 12) as `First Year Cost`
FROM club_db.facilities

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q2: What is the annual cost of running a facility including 25% depriciation of intial investment?\
-- MAGIC Create a report as the following.
-- MAGIC ```
-- MAGIC Facility Name | Initial Investment | Depriciation | Monthly Maintainance | Annual Maintanance | Annual Cost
-- MAGIC ------------------------------------------------------------------------------------------------------------
-- MAGIC ```

-- COMMAND ----------

SELECT facility_name as `Facility Name`,
       initial_outlay as `Initial Investment`,
       initial_outlay * 0.25 as Depriciation, 
       monthly_maintainance as `Monthly Maintainance`,
       monthly_maintainance * 12 as `Annual Maintainance`,
       initial_outlay * 0.25 + monthly_maintainance * 12 as `Annual Cost`
FROM club_db.facilities

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q3: What is the annual cost of running a facility including 25% depriciation of intial investment?\
-- MAGIC Create a report as the following using a Common Table Expression (CTE)
-- MAGIC ```
-- MAGIC Facility Name | Initial Investment | Depriciation | Monthly Maintainance | Annual Maintanance | Annual Cost
-- MAGIC ------------------------------------------------------------------------------------------------------------
-- MAGIC ```

-- COMMAND ----------

WITH facility_set as (
    SELECT facility_name as `Facility Name`,
        initial_outlay as `Initial Investment`,
        initial_outlay * 0.25 as Depriciation, 
        monthly_maintainance as `Monthly Maintainance`,
        monthly_maintainance * 12 as `Annual Maintainance`
    FROM club_db.facilities)
SELECT *, Depriciation +  `Annual Maintainance` as  `Annual Cost`
FROM facility_set  


-- COMMAND ----------

-- MAGIC %md
-- MAGIC &copy; 2021-2025 <a href="https://www.scholarnest.com/">ScholarNest</a>. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC Databricks, Databricks Cloud and the Databricks logo are trademarks of the <a href="https://www.databricks.com/">Databricks Inc</a>.<br/>
-- MAGIC <br/>
-- MAGIC <a href="https://www.scholarnest.in/pages/privacy">Privacy Policy</a> | <a href="https://www.scholarnest.in/pages/terms">Terms of Use</a> | <a href="https://www.scholarnest.in/pages/contact">Contact Us</a>