# Cubismino

A minimalistic and volatile [statsd][statsd] stack to collect and visualize metrics using [cubism][cubism].

## Usage

Run it with docker:

    sudo docker build -t username/cubismino .
    sudo docker run username/cubismino

Send some data to statsd:

    while true; do echo -n "."; echo "client.random:$RANDOM|ms" | nc -u localhost -w1 -q1 8125; sleep 1; done;

Visit `http://localhost:8128`.


[statsd]: https://github.com/etsy/statsd
[cubism]: https://github.com/square/cubism

