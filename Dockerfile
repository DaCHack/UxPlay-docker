FROM debian:testing-slim

ENV DEBIAN_FRONTEND="noninteractive" TZ=Europe/UTC    

RUN apt-get update -yy && \
    apt-get install -yy libssl-dev libplist-dev && \
    apt-get install -yy libavahi-compat-libdnssd-dev && \
    apt-get install -yy libgstreamer1.0 libgstreamer-plugins-base1.0 gstreamer1.0-libav gstreamer1.0-plugins-bad gstreamer1.0-plugins-good gstreamer1.0-alsa && \
    apt-get install -yy uxplay && \
    rm -rf /var/lib/apt/lists/*

# hardware-accelerated Intel graphics, but not NVIDIA
#RUN apt-get install -yy gstreamer1.0-vaapi

CMD uxplay -n Homeserver -nh -s 1920x1080 -nohold -vs "fbdevsink device=/dev/fb0" -as "alsasink device=plughw:1,0"
