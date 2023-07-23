FROM alpine:latest
WORKDIR /
RUN apk update && apk upgrade && apk add --update openvpn openvpn-auth-pam bash tzdata openntpd
EXPOSE 1194/udp
ENV conf_file /etc/openvpn/server.conf
ENTRYPOINT openvpn $conf_file
