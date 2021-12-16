FROM alpine:latest
RUN apk add --no-cache openvpn openvpn-auth-pam bash
EXPOSE 1194/udp
