Build command:
    docker build --tag demo_kafka .

Run command:
    docker network create demo_kafka
    docker run -it -p 9092:9092 -p 2181:2181 -p 8083:8083 --network=demo_kafka --name=demo_kafka  demo_kafka 

Create Connector:
    curl -i -X POST -H "Accept:application/json" \
            -H  "Content-Type:application/json" http://localhost:8083/connectors/ \
            -d '{
        "name": "<database_name>-mysql-connector",  
        "config": {
            "connector.class": "io.debezium.connector.mysql.MySqlConnector", 
            "database.hostname": "<database_host>", 
            "database.port": "<database_port>", 
            "database.user": "<database_user>", 
            "database.password": "<database_password>", 
            "database.server.id": "<database_server_id>", 
            "database.server.name": "<database_name>", 
            "database.whitelist": "<database_name>", 
            "database.history.kafka.bootstrap.servers": "localhost:9092", 
            "database.history.kafka.topic": "dbhistory.<database_name>", 
            "include.schema.changes": "false" ,
            "table.whitelist": "<database_name>.<table_name>"
        }
    }'
Consumer:
    connect container and run following command for consumer: 
        docker exec -it demo_kafka bash
        bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic <topic_name> --from-beginning
