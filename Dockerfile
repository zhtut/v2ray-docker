FROM docker.io/alpine:latest

# 4.32.1才支持xtls，更高的版本不支持了，所以我们就使用这个版本就行
ARG V2RAY_VERSION=4.32.1
ENV PATH=$PATH:/opt/v2ray

RUN wget -O v2ray-linux-64.zip https://github.com/v2fly/v2ray-core/releases/download/v${V2RAY_VERSION}/v2ray-linux-64.zip &&\
    unzip v2ray-linux-64.zip -d /opt/v2ray &&\
    rm -f v2ray-linux-64.zip &&\
    mkdir /etc/v2ray
RUN printf "#!/bin/sh \n\
    if [ ! -f /etc/v2ray/config.json ]; then \n  cp /opt/v2ray/config.json /etc/v2ray \nfi \n\
    v2ray -config=/etc/v2ray/config.json" > entrypoint.sh && chmod +x entrypoint.sh

CMD ./entrypoint.sh