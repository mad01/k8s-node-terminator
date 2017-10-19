FROM golang:1.8.4-jessie as builder
ENV buildpath=/usr/local/go/src/build/k8s-node-updater
ARG build=notSet
RUN mkdir -p $buildpath
ADD . $buildpath
WORKDIR $buildpath

RUN make build/release

FROM alpine:3.6
COPY --from=builder /usr/local/go/src/build/k8s-node-updater/_release/k8s-node-updater /k8s-node-updater

ENTRYPOINT ["/k8s-node-updater"]
