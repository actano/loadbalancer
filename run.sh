#!/bin/bash
set -e

PIDFILE=/var/run/haproxy.pid
CONFIG=/etc/haproxy/haproxy.cfg

reload() {
    echo Reloading config

    if ! haproxy -c -f $CONFIG; then
        echo Invalid config, not reloading
        return 1
    fi

    haproxy -D -f $CONFIG -p $PIDFILE -sf $(cat $PIDFILE)
    echo haproxy reloaded
}

# check config
haproxy -c -f $CONFIG

haproxy -D -f $CONFIG -p $PIDFILE
echo haproxy started

# use SIGHUP for reloading haproxy config
trap reload SIGHUP

# exit endless loop on SIGTERM
trap "exit 0" SIGTERM

while true; do
    sleep infinity &
    wait || :
done
