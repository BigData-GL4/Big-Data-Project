#!/bin/bash
set -oe pipefail

docker compose up -d

cd Vaccination-Rate-Hadoop && bash build.sh
cd ../Vaccination-Rate-Spark && bash build.sh

cd .. && python ./Data/shuffle.py

docker exec -it hadoop-master bash -c "mkdir -p /root/scripts"
docker exec -it cassandra bash -c "mkdir -p /root/scripts"
docker exec -it grafana bash -c "mkdir -p /home/grafana/scripts"

docker cp ./Data/shuffled_measles.csv hadoop-master:/root/

docker cp ./scripts/kafka-producer.sh hadoop-master:/root/scripts/
docker cp ./scripts/hadoop-job.sh hadoop-master:/root/scripts/
docker cp ./scripts/spark-job.sh hadoop-master:/root/scripts/

docker cp ./scripts/grafana-config.sh grafana:/home/grafana/scripts

docker cp ./scripts/cassandra-tables.sh cassandra:/root/scripts/
docker cp ./cassandra-setup.cql cassandra:/root/cassandra-setup.cql

echo "Creating Cassandra tables ..."
docker exec -i cassandra bash -c "bash /root/scripts/cassandra-tables.sh"

echo "Configuring Grafana ..."
docker exec -i grafana bash -c "bash /home/grafana/scripts/grafana-config.sh"
docker restart grafana

docker exec -i hadoop-master bash -c "bash /root/scripts/kafka-producer.sh" & echo "Kafka Producer Started"

docker exec -i hadoop-master bash -c "bash /root/scripts/hadoop-job.sh" & echo "Hadoop Job Started"
docker exec -i hadoop-master bash -c "bash /root/scripts/spark-job.sh" & echo "Spark Job Started"

# Get where grafana is running and print it
GRAFANA_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' grafana)

echo "You can consult the dashboard at http://$GRAFANA_IP:3000/d/oaK8xaOVz/vaccination-rates?orgId=1&refresh=3s"