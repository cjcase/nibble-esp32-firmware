#!/bin/bash
#
# Build Meshtastic firmware for target nibble_esp32
# ------------------------------------------------------
# Requirements: git, python3, python3-venv
#

# Variables
TARGET=nibble-esp32
WORKDIR=/tmp/nibble-fw

# Checkout Repos
TARGET_DIR=${WORKDIR}/firmware/variants/esp32s3/${TARGET}
git clone https://github.com/meshtastic/firmware.git ${WORKDIR}/firmware
git clone https://github.com/cjcase/nibble-esp32-firmware.git ${WORKDIR}/nibble-esp32-firmware

# Create and activate virtualenv
python -m venv ${WORKDIR}/runenv
source ${WORKDIR}/runenv/bin/activate

# Install PlatformIO on venv
pip install -U platformio

# Install platform for firmware
platformio platform install espressif32

# update nibble's variant.h and platformio.ini
cp --update=all ${WORKDIR}/nibble-esp32-firmware/variant.h ${TARGET_DIR}/variant.h
cp --update=all ${WORKDIR}/nibble-esp32-firmware/platformio.ini ${TARGET_DIR}/platformio.ini

# Build firmware
platformio run --project-dir ${WORKDIR}/firmware -e ${TARGET}

# Move firmware to working directory
mv ${WORKDIR}/firmware/.pio/build/*.bin ${WORKDIR}

# Output firmware's SHA256 digest
sha256sum ${WORKDIR}/*.bin
