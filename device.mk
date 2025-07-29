#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Dynamic Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Fastbootd
PRODUCT_PACKAGES += \
    fastbootd

# Overlays
PRODUCT_ENFORCE_RRO_TARGETS := *

# Project ID Quota
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Recovery
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/init.recovery.mt6765.rc:recovery/root/init.recovery.mt6765.rc

# Rootdir
PRODUCT_PACKAGES += \
    fstab.mt6765 \
    fstab.mt6765_ramdisk \
    init.mt6765.rc \
    init.mt6765.usb.rc \
    ueventd.mt6765.rc

# Shipping API level
PRODUCT_SHIPPING_API_LEVEL := 29

# Screen
TARGET_SCREEN_DENSITY := 226
TARGET_SCREEN_HEIGHT := 1280
TARGET_SCREEN_WIDTH := 800

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Inherit the proprietary files
$(call inherit-product, vendor/huawei/kobe2/kobe2-vendor.mk)
