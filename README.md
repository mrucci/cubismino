# Cubismino

A minimalistic and volatile [statsd][statsd] stack to collect and visualize metrics using [cubism][cubism].

## Architecture

    [statsd-client*] -> [cubismino host] <- [cubismino-client*]

There are three parties involved:

 * the statsd clients
 * the cubismino host (e.g. the machine that runs the container)
 * the cubismino web ui clients (e.g. the web browsers)

On the cubismino host there are three services running:

 * the statsd-server that receives metrics from its statsd-clients
 * the statsd-http-server that exposes the metrics received from the statsd server
 * the cubismino-web frontend server

Reaching the cubismino-web frontend endpoint, the client is served an html+javascript web page from the cubismino-web frontend server (a static python http server).

The browser than contacts the statsd-http-server with a `GET /` request to obtain a list of available metrics.

For each of the available metrics, the frontend builds a [cubism Metric object][cubism-metric] that polls the statsd-http-server for new values and populates the pretty horizon graphs.

## Usage

Run it with docker:

    sudo docker pull ubuntu:14.04
    sudo docker build -t username/cubismino .
    sudo docker run --rm -p 8125:8125/udp -p 8127:8127 -p 8128:8128 username/cubismino


Send some data to statsd:

    while true; do echo -n "."; echo "client.random:$RANDOM|ms" | nc -u localhost -w1 -q1 8125; sleep 1; done;

Visit `http://localhost:8128`.


[statsd]: https://github.com/etsy/statsd
[cubism]: https://github.com/square/cubism
[cubism-metric]: https://github.com/square/cubism/wiki/Context#metric

