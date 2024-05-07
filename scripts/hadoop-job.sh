hdfs dfsadmin -safemode leave

hdfs dfs -rm input/*
hdfs dfs -put shuffled_measles.csv

hadoop jar /root/mmr-average-1.0-SNAPSHOT-jar-with-dependencies.jar shuffled_measles.csv output