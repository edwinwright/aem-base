#!/bin/sh

function aem_started {
  PORT=${1:-4502}
  printf "Checking AEM on port $PORT"
  until [ "`curl --silent --head --fail --noproxy localhost --connect-timeout 1 http://admin:admin@localhost:$PORT/index.html | grep '302'`" != "" ]; do
    printf ".";
    sleep 5
  done
  printf "\n"
  echo "AEM started"
}

function watch_log {
  PATTERN=$1
  echo "Watching log for /$PATTERN/"
  LOG_FILE=/opt/aem/crx-quickstart/logs/error.log
  touch $LOG_FILE
  tail -n100 -f $LOG_FILE | sed "/$PATTERN/q" > /dev/null
  echo "Log entry found"
}

function log_settled {
  INTERVAL=${1:-15}
  printf "Waiting for log to settle"
  LOG_FILE=/opt/aem/crx-quickstart/logs/error.log
  touch $LOG_FILE
  LOG_LINES=$(cat $LOG_FILE | wc -l)
  while true; do
    sleep $INTERVAL
    LINE_COUNT=$(cat $LOG_FILE | wc -l)
    [[ $LINE_COUNT -eq $LOG_LINES ]] && break
    printf "."
    LOG_LINES=$LINE_COUNT
  done
  printf "\n"
  echo "Log settled"
}
