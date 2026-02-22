-- Databricks notebook source
-- MAGIC %md
-- MAGIC <div style="text-align: center; line-height: 0; padding-top: 9px;">
-- MAGIC   <img src="https://learningjournal.github.io/pub-resources/logos/scholarnest_academy.jpg" alt="ScholarNest Academy" style="width: 1400px">
-- MAGIC </div>

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####Commonly used Date Time functions
-- MAGIC 1. current_date(), current_timestamp()
-- MAGIC 2. to_date(date_str[, fmt]), to_timestamp(timestamp_str[, fmt]), date_format(timestamp, fmt)
-- MAGIC 3. day(date), month(date), year(date), quarter(date)
-- MAGIC 4. add_months(start_date, num_months), months_between(timestamp1, timestamp2)
-- MAGIC 5. date_add(start_date, num_days), date_sub(start_date, num_days), date_diff(endDate, startDate)
-- MAGIC 6. to_unix_timestamp(timeExp[, fmt]), from_unixtime(unix_time[, fmt])

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q1. How can you add a current date and current timestamp to your SQL query?

-- COMMAND ----------

SELECT current_date() as today_date,
       current_timestamp() as today_time

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q2. How can you convert a string to a date?
-- MAGIC
-- MAGIC You are given the users table as below.
-- MAGIC ```
-- MAGIC ----------------------------
-- MAGIC user_name   | created_date
-- MAGIC ----------------------------
-- MAGIC Prashant    | 12-07-2024
-- MAGIC Sushant     | 15-09-2024
-- MAGIC ```
-- MAGIC Calculate password_expiry for the users adding 90 days to the created date.

-- COMMAND ----------

WITH my_users(user_name, created_date) AS(
  SELECT * FROM VALUES("Prashant", "12-07-2024"),
                      ("Sushant", "15-09-2024")
)
SELECT user_name, created_date, 
       to_date(created_date, "dd-MM-yyyy") + 90 AS password_expiry
FROM my_users

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q3. How can you convert a string to a timestamp?
-- MAGIC
-- MAGIC You are given the following table.
-- MAGIC ```
-- MAGIC ------------------------------------------
-- MAGIC user_name | created_date  | created_time
-- MAGIC ------------------------------------------
-- MAGIC Prashant  | 12-07-2024    | 12:30 IST
-- MAGIC Sushant   | 15-09-2024    | 15:17 PST
-- MAGIC ```
-- MAGIC Combine date and time to make a created_timestamp.

-- COMMAND ----------

WITH my_users(user_name, created_date, created_time) AS(
  SELECT * FROM VALUES("Prashant", "12-07-2024", "12:30 IST"),
                      ("Sushant", "15-09-2024", "15:17 PST")
)
SELECT user_name, created_date, created_time,
       to_timestamp(concat(created_date,created_time), "dd-MM-yyyyHH:mm z")  AS created_timestamp
FROM my_users

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q4. How can you display a date in your desired format?
-- MAGIC
-- MAGIC Use the given table to display date in following formats.
-- MAGIC ```
-- MAGIC ------------------------------------------------------------
-- MAGIC user_name | date_1      | date_2        | date_3
-- MAGIC ------------------------------------------------------------
-- MAGIC Prashant  | 24-09-2024  | 24/Sep/2024   | 24 September 2024
-- MAGIC ```
-- MAGIC

-- COMMAND ----------

WITH my_users(user_name, created_date) AS(
  SELECT "Prashant", to_date("2024-09-24") 
)
SELECT user_name,
       date_format(created_date, "dd-MM-yyyy") AS date_1, 
       date_format(created_date, "dd/MMM/yyyy") AS date_2,
       date_format(created_date, "dd MMMM yyyy") AS date_3
FROM my_users

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q5. How can you display a timestamp in your desired format?
-- MAGIC
-- MAGIC Use the given table to display time in following formats.
-- MAGIC ```
-- MAGIC ------------------------------------------------------------------------------------------------------------------------------
-- MAGIC user_name | time_1            | time_2                | time3_3                       | time_4                      | time_5
-- MAGIC ------------------------------------------------------------------------------------------------------------------------------
-- MAGIC Prashant  | 24-09-2024 15:30  | 24/Sep/2024 03:30 PM  | 24 September 2024 03:30:24 PM | 24 September 2024 15:30 UTC | 03:30 PM
-- MAGIC ```

-- COMMAND ----------

WITH my_users(user_name, created_time) AS(
  SELECT "Prashant", to_timestamp("2024-09-24T15:30:24") 
)
SELECT user_name,
       date_format(created_time, "dd-MM-yyyy HH:mm") AS time_1, 
       date_format(created_time, "dd/MMM/yyyy hh:mm a") AS time_2,
       date_format(created_time, "dd MMMM yyyy hh:mm:ss a") AS time3_3,
       date_format(created_time, "dd MMMM yyyy HH:mm z") AS time_4,
       date_format(created_time, "hh:mm a") AS time_5
FROM my_users

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q6. How can you extract a day, month, year, and quarter number from a date?
-- MAGIC
-- MAGIC You are given a table to extract day, month, year, quarter, hour, minute, second from the created_time

-- COMMAND ----------

WITH my_users(user_name, created_time) AS(
  SELECT "Prashant", to_timestamp("2024-09-24T15:30:24") 
)
SELECT user_name, day(created_time) AS dd, 
                  month(created_time) AS mnth,
                  year(created_time) AS yr,
                  quarter(created_time) AS qtr,
                  hour(created_time) AS hr,
                  minute(created_time) AS mnt,
                  second(created_time) AS sec
FROM my_users

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q7. How can you add N months to a date?
-- MAGIC
-- MAGIC You are given the users table as below.
-- MAGIC ```
-- MAGIC ----------------------------
-- MAGIC user_name   | created_date
-- MAGIC ----------------------------
-- MAGIC Prashant    | 12-07-2024
-- MAGIC Sushant     | 15-09-2024
-- MAGIC ```
-- MAGIC Calculate password_expiry for the users adding 3 months to the created date.

-- COMMAND ----------

WITH my_users(user_name, created_date) AS(
  SELECT * FROM VALUES("Prashant", "12-07-2024"),
                      ("Sushant", "15-09-2024")
)
SELECT user_name, created_date, 
       add_months(to_date(created_date, "dd-MM-yyyy"), 3) AS password_expiry
FROM my_users

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q8. How can you subtract N months from a date?
-- MAGIC
-- MAGIC You are given the courses table as below.
-- MAGIC ```
-- MAGIC ----------------------------
-- MAGIC course      | launch_date
-- MAGIC ----------------------------
-- MAGIC Spark       | 12-07-2024
-- MAGIC SQL         | 15-09-2024
-- MAGIC ```
-- MAGIC Calculate preorder_date for the users subtracting 2 months to the launch date.

-- COMMAND ----------

WITH courses(course, launch_date) AS(
  SELECT * FROM VALUES("Spark", "12-07-2024"),
                      ("SQL", "15-09-2024")
)
SELECT course, launch_date, 
       add_months(to_date(launch_date, "dd-MM-yyyy"), -2) AS preorder_date
FROM courses

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q9. How can you find the difference between two dates in months?
-- MAGIC
-- MAGIC Calculate the age of the course in months from the given course table.

-- COMMAND ----------

WITH courses(course, launch_date) AS(
  SELECT * FROM VALUES("Spark", "12-07-2023"),
                      ("SQL", "15-09-2023")
)
SELECT course, months_between(current_date() , to_date(launch_date, "dd-MM-yyyy")) as course_age
FROM courses

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q10. How can you add N days to your date?
-- MAGIC
-- MAGIC Calculate password_expiry for the users adding 90 days to the created date.

-- COMMAND ----------

WITH my_users(user_name, created_date) AS(
  SELECT "Prashant", to_date("2024-09-24") 
)
SELECT user_name, created_date + 90
FROM my_users

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q11. How can you subtract N days from a date?
-- MAGIC
-- MAGIC You are given the courses table as below.
-- MAGIC ```
-- MAGIC ----------------------------
-- MAGIC course      | launch_date
-- MAGIC ----------------------------
-- MAGIC Spark       | 12-07-2024
-- MAGIC SQL         | 15-09-2024
-- MAGIC ```
-- MAGIC Calculate preorder_date for the users subtracting 30 days from the launch date.

-- COMMAND ----------

WITH courses(course, launch_date) AS(
  SELECT * FROM VALUES("Spark", "12-07-2024"),
                      ("SQL", "15-09-2024")
)
SELECT course, launch_date, 
       date_add(to_date(launch_date, "dd-MM-yyyy"), -30) AS preorder_date
FROM courses

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q12. How can you find the difference between two dates in days?
-- MAGIC
-- MAGIC Calculate the age of the course in days from the given course table.

-- COMMAND ----------

WITH courses(course, launch_date) AS(
  SELECT * FROM VALUES("Spark", "12-07-2023"),
                      ("SQL", "15-09-2023")
)
SELECT course, date_diff(current_date() , to_date(launch_date, "dd-MM-yyyy")) as course_age
FROM courses

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q13. How can you add/subtract N days/hours/minutes/seconds to a timestamp?

-- COMMAND ----------

WITH my_users(user_name, created_time) AS(
  SELECT "Prashant", to_timestamp("2024-09-24 10:30.15 UTC", "yyyy-MM-dd HH:mm.ss z") 
)
SELECT user_name, created_time,
       from_unixtime(to_unix_timestamp(created_time) - 3 * 24 * 60 * 60) AS d_minus_3d,
       from_unixtime(to_unix_timestamp(created_time) + 3 * 24 * 60 * 60) AS d_plus_3d,
       from_unixtime(to_unix_timestamp(created_time) - 10 * 60 * 60) AS d_plus_10h,
       from_unixtime(to_unix_timestamp(created_time) - 30 * 60) AS d_plus_30m,
       from_unixtime(to_unix_timestamp(created_time) - 10) AS d_plus_10s
FROM my_users

-- COMMAND ----------

-- MAGIC %md
-- MAGIC &copy; 2021-2025 <a href="https://www.scholarnest.com/">ScholarNest</a>. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC Databricks, Databricks Cloud and the Databricks logo are trademarks of the <a href="https://www.databricks.com/">Databricks Inc</a>.<br/>
-- MAGIC <br/>
-- MAGIC <a href="https://www.scholarnest.in/pages/privacy">Privacy Policy</a> | <a href="https://www.scholarnest.in/pages/terms">Terms of Use</a> | <a href="https://www.scholarnest.in/pages/contact">Contact Us</a>