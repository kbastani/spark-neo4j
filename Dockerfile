FROM python:2.7.9
MAINTAINER kb@socialmoon.com

RUN pip install -U docker-compose

# Uses docker-compose to create a multi-container deployment from app/docker-compose.yml 
ADD ./app/ /app/
ENV DOCKER_HOST tcp://192.168.0.1:2376
ENV DOCKER_CERT_PATH /docker/cert
ENV DOCKER_TLS_VERIFY 1

ENTRYPOINT ["/usr/local/bin/docker-compose"]

WORKDIR /app
