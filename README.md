# UxPlay-docker
[![docker-hub Actions Status](https://github.com/dachack/uxplay-docker/workflows/docker-hub/badge.svg)](https://github.com/dachack/uxplay-docker/actions)

Run [UxPlay](https://github.com/FDH2/UxPlay) on latest Debian:Testing in Docker
Thanks to the great community around UxPlay for this tool! This repo is just a wrapper to provide a docker container.

## Image on Docker Hub
https://hub.docker.com/r/dachack/uxplay

## Sources in Github
https://github.com/DaCHack/uxplay-docker

## Host Requirements
- Avahi daemon installed on host

## Docker-compose
```
services:
  uxplay:
    image: dachack/uxplay
    container_name: "uxplay" # choose any name you like
    stdin_open: true # docker run -i
    tty: true        # docker run -t
    restart: unless-stopped # always restart in case of issues or system reboot
    network_mode: "host"
    devices:
      - '/dev/fb0:/dev/fb0'
      - '/dev/dri:/dev/dri'
    volumes:
      - '/var/run/dbus:/var/run/dbus'
      - '/var/run/avahi-daemon/socket:/var/run/avahi-daemon/socket'
      - '/run:/run'
    command: 'uxplay -n Homeserver -nh -s 1280x1024 -nohold -vs "fbdevsink device=/dev/fb0" -as "alsasink device=plughw:1,0"'  # Command can be tailored based on uxplay documentation
```
