#!/bin/sh

function aemStarted {
    # TODO: Add a default value of CQ_PORT=4502 if no arg passed
    # if [ "$1" ]; then
    #     printf "Checking AEM on port ${1} "
    # fi
    CQ_PORT="$1"

    printf "Checking AEM on port $CQ_PORT "
    until [ "`curl --silent --head --fail --noproxy localhost --connect-timeout 1 http://admin:admin@localhost:$CQ_PORT/index.html | grep '302'`" != "" ]; do
        printf ".";
        sleep 5
    done
    printf "\n"
    printf "AEM started\n"
}
