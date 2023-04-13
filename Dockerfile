FROM postgres:14.7-alpine

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive

RUN apk add --no-cache \
  coreutils \
  python3 \
  py3-pip

RUN python3 -m pip install --upgrade pip \
  && python3 -m pip install awscli

