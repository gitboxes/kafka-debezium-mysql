FROM ubuntu:18.04

RUN apt-get update

RUN apt-get install -y vim

RUN apt-get install -y procps

RUN apt-get install -y wget

RUN apt-get install -y default-jre

RUN apt-get install -y default-jdk

RUN apt-get install -y locate

#RUN apt-get -y upgrade

ENV JAVA_HOME=/usr/lib/jvm/default-java


WORKDIR /usr/local/kafka

COPY ./kafka_2.12-2.3.1 /usr/local/kafka

COPY  ./kafka-connect /usr/local/kafka/connect

EXPOSE 2181 9092 8083 

COPY ./start.sh /usr/local/start.sh

RUN chmod +x /usr/local/start.sh

ENV KAFKA_CONNECT_PLUGINS_DIR=/usr/local/kafka/connect/

ENV CLASSPATH=/usr/local/kafka/connect/*:$CLASSPATH

RUN apt-get install -y curl

ENTRYPOINT [ "/usr/local/start.sh" ]

