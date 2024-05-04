#!/bin/bash
set -oe pipefail

BROKER_ADDRESS="localhost:9092"
TOPIC="my_measles_data"
DATA="/root/kafka/shuffled_measles.csv"


kafka_producer() {
    # Read the file line by line
    while IFS= read -r line; do
        # Send the line to Kafka
        echo "$line" | kafka-console-producer.sh --broker-list "$BROKER_ADDRESS" --topic "$TOPIC"
        # Sleep for 100 milliseconds
        sleep .1
    done < "$DATA"
}

create_kafka_topic() {
    # Check if the topic already exists
    kafka-topics.sh --list --bootstrap-server "$BROKER_ADDRESS" | grep -q "$TOPIC" && return
    # Create the Kafka topic
    kafka-topics.sh --create --topic "$TOPIC" --replication-factor 1 --partitions 1 --bootstrap-server "$BROKER_ADDRESS"
    echo "Created Kafka topic: $TOPIC"
}

create_kafka_topic
kafka_producer
