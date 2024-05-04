#!/bin/bash
set -oe pipefail

get-data() {
    python ./Data/shuffle.py
}

get-data

docker exec -it hadoop-master bash -c "mkdir -p /root/kafka"

docker cp ./Data/shuffled_measles.csv hadoop-master:/root/kafka/
docker cp kafka-producer.sh hadoop-master:/root/kafka/

docker exec -i hadoop-master bash -c "bash /root/kafka/kafka-producer.sh" & echo "Kafka producer started"

