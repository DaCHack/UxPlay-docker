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
    container_name: "uxplay"
    tty: true
    restart: unless-stopped
    network_mode: "host"
    devices:
      - '/dev/fb0:/dev/fb0'
      - '/dev/snd:/dev/snd'
#      - '/dev/dri:/dev/dri'  Using the gpu's rendering device causes stuttering and error message:
#                             ** (gst-plugin-scanner:7): CRITICAL **: 22:30:24.832: _dma_fmt_to_dma_drm_fmts: assertion 'fmt != GST_VIDEO_FORMAT_UNKNOWN' failed

    volumes:
      - '/var/run/dbus:/var/run/dbus'
      - '/var/run/avahi-daemon/socket:/var/run/avahi-daemon/socket'
      - '/run:/run'
    # Tailor command based on UxPlay documentation
    command: 'uxplay -n Homeserver -nh -s 1920x1080 -dacp -nohold -vs "fbdevsink device=/dev/fb0" -as "alsasink device=plughw:1,3"'
```
