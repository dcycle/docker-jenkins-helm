set -e
docker pull jenkins/jenkins:lts-alpine
# docker pull dcycle/jenkins-helm:1
docker build -t local-dcycle-jenkins-helm-image .
