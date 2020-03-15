############# builder
FROM golang:1.13.8 AS builder

WORKDIR /go/src/github.com/gardener/gardener-extension-os-ubuntu-alicloud
COPY . .
RUN make install-requirements && make VERIFY=true all

############# gardener-extension-os-ubuntu-alicloud
FROM alpine:3.11.3 AS gardener-extension-os-ubuntu-alicloud

COPY --from=builder /go/bin/gardener-extension-os-ubuntu-alicloud /gardener-extension-os-ubuntu-alicloud
ENTRYPOINT ["/gardener-extension-os-ubuntu-alicloud"]
