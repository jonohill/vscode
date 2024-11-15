FROM --platform=$BUILDPLATFORM curlimages/curl

ARG TARGETPLATFORM

COPY download.sh /tmp/download.sh
RUN /tmp/download.sh

FROM debian:12.8-slim

# renovate: datasource=github-releases depName=microsoft/vscode
ENV VSCODE_VERSION=1.86.2

RUN apt-get update && apt-get install -y \
        curl \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd -r code && useradd -r -g code code && \
    mkdir /home/code && \
    chown -R code:code /home/code

ENV HOME=/home/code
USER code

COPY --from=0 --chown=code:code /tmp/code /usr/local/bin/code
COPY --chown=code:code run-once.sh /tmp/run-once.sh
RUN /tmp/run-once.sh && rm /tmp/run-once.sh

ENTRYPOINT [ "code" ]
CMD [ "serve-web", "--host", "0.0.0.0", "--without-connection-token", "--accept-server-license-terms" ]
