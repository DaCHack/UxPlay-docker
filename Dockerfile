FROM debian:testing

ENV DEBIAN_FRONTEND="noninteractive" TZ=Europe/UTC    

RUN apt-get update -yy

RUN apt-get install -yy libssl-dev libplist-dev 
RUN apt-get install -yy libavahi-compat-libdnssd-dev 
RUN apt-get install -yy libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev gstreamer1.0-libav gstreamer1.0-plugins-bad gstreamer1.0-plugins-good gstreamer1.0-alsa
RUN apt-get install -yy uxplay 

# hardware-accelerated Intel graphics, but not NVIDIA
#RUN apt-get install -yy gstreamer1.0-vaapi

CMD uxplay -n Homeserver -nh -s 1280x1024 -nohold -vs "fbdevsink device=/dev/fb1" -as "alsasink device=plughw:1,0"
