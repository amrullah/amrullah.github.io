# Databricks notebook source
class Setup():
    def __init__(self):
        self.db_name = "my_db"
        spark.sql("USE CATALOG dev")

    def delete_db(self):
        if spark.sql(f"SHOW DATABASES IN dev").filter(f"databaseName == '{self.db_name}'").count() == 1:
            print(f"Dropping the database {self.db_name}...", end='')
            spark.sql(f"DROP DATABASE {self.db_name} CASCADE")
            print("Done")
    
    
    def setup_table(self, spark):
        spark.sql(f"""CREATE DATABASE IF NOT EXISTS {self.db_name}""")
        spark.sql(f"""CREATE OR REPLACE TABLE {self.db_name}.diamonds(
                        carat DOUBLE,
                        clarity STRING,
                        color STRING,
                        cut STRING,
                        depth STRING,
                        price DOUBLE)""")
        spark.sql(f"""INSERT INTO {self.db_name}.diamonds 
                      SELECT * FROM json.`/Volumes/dev/scholarnest/sql_data/diamonds.json`""")
        

DB = Setup()
DB.delete_db()