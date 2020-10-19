CREATE EXTERNAL TABLE IF NOT EXISTS covid_db.covid_final_output
(
TOP_DEATH STRING,
TOP_TEST STRING
)
PARTITIONED BY (COUNTRY_NAME STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED by ','
STORED as TEXTFILE
LOCATION '/user/cloudera/ds/COVID_FINAL_OUTPUT';

set hive.exec.dynamic.partition.mode=nonstrict;
SET mapreduce.map.memory.mb=4096;
SET mapreduce.reduce.memory.mb=5120;
SET hive.exec.max.dynamic.partitions=217;
SET hive.exec.max.dynamic.partitions.pernode=217;

CREATE TEMPORARY TABLE t1 AS select cast(rank_by_death_rate as int), COUNTRY_NAME from covid_db.covid_partitioned where rank_by_death_rate<11 order by rank_by_death_rate;

CREATE TEMPORARY TABLE t2 AS select cast(rank_by_testing_rate as int), COUNTRY_NAME from covid_db.covid_partitioned where rank_by_testing_rate<11 order by rank_by_testing_rate;

INSERT INTO covid_db.covid_final_output PARTITION (COUNTRY_NAME)
select DISTINCT u1.rank_by_death_rate,u1.rank_by_testing_rate,u1.COUNTRY_NAME from 
(select t1.COUNTRY_NAME,t1.rank_by_death_rate,t2.rank_by_testing_rate from t1 LEFT JOIN t2 on t1.COUNTRY_NAME = t2.COUNTRY_NAME 
UNION ALL
select t2.COUNTRY_NAME,t1.rank_by_death_rate,t2.rank_by_testing_rate from t1 RIGHT JOIN t2 on t1.COUNTRY_NAME = t2.COUNTRY_NAME) AS u1;



