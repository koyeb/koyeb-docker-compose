#!/bin/sh

set -e

# Run docker daemon
/usr/local/bin/dockerd-entrypoint.sh --tls=false > /tmp/docker.log 2>&1 &

echo "Waiting for docker daemon to start..." >&2

i=0
while true;
do
    test -S /var/run/docker.sock && echo "ok!" >&2 && break
    echo ... >&2
    sleep .5
    i=$((i+1))

    if [ $i -gt 60 ];
    then
    echo === Unable to start docker daemon === >&2
    cat /tmp/docker.log >&2
    echo "====================================" >&2
    echo "Unable to start docker daemon. Make sure your service has the privileged flag set." >&2
    exit 1
    fi
done

exec "$@"