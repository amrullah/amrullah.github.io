-- Databricks notebook source
-- MAGIC %md
-- MAGIC <div style="text-align: center; line-height: 0; padding-top: 9px;">
-- MAGIC   <img src="https://learningjournal.github.io/pub-resources/logos/scholarnest_academy.jpg" alt="ScholarNest Academy" style="width: 1400px">
-- MAGIC </div>

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####Multilevel Aggregates
-- MAGIC Multilevel aggregates provide final total over the group by columns.\
-- MAGIC We have three variations of multilevel aggregates.
-- MAGIC 1. Rollup
-- MAGIC 2. Grouping Sets
-- MAGIC 3. Cube

-- COMMAND ----------

-- DBTITLE 1,Clean Previous Executions
-- MAGIC %run ./utils/clean-microproject

-- COMMAND ----------

-- DBTITLE 1,Setup Database and Tables
-- MAGIC %python
-- MAGIC DB.setup(spark)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q1. Prepare a monthly revenue report for year 2022.

-- COMMAND ----------

SELECT month(start_time) mnth, 
       sum(booking_amount) revenue
FROM club_db.club_bookings
WHERE year(start_time) = 2022
GROUP BY mnth
ORDER BY mnth

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q2. Prepare a monthly revenue report for year 2022.
-- MAGIC
-- MAGIC Also roll up the total for a the month column.

-- COMMAND ----------

SELECT month(start_time) mnth, 
       sum(booking_amount) revenue
FROM club_db.club_bookings
WHERE year(start_time) = 2022
GROUP BY ROLLUP(mnth)
ORDER BY mnth NULLS LAST

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q3. Prepare a revenue report similar to the following.
-- MAGIC ```
-- MAGIC revenue_from  | facility_name   | revenue
-- MAGIC ---------------------------------------
-- MAGIC Guest         | Badminton Court | 1906.5
-- MAGIC Guest         | Massage Room 1  | 41600
-- MAGIC Guest         | Massage Room 2  | 13920
-- MAGIC Member        | Badminton Court | 0
-- MAGIC Member        | Massage Room 1  | 30940
-- MAGIC Member        | Massage Room 2  | 1890
-- MAGIC ```

-- COMMAND ----------

SELECT if(member_id=0, "Guest" , "Member") revenue_from,
       facility_name,
       sum(booking_amount) revenue
FROM club_db.club_bookings
WHERE year(start_time) = 2022
GROUP BY revenue_from, facility_name
ORDER BY revenue_from, facility_name nulls last

-- COMMAND ----------

-- MAGIC %md
-- MAGIC %md
-- MAGIC Q4. Prepare a revenue report similar to the following.
-- MAGIC ```
-- MAGIC revenue_from  | facility_name   | revenue
-- MAGIC ---------------------------------------
-- MAGIC Guest         | Badminton Court | 1906.5
-- MAGIC Guest         | Massage Room 1  | 41600
-- MAGIC Guest         | Massage Room 2  | 13920
-- MAGIC Guest         |                 | 57426.5
-- MAGIC Member        | Badminton Court | 0
-- MAGIC Member        | Massage Room 1  | 30940
-- MAGIC Member        | Massage Room 2  | 1890
-- MAGIC Member        |                 | 32830
-- MAGIC ```
-- MAGIC Also roll up the total for a the facility_name column.

-- COMMAND ----------

SELECT if(member_id=0, "Guest" , "Member") revenue_from,
       facility_name,
       sum(booking_amount) revenue
FROM club_db.club_bookings
WHERE year(start_time) = 2022
GROUP BY revenue_from, ROLLUP(facility_name)
ORDER BY revenue_from, facility_name nulls last

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q5. Prepare a revenue report similar to the following.
-- MAGIC ```
-- MAGIC revenue_from  | facility_name   | revenue
-- MAGIC ---------------------------------------
-- MAGIC Guest         | Badminton Court | 1906.5
-- MAGIC Guest         | Massage Room 1  | 41600
-- MAGIC Guest         | Massage Room 2  | 13920
-- MAGIC Guest         |                 | 57426.5
-- MAGIC Member        | Badminton Court | 0
-- MAGIC Member        | Massage Room 1  | 30940
-- MAGIC Member        | Massage Room 2  | 1890
-- MAGIC Member        |                 | 32830
-- MAGIC               |                 | 90256.5
-- MAGIC ```
-- MAGIC Also roll up the total for a the facility_name and revenue_from columns.

-- COMMAND ----------

SELECT if(member_id=0, "Guest" , "Member") revenue_from,
       facility_name,
       sum(booking_amount) revenue
FROM club_db.club_bookings
WHERE year(start_time) = 2022
GROUP BY ROLLUP(revenue_from, facility_name)
ORDER BY revenue_from nulls last, facility_name nulls last

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####Grouping Sets
-- MAGIC
-- MAGIC Q. What are grouping sets?\
-- MAGIC A. They define the levels of grouping aggregation.
-- MAGIC
-- MAGIC Q. How many grouping sets are possible for n columns?\
-- MAGIC A. We can have \\({2^n}\\) grouping sets.
-- MAGIC
-- MAGIC Q. List all grouping sets for revenue_from and facility_name columns.\
-- MAGIC A. Following grouping sets will be created
-- MAGIC 1. (1,1) -> (revenue_from, facility_name) -> Total for all revenue_from and facility_name combination (similar to plain group by) 
-- MAGIC 2. (1,0) -> (revenue_from, null)  -> Total for all revenue_from irrespective to facility_name
-- MAGIC 3. (0,1) -> (null, facility_name) -> Total for all facility_name irrespective of revenue_from <span style="color:red">(Not included in ROLLUP)</span>
-- MAGIC 4. (0,0) -> (null, null) -> Final total irrespective of revenue_from and facility_name
-- MAGIC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q6. Prepare a revenue report similar to the following.
-- MAGIC ```
-- MAGIC   revenue_from  | facility_name   | revenue
-- MAGIC   ---------------------------------------
-- MAGIC   Guest         | Badminton Court | 1906.5
-- MAGIC   Guest         | Massage Room 1  | 41600
-- MAGIC   Guest         | Massage Room 2  | 13920
-- MAGIC   Guest         |                 | 57426.5
-- MAGIC   Member        | Badminton Court | 0
-- MAGIC   Member        | Massage Room 1  | 30940
-- MAGIC   Member        | Massage Room 2  | 1890
-- MAGIC   Member        |                 | 32830
-- MAGIC                 |                 | 90256.5
-- MAGIC ```
-- MAGIC 1. Roll up the total for a the facility_name and revenue_from columns.
-- MAGIC 2. Use grouping sets for this query

-- COMMAND ----------

SELECT if(member_id=0, "Guest" , "Member") revenue_from,
       facility_name,
       sum(booking_amount) revenue
FROM club_db.club_bookings
WHERE year(start_time) = 2022
GROUP BY GROUPING SETS((revenue_from, facility_name),
                       (revenue_from, null),
                       (null, null))
ORDER BY revenue_from NULLS LAST, facility_name NULLS LAST

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q6. Prepare a revenue report similar to the following.
-- MAGIC ```
-- MAGIC   revenue_from  | facility_name   | revenue
-- MAGIC   ---------------------------------------
-- MAGIC   Guest         | Badminton Court | 1906.5
-- MAGIC   Guest         | Massage Room 1  | 41600
-- MAGIC   Guest         | Massage Room 2  | 13920
-- MAGIC   Guest         |                 | 57426.5
-- MAGIC ```
-- MAGIC Include totals for all grouping sets

-- COMMAND ----------

SELECT if(member_id=0, "Guest" , "Member") revenue_from,
       facility_name,
       sum(booking_amount) revenue
FROM club_db.club_bookings
WHERE year(start_time) = 2022
GROUP BY GROUPING SETS((revenue_from, facility_name),
                       (revenue_from, null),
                       (null, facility_name),
                       (null, null))
ORDER BY revenue_from NULLS LAST, facility_name NULLS LAST

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q7. Prepare a revenue report similar to the following.
-- MAGIC ```
-- MAGIC   revenue_from  | facility_name   | revenue
-- MAGIC   ---------------------------------------
-- MAGIC   Guest         | Badminton Court | 1906.5
-- MAGIC   Guest         | Massage Room 1  | 41600
-- MAGIC   Guest         | Massage Room 2  | 13920
-- MAGIC   Guest         |                 | 57426.5
-- MAGIC ```
-- MAGIC 1. Include totals for all grouping sets
-- MAGIC 2. Prefer using CUBE for this query

-- COMMAND ----------

SELECT if(member_id=0, "Guest" , "Member") revenue_from,
       facility_name,
       sum(booking_amount) revenue
FROM club_db.club_bookings
WHERE year(start_time) = 2022
GROUP BY CUBE(revenue_from, facility_name)
ORDER BY revenue_from NULLS LAST, facility_name NULLS LAST

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q8. Why do we need Grouping Sets when we already have Group By, Rollup, and Cube?

-- COMMAND ----------

SELECT if(member_id=0, "Guest" , "Member") revenue_from,
       facility_name,
       sum(booking_amount) revenue
FROM club_db.club_bookings
WHERE year(start_time) = 2022
GROUP BY GROUPING SETS(
                        (revenue_from, facility_name) -- 1. Use simple group by (mandatory grouping set with any syntax)
                       -- (revenue_from, null),        -- 2. Use GROUP BY revenue_from ROLLUP(facility_name)
                       -- (null, facility_name),       -- 3. Use Grouping sets
                       -- (null, null)                 -- 4. Use grouping sets
                                                       -- Need 1,2, and 4 -> Use GROUP BY ROLLUP(revenue_from, facility_name)
                                                       -- Need all -> Use GROUP NU CUBE(revenue_from, facility_name)
                       )
ORDER BY revenue_from NULLS LAST, facility_name NULLS LAST

-- COMMAND ----------

-- MAGIC %md
-- MAGIC &copy; 2021-2025 <a href="https://www.scholarnest.com/">ScholarNest</a>. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC Databricks, Databricks Cloud and the Databricks logo are trademarks of the <a href="https://www.databricks.com/">Databricks Inc</a>.<br/>
-- MAGIC <br/>
-- MAGIC <a href="https://www.scholarnest.in/pages/privacy">Privacy Policy</a> | <a href="https://www.scholarnest.in/pages/terms">Terms of Use</a> | <a href="https://www.scholarnest.in/pages/contact">Contact Us</a>