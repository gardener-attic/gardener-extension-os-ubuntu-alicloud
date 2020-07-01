############# builder
FROM golang:1.14.4 AS builder

WORKDIR /go/src/github.com/gardener/gardener-extension-os-ubuntu-alicloud
COPY . .
RUN make install-requirements && make generate && make install

############# gardener-extension-os-ubuntu-alicloud
FROM alpine:3.12.0 AS gardener-extension-os-ubuntu-alicloud

COPY --from=builder /go/bin/gardener-extension-os-ubuntu-alicloud /gardener-extension-os-ubuntu-alicloud
ENTRYPOINT ["/gardener-extension-os-ubuntu-alicloud"]
