hdfs dfs -rm -r -f /user/cloudera/ds
hdfs dfs -mkdir -p /user/cloudera/ds/COVID_HDFS_LZ
hdfs dfs -mkdir /user/cloudera/ds/COVID_FINAL_OUTPUT
hdfs dfs -cp /user/cloudera/covid_project/landing_zone/COVID_SRC_LZ/covid-19.csv /user/cloudera/ds/COVID_HDFS_LZ
