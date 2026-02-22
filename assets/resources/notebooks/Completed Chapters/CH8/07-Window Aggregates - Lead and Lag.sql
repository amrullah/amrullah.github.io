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
-- MAGIC Q1. Find the members who did not book any facility for 3 consecutive days in September 2022. 
-- MAGIC
-- MAGIC Expected Results
-- MAGIC ```
-- MAGIC   member_id |member_name    |booking_date |next_booking |delay_days
-- MAGIC   --------------------------------------------------------------
-- MAGIC   5         |Gerald Butters |2022-09-22   |2022-09-26   |4
-- MAGIC   26        |Douglas Jones  |2022-09-23   |2022-09-27   |4
-- MAGIC ```

-- COMMAND ----------

WITH daily_bookings AS (SELECT distinct member_id, member_name, to_date(start_time) booking_date
                              FROM club_db.club_bookings
                              WHERE member_id !=0 AND year(start_time) = 2022 AND month(start_time) = 9
                              order by member_id, booking_date),
bookings_lookahead AS (SELECT member_id, member_name, booking_date,  
                            lead(booking_date) OVER (PARTITION BY member_id ORDER BY booking_date) next_booking
                      FROM daily_bookings)
SELECT member_id, member_name, booking_date, next_booking,
       date_diff(next_booking, booking_date) as delay_days
FROM bookings_lookahead
WHERE date_diff(next_booking, booking_date) > 3  


-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q2. You are provided the sales report. Transform it to the following format.
-- MAGIC ```
-- MAGIC product | 2022_sale | 2021_sale | 2020_sale
-- MAGIC -----------------------------------------------
-- MAGIC Laptop  | 78920     | 93847     | 23967
-- MAGIC Mobile  | 6730      | 9730      | 8730
-- MAGIC ```

-- COMMAND ----------

WITH annual_sales(year, product, sales) AS(
  SELECT * FROM 
  VALUES(2018, "Laptop", 24967),
        (2018, "Mobile", 7730),
        (2019, "Laptop", 63847),
        (2019, "Mobile", 4730),
        (2020, "Laptop", 23967),
        (2020, "Mobile", 8730),
        (2021, "Laptop", 93847),
        (2021, "Mobile", 9730),
        (2022, "Laptop", 78920),
        (2022, "Mobile", 6730)
),
sales_trend AS (SELECT year, product, sales AS 2022_sale,
                      lag(sales) OVER(PARTITION BY product ORDER BY year) 2021_sale,
                      lag(sales, 2) OVER(PARTITION BY product ORDER BY year) 2020_sale  
                FROM annual_sales)
SELECT * EXCEPT(year) 
FROM sales_trend
WHERE year = 2022                      

-- COMMAND ----------

-- MAGIC %md
-- MAGIC &copy; 2021-2025 <a href="https://www.scholarnest.com/">ScholarNest</a>. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC Databricks, Databricks Cloud and the Databricks logo are trademarks of the <a href="https://www.databricks.com/">Databricks Inc</a>.<br/>
-- MAGIC <br/>
-- MAGIC <a href="https://www.scholarnest.in/pages/privacy">Privacy Policy</a> | <a href="https://www.scholarnest.in/pages/terms">Terms of Use</a> | <a href="https://www.scholarnest.in/pages/contact">Contact Us</a>