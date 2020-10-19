CREATE EXTERNAL TABLE IF NOT EXISTS covid_db.covid_staging
(
Country STRING,
Total_Cases BIGINT,
New_Cases INT,
Total_Deaths BIGINT,
New_Deaths INT,
Total_Recovered BIGINT,
Active_Cases BIGINT,
Serious INT,
Tot_Cases BIGINT,
Deaths DOUBLE,
Total_Tests BIGINT,
Tests BIGINT,
CASES_per_Test BIGINT,
Death_in_Closed_Cases STRING,
Rank_by_Testing_rate INT,
Rank_by_Death_rate INT,
Rank_by_Cases_rate INT,
Rank_by_Death_of_Closed_Cases INT
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
STORED AS TEXTFILE
LOCATION '/user/cloudera/ds/COVID_HDFS_LZ/'
tblproperties ("skip.header.line.count"="1");
