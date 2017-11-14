FROM anapsix/alpine-java:8_jdk
MAINTAINER Marcin Podlodowski <marcin@podlodowski.it>
ARG GRADLE_VERSION=4.2.1

ENV \
    BUILD_DEPS="gettext"  \
    RUNTIME_DEPS="libintl py-pip tar bash docker unzip curl"

RUN \
    apk add --no-cache $RUNTIME_DEPS && \
    apk add --no-cache --virtual build_deps $BUILD_DEPS &&  \
    cp /usr/bin/envsubst /usr/local/bin/envsubst && \
    apk del build_deps

RUN pip install 'docker-compose==1.16.1'

WORKDIR /usr/bin

RUN \
  curl -sLO https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-all.zip && \
  unzip gradle-${GRADLE_VERSION}-all.zip && \
  ln -s gradle-${GRADLE_VERSION} gradle && \
  rm gradle-${GRADLE_VERSION}-all.zip

ENV GRADLE_HOME /usr/bin/gradle
ENV PATH $PATH:$GRADLE_HOME/bin

RUN mkdir /app
WORKDIR /app
