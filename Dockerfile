FROM golang:1.13-alpine3.12 AS builder
ARG opts
WORKDIR /go/src/github.com/gliderlabs/logspout/
COPY . .
RUN apk --no-cache add build-base git mercurial ca-certificates curl
RUN go mod download
RUN env ${opts} go build \
    -ldflags "-X main.Version=$(cat VERSION)" \
    -o bin/logspout \
    .
RUN apk del git mercurial build-base
RUN rm -rf /var/cache/apk/*


FROM alpine:3.12
RUN apk add --no-cache ca-certificates
COPY --from=builder /go/src/github.com/gliderlabs/logspout/bin/logspout /bin/logspout
RUN ln -fs /tmp/docker.sock /var/run/docker.sock

VOLUME /mnt/routes
EXPOSE 80

ENTRYPOINT ["/bin/logspout"]

