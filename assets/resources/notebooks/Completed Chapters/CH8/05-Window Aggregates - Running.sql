-- Databricks notebook source
-- MAGIC %md
-- MAGIC <div style="text-align: center; line-height: 0; padding-top: 9px;">
-- MAGIC   <img src="https://learningjournal.github.io/pub-resources/logos/scholarnest_academy.jpg" alt="ScholarNest Academy" style="width: 1400px">
-- MAGIC </div>

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####Window Aggregation
-- MAGIC 1. Window aggregations do not require Group By and they cannot be combined with Group By.
-- MAGIC 2. Window aggregation often requires an aggregated summary table or CTE.
-- MAGIC
-- MAGIC Window aggregation allow us to do the following.
-- MAGIC 1. Partition the SQL result
-- MAGIC 2. Sort each partition 
-- MAGIC 3. Define a window of adjecent rows.
-- MAGIC 4. Apply aggregation within the partition for a window of sorted and adjecent rows 
-- MAGIC
-- MAGIC #####Structure of window aggregation
-- MAGIC ```
-- MAGIC   agg_function() OVER(PARTITION BY column_list 
-- MAGIC                       ORDER BY column_list 
-- MAGIC                       ROWS BETWEEN window_start AND window_end)
-- MAGIC ```
-- MAGIC Components of window aggregation
-- MAGIC 1. agg_function()
-- MAGIC     1. Aggregate function -> sum(), avg(), count(), min(), max() etc <span style="color:red">-></span> Running/Moving Aggregates
-- MAGIC     2. Window aggregate functions -> rank(), dense_rank(), row_number() <span style="color:red">-></span> Top N and Sequencing
-- MAGIC     3. Analytic functions -> lead(), lag() <span style="color:red">-></span> Forward/Backword Comparison
-- MAGIC 2. Window Frame (ROWS BETWEEN window_start AND window_end)
-- MAGIC     1. window_start - UNBOUNDED PRECEDING, n PRECEDING, CURRENT ROW
-- MAGIC     2. window_end - UNBOUNDED FOLLOWING, n FOLLOWING, CURRENT ROW
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
-- MAGIC Q1. Prepare a revenue report with the running total of the revenue similar to the following.
-- MAGIC ```
-- MAGIC booked_by | booking_date    | revenue | running_total
-- MAGIC -------------------------------------------------------
-- MAGIC Guest     | 2022-07-03      | 35      | 35
-- MAGIC Guest     | 2022-07-04      | 390     | 425
-- MAGIC Guest     | 2022-07-05      | 110     | 535
-- MAGIC Guest     | 2022-07-06      | 150     | 685
-- MAGIC Member    | 2022-07-03      | 70      | 755
-- MAGIC Member    | 2022-07-04      | 107     | 862
-- MAGIC Member    | 2022-07-05      | 77      | 939
-- MAGIC Member    | 2022-07-06      | 92      | 1031
-- MAGIC ```
-- MAGIC Prepare this report for July 2022

-- COMMAND ----------

WITH summary AS (SELECT if(member_id=0, "Guest", "Member") AS booked_by,
                        to_date(start_time, "dd-MM-yyyy") AS booking_date,
                        sum(booking_amount) revenue
                  FROM club_db.club_bookings
                  WHERE month(start_time) = 7 AND year(start_time) = 2022
                  GROUP BY booked_by, booking_date)
SELECT booked_by, booking_date, revenue,
       sum(revenue) OVER(ORDER BY booked_by, booking_date) AS running_total
FROM summary                  


-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q2. Prepare a revenue report with the running total of the revenue similar to the following.
-- MAGIC ```
-- MAGIC booked_by | booking_date    | revenue | running_total
-- MAGIC -------------------------------------------------------
-- MAGIC Guest     | 2022-07-03      | 35      | 35
-- MAGIC Guest     | 2022-07-04      | 390     | 425
-- MAGIC Guest     | 2022-07-05      | 110     | 535
-- MAGIC Guest     | 2022-07-06      | 150     | 685
-- MAGIC Member    | 2022-07-03      | 70      | 70
-- MAGIC Member    | 2022-07-04      | 107     | 177
-- MAGIC Member    | 2022-07-05      | 77      | 254
-- MAGIC Member    | 2022-07-06      | 92      | 346
-- MAGIC
-- MAGIC ```
-- MAGIC 1. Prepare this report for July 2022
-- MAGIC 2. Running total should restart for the change in the booked by.

-- COMMAND ----------

WITH summary AS (SELECT if(member_id=0, "Guest", "Member") AS booked_by,
                        to_date(start_time, "dd-MM-yyyy") AS booking_date,
                        sum(booking_amount) revenue
                  FROM club_db.club_bookings
                  WHERE month(start_time) = 7 AND year(start_time) = 2022
                  GROUP BY booked_by, booking_date)
SELECT booked_by, booking_date, revenue,
       sum(revenue) OVER(PARTITION BY booked_by 
                         ORDER BY booked_by, booking_date) AS running_total
FROM summary                  


-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q3. Prepare a revenue report with 3 day moving average similar to the following.
-- MAGIC ```
-- MAGIC booked_by   | booking_date    |revenue  | 3_day_avg
-- MAGIC -------------------------------------------------------
-- MAGIC Guest       | 2022-07-03      | 35      | 35
-- MAGIC Guest       | 2022-07-04      | 390     | 212.5
-- MAGIC Gues        | 2022-07-05      | 110     | 178.33
-- MAGIC Guest       | 2022-07-06      | 150     | 216.67
-- MAGIC Guest       | 2022-07-07      | 305     | 188.33
-- MAGIC Guest       | 2022-07-08      | 550     | 335
-- MAGIC Member      | 2022-07-03      | 70      | 70
-- MAGIC Member      | 2022-07-04      | 107     | 88.5
-- MAGIC Member      | 2022-07-05      | 77      | 84.67
-- MAGIC Member      | 2022-07-06      | 92      | 92
-- MAGIC Member      | 2022-07-07      | 199     | 122.67
-- MAGIC ```
-- MAGIC 1. Prepare this report for July 2022
-- MAGIC 2. The average should restart for the change in the booked by.

-- COMMAND ----------

WITH summary AS (SELECT if(member_id=0, "Guest", "Member") AS booked_by,
                        to_date(start_time, "dd-MM-yyyy") AS booking_date,
                        sum(booking_amount) revenue
                  FROM club_db.club_bookings
                  WHERE month(start_time) = 7 AND year(start_time) = 2022
                  GROUP BY booked_by, booking_date)
SELECT booked_by, booking_date, revenue,
       round(avg(revenue) OVER(PARTITION BY booked_by 
                         ORDER BY booked_by, booking_date 
                         ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS 3_day_avg
FROM summary 

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q4. Prepare a revenue report with 3 day forward moving average similar to the following.
-- MAGIC ```
-- MAGIC booked_by   | booking_date    | revenue   | 3_day_fwd_avg
-- MAGIC -----------------------------------------------------------
-- MAGIC Guest       | 2022-07-03      | 35        | 178.33
-- MAGIC Guest       | 2022-07-04      | 390       | 216.67
-- MAGIC Guest       | 2022-07-05      | 110       | 188.33
-- MAGIC Gues        | 2022-07-06      | 150       | 335
-- MAGIC Guest       | 2022-07-07      | 305       | 343.83
-- MAGIC Member      | 2022-07-03      | 70        | 84.67
-- MAGIC Member      | 2022-07-04      | 107       | 92
-- MAGIC Member      | 2022-07-05      | 77        | 122.67
-- MAGIC Member      | 2022-07-06      | 92        | 140.33
-- MAGIC Member      | 2022-07-07      | 199       | 176.33
-- MAGIC ```
-- MAGIC 1. Prepare this report for July 2022
-- MAGIC 2. The average should restart for the change in the booked by.

-- COMMAND ----------

WITH summary AS (SELECT if(member_id=0, "Guest", "Member") AS booked_by,
                        to_date(start_time, "dd-MM-yyyy") AS booking_date,
                        sum(booking_amount) revenue
                  FROM club_db.club_bookings
                  WHERE month(start_time) = 7 AND year(start_time) = 2022
                  GROUP BY booked_by, booking_date)
SELECT booked_by, booking_date, revenue,
       round(avg(revenue) OVER(PARTITION BY booked_by 
                         ORDER BY booked_by, booking_date 
                         ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING),2) AS 3_day_fwd_avg
FROM summary 

-- COMMAND ----------

-- MAGIC %md
-- MAGIC &copy; 2021-2025 <a href="https://www.scholarnest.com/">ScholarNest</a>. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC Databricks, Databricks Cloud and the Databricks logo are trademarks of the <a href="https://www.databricks.com/">Databricks Inc</a>.<br/>
-- MAGIC <br/>
-- MAGIC <a href="https://www.scholarnest.in/pages/privacy">Privacy Policy</a> | <a href="https://www.scholarnest.in/pages/terms">Terms of Use</a> | <a href="https://www.scholarnest.in/pages/contact">Contact Us</a>