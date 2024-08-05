# UxPlay-docker
[![docker-hub Actions Status](https://github.com/dachack/uxplay-docker/workflows/docker-hub/badge.svg)](https://github.com/dachack/uxplay-docker/actions)

Run UxPlay on latest Debian in Docker

## Image on Docker Hub
https://hub.docker.com/r/dachack/uxplay

## Sources in Github
https://github.com/DaCHack/uxplay-docker

## Docker-compose
```
  uxplay:
    image: dachack/uxplay
    container_name: "uxplay" # choose any name you like
    stdin_open: true # docker run -i
    tty: true        # docker run -t
    restart: unless-stopped # always restart in case of issues or system reboot
    network_mode: "host"
    devices:
      - '/dev/fb0:/dev/fb0'
      - '/dev/fb1:/dev/fb1'
```
