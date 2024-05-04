#!/bin/bash

# Set the Kafka broker address and topic name
broker_address="localhost:9092"
topic="my_measles_data"

# Read the file line by line
while IFS= read -r line; do
    # Send the line to Kafka
    echo "$line" | kafka-console-producer.sh --broker-list "$broker_address" --topic "$topic"
    # Sleep for 10 milliseconds
    usleep 10000
done < "shuffled_measles.csv"