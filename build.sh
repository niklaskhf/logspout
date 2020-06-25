#!/bin/sh
set -e
apk add --update go build-base git mercurial ca-certificates
cd /src
env $2
go build -ldflags "-X main.Version=$1" -o /bin/logspout
apk del go git mercurial build-base
rm -rf /root/go /var/cache/apk/*

# backwards compatibility
ln -fs /tmp/docker.sock /var/run/docker.sock
