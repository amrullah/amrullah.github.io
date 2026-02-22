-- Databricks notebook source
-- MAGIC %md
-- MAGIC <div style="text-align: center; line-height: 0; padding-top: 9px;">
-- MAGIC   <img src="https://learningjournal.github.io/pub-resources/logos/scholarnest_academy.jpg" alt="ScholarNest Academy" style="width: 1400px">
-- MAGIC </div>

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####Views in SQL
-- MAGIC 1. Views are stored SQL query that behaves like a table. 
-- MAGIC 2. View executes the SQL query everytime you select from the view.
-- MAGIC
-- MAGIC Syntax
-- MAGIC ```
-- MAGIC CREATE [ OR REPLACE ] VIEW view_name
-- MAGIC AS sql_query
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
-- MAGIC Q1. We want to create a simplified view of club members for our day to day reporting.\
-- MAGIC Create a club members view using the following SQL.

-- COMMAND ----------

CREATE OR REPLACE VIEW club_db.club_members AS
SELECT m.member_id,  
    if(m.member_id = 0, "Guest Member", concat_ws(" ", m.first_name, m.last_name)) as member_name,                     
    m.address, m.zip_code, m.telephone, 
    concat_ws(" ", r.first_name, r.last_name) AS recomended_by      
FROM club_db.members m
    LEFT JOIN club_db.members AS r ON m.recommended_by = r.member_id

-- COMMAND ----------

SELECT * FROM club_db.club_members

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q2. We want to create a denormalized view of club booking for our reporting.\
-- MAGIC Create a club bookings view using the following query.

-- COMMAND ----------

CREATE OR REPLACE VIEW club_db.club_bookings AS
WITH m_temp AS (SELECT m.member_id,  
                if(m.member_id = 0, "Guest Member", concat_ws(" ", m.first_name, m.last_name)) as member_name,                 
                if(m.member_id = 0, "Guest Address", substring_index(m.address, ",", 1)) as address,
                if(m.member_id = 0, "Guest Address", substring_index(m.address, ",", -1)) as area,
                m.address as o_address,
                position(",", m.address, 1) + 1 p1,
                position(",", m.address, position(",", m.address, 1) + 1) p2,
                concat_ws(" ", r.first_name, r.last_name) AS recomended_by      
            FROM club_db.members m
                LEFT JOIN club_db.members AS r ON m.recommended_by = r.member_id),
m_final AS (SELECT member_id, member_name, address,
            trim(CASE WHEN rlike(area,"[0-9]+" ) 
                        THEN substr(o_address, p1, p2-p1) 
                        ELSE area END) AS area,
            recomended_by
    FROM m_temp),
club_bookings AS (SELECT b.booking_id, b.start_time, b.slots,
                        m.*,
                        f.*, 
                        if(b.member_id = 0, b.slots * f.guest_cost, b.slots * f.member_cost) AS booking_amount
                FROM club_db.bookings AS b NATURAL JOIN m_final AS m NATURAL JOIN club_db.facilities AS f)
SELECT * FROM club_bookings

-- COMMAND ----------

SELECT * FROM club_db.club_bookings

-- COMMAND ----------

-- MAGIC %md
-- MAGIC &copy; 2021-2025 <a href="https://www.scholarnest.in/">ScholarNest</a>. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC Databricks, Databricks Cloud and the Databricks logo are trademarks of the <a href="https://www.databricks.com/">Databricks Inc</a>.<br/>
-- MAGIC <br/>
-- MAGIC <a href="https://www.scholarnest.in/pages/privacy">Privacy Policy</a> | <a href="https://www.scholarnest.in/pages/terms">Terms of Use</a> | <a href="https://www.scholarnest.in/pages/contact">Contact Us</a>