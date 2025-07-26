#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from device makefile.
$(call inherit-product, device/huawei/kobe2/device.mk)

# Inherit some common LineageOS stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

PRODUCT_NAME := lineage_kobe2
PRODUCT_DEVICE := kobe2
PRODUCT_MANUFACTURER := HUAWEI
PRODUCT_BRAND := HUAWEI
PRODUCT_MODEL := Huawei Matepad T8

PRODUCT_GMS_CLIENTID_BASE := android-huawei
