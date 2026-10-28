#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Pixel apps that ship alongside the GMS payload.
# The GMS payload itself is inherited from config/partner_gms.mk.

ifeq ($(WITH_GMS),true)

# Pixel Sounds
$(call inherit-product-if-exists, vendor/pixel/sounds/products/sounds.mk)

# Pixel Launcher
$(call inherit-product-if-exists, vendor/pixel/launcher/products/launcher.mk)

# Pixel ThemePicker
$(call inherit-product-if-exists, vendor/pixel/themepicker/products/themepicker.mk)

endif
