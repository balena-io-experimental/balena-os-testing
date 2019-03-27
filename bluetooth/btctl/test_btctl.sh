#/bin/sh

DEVS=0
FAILED=0

export DBUS_SYSTEM_BUS_ADDRESS=unix:path=/host/run/dbus/system_bus_socket

/bin/bash ./$(dirname $0)/btctl_commands.sh | bluetoothctl | grep "Device"  > ./devices
DEVS=`wc -l ./devices | awk '{print $1}'`;
if [ $DEVS -le 1 ]; then
    FAILED=1;
else
    echo "Found devices:";
    cat ./devices;
    FAILED=0;
fi;

rm ./devices;

exit $FAILED;
