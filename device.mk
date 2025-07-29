#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Binder
PRODUCT_PACKAGES += \
    android.hidl.allocator@1.0.vendor \
    android.hidl.memory@1.0.vendor

PRODUCT_PACKAGES += \
    libhidltransport \
    libhidltransport.vendor \
    libhwbinder.vendor \
    libhwbinder

# Display
PRODUCT_PACKAGES += \
    android.hardware.graphics.allocator@2.0-impl \
    android.hardware.graphics.allocator@2.0-service \
    android.hardware.graphics.composer@2.1-service \
    android.hardware.graphics.mapper@2.0-impl \
    android.hardware.memtrack@1.0-service \
    android.hardware.memtrack@1.0-impl

PRODUCT_PACKAGES += \
    libdrm \
    libdrm.vendor \
    libion

PRODUCT_PACKAGES += \
    disable_configstore

# Dynamic Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Fastbootd
PRODUCT_PACKAGES += \
    fastbootd

# Keymaster
PRODUCT_PACKAGES += \
    libkeymaster3device.vendor \
    libkeystore-engine-wifi-hidl \
    libkeystore-wifi-hidl

# Logging
PRODUCT_PACKAGES += \
    libimonitor \
    libxcollie

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
    $(LOCAL_PATH) \
    hardware/huawei

# Inherit the proprietary files
$(call inherit-product, vendor/huawei/kobe2/kobe2-vendor.mk)
