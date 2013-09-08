FROM ubuntu:12.04

MAINTAINER Marco Rucci "marco.rucci@gmail.com"

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get -y update
RUN apt-get -y install wget git python supervisor python-software-properties

RUN add-apt-repository ppa:chris-lea/node.js
RUN apt-get update
RUN apt-get install -y nodejs

RUN git clone git://github.com/etsy/statsd.git statsd
RUN mkdir -p /var/log/supervisor

RUN git clone git://github.com/mrucci/statsd-http-api.git statsd-http-api

ADD ./statsd-config.js ./statsd/config.js
ADD ./cubismino-web/ ./cubismino-web/
ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

## statsd server
EXPOSE  :8125/udp

## statsd http api
EXPOSE  :8127/tcp

## cubismino web app
EXPOSE  :8128/tcp

CMD ["supervisord", "-n"]

