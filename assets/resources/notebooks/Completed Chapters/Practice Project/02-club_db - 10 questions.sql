-- Databricks notebook source
-- MAGIC %md
-- MAGIC <div style="text-align: center; line-height: 0; padding-top: 9px;">
-- MAGIC   <img src="https://learningjournal.github.io/pub-resources/logos/scholarnest_academy.jpg" alt="ScholarNest Academy" style="width: 1400px">
-- MAGIC </div>

-- COMMAND ----------

-- DBTITLE 1,Clean Previous Executions
-- MAGIC %run ./utils/clean-practice-project

-- COMMAND ----------

-- DBTITLE 1,Setup Database Tables
-- MAGIC %python
-- MAGIC DB.setupClubDB(spark)
-- MAGIC DB.loadClubDB(spark)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q1. List the number of members joined in each month of the year 2022.
-- MAGIC
-- MAGIC Expected Output:
-- MAGIC ```
-- MAGIC   month_number |members_joined
-- MAGIC   -------------------------------
-- MAGIC   9            |10 
-- MAGIC   8            |11
-- MAGIC   7            |10
-- MAGIC ```

-- COMMAND ----------

SELECT month(joining_date) AS month_number, 
       count(joining_date) AS members_joined 
FROM club_db.members
WHERE year(joining_date) = 2022
GROUP BY month_number

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q2. Retrieve the full names of all members who have booked either of the table tennis court on August 15, 2022.
-- MAGIC
-- MAGIC Expected Output:
-- MAGIC ```
-- MAGIC   Name	
-- MAGIC   -----------------
-- MAGIC   Nancy Dare
-- MAGIC   David Jones
-- MAGIC   Jack Smith
-- MAGIC   Tim Boothe
-- MAGIC   Gerald Butters
-- MAGIC   Anne Baker
-- MAGIC   Burton Tracy
-- MAGIC ```

-- COMMAND ----------

SELECT DISTINCT concat(m.first_name,' ', m.last_name) AS Name
FROM club_db.members m
INNER JOIN club_db.bookings b ON m.member_id = b.member_id
INNER JOIN club_db.facilities f ON f.facility_id = b.facility_id
WHERE f.facility_name LIKE 'Tennis Court%' 
AND date(b.start_time) = '2022-08-15'
AND b.member_id!=0

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q3. The club wants to find out which facility has the highest total revenue generated from bookings in the year 2022?
-- MAGIC
-- MAGIC Expected Output:
-- MAGIC ```
-- MAGIC   facility_name   | total_revenue
-- MAGIC   --------------------------------
-- MAGIC   Massage Room 1  | 72540
-- MAGIC ```

-- COMMAND ----------

SELECT f.facility_name, 
       sum(if(b.member_id=0, f.guest_cost * b.slots, f.member_cost * b.slots)) AS total_revenue
FROM club_db.facilities f
INNER JOIN club_db.bookings b ON f.facility_id = b.facility_id
WHERE year(b.start_time) = 2022
GROUP BY f.facility_name
ORDER BY total_revenue DESC LIMIT 1

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q4. List the count of unique members who have made the bookings.
-- MAGIC
-- MAGIC Expected Output:
-- MAGIC ```
-- MAGIC   count
-- MAGIC   --------
-- MAGIC   30 
-- MAGIC ```

-- COMMAND ----------

SELECT count(DISTINCT member_id) AS count
FROM club_db.bookings

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q5. Identify member's first name who have made bookings on 15th August 2022.
-- MAGIC
-- MAGIC Expected Output:
-- MAGIC ```
-- MAGIC first_name  
-- MAGIC -------------
-- MAGIC   Gerald
-- MAGIC   Jack
-- MAGIC   Tracy
-- MAGIC   Darren
-- MAGIC   Charles
-- MAGIC   Anne
-- MAGIC   Tim
-- MAGIC   Ponder
-- MAGIC   Nancy
-- MAGIC   David
-- MAGIC   Burton
-- MAGIC   Jemima
-- MAGIC ```

-- COMMAND ----------

SELECT DISTINCT m.first_name
FROM club_db.members m
INNER JOIN club_db.bookings b ON m.member_id = b.member_id
WHERE date(b.start_time) = '2022-08-15'
AND b.member_id !=0

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q6. List the timestamps of all the bookings made by 'John Hunt.'
-- MAGIC
-- MAGIC Expected Output:
-- MAGIC ```
-- MAGIC start_time 
-- MAGIC ------------------------------
-- MAGIC   2022-09-23T14:00:00.000+00:00
-- MAGIC   2022-09-23T16:30:00.000+00:00
-- MAGIC   2022-09-24T12:30:00.000+00:00
-- MAGIC   ....
-- MAGIC
-- MAGIC   2022-09-30T18:30:00.000+00:00
-- MAGIC   2022-09-30T16:30:00.000+00:00
-- MAGIC -------------------------------
-- MAGIC 15 rows
-- MAGIC
-- MAGIC ```

-- COMMAND ----------

SELECT b.start_time
FROM club_db.members m
INNER JOIN club_db.bookings b ON m.member_id = b.member_id
WHERE m.first_name = 'John' AND m.last_name = 'Hunt'

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q7. The club wants to categorize the monthly maintenance by categorizing them as 'Low', 'Medium', or 'High' based on their maintenance cost such that:
-- MAGIC If the monthly maintenance is less than or equal to $99 then it is categorized as 'Low,' similarly, if the monthly maintenance is between $100 to $999 then it is categorized as 'Medium,' and if the monthly maintenance is greater than $1000 then it is categorized as 'High.' Sort the output table based on the categories from Low to High.
-- MAGIC
-- MAGIC Expected Output:
-- MAGIC ```
-- MAGIC   facility_name   |monthly_maintenance |maintenan_cecategory  
-- MAGIC   ------------------------------------------------------------
-- MAGIC   Table Tennis    |10                 |Low  
-- MAGIC   Snooker Table   |15                 |Low  
-- MAGIC   Pool Table      |15                 |Low  
-- MAGIC   Badminton Court |50                 |Low  
-- MAGIC   Squash Court    |80                 |Low  
-- MAGIC   Tennis Court 1  |200                |Medium 
-- MAGIC   Tennis Court 2  |200                |Medium 
-- MAGIC   Massage Room 2  |3000               |High 
-- MAGIC   Massage Room 1  |3000               |High 
-- MAGIC ```

-- COMMAND ----------

SELECT
    facility_name, monthly_maintainance,
    CASE
        WHEN monthly_maintainance <= 99 THEN 'Low'
        WHEN monthly_maintainance BETWEEN 100 AND 999 THEN 'Medium'
        ELSE 'High'
    END AS maintenance_category
FROM  club_db.facilities
ORDER BY monthly_maintainance

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q8. List the member name and who recomended him.\
-- MAGIC If a member is not recommended by anyone, replace the recommended by value with 'self-recommended'.
-- MAGIC
-- MAGIC
-- MAGIC Need Correction
-- MAGIC
-- MAGIC Expected Output:
-- MAGIC ```
-- MAGIC   member_name     | recommended_by
-- MAGIC   --------------------------------
-- MAGIC   Darren Smith    | self-recommended
-- MAGIC   Tracy Smith     | self-recommended
-- MAGIC   Janice Joplette | Darren Smith
-- MAGIC   Gerald Butters  | Darren Smith
-- MAGIC   ......
-- MAGIC   Erica Crumpet   | Tracy Smith
-- MAGIC   Darren Smith    | self-recommended
-- MAGIC   -----------------------------
-- MAGIC   30 rows in the result
-- MAGIC ```

-- COMMAND ----------

SELECT m.first_name || " " || m.last_name member_name,
       coalesce(trim(r.first_name || " " || r.last_name), 'self-recommended') AS recommended_by
FROM club_db.members m LEFT JOIN club_db.members r ON m.recommended_by = r.member_id
WHERE m.member_id !=0


-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q9. In the members table, display the first and last names of members along with their membership status. If the recommended by field is NULL, consider them as 'Non Recommended' members. If the joining date is before 2022-08-15, consider them as 'Old Members'; otherwise, consider them as 'New Member'.
-- MAGIC
-- MAGIC Expected Output:
-- MAGIC ```
-- MAGIC   Name            |membership_status 
-- MAGIC   -----------------------------------
-- MAGIC   Darren Smith    |Non Recommended
-- MAGIC   Tracy Smith     |Non Recommended
-- MAGIC   ............
-- MAGIC   Janice Joplette |Old Member
-- MAGIC   Gerald Butters  |Old Member
-- MAGIC   ............
-- MAGIC   Timothy Baker   |New Member
-- MAGIC   David Pinker    |New Member
-- MAGIC   -----------------------------------
-- MAGIC   30 rows in the result
-- MAGIC ```

-- COMMAND ----------

SELECT CONCAT(first_name, ' ', last_name) AS Name,
       CASE           
           WHEN recommended_by IS NULL THEN "Non Recommended"   
           WHEN joining_date < '2022-08-15' THEN "Old Member"        
           ELSE "New Member"
       END AS membership_status
FROM club_db.members
WHERE member_id != 0

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q10. Generate a report that lists all bookings made, including the facility name, 
-- MAGIC booking start time, and the member or guest name.
-- MAGIC
-- MAGIC Expected Output:
-- MAGIC ```
-- MAGIC   facility_name   |start_time                     |member_name  
-- MAGIC   --------------------------------------------------------------
-- MAGIC   Pool Table      |2022-07-04T12:00:00.000+00:00  |Tracy Smith
-- MAGIC   Squash Court    |2022-07-04T12:30:00.000+00:00  |Guest
-- MAGIC   Massage Room 1  |2022-07-04T13:30:00.000+00:00  |Tim Rownam
-- MAGIC   Snooker Table   |2022-07-04T14:00:00.000+00:00  |Tracy Smith
-- MAGIC   --------------------------------------------------------------
-- MAGIC   4044 rows in the result
-- MAGIC ```

-- COMMAND ----------

SELECT f.facility_name, b.start_time, 
       CONCAT(m.first_name, ' ', m.last_name) AS member_name
FROM club_db.facilities f
INNER JOIN club_db.bookings b ON f.facility_id = b.facility_id
INNER JOIN club_db.members m ON b.member_id = m.member_id
WHERE m.member_id !=0

UNION

SELECT f.facility_name, b.start_time, 
       'Guest' AS member_name
FROM club_db.facilities f
INNER JOIN club_db.bookings b ON f.facility_id = b.facility_id
WHERE b.member_id = 0

-- COMMAND ----------

-- MAGIC %md
-- MAGIC &copy; 2021-2025 <a href="https://www.scholarnest.com/">ScholarNest</a>. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC Databricks, Databricks Cloud and the Databricks logo are trademarks of the <a href="https://www.databricks.com/">Databricks Inc</a>.<br/>
-- MAGIC <br/>
-- MAGIC <a href="https://www.scholarnest.in/pages/privacy">Privacy Policy</a> | <a href="https://www.scholarnest.in/pages/terms">Terms of Use</a> | <a href="https://www.scholarnest.in/pages/contact">Contact Us</a>