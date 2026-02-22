-- Databricks notebook source
-- MAGIC %md
-- MAGIC <div style="text-align: center; line-height: 0; padding-top: 9px;">
-- MAGIC   <img src="https://learningjournal.github.io/pub-resources/logos/scholarnest_academy.jpg" alt="ScholarNest Academy" style="width: 1400px">
-- MAGIC </div>

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####Cleanup previous executions

-- COMMAND ----------

-- MAGIC %run ./utils/cleanup-microproject

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####1. Create Database

-- COMMAND ----------

CREATE DATABASE IF NOT EXISTS club_db

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####2. Create Facilities Table

-- COMMAND ----------

CREATE OR REPLACE TABLE club_db.facilities(
    facility_id INT,
    facility_name STRING,
    member_cost DOUBLE,
    guest_cost DOUBLE,
    initial_outlay DOUBLE,
    monthly_maintainance DOUBLE
)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####3. Create Members Table

-- COMMAND ----------

CREATE OR REPLACE TABLE club_db.members(
    member_id INT,
    first_name STRING,
    last_name STRING,
    address STRING,
    zip_code STRING,
    telephone STRING,
    recommended_by STRING,
    joining_date DATE
)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####4. Create Bookings Table

-- COMMAND ----------

CREATE OR REPLACE TABLE club_db.bookings(
    booking_id INT,
    facility_id INT,
    member_id INT,
    start_time TIMESTAMP,
    slots INT
)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####Load Data into tables

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####1. Load facilities table (9 records)

-- COMMAND ----------

insert into club_db.facilities
select _c0 facility_id, 
       _c1 facility_name, 
       _c2 member_cost, 
       _c3 guest_cost, 
       _c4 initial_outlay, 
       _c5 monthly_maintainance
from csv.`/Volumes/dev/scholarnest/sql_data/club/facilities.csv` offset 1

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####2. Load members table (31 records)

-- COMMAND ----------

insert into club_db.members
select _c0 member_id,
      _c2 first_name,
      _c1 last_name,
      _c3 address,
      _c4 zip_code,
      _c5 telephone,
      _c6 recommended_by,
      _c7 joining_date
from csv.`/Volumes/dev/scholarnest/sql_data/club/members.csv` offset 1

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####3. Load bookings table (4044 records)

-- COMMAND ----------

insert into club_db.bookings
select _c0 booking_id,
      _c1 facility_id,
      _c2 member_id,
      _c3 start_time,
      _c4 slots
from csv.`/Volumes/dev/scholarnest/sql_data/club/bookings.csv` offset 1

-- COMMAND ----------

-- MAGIC %md
-- MAGIC &copy; 2021-2024 <a href="https://www.scholarnest.in/">ScholarNest</a>. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC Databricks, Databricks Cloud and the Databricks logo are trademarks of the <a href="https://www.databricks.com/">Databricks Inc</a>.<br/>
-- MAGIC <br/>
-- MAGIC <a href="https://www.scholarnest.in/pages/privacy">Privacy Policy</a> | <a href="https://www.scholarnest.in/pages/terms">Terms of Use</a> | <a href="https://www.scholarnest.in/pages/contact">Contact Us</a>