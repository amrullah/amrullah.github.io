-- Databricks notebook source
-- MAGIC %md
-- MAGIC <div style="text-align: center; line-height: 0; padding-top: 9px;">
-- MAGIC   <img src="https://learningjournal.github.io/pub-resources/logos/scholarnest_academy.jpg" alt="ScholarNest Academy" style="width: 1400px">
-- MAGIC </div>

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####Description
-- MAGIC You are working for a corporation. The diagram below shows the data model for the corporation business.\
-- MAGIC The database is desinged using the following tables.
-- MAGIC 1. employees – stores employees data including name, department, and salary etc.
-- MAGIC 2. products – stores product information name, cost, category, etc.
-- MAGIC 3. clients – stores the transactions and information about client, and relation with employee and product.
-- MAGIC
-- MAGIC ####Requirement
-- MAGIC Data is provide to you as comma delimited files.\
-- MAGIC You are asked to write SQL to implement the data model.
-- MAGIC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####Corp Data Model
-- MAGIC
-- MAGIC <br>
-- MAGIC <img src ='https://learningjournal.github.io/pub-resources/images/corp_data_model.jpg' alt="Left Outer Join" style="width:300px">

-- COMMAND ----------

-- MAGIC %md
-- MAGIC &copy; 2021-2025 <a href="https://www.scholarnest.com/">ScholarNest</a>. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC Databricks, Databricks Cloud and the Databricks logo are trademarks of the <a href="https://www.databricks.com/">Databricks Inc</a>.<br/>
-- MAGIC <br/>
-- MAGIC <a href="https://www.scholarnest.in/pages/privacy">Privacy Policy</a> | <a href="https://www.scholarnest.in/pages/terms">Terms of Use</a> | <a href="https://www.scholarnest.in/pages/contact">Contact Us</a>