FROM openjdk:8-jre-slim

RUN ln -sf /usr/share/zoneinfo/Asia/Taipei /etc/localtime && echo "Asia/Taipei" > /etc/timezone

RUN apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/*

ARG TOMCAT_VER
RUN wget -q -O- https://archive.apache.org/dist/tomcat/tomcat-8/v${TOMCAT_VER}/bin/apache-tomcat-${TOMCAT_VER}.tar.gz | tar xzv -C /opt && ln -s /opt/apache-tomcat-${TOMCAT_VER} /opt/tomcat && rm -rf /opt/tomcat/webapps/*
ADD tomcat-configs /opt/tomcat/conf
ADD lib /opt/tomcat/lib

