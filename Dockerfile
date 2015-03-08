FROM python:2.7.9
MAINTAINER kb@socialmoon.com

RUN pip install -U docker-compose

# Uses docker-compose to create a multi-container deployment from app/docker-compose.yml
ADD ./app/ /app/

ENTRYPOINT ["/usr/local/bin/docker-compose"]

WORKDIR /app
