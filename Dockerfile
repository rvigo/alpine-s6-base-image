FROM alpine:3.10

ARG S6_OVERLAY_VERSION=3.0.0.2

RUN set -x && apk add --no-cache shadow curl coreutils tzdata && \
    mkdir -p /app /config /defaults && \
    addgroup -S abc && adduser -S -u 777 abc --disabled-password --gecos "" -G abc && \
    apk del --no-cache curl \
    apk del --purge \
    rm -rf /tmp/*

ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64-${S6_OVERLAY_VERSION}.tar.xz /tmp
RUN tar Jxpf /tmp/s6-overlay-x86_64-${S6_OVERLAY_VERSION}.tar.xz -C /
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch-${S6_OVERLAY_VERSION}.tar.xz /tmp
RUN tar Jxpf /tmp/s6-overlay-noarch-${S6_OVERLAY_VERSION}.tar.xz -C / 
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-symlinks-noarch-${S6_OVERLAY_VERSION}.tar.xz /tmp
RUN tar Jxpf /tmp/s6-overlay-symlinks-noarch-${S6_OVERLAY_VERSION}.tar.xz -C / 

ENV TZ="America/Sao_Paulo"
ENV PS1="$(whoami)@$(hostname):$(pwd)\\$ " \
    HOME="/root" \
    TERM="xterm"

COPY root /

ENTRYPOINT ["/init"]
