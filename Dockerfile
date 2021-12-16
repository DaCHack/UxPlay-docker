FROM alpine:latest
RUN apk update
RUN apk upgrade
RUN apk add --update openvpn openvpn-auth-pam bash
EXPOSE 1194/udp
CMD ["openvpn --config /etc/openvpn/server.conf"]
