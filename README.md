TODO:

- runtime-intefaces:
    - catch failures
- new tests to add:
    - add wifi-connect, so this can be preloaded and pinned.
    - add bluetooth testing with envar to enable.
    - test healthcheck and deviceURL: https://github.com/balena-io-playground/healthcheck-publicurl



## Enable Proxy:

curl -X PATCH --header "Content-Type:application/json" \
    --data '{"network":{"proxy":{"type":"socks5","ip":"192.168.1.37","port":"8123"},"hostname":"shaun"}}' \
    "$BALENA_SUPERVISOR_ADDRESS/v1/device/host-config?apikey=$BALENA_SUPERVISOR_API_KEY"

## Reset:
rm -rf /mnt/boot/system-proxy/ && reboot
