#!/bin/bash

# Makes sure we exit if fails.
set -e

# The application you'd like to run
ping_super () {
    echo "Ping supervisor API"
  curl -X GET --header "Content-Type:application/json" \
    "$BALENA_SUPERVISOR_ADDRESS/ping?apikey=$BALENA_SUPERVISOR_API_KEY"
}

device () {
    echo "get device state from supervisor"
    curl -X GET --header "Content-Type:application/json" \
    "$BALENA_SUPERVISOR_ADDRESS/v1/device?apikey=$BALENA_SUPERVISOR_API_KEY" | jq .
}

state () {
    curl "$BALENA_SUPERVISOR_ADDRESS/v2/state/status?apikey=$RESIN_SUPERVISOR_API_KEY" | jq .
}

check_dbus () {
    DBUS_SYSTEM_BUS_ADDRESS=unix:path=/host/run/dbus/system_bus_socket \
    dbus-send \
    --system \
    --print-reply \
    --reply-timeout=2000 \
    --type=method_call \
    --dest=org.freedesktop.timedate1 \
    /org/freedesktop/timedate1  \
    org.freedesktop.DBus.Properties.GetAll \
    string:"org.freedesktop.timedate1"

### Check that it is true
    #    dict entry(
    #      string "NTPSynchronized"
    #      variant             boolean true
    #   )
}

(

    ping_super
    device
    #state
    check_dbus

)

# Don't exit the process
while true; do
    echo "Sleeping..."
    sleep 60
done