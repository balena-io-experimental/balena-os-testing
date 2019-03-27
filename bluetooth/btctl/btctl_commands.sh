#!/bin/bash

# This script contains commands
# for bluetoothctl tool

echo -e 'power on\n'
sleep 2
echo -e 'agent on\n'
echo -e 'default-agent\n'
echo -e 'scan on\n'
sleep 10
echo -e 'scan off\n'
sleep 2
echo -e 'devices\n'
sleep 1;
echo -e 'quit\n'
