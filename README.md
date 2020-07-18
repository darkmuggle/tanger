# Tanger

Execute a containerized Tang Server

## Use socat instead of xinetd

xinetd is great fun, but really, in a container? This uses socat instead.

## Example:

```
podman volume create tang
podman run --rm --detach -v tang:/var/db/tang -p 8180:80 muggle.dev/tanger
```

The keys will be stored in the tang volume
