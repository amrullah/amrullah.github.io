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
-- MAGIC Q1. Show top 3 dates of maximum revenue from guests or members for July 2022.
-- MAGIC
-- MAGIC Expected Results
-- MAGIC ```
-- MAGIC   booked_by | booking_date  |revenue
-- MAGIC   ----------------------------------
-- MAGIC   Guest     | 2022-07-24    |1105
-- MAGIC   Guest     | 2022-07-27    |990
-- MAGIC   Guest     | 2022-07-30    |986.5
-- MAGIC ```

-- COMMAND ----------

SELECT if(member_id=0, "Guest", "Member") AS booked_by,
       to_date(start_time, "dd-MM-yyyy") AS booking_date,
       sum(booking_amount) revenue
FROM club_db.club_bookings
WHERE month(start_time) = 7 AND year(start_time) = 2022
GROUP BY booked_by, booking_date
ORDER BY revenue DESC
LIMIT 3

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q2. Show top 3 dates of maximum revenue from guests and members for July 2022.
-- MAGIC
-- MAGIC Expected Results
-- MAGIC ```
-- MAGIC   booked_by | booking_date  |revenue
-- MAGIC   ----------------------------------
-- MAGIC   Guest     | 2022-07-24    |1105
-- MAGIC   Guest     | 2022-07-27    |990
-- MAGIC   Guest     | 2022-07-30    |986.5
-- MAGIC   Member    | 2022-07-25    |626
-- MAGIC   Member    | 2022-07-31    |486
-- MAGIC   Member    | 2022-07-26    |455
-- MAGIC ```

-- COMMAND ----------

WITH total_revenue AS (SELECT if(member_id = 0, "Guest", "Member") AS booked_by,
                            to_date(start_time) AS booking_date,
                            sum(booking_amount) AS revenue
                      FROM club_db.club_bookings
                      WHERE year(start_time) = 2022 AND month(start_time) = 7
                      GROUP BY booked_by, booking_date),
ranked_revenue AS (SELECT booked_by, booking_date, revenue,
                          rank() OVER (PARTITION BY booked_by
                                      ORDER BY revenue DESC) AS rank
                    FROM  total_revenue)
SELECT booked_by, booking_date, revenue 
FROM ranked_revenue
WHERE rank <= 3                    

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q3. Show bottom 3 dates of maximum revenue from guests and members for July 2022.
-- MAGIC
-- MAGIC Expected Results
-- MAGIC ```
-- MAGIC   booked_by |booking_date |revenue
-- MAGIC   ----------------------------------
-- MAGIC   Guest     |2022-07-03   |35
-- MAGIC   Guest     |2022-07-05   |110
-- MAGIC   Guest     |2022-07-16   |110
-- MAGIC   Guest     |2022-07-14   |145
-- MAGIC   Guest     |2022-07-12   |145
-- MAGIC   Member    |2022-07-03   |70
-- MAGIC   Member    |2022-07-05   |77
-- MAGIC   Member    |2022-07-06   |92
-- MAGIC ```

-- COMMAND ----------

WITH summary AS (SELECT if(member_id=0, "Guest", "Member") AS booked_by,
                        to_date(start_time, "dd-MM-yyyy") AS booking_date,
                        sum(booking_amount) revenue
                  FROM club_db.club_bookings
                  WHERE month(start_time) = 7 AND year(start_time) = 2022
                  GROUP BY booked_by, booking_date),
ranked_summary AS (SELECT booked_by, booking_date, revenue,
                          dense_rank(revenue) OVER (PARTITION BY booked_by
                                              ORDER BY revenue ASC) as rank    
                    FROM summary)
SELECT * FROM ranked_summary WHERE rank < 4

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q4. How to assign a consecutive sequence to all records of July 2022 starting from 1 for each booked by?
-- MAGIC
-- MAGIC Expected Results
-- MAGIC ```
-- MAGIC   booked_by |booking_date |revenue  |seq_no
-- MAGIC   --------------------------------------------
-- MAGIC   Guest     |2022-07-03   |35       |1
-- MAGIC   Guest     |2022-07-05   |110      |2
-- MAGIC   Guest     |2022-07-16   |110      |3
-- MAGIC   Guest     |2022-07-12   |145      |4
-- MAGIC   Guest     |2022-07-14   |145      |5
-- MAGIC   ......
-- MAGIC   Guest     |2022-07-30   |986.5    |27
-- MAGIC   Guest     |2022-07-27   |990      |28
-- MAGIC   Guest     |2022-07-24   |1105     |29
-- MAGIC   Member    |2022-07-03   |70       |1
-- MAGIC   Member    |2022-07-05   |77       |2
-- MAGIC   Member    |2022-07-06   |92       |3
-- MAGIC   .......
-- MAGIC   Member    |2022-07-26   |455      |27
-- MAGIC   Member    |2022-07-31   |486      |28
-- MAGIC   Member    |2022-07-25   |626      |29
-- MAGIC ```

-- COMMAND ----------

WITH summary AS (SELECT if(member_id=0, "Guest", "Member") AS booked_by,
                        to_date(start_time, "dd-MM-yyyy") AS booking_date,
                        sum(booking_amount) revenue
                  FROM club_db.club_bookings
                  WHERE month(start_time) = 7 AND year(start_time) = 2022
                  GROUP BY booked_by, booking_date)
SELECT booked_by, booking_date, revenue,
      row_number() OVER (PARTITION BY booked_by
                          ORDER BY revenue, booking_date ASC                           
                        )  as seq_no    
FROM summary

-- COMMAND ----------

-- MAGIC %md
-- MAGIC &copy; 2021-2025 <a href="https://www.scholarnest.com/">ScholarNest</a>. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC Databricks, Databricks Cloud and the Databricks logo are trademarks of the <a href="https://www.databricks.com/">Databricks Inc</a>.<br/>
-- MAGIC <br/>
-- MAGIC <a href="https://www.scholarnest.in/pages/privacy">Privacy Policy</a> | <a href="https://www.scholarnest.in/pages/terms">Terms of Use</a> | <a href="https://www.scholarnest.in/pages/contact">Contact Us</a>