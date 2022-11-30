# teams-tomcat

## teams 基於 docker image 用於 k8s 上的 tomcat

Build
```
docker build --platform=linux/amd64 --tag ehanlin/teams-tomcat:$TEAMS_TAG --build-arg TOMCAT_VER=8.5.84 .
```

Publish
```
docker push ehanlin/teams-tomcat:$TEAMS_TAG
```