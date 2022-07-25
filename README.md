# openvpn-docker
[![docker-hub Actions Status](https://github.com/dachack/openvpn-docker/workflows/docker-hub/badge.svg)](https://github.com/dachack/openvpn-docker/actions)

Run openvpn on latest Alpine in Docker

## About
If you simply want to use OpenVPN in a Docker container without additional bloat I found it hard to find something suitable and decided to build this workflow. Nothing special and a very naive, simplistic approach. Please let me know in case I missed something important.
* Provide existing OpenVPN config folder as volume or create a new one based on [OpenVPN Reference](https://openvpn.net/community-resources/reference-manual-for-openvpn-2-4/)
* Provide existing certificate as volume, e.g. included in OpenVPN config folder (be careful with permissions!) and link in .conf-File
* Run this container that utilizes minimalistic, yet up-to-date software (OS and OpenVPN-package), e.g. by using Portainer and/or the Docker-Compose below
* Use Watchtower to regularly update the base image for your container

## Image on Docker Hub
https://hub.docker.com/r/dachack/openvpn

## Sources in Github
https://github.com/DaCHack/openvpn-docker

## Docker-compose
```
  openvpn:
    image: dachack/openvpn
    container_name: "openvpn" # choose any name you like
    stdin_open: true # docker run -i
    tty: true        # docker run -t
    restart: unless-stopped # always restart in case of issues or system reboot
    network_mode: "host" # as far as I read OpenVPN requires host network 
    ports:
      - 1194:1194/udp
    volumes:
      - '/root/containers/openvpn:/etc/openvpn' # use your existing config here or create a new one based on OpenVPN config reference
      - '/root/containers/openvpn/etc/passwd:/etc/passwd' # if using PAM auth simply use the users on the host for VPN login by linking/copying passwd and shadow files or create custom files based on the Alpine template
      - '/root/containers/openvpn/etc/shadow:/etc/shadow' # see above
    devices:
      - '/dev/net/tun:/dev/net/tun' # Give permission to use the tunnel device of the host
    cap_add:
      - NET_ADMIN # as far as I read OpenVPN requires the capability
```
