-- Databricks notebook source
-- MAGIC %md
-- MAGIC <div style="text-align: center; line-height: 0; padding-top: 9px;">
-- MAGIC   <img src="https://learningjournal.github.io/pub-resources/logos/scholarnest_academy.jpg" alt="ScholarNest Academy" style="width: 1400px">
-- MAGIC </div>

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####Filtering Rows
-- MAGIC
-- MAGIC Filtering can be done using WHERE Clause
-- MAGIC
-- MAGIC ```sql
-- MAGIC       SELECT expression
-- MAGIC       FROM table_name
-- MAGIC       WHERE boolean_expression
-- MAGIC ```
-- MAGIC
-- MAGIC ####Comparision operators
-- MAGIC 1. Equality=>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =, ==
-- MAGIC 2. Not Equal=>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   !=
-- MAGIC 3. Greater=>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  >
-- MAGIC 4. Less=>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   <
-- MAGIC 5. Greater or Equal=>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   >=
-- MAGIC 6. Less or Equal=>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   <=
-- MAGIC 7. Range filter=>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   BETWEEN low AND high
-- MAGIC 7. List filter=>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   IN
-- MAGIC 8. String Pattern filter=>&nbsp;&nbsp;&nbsp;&nbsp;  like
-- MAGIC 9. Null filter=>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   IS NULL
-- MAGIC
-- MAGIC ####Logical operators
-- MAGIC 1. AND=>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   AND
-- MAGIC 2. OR=>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
-- MAGIC     OR
-- MAGIC 3. NOT=>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   NOT
-- MAGIC

-- COMMAND ----------

-- DBTITLE 1,Clean previous executions
-- MAGIC %run ./utils/clean-microproject

-- COMMAND ----------

-- DBTITLE 1,Setup Database and Tables
-- MAGIC %python
-- MAGIC DB.setup(spark)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q1: What are the facilities available to our guests for $25?

-- COMMAND ----------

SELECT * FROM club_db.facilities
WHERE guest_cost = 25

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q2: What facilities are availabe to our members for 1/3rd or lesser price?

-- COMMAND ----------

SELECT * 
FROM club_db.facilities
WHERE member_cost <= guest_cost / 3

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q3: List all members who joined us without any recomendations.

-- COMMAND ----------

SELECT * FROM club_db.members
WHERE recommended_by IS NULL

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q4: List all members recomended by some other member.

-- COMMAND ----------

SELECT * FROM club_db.members
WHERE recommended_by IS NOT NULL

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q5: Which facilities are free for members but charged for guests?

-- COMMAND ----------

SELECT * FROM club_db.facilities
WHERE member_cost = 0 AND guest_cost > 0

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q6: List facilities of the following type
-- MAGIC 1. It is a court type facility
-- MAGIC 2. Monthly maintainance is more than depriciation (25% of intitial setup cost)

-- COMMAND ----------

SELECT * FROM club_db.facilities
WHERE facility_name LIKE "%Court%" OR monthly_maintainance > initial_outlay * 0.25


-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q7: List all members except those recomended by Darren Smith (Darren's member ID is 1).

-- COMMAND ----------

SELECT * FROM club_db.members
WHERE recommended_by != 1 OR recommended_by IS NULL

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q8: Which facilities have annual maintainance cost in the range of 1000 to 3000?

-- COMMAND ----------

SELECT * FROM club_db.facilities
WHERE monthly_maintainance * 12 >= 1000 AND monthly_maintainance * 12 <= 3000

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q9: Which facilities have annual maintainance cost in the range of 1000 to 3000?

-- COMMAND ----------

SELECT * FROM club_db.facilities
WHERE monthly_maintainance * 12 BETWEEN 1000 AND 3000

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q10: List all facilities having monthly maintainance of 5, 10, 15, or 50.

-- COMMAND ----------

SELECT * FROM club_db.facilities
WHERE monthly_maintainance IN (5, 10, 15, 50)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q11: List all members with first name Tim or Darren.

-- COMMAND ----------

SELECT * FROM club_db.members
WHERE first_name IN ("Tim", "Darren")

-- COMMAND ----------

-- MAGIC %md
-- MAGIC &copy; 2021-2025 <a href="https://www.scholarnest.com/">ScholarNest</a>. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC Databricks, Databricks Cloud and the Databricks logo are trademarks of the <a href="https://www.databricks.com/">Databricks Inc</a>.<br/>
-- MAGIC <br/>
-- MAGIC <a href="https://www.scholarnest.in/pages/privacy">Privacy Policy</a> | <a href="https://www.scholarnest.in/pages/terms">Terms of Use</a> | <a href="https://www.scholarnest.in/pages/contact">Contact Us</a>