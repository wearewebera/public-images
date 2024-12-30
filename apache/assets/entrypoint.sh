#!/bin/bash

function sigterm() {
    echo "[ENTRYPOINT] SIGTERM signal received..."
    /usr/sbin/apachectl -k graceful-stop
    echo "[ENTRYPOINT] Exited."
    exit 0
}

trap sigterm SIGTERM

echo '[ENTRYPOINT] Start Apache and wating for SIGTERM signal...'
/usr/sbin/apache2ctl -D FOREGROUND &
wait
