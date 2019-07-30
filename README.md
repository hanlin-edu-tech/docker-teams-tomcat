# teams-tomcat

## teams 基於 docker image 用於 k8s 上的 tomcat

Build
```
docker build --tag ehanlin/teams-tomcat:$TOMCAT_VER --build-arg TOMCAT_VER=$TOMCAT_VER .
```

Publish
```
docker push ehanlin/teams-tomcat:$TOMCAT_VER
```