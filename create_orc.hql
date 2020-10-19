SET hive.exec.dynamic.partition.mode=nonstrict;
SET mapreduce.map.memory.mb=4096;
SET mapreduce.reduce.memory.mb=5120;
SET hive.exec.max.dynamic.partitions=217;
SET hive.exec.max.dynamic.partitions.pernode=217;

CREATE TABLE IF NOT EXISTS covid_db.covid_partitioned
(
Total_Cases STRING,
New_Cases STRING,
Total_Deaths STRING,
New_Deaths STRING,
Total_Recovered STRING,
Active_Cases STRING,
Serious STRING,
Tot_Cases STRING,
Deaths STRING,
Total_Tests STRING,
Tests STRING,
CASES_per_Test STRING,
Death_in_Closed_Cases STRING,
Rank_by_Testing_rate STRING,
Rank_by_Death_rate STRING,
Rank_by_Cases_rate STRING,
Rank_by_Death_of_Closed_Cases STRING
)
PARTITIONED BY (COUNTRY_NAME STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/user/cloudera/ds/COVID_HDFS_PARTITIONED';

INSERT INTO TABLE covid_db.covid_partitioned PARTITION(COUNTRY_NAME)
SELECT 
Total_Cases,
New_Cases,
Total_Deaths,
New_Deaths,
Total_Recovered,
Active_Cases,
Serious,
Tot_Cases,
Deaths,
Total_Tests,
Tests,
CASES_per_Test,
Death_in_Closed_Cases,
Rank_by_Testing_rate,
Rank_by_Death_rate,
Rank_by_Cases_rate,
Rank_by_Death_of_Closed_Cases,
Country FROM covid_db.covid_staging WHERE Country is not null;
