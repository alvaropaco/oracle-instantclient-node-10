FROM node:10.15.1-alpine

LABEL version="1.0"
LABEL description="Oracle InstantClient with Node 10.15.0 and Linux Alpine"
LABEL maintainer="alvaropaconeto@gmail.com"

RUN apk add --update bash curl make gcc g++ python git binutils-gold gnupg unzip

ENV CLIENT_FILENAME instantclientlibs-linux.x64-12.1.0.1.0.tar.gz

COPY ./docker/oracle/${CLIENT_FILENAME} /usr/lib

RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.8/main" > /etc/apk/repositories && \
    echo "http://dl-cdn.alpinelinux.org/alpine/latest-stable/community" >> /etc/apk/repositories && \
    apk add --no-cache libaio libnsl git && \
    ln -s /usr/lib/libnsl.so.2 /usr/lib/libnsl.so.1 && \
    cd /usr/lib && \
    tar xf ${CLIENT_FILENAME} && \
    ln -s /usr/lib/libclntsh.so.12.1 /usr/lib/libclntsh.so && \
    rm ${CLIENT_FILENAME}

CMD [ "node", "--version" ]