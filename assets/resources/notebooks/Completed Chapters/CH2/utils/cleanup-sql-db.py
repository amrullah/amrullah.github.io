# Databricks notebook source
class Cleanup():
    def __init__(self):
        self.db_name = "sql_db"
  
    def delete_sql_db(self):
        spark.sql("USE CATALOG dev")
        if spark.sql(f"SHOW DATABASES IN dev").filter(f"databaseName == '{self.db_name}'").count() == 1:
            print(f"Dropping the database {self.db_name}...", end='')
            spark.sql(f"DROP DATABASE {self.db_name} CASCADE")
            print("Done")


CL = Cleanup()
CL.delete_sql_db()