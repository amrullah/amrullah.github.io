# Databricks notebook source
class Setup():
    def __init__(self):
        self.db_name = "club_db"
        spark.sql("USE CATALOG dev")
  
    def clean(self):
        if spark.sql(f"SHOW DATABASES IN dev").filter(f"databaseName == '{self.db_name}'").count() == 1:
            print(f"Dropping the database {self.db_name}...", end='')
            spark.sql(f"DROP DATABASE {self.db_name} CASCADE")
            print("Done")
    

    def setup(self, spark):
        spark.sql(f"CREATE DATABASE IF NOT EXISTS {self.db_name}")
        spark.sql(f"""CREATE OR REPLACE TABLE {self.db_name}.facilities(
                        facility_id INT,
                        facility_name STRING,
                        member_cost DOUBLE,
                        guest_cost DOUBLE,
                        initial_outlay DOUBLE,
                        monthly_maintainance DOUBLE
                    )""")
        spark.sql(f"""CREATE OR REPLACE TABLE {self.db_name}.members(
                        member_id INT,
                        first_name STRING,
                        last_name STRING,
                        address STRING,
                        zip_code STRING,
                        telephone STRING,
                        recommended_by STRING,
                        joining_date DATE
                    )""")
        spark.sql(f"""CREATE OR REPLACE TABLE {self.db_name}.bookings(
                        booking_id INT,
                        facility_id INT,
                        member_id INT,
                        start_time TIMESTAMP,
                        slots INT
                    )""")
        spark.sql(f"""insert into {self.db_name}.facilities
                            select _c0 facility_id, 
                                _c1 facility_name, 
                                _c2 member_cost, 
                                _c3 guest_cost, 
                                _c4 initial_outlay, 
                                _c5 monthly_maintainance
                            from csv.`/Volumes/dev/scholarnest/sql_data/club/facilities.csv` offset 1""")
        spark.sql(f"""insert into {self.db_name}.members
                            select _c0 member_i,
                                _c2 first_name,
                                _c1 last_name,
                                _c3 address,
                                _c4 zip_code,
                                _c5 telephone,
                                _c6 recommended_by,
                                _c7 joining_date
                            from csv.`/Volumes/dev/scholarnest/sql_data/club/members.csv` offset 1""")
        spark.sql(f"""insert into {self.db_name}.bookings
                            select _c0 booking_id,
                                _c1 facility_id,
                                _c2 member_id,
                                _c3 start_time,
                                _c4 slots
                            from csv.`/Volumes/dev/scholarnest/sql_data/club/bookings.csv` offset 1""")
        
        spark.sql(f"""CREATE OR REPLACE VIEW {self.db_name}.club_bookings AS
                        WITH m_temp AS (SELECT m.member_id,  
                                        if(m.member_id = 0, "Guest Member", concat_ws(" ", m.first_name, m.last_name)) as member_name,                 
                                        if(m.member_id = 0, "Guest Address", substring_index(m.address, ",", 1)) as address,
                                        if(m.member_id = 0, "Guest Address", substring_index(m.address, ",", -1)) as area,
                                        m.address as o_address,
                                        position(",", m.address, 1) + 1 p1,
                                        position(",", m.address, position(",", m.address, 1) + 1) p2,
                                        concat_ws(" ", r.first_name, r.last_name) AS recomended_by      
                                    FROM {self.db_name}.members m
                                        LEFT JOIN {self.db_name}.members AS r ON m.recommended_by = r.member_id),
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
                                        FROM {self.db_name}.bookings AS b NATURAL JOIN m_final AS m NATURAL JOIN {self.db_name}.facilities AS f)
                        SELECT * FROM club_bookings
                  """)  

DB = Setup()
DB.clean()