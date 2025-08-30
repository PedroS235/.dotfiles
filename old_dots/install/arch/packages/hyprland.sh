#!/bin/bash

# Hyprland
sudo pacman -S --noconfirm --needed hyprland hyprutils hypridle hyprpaper hyprlock \
    xdg-desktop-portal-hyprland polkit-gnome wofi wl-clipboard cliphist \
    pipewire wireplumber qt5-wayland qt6-wayland udiskie hyprpolkitagent

# Bars
sudo pacman -S --noconfirm --needed waybar python-dbus


# Check if Nvidia GPU is available
if lspci -k | grep -A 2 -E "NVIDIA" >/dev/null; then
    sudo pacman -S --noconfirm --needed nvidia-dkms nvidia-utils lib32-nvidia-utils egl-wayland

    # Path to the mkinitcpio.conf file
    MKINITCPIO_CONF="/etc/mkinitcpio.conf"

    # Modules to add
    NVIDIA_MODULES=("nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm")

    updated=0

    # Check if the MODULES line exists
    if grep -q "^MODULES=" "$MKINITCPIO_CONF"; then
        # If MODULES line exists, append the NVIDIA modules
        for module in "${NVIDIA_MODULES[@]}"; do
            if ! grep -q "$module" "$MKINITCPIO_CONF"; then
                sed -i "/^MODULES=(/ s/)/ $module)/" "$MKINITCPIO_CONF"
                updated=1
            fi
        done
    else
        # If MODULES line doesn't exist, add it with the NVIDIA modules
        echo "MODULES=(${NVIDIA_MODULES[@]})" >> "$MKINITCPIO_CONF"
    fi

    if [ ! -f /etc/modprobe.d/nvidia.conf ]; then
        sudo touch /etc/modprobe.d/nvidia.conf
        echo "options nvidia_drm modeset=1 fbdev=1 NVreg_PreserveVideoMemoryAllocations=1" | sudo tee -a /etc/modprobe.d/nvidia.conf >/dev/null
    fi

    if [ updated -eq 1]; then
        log_warn "UPDATED $update"
        sudo mkinitcpio -P
    fi
fi
