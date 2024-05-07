wget https://repo1.maven.org/maven2/com/google/guava/guava/16.0.1/guava-16.0.1.jar -P /usr/local/spark/jars
if [ -f /usr/local/spark/jars/guava-14.0.1.jar ]; then
    rm /usr/local/spark/jars/guava-14.0.1.jar
fi

spark-submit --class spark.kafka.MeaslesDataConsumer --master local /root/stream-kafka-spark-1.0-SNAPSHOT-jar-with-dependencies.jar localhost:9092 my_measles_data shuffled_measles.csv mySparkConsumerGroup >> out
