

import csv
from kafka import KafkaProducer
import time

# Replace these with your details
KAFKA_BROKERS = "localhost:9092"  # Replace with your Kafka broker address
TOPIC_NAME = "my-measles-data"  # Replace with your desired topic name
DATASET_PATH = "shuffled_measles.csv"  # Replace with the path to your shuffled CSV file

def main():
    producer = KafkaProducer(bootstrap_servers=KAFKA_BROKERS)

    with open(DATASET_PATH, "r") as csvfile:
        reader = csv.reader(csvfile)
        for row in reader:
            # Encode each row as UTF-8 bytes before sending
            data = ",".join(row).encode('utf-8')
            producer.send(TOPIC_NAME, data)
            # Wait for 2 seconds before sending another message
            time.sleep(2)

if __name__ == "__main__":
    main()
