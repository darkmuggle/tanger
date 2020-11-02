# Tanger

Execute a containerized Tang Server

## Caveaut Emptor

These scripts are completely unsupported and have the usual "found it on Github support."

If you found this script because someone "official" passed this along, well, my condolences.

## Prior Art

A collegue publishes [Tang in a Container](quay.io/mike_nguyen/tang), which is used for FCOS testing and development. This solution, however, does not work in OCP.

## Use socat instead of xinetd

xinetd is great fun, but really, in a container? This uses socat instead.

When I was trying to use [Tang's xinetd unit](https://github.com/latchset/tang/blob/master/units/tangd.xinetd) I hit two problems:

1. `xinetd` wants a proper `/etc/service` entry or it needs `type = UNLISTED`.
1. Running it in podman was really inconsistent with curl http0.9 errors.

# To Use:

1. Use the pre-built container `quay.io/behoward/tanger:latest`
1. Build your own:
```
git clone github.com/darkmuggle/tanger
cd tanger
make
```


## Example:

```
podman volume create tang
podman run --rm --detach -v tang:/var/db/tang -p 8180:80 quay.io/behoward/tanger
```

The keys will be stored in the `tang` volume.

## Change port
```
podman volume create tang
podman run --rm --detach -e PORT=8180 -v tang:/var/db/tang -p 8180:8180 quay.io/behoward/tanger
```

## Creating new keys
You can create or cycle the keys by running:
```
podman run --rm -it -v tang:/var/db/tang quay.io/behoward/tanger /usr/libexec/tangd-keygen /var/db/tang
podman run --rm -it -v tang:/var/db/tang quay.io/behoward/tanger /usr/libexec/tangd-update /var/db/tang /var/cache/tang
```


