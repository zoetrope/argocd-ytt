FROM quay.io/cybozu/ubuntu:20.04 AS ubuntu

ARG YTT_VERSION=0.30.0

WORKDIR /work
RUN curl -sSL -o ytt https://github.com/vmware-tanzu/carvel-ytt/releases/download/v${YTT_VERSION}/ytt-linux-amd64
RUN chmod +x ytt

FROM argoproj/argocd:latest

COPY --from=ubuntu /work/ytt /usr/local/bin/ytt
