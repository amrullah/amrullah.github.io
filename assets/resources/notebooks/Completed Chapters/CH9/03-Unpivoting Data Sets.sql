-- Databricks notebook source
-- MAGIC %md
-- MAGIC <div style="text-align: center; line-height: 0; padding-top: 9px;">
-- MAGIC   <img src="https://learningjournal.github.io/pub-resources/logos/scholarnest_academy.jpg" alt="ScholarNest Academy" style="width: 1400px">
-- MAGIC </div>

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####Unpivoting data sets
-- MAGIC Unpivoting is opposit to the pivoting.\
-- MAGIC Remember: Pivoting aggregates but Unpivoting does not undo the aggregate.
-- MAGIC
-- MAGIC Pivot
-- MAGIC ```
-- MAGIC   Customers   | Product 1 | Product 2 | Product 3
-- MAGIC   -----------------------------------------------
-- MAGIC   Customer 1  |    xxx    |    xxx    |    xxx    
-- MAGIC   Customer 2  |    xxx    |    xxx    |    xxx    
-- MAGIC   Customer 3  |    xxx    |    xxx    |    xxx    
-- MAGIC   -----------------------------------------------
-- MAGIC ```
-- MAGIC
-- MAGIC Unpivot
-- MAGIC ```
-- MAGIC   Customers   | Products  | sales 
-- MAGIC   --------------------------------
-- MAGIC   Customer 1  | Product 1 | xxx   
-- MAGIC   Customer 1  | Product 2 | xxx 
-- MAGIC   Customer 1  | Product 3 | xxx 
-- MAGIC   Customer 2  | Product 1 | xxx   
-- MAGIC   Customer 2  | Product 2 | xxx 
-- MAGIC   Customer 2  | Product 3 | xxx 
-- MAGIC   --------------------------------
-- MAGIC ```
-- MAGIC
-- MAGIC Unpivot Syntax
-- MAGIC ```
-- MAGIC   SELECT * FROM pivot_data
-- MAGIC   UNPIVOT(desired_last_value_column_name
-- MAGIC           FOR desired_previous_column_name IN ( previous_column_values ) 
-- MAGIC         )
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
-- MAGIC Q1. You have a sales pivot. Transform product columns to rows.
-- MAGIC
-- MAGIC Expected Results
-- MAGIC ```
-- MAGIC   Customer Name           |product              |amount
-- MAGIC   ----------------------------------------------------
-- MAGIC   Super Trading Company   |Steel Door 4x7       |52000
-- MAGIC   Super Trading Company   |Steel TMT 550        |105000
-- MAGIC   Super Trading Company   |Steel Window 8x4     |88000
-- MAGIC   One Distributors        |Steel TMT 550        |64000
-- MAGIC   One Distributor         |Steel Window 8x4     |26000
-- MAGIC   Great Enterprises       |Steel Door 4x7       |90000
-- MAGIC   Great Enterprises       |Steel TMT 550        |143000
-- MAGIC   Great Enterprises       |Steel Window 8x4     |35000
-- MAGIC ```

-- COMMAND ----------

SELECT * FROM ramco_db.sales_pivot
UNPIVOT(amount
        FOR product IN (`Steel Door 4x7`, `Steel TMT 550`, `Steel Window 8x4`) 
      )

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q2. You have a quarterly sales. Transforms quarters from column to row.
-- MAGIC
-- MAGIC Expected Results
-- MAGIC ```
-- MAGIC   year	|quarter  |sales
-- MAGIC   -------------------------
-- MAGIC   2023	|q1       |87563
-- MAGIC   2023	|q2       |86124
-- MAGIC   2023	|q3       |97206
-- MAGIC   2023	|q4       |59027
-- MAGIC   2022	|q1       |71209
-- MAGIC   2022	|q2       |67230
-- MAGIC   2022	|q3       |71029
-- MAGIC   2022	|q4       |59820
-- MAGIC   2021	|q1       |68129
-- MAGIC   2021	|q2       |69018
-- MAGIC   2021	|q3       |56018
-- MAGIC   2021	|q4       |50029
-- MAGIC ```

-- COMMAND ----------

SELECT * FROM ramco_db.yearly_sales
UNPIVOT(sales
        FOR quarter IN (q1, q2, q3, q4) 
      )

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q3. You have a quarterly sales. Create a half yearly pivot as the following.
-- MAGIC ```
-- MAGIC   year  | half_year | first_quarter | second_quarter
-- MAGIC   -------------------------------------------------
-- MAGIC   2023  | H1        |   87563       |   86124
-- MAGIC   2023  | H2        |   97206       |   59027
-- MAGIC   2022  | H1        |   71209       |   67230
-- MAGIC   2022  | H2        |   71029       |   59820
-- MAGIC ```

-- COMMAND ----------

SELECT * FROM ramco_db.yearly_sales
UNPIVOT((first_quarter, second_quarter)
        FOR half_year IN ( (q1, q2) AS H1,
                           (q3, q4) AS H2 ) 
      )

-- COMMAND ----------

-- MAGIC %md
-- MAGIC &copy; 2021-2025 <a href="https://www.scholarnest.in/">ScholarNest</a>. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC Databricks, Databricks Cloud and the Databricks logo are trademarks of the <a href="https://www.databricks.com/">Databricks Inc</a>.<br/>
-- MAGIC <br/>
-- MAGIC <a href="https://www.scholarnest.in/pages/privacy">Privacy Policy</a> | <a href="https://www.scholarnest.in/pages/terms">Terms of Use</a> | <a href="https://www.scholarnest.in/pages/contact">Contact Us</a>