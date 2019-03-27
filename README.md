TODO:

- runtime-intefaces:
    - parse output a bit better
    - catch failures
    - Expand to test other interfaces.
- site:
    - Expand on how to use the "locks funtionality during testing"
    - add ability to enable proxy from deviceURL with a specific server IP.
- new tests to add:
    - add wifi-connect, so this can be preloaded and pinned.

## Enable Proxy at runtime:
```
curl -X PATCH --header "Content-Type:application/json" \
    --data '{"network":{"proxy":{"type":"socks5","ip":"192.168.1.37","port":"8123"},"hostname":"shaun"}}' \
    "$BALENA_SUPERVISOR_ADDRESS/v1/device/host-config?apikey=$BALENA_SUPERVISOR_API_KEY"
```

## Reset proxy:
Do the following from the hostOS:
```
rm -rf /mnt/boot/system-proxy/ && reboot
```