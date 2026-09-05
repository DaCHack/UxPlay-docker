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

## When using with a TV or Set-top box UxPlay does not show full resolution?
You can force the right resolution also in case the HDMI connection is established only after boot (e.g. when using and rebooting the homeserver while the TV is off).
Edit your grub confing and do not forget `update-grub`:
```
GRUB_CMDLINE_LINUX_DEFAULT="drm_kms_helper.edid_firmware=edid/lgtv_c4.bin video=HDMI-A-2:1920x1080@60e,audio=on quiet"
```
Make sure to adapt the resolution to your monitor in this line as well as in the docker-compose below.
Be careful with HDMI-Matrices or HDMI-Ambilight-Boxes which might not be able to handle higher resolutions together with audio. They might block electronically in this case.

## I hear no sound
If the video works but you get no audio output through HDMI, structured troubleshooting on the host system usually solves the issue.

### 1. Verify Audio Hardware and IDs
Check if the host sees your playback devices and verify your card and device numbers:
```bash
aplay -l
```
Look for your HDMI output (e.g., `card 1: PCH ..., device 3: HDMI 0`). Ensure that the card and device numbers match the ALSA device specified in your `docker-compose.yml` command (`alsasink device=plughw:1,3`).

### 2. Disable Intel HDA Power Saving (Fix Hangar/Timeout)
Intel onboard audio controllers often aggressively cut power to HDMI outputs, leading to freezing handshakes, missing EDID audio data (`monitor_present 0`), or `azx_get_response timeout` errors.

Create or edit the ALSA base configuration file on your host:
```bash
sudo nano /etc/modprobe.d/alsa-base.conf
```
Add the following lines to disable audio power-saving entirely:
```text
options snd-hda-intel power_save=0 power_save_controller=N
```
Save the file and reboot your system.

### 3. Check for HDMI Bandwidth Limits
If you previously forced a 4K resolution (e.g., via `3840x2160@60e` in your GRUB config) while using an HDMI-Matrix or an Ambilight/Capture box, the video stream might consume all available bandwidth, causing the digital audio layer to drop entirely. 
* Reduce the forced resolution in your `/etc/default/grub` to `1920x1080@60e` to see if the sound returns.

### 4. Unmute S/PDIF Channels in ALSA Mixer
HDMI audio channels are often mapped as S/PDIF switches in the native ALSA layout and might be muted by default.
1. Run `alsamixer -c X` (replace `X` with your HDMI sound card number).
2. Use the arrow keys to scroll right to the **S/PDIF** or **S/PDIF 1** items.
3. If you see **`MM`** below a channel, press the **`M`** key to unmute it. It must toggle to **`00`**.


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
    command: 'uxplay -n Homeserver -nh -s 1920x1080 -vol 0.5 -dacp -nohold -vs "fbdevsink device=/dev/fb0" -as "alsasink device=plughw:1,3"'
```
