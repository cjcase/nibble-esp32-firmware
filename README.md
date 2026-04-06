# nibble-esp32-firmware
Automatic Meshtastic firmware build for Retia's 38C3 Nibble (esp32-s3-zero + rfm95)

## Quick-Start

Latest Meshtastic firmware build: [firmware-nibble-esp32-2.7.20.016e68e.bin](https://github.com/cjcase/nibble-esp32-firmware/releases/download/nibble-esp32-v2.7.20.6658ec2/firmware-nibble-esp32-2.7.20.016e68e.bin)

You can grab the latest Meshtastic development firmware build from [this repo's release page](https://github.com/cjcase/nibble-esp32-firmware/releases) and flash it with [Retia's Nugget Flasher](https://nugget.dev).

If you rather build yourself, a build script has been provided for linux environments.
Requirements: `bash`, `git`, `python3`, `python3-venv`

1. Clone this repository
2. Make build.sh executable
3. Run build.sh
4. Flash `firmware-nibble-esp32-VERSION.bin` with [Retia's Nugget Web Flasher](https://nugget.dev)

## Linux Troubleshooting

If you get a "permission error" or "interface not found" error while trying to flash the Nibble, the most likely issue is missing udev rules.  
[You can read a comprehensive guide on udev rules here](https://wiki.archlinux.org/title/Udev#Introduction_to_udev_rules).  
For a quick fix follow this:

1. Create a new udev rule file for esp32 in `/etc/udev/rules.d/99-esp32.rules` with the following content:
```udev
#esp32-s3
SUBSYSTEMS=="usb", ATTRS{idVendor}=="303a", ATTRS{idProduct}=="1001", ATTRS{manufacturer}=="Espressif *", TAG+="uaccess", MODE="0660"
```

2. Reload udev rules 
```
$ sudo udevadm control --reload-rules
$ sudo udevadm trigger
```

3. Finally, follow the web flashing instructions in the "Software" section [from here.](https://retia.io/blogs/news/how-to-make-a-nibble-simple-cutie-meshtastic-node-for-c3)

## Disclaimer

This is just a personal convenience repository dedicated to automated working builds of Meshtastic firmware for Retia's 38C3 version of their Nibble node (esp32s3 + rfm95).

The original code and schematics can be found in the following links:
* https://github.com/RetiaLLC/Nibble
* https://retia.io/blogs/news/how-to-make-a-nibble-simple-cutie-meshtastic-node-for-c3
* https://github.com/skickar/retia-boards
* https://github.com/meshtastic/firmware/tree/develop/variants/esp32s3/nibble_esp32
