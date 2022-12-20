# Rosetta in Docker

### Make x86 containers on M1 devices run 20x faster with this one weird trick.

Patch copied from [rosetta-linux-asahi](https://github.com/CathyKMeow/rosetta-linux-asahi).

## How to?

```
./prepare.sh
docker build -t docker-rosetta2 .
docker run --name docker-rosetta2 --privileged -d --restart unless-stopped docker-rosetta2
```

This will unregister the default `qemu-x86_64` emulator and register Rosetta2 one.

### Verify

```
$ docker run --rm -it --platform=linux/amd64 alpine
/ # ps -a
PID   USER     TIME  COMMAND
    1 root      0:00 {sh} /bin/rosetta /bin/sh
    7 root      0:00 /bin/ps -a
```

Notice that `/bin/sh` is running under `/bin/rosetta` emulator.
