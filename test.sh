set -e
docker pull jenkins/jenkins:lts-alpine
docker build -t local-dcycle-jenkins-helm-image .

docker run --rm --entrypoint /bin/bash local-dcycle-jenkins-helm-image -c 'echo "helm version" && helm version && echo "kubectl" && kubectl && echo "doctl version" && doctl version && echo "All done!"'
