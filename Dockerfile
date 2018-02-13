FROM ubuntu:16.04

MAINTAINER Open Sysytem Lab

ENV DEBIAN_FRONTEND noninteractive

# COPY repos/sources.list /etc/apt/sources.list

# setup pypy proxy
RUN mkdir ~/.pip && \
    echo '[global]' > ~/.pip/pip.conf && \
    echo 'extra-index-url = http://pypi-repo.cicd.stg.taco/simple/' >> ~/.pip/pip.conf && \
    echo 'trusted-host = pypi-repo.cicd.stg.taco' >> ~/.pip/pip.conf && \
    apt-get update && \
    apt-get install apt-transport-https ca-certificates curl software-properties-common -y && \
    apt-get install net-tools vim netcat iputils-ping -y && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable" && \
    apt-get install python-pip python-dev build-essential -y && \
    pip install --upgrade pip && \
    pip install pycrypto && \
    apt-get update

# setup label
LABEL org.label-schema.build-date="@BUILD_TIMESTAMP" \
      org.label-schema.build-id="@BUILD_ID" \
      org.label-schema.name="SKT Ubuntu Base Image" \
      org.label-schema.description="This service does awesome things with other things" \
      org.label-schema.url="http://oreo-devops.sktelecom.com" \
      org.label-schema.vcs-url="@VCS_URL" \
      org.label-schema.vcs-ref="@VCS_REF" \
      org.label-schema.vendor="SKT" \
      org.label-schema.version="phase2" \
      org.label-schema.schema-version="0.1" \
      org.label-schema.base-build-date="@BASE_BUILD_DATE" \
      org.label-schema.base-build-id="@BASE_BUILD_ID" \
      org.label-schema.base-name="@BASE_NAME"