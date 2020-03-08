FROM jenkins/jenkins:lts-alpine

# Our goal here is to have an image with Jenkins AND Helm, so that Jenkins jobs
# can access Kubernetes through the Helm tool.
USER root
RUN apk add --update --no-cache openssl ca-certificates && \
  curl -O https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 && \
  chmod +x ./get-helm-3 && \
  ./get-helm-3 && \
  curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl && \
  chmod +x ./kubectl && \
  mv ./kubectl /usr/local/bin/kubectl && \
  rm -f /var/cache/apk/*
USER jenkins
