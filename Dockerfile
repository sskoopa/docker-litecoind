FROM alpine
LABEL MAINTAINER="Scott Sanders <scott@koopaworks.com>"

ARG LITECOIN_VERSION=0.17.1
ARG GLIBC_VERSION=2.29-r0

ENV FILENAME litecoin-${LITECOIN_VERSION}-x86_64-linux-gnu.tar.gz
ENV DOWNLOAD_URL https://download.litecoin.org/litecoin-${LITECOIN_VERSION}/linux/${FILENAME}

RUN apk update \
  && apk --no-cache add wget tar bash ca-certificates \
  && wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
  && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk \
  && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk \
  && apk --no-cache add glibc-${GLIBC_VERSION}.apk \
  && apk --no-cache add glibc-bin-${GLIBC_VERSION}.apk \
  && rm -rf /glibc-${GLIBC_VERSION}.apk \
  && rm -rf /glibc-bin-${GLIBC_VERSION}.apk \
  && wget $DOWNLOAD_URL \
  && tar xzvf /${FILENAME} \
  && mkdir /root/.litecoin \
  && mv /litecoin-${LITECOIN_VERSION}/bin/* /usr/local/bin/ \
  && rm -rf /litecoin-${LITECOIN_VERSION}/ \
  && rm -rf /${FILENAME} \
  && apk del tar wget ca-certificates

EXPOSE 9332 9333 19332 19333 29332 29333

ADD ./bin/docker_entrypoint.sh /usr/local/bin/docker_entrypoint.sh
RUN chmod a+x /usr/local/bin/docker_entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]
