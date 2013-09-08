{
  port: 8125
, deleteIdleStats: true
, backends: [ "/statsd-http-api/statsd-http-api" ]
, debug: true
, dumpMessages: true
, percentThreshold: [50, 90, 99]
, flush_counts: false
}
