FROM ubuntu:14.04

MAINTAINER Marco Rucci "marco.rucci@gmail.com"

RUN apt-get -y update
RUN apt-get -y install wget git python supervisor nodejs

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

## cubismino web ui
## Note: this needs to match port in the python server started by supervisord
EXPOSE  :8128/tcp

CMD ["supervisord", "-n"]

