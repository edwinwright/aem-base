#!/bin/sh

function aem_started {
  PORT=${1:-4502}
  printf "Checking AEM on port $PORT "
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
