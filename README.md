## 使用情況調查（2026-11-09）

> 本節為 hanlin-edu-tech repo 清理作業的調查紀錄，待負責人確認後決定封存或刪除。

- 調查結論：仍在使用
- 建議處置：保留，理由：由本 repo 建置的 Docker Hub image `ehanlin/teams-tomcat:8.5.84-msm` 是 Teams 一個正式環境現行部署版本的 base image，該版本於近 180 天內建置。
- 最後更新：pushedAt 2022-12-15；最後 commit `827b2ff` 2022-12-15 hotdog929 url例外規則加入"
- 用途：Teams 系統在 Kubernetes 上使用的 Tomcat base image（openjdk:8-jre-slim + Tomcat 8.5.x + tomcat-session-synchronizer 函式庫 + 自訂 `catalina.properties`、`context.xml`），發布到 Docker Hub `ehanlin/teams-tomcat`。

### 檢查結果

| 檢查項目 | 結果 | 依據 |
|---|---|---|
| GitHub 活動 | 2022-12-15 後無 commit | 共 9 個 commit；分支 `master`（2022-12-15）、`add-license-1`（2019-07-30，已併入）；PR 1 個（MERGED 2019-07-30）；issue 0；tag 0、release 0；Actions workflow 0；webhook 0；非 fork |
| org 內程式碼引用 | 有，引用方仍在運行 | `teams-tomcat`、`ehanlin/teams-tomcat`（各 7 筆）、`8.5.84-msm`（3 筆）：命中 private repo teams-103、teams-paper2docx、upload-server；`docker-teams-tomcat` 0 筆。teams-103 的 ACE 部署版本以 `ehanlin/teams-tomcat:8.5.84-msm` 為 base image；細節記錄於內部調查報告 |
| GCP 部署 | 有現行正式部署使用本 image | 已查核 8 個 GKE 叢集現行 image 的 manifest：一個 Teams 正式環境（2/2 Ready）現行 image 於 2026-06 建置，9 層 layer 全數與 `ehanlin/teams-tomcat:8.5.84-msm` 相同；Docker Hub 該 tag 的 `catalina.properties`、`context.xml` 與本 repo `827b2ff` 內容相同；Teams 其他正式環境的主程式現行版本已改用其他 base image；另有 2018～2019 年建置、仍在運行的 Teams 附屬服務 image 含早期 Tomcat 8.0.18 base 層（與 Docker Hub 現存 tag 的 layer 不同）；細節記錄於內部調查報告 |
| AWS 部署 | 查無 | 4 個 AWS 帳號的 Lambda、API Gateway（REST 與 HTTP API）、CloudFront、ECR、ECS、EventBridge、SQS、S3 以 `tomcat` 搜尋 0 筆 |
| Docker Hub | image 仍被拉取 | `ehanlin/teams-tomcat` 共 6 個 tag，最後推送 2022-12-15；`8.5.84-msm` 最後拉取 2026-10-27，其餘 tag 最後拉取 2026-11-04 |

### 待確認事項
- 本 repo 為 PUBLIC，Teams 系統改用其他 base image 後，請 Teams 負責人決定本 repo 與 Docker Hub image 的保留期限。

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