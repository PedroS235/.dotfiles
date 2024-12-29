#!/bin/bash

if lspci -k | grep -A 2 -E "(VGA|3D)" | grep -iq nvidia; then
    ISNVIDIA=true
else
    ISNVIDIA=false
fi

if [[ "$ISNVIDIA" == true ]]; then
    export LIBVA_DRIVER_NAME=nvidia
    export GBM_BACKEND=nvidia-drm
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export NVD_BACKEND=direct
fi
