#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Audio
PRODUCT_PACKAGES += \
    android.hardware.audio@5.0 \
    android.hardware.audio@5.0-impl \
    android.hardware.audio.common@5.0 \
    android.hardware.audio.common@5.0-util \
    android.hardware.audio.effect@5.0 \
    android.hardware.audio.effect@5.0-impl \
    android.hardware.audio.service \
    android.hardware.bluetooth.audio@2.0-impl

PRODUCT_PACKAGES += \
    audio.a2dp.default \
    audio.bluetooth.default \
    audio.r_submix.default \
    audio.usb.default \
    audio_policy.stub

PRODUCT_PACKAGES += \
    libalsautils \
    libaudiopreprocessing \
    libnbaio_mono \
    libtinyalsa \
    libtinycompress \
    libtinyxml

PRODUCT_PACKAGES += \
    libmedia_helper-v29

PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/audio/,$(TARGET_COPY_OUT_VENDOR)/etc)

PRODUCT_COPY_FILES += \
    frameworks/av/services/audiopolicy/config/a2dp_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/a2dp_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/a2dp_in_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/a2dp_in_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/bluetooth_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/bluetooth_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usb_audio_policy_configuration.xml

# Binder
PRODUCT_PACKAGES += \
    android.hidl.allocator@1.0.vendor \
    android.hidl.memory@1.0.vendor

PRODUCT_PACKAGES += \
    libhidltransport \
    libhidltransport.vendor \
    libhwbinder.vendor \
    libhwbinder

# Bluetooth
PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.0-impl \
    android.hardware.bluetooth@1.0-service

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

# Gatekeeper
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-impl \
    android.hardware.gatekeeper@1.0-service

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

# Wi-Fi
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/wifi,$(TARGET_COPY_OUT_VENDOR)/etc/wifi)

PRODUCT_PACKAGES += \
    android.hardware.wifi@1.0.vendor \
    android.hardware.wifi@1.1.vendor \
    android.hardware.wifi@1.2.vendor \
    android.hardware.wifi@1.3.vendor \
    android.hardware.wifi.supplicant@1.0.vendor \
    android.hardware.wifi.supplicant@1.1.vendor \
    android.hardware.wifi.supplicant@1.2.vendor \
    android.hardware.wifi.hostapd@1.0.vendor \
    android.hardware.wifi.hostapd@1.1.vendor

# Inherit the proprietary files
$(call inherit-product, vendor/huawei/kobe2/kobe2-vendor.mk)
