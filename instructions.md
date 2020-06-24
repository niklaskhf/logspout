# Instructions

How to build: 

ARM64: 
`docker build --build-arg opts="GOARCH=arm64" -t niklaskhf/logspout:arm64 .`

AMD64: 
`docker build --build-arg opts="CGO_ENABLED=0 GOARCH=amd64" -t niklaskhf/logspout:amd64 .`