FROM alpine:latest
WORKDIR /
RUN apk update && apk upgrade && apk add --update openvpn openvpn-auth-pam bash
EXPOSE 1194/udp
ENTRYPOINT ["openvpn", "--config /etc/openvpn/server.conf"]
