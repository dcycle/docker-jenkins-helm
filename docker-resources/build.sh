#!/bin/sh
# Build script to run on Docker
set -e

echo "Our goal here is to have an image with Jenkins, Helm and the DigitalOcean"
echo "command line tool https://github.com/digitalocean/doctl"
echo "so that Jenkins jobs can access Kubernetes through the Helm tool and"
echo "manage DigitalOcean VMs to do things like build new multi-architecture"
echo "images on a VM."
echo ""
echo "=> Install Helm"
echo ""
apk add --update --no-cache openssl ca-certificates
curl -O https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod +x ./get-helm-3
./get-helm-3
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectlrm -f /var/cache/apk/*
echo ""
echo "=> Install Helm done"
echo ""
echo "=> Install Doctl"
echo ""
# Inspird by https://github.com/alpine-docker/doctl/blob/main/Dockerfile
# See https://gist.github.com/steinwaywhw/a4cd19cda655b8249d908261a62687f8
# on how to get the latest release.
apk add --update --no-cache tar
curl -s https://api.github.com/repos/digitalocean/doctl/releases/latest \
| grep "\/.*linux-amd64.tar.gz" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi - \
| tar xvz -C /usr/bin
apk del tar
echo ""
echo "=> Install Doctl done"
echo ""
echo "=> All done!"
echo ""
