#!/bin/bash

echo 'starting zookeeper..'
bin/zookeeper-server-start.sh /usr/local/kafka/config/zookeeper.properties  > /dev/null 2>&1 &
sleep 2
echo 'starting kafka..'
bin/kafka-server-start.sh /usr/local/kafka/config/server.properties > /dev/null 2>&1 &
sleep 5
echo 'starting cluster..'
bin/connect-distributed.sh config/connect-distributed.properties
