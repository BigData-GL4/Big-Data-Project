#!/bin/bash

BROKER_ADDRESS="localhost:9092"
TOPIC="my_measles_data"
DATA="/root/shuffled_measles.csv"

kafka-topics.sh --create --topic "$TOPIC" --replication-factor 1 --partitions 1 --bootstrap-server "$BROKER_ADDRESS"
echo "Created Kafka topic: $TOPIC"

while IFS= read -r line; do
    # Send the line to Kafka
    echo "$line" | kafka-console-producer.sh --broker-list "$BROKER_ADDRESS" --topic "$TOPIC"
    # Sleep for 100 milliseconds
    sleep .1
done < "$DATA"