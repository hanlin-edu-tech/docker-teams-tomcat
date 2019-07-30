FROM openjdk:8-jre-slim

RUN ln -sf /usr/share/zoneinfo/Asia/Taipei /etc/localtime && echo "Asia/Taipei" > /etc/timezone

RUN apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/cprof && wget -q -O- https://storage.googleapis.com/cloud-profiler/java/latest/profiler_java_agent.tar.gz | tar xzv -C /opt/cprof

ARG TOMCAT_VER
RUN wget -q -O- https://archive.apache.org/dist/tomcat/tomcat-8/v${TOMCAT_VER}/bin/apache-tomcat-${TOMCAT_VER}.tar.gz | tar xzv -C /opt && ln -s /opt/apache-tomcat-${TOMCAT_VER} /opt/tomcat && rm -rf /opt/tomcat/webapps/*
ADD tomcat-configs/logging.properties /opt/tomcat/conf/logging.properties
ADD tomcat-configs/server.xml /opt/tomcat/conf/server.xml
ADD tomcat-configs/web.xml /opt/tomcat/conf/web.xml
ADD lib /opt/tomcat/lib