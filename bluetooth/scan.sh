#!/bin/bash

FAILED=0

echo "Testing bluetooth. Make sure you have a bluetooth device enabled and visible."

# For Intel Edison use bluetoothctl
if [ "x$BALENA_DEVICE_TYPE" == "xintel-edison" ]; then
    /bin/bash ./btctl/test_btctl.sh;
    if [ $? -eq 0 ]; then
        echo "TEST PASSED"
    else
        echo "TEST FAILED"
    fi

    # Don't exit the process
    while true; do
        sleep 1
    done
fi;

hcitool dev

echo "Scan for nearby blueooth devices..."
mapfile -t scanresult < <(hcitool scan)
if [ ${#scanresult[@]} -le 1 ]; then
    FAILED=1
else
    echo "Found these devices:"
    for (( i=1; i<${#scanresult[@]}; i++ )); do
        echo ${scanresult[i]};
    done
    FAILED=0
fi

echo "Test finished. App configured to not exit. Restart the app if you want to retest."

# Test result
if [ $FAILED -eq 1 ]; then
    echo "TEST FAILED"
else
    echo "TEST PASSED"
fi

# Don't exit the process
while true; do
    echo "Sleeping..."
    sleep 10
done
