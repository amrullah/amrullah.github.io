-- Databricks notebook source
-- MAGIC %md
-- MAGIC <div style="text-align: center; line-height: 0; padding-top: 9px;">
-- MAGIC   <img src="https://learningjournal.github.io/pub-resources/logos/scholarnest_academy.jpg" alt="ScholarNest Academy" style="width: 1400px">
-- MAGIC </div>

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####SQL Functions
-- MAGIC 1. SQL offers more than 100 functions to transforma columns.
-- MAGIC 2. A SQL function can be applied to a column or column expression.
-- MAGIC
-- MAGIC #####Types of functions
-- MAGIC 1. Mathematical functions - round(), pow() etc
-- MAGIC 2. String functions - trim(), substr()
-- MAGIC 3. Date and time functions - date_format(), to_unix_timestamp()
-- MAGIC 4. Conditional functions - nvl(), if()
-- MAGIC 5. Conversion functions - to_date(), cast()
-- MAGIC 6. Aggregate functions - min(), max(), avg()
-- MAGIC 7. Other functions - current_timestamp(), current_user()

-- COMMAND ----------

-- DBTITLE 1,Clean Previous Executions
-- MAGIC %run ./utils/clean-microproject

-- COMMAND ----------

-- DBTITLE 1,Setup Database and Tables
-- MAGIC %python
-- MAGIC DB.setup(spark)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q1. Create a facility report as shown below.
-- MAGIC ```
-- MAGIC facility_name | monthly_cost
-- MAGIC ---------------------------------
-- MAGIC ```
-- MAGIC The monthly cost is calculates as the following
-- MAGIC 1. 25% of the initial investment divided by 12 + monthly maintainance
-- MAGIC 2. Monthly cost is rounded to 2 dicimal places

-- COMMAND ----------

WITH f as (SELECT facility_id, facility_name, 
                  initial_outlay * 0.25 / 12 + monthly_maintainance as monthly_cost
            FROM club_db.facilities)
SELECT facility_id, facility_name, monthly_cost, 
       round(monthly_cost, 2) as r_cost, 
       ceil(monthly_cost, 2) c_cost, 
       floor(monthly_cost, 2) as f_cost
FROM f

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q2. Prepare a members report as the following.
-- MAGIC ```
-- MAGIC member_id | full_name | address | city
-- MAGIC ```
-- MAGIC The address is a comma saperated string. You can transform the address as the following.
-- MAGIC 1. The first part (string before first comma) of the address string is the address.
-- MAGIC 2. Extract city name from the address string.

-- COMMAND ----------

WITH m AS (SELECT member_id,  
                  concat_ws(" ", first_name, last_name) as full_name,                 
                  substring_index(address, ",", 1) as address,
                  substring_index(address, ",", -1) as city,
                  address as o_address,
                  position(",", address, 1) + 1 p1,
                  position(",", address, position(",", address, 1) + 1) p2      
            FROM club_db.members
            WHERE member_id != 0)
SELECT member_id, full_name, address,
       trim(CASE WHEN rlike(city,"[0-9]+" ) 
                  THEN substr(o_address, p1, p2-p1) 
                  ELSE city END) AS city
FROM m


-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q3. Prepare bookings report for all sundays of August 2022 as the following.
-- MAGIC ```
-- MAGIC booked_by | facility_name | slots | day | month | start_time | end_time
-- MAGIC ```
-- MAGIC Consider the following
-- MAGIC 1. The booked_by is the Guest or the full name of the member. 
-- MAGIC 2. The day is the date of the month
-- MAGIC 3. The month is the full name of the month
-- MAGIC 4. The start time and end time are the time such as 08:30 AM
-- MAGIC 5. Sort the report by date and time

-- COMMAND ----------

SELECT CASE WHEN m.member_id = 0 THEN initcap(m.first_name)
       ELSE concat_ws(" ", m.first_name, m.last_name) END AS booked_by,
       f.facility_name,
       b.slots,
       day(start_time) day,
       date_format(start_time, "MMMM") month,  
       date_format(start_time, "hh:mm a") start_time,
       date_format(to_timestamp(to_unix_timestamp(start_time) + slots * 60 * 60), "hh:mm a") end_time       
FROM club_db.bookings AS b 
       NATURAL JOIN club_db.members AS m 
       NATURAL JOIN club_db.facilities AS f
WHERE  year(start_time) = 2022 AND month(start_time)= 8 AND date_format(start_time, "EEE") = "Sun"
ORDER BY b.start_time

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q4. Prepare a members resport as th following
-- MAGIC ```
-- MAGIC member_id | member_name | member_since | recommended_by
-- MAGIC ```
-- MAGIC Consider the following
-- MAGIC 1. member_name and recommended_by are the full names
-- MAGIC 2. member_since is the joining month such as "Jan 2022"
-- MAGIC 2. Show "Self" when the member is not recommended by any one

-- COMMAND ----------

SELECT m.member_id, 
       if(m.member_id = 0 , initcap(m.first_name), concat_ws(" ", m.first_name, m.last_name)) as member_name,
       date_format(m.joining_date, "MMM yyyy") as member_since,
       nvl(r.first_name || " " || r.last_name, "Self") as recommended_by
FROM club_db.members AS m 
    LEFT JOIN club_db.members AS r ON m.recommended_by = r.member_id

-- COMMAND ----------

-- MAGIC %md
-- MAGIC &copy; 2021-2025 <a href="https://www.scholarnest.com/">ScholarNest</a>. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC Databricks, Databricks Cloud and the Databricks logo are trademarks of the <a href="https://www.databricks.com/">Databricks Inc</a>.<br/>
-- MAGIC <br/>
-- MAGIC <a href="https://www.scholarnest.in/pages/privacy">Privacy Policy</a> | <a href="https://www.scholarnest.in/pages/terms">Terms of Use</a> | <a href="https://www.scholarnest.in/pages/contact">Contact Us</a>