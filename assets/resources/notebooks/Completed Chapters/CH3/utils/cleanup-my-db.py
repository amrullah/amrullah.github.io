# Databricks notebook source
class Cleanup():
    def delete_db(self, db_name):
        spark.sql("USE CATALOG dev")
        if spark.sql(f"SHOW DATABASES IN dev").filter(f"databaseName == '{db_name}'").count() == 1:
            print(f"Dropping the database {db_name}...", end='')
            spark.sql(f"DROP DATABASE {db_name} CASCADE")
            print("Done")
    

class SetupDeltaFeatures():
    def enableRename(self, spark):
        pass
        #spark.conf.set("spark.databricks.delta.alterTable.rename.enabledOnAWS", "true")

    def enableDrop(self, spark):        
        spark.sql(f"""ALTER TABLE my_db.facility SET TBLPROPERTIES (
                        'delta.columnMapping.mode' = 'name',
                        'delta.minReaderVersion' = '2',
                        'delta.minWriterVersion' = '5')""")
        
        spark.sql("""ALTER TABLE my_db.facility SET TBLPROPERTIES ('delta.columnMapping.mode' = 'name')""")

CL = Cleanup()
CL.delete_db("test_db")
CL.delete_db("my_db")

DB = SetupDeltaFeatures()