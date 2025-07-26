#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

#
# boot.img
#
BOOT_DUMMY_RAMDISK := $(PRODUCT_OUT)/boot_dummy_ramdisk
BOOT_DUMMY_SECOND := $(PRODUCT_OUT)/boot_dummy_second

$(BOOT_DUMMY_RAMDISK):
	$(hide) echo "dummy" > $@

$(BOOT_DUMMY_SECOND):
	$(hide) echo "dummy" > $@

INTERNAL_CUSTOM_BOOTIMAGE_ARGS := \
	--base 0x40078000 \
	--pagesize 2048 \
	--kernel $(INSTALLED_KERNEL_TARGET) \
	--ramdisk $(BOOT_DUMMY_RAMDISK) \
	--second $(BOOT_DUMMY_SECOND) \
	--dtb $(INSTALLED_DTBIMAGE_TARGET) \
	--cmdline "bootopt=64S3,32N2,64N2 androidboot.selinux=permissive androidboot.init_fatal_reboot_target=recovery unmovable_isolate1=2:256M,3:312M,4:348M" \
	--kernel_offset 0x00008000 \
	--ramdisk_offset 0x11a88000 \
	--second_offset 0x00e88000 \
	--tags_offset 0x07808000 \
	--header_version 2

$(INSTALLED_BOOTIMAGE_TARGET): $(MKBOOTIMG) $(AVBTOOL) $(INTERNAL_BOOTIMAGE_FILES) $(BOOTIMAGE_EXTRA_DEPS) $(INSTALLED_KERNEL_TARGET) $(INSTALLED_DTBIMAGE_TARGET) $(BOOT_DUMMY_RAMDISK) $(BOOT_DUMMY_SECOND) $(INSTALLED_BOOTRAMDISKIMAGE_TARGET) $(INSTALLED_DTBOIMAGE_TARGET)
	$(call pretty,"Target boot image: $@")
	$(hide) $(MKBOOTIMG) $(INTERNAL_CUSTOM_BOOTIMAGE_ARGS) $(INTERNAL_MKBOOTIMG_VERSION_ARGS) $(BOARD_MKBOOTIMG_ARGS) --output $@
	$(hide) $(call assert-max-image-size,$@,$(BOARD_BOOTIMAGE_PARTITION_SIZE))
	$(hide) $(AVBTOOL) add_hash_footer \
		--image $@ \
		--partition_size $(BOARD_BOOTIMAGE_PARTITION_SIZE) \
		--partition_name boot $(INTERNAL_AVB_BOOT_SIGNING_ARGS) \
		$(BOARD_AVB_BOOT_ADD_HASH_FOOTER_ARGS)

#
# bootramdisk.img
#
INSTALLED_BOOTRAMDISKIMAGE_TARGET := $(PRODUCT_OUT)/boot_ramdisk.img
RAMDISK_DUMMY_KERNEL := $(PRODUCT_OUT)/bootramdisk_dummy_kernel
RAMDISK_DUMMY_SECOND := $(PRODUCT_OUT)/bootramdisk_dummy_second

$(RAMDISK_DUMMY_KERNEL):
	$(hide) echo "dummy" > $@

$(RAMDISK_DUMMY_SECOND):
	$(hide) echo "dummy" > $@

INTERNAL_CUSTOM_BOOTRAMDISKIMAGE_ARGS := \
	--kernel /dev/null \
	--ramdisk $(BUILT_RAMDISK_TARGET) \
	--second $(RAMDISK_DUMMY_SECOND) \
	--cmdline "buildvariant=user"

.PHONY: bootimage bootramdiskimage
bootimage: bootramdiskimage $(INSTALLED_BOOTIMAGE_TARGET)

bootramdiskimage: $(INSTALLED_BOOTRAMDISKIMAGE_TARGET)

$(INSTALLED_BOOTRAMDISKIMAGE_TARGET): $(MKBOOTIMG) $(AVBTOOL) $(BUILT_RAMDISK_TARGET) $(RAMDISK_DUMMY_KERNEL) $(RAMDISK_DUMMY_SECOND)
	$(call pretty,"Target bootramdisk image: $@")
	$(hide) $(MKBOOTIMG) $(INTERNAL_CUSTOM_BOOTRAMDISKIMAGE_ARGS) $(INTERNAL_MKBOOTIMG_VERSION_ARGS) --output $@
	$(hide) $(call assert-max-image-size,$@,$(BOARD_BOOTRAMDISKIMAGE_PARTITION_SIZE))
	$(hide) $(AVBTOOL) add_hash_footer \
		--image $@ \
		--partition_size $(BOARD_BOOTRAMDISKIMAGE_PARTITION_SIZE) \
		--partition_name boot $(INTERNAL_AVB_BOOT_SIGNING_ARGS) \
		$(BOARD_AVB_BOOT_ADD_HASH_FOOTER_ARGS)

INSTALLED_RADIOIMAGE_TARGET += $(INSTALLED_BOOTRAMDISKIMAGE_TARGET)

#
# recovery.img
#
INSTALLED_RECOVERYIMAGE_TARGET := $(PRODUCT_OUT)/recovery.img
INSTALLED_DTBOIMAGE_TARGET := $(PRODUCT_OUT)/dtbo.img
RECOVERY_KERNEL_DUMMY_RAMDISK := $(PRODUCT_OUT)/recovery_kernel_dummy_ramdisk
RECOVERY_KERNEL_DUMMY_SECOND := $(PRODUCT_OUT)/recovery_kernel_dummy_second

$(RECOVERY_KERNEL_DUMMY_RAMDISK):
	$(hide) echo "dummy" > $@

$(RECOVERY_KERNEL_DUMMY_SECOND):
	$(hide) echo "dummy" > $@

INTERNAL_CUSTOM_RECOVERYIMAGE_ARGS := \
	--base 0x40078000 \
	--pagesize 2048 \
	--kernel $(INSTALLED_KERNEL_TARGET) \
	--ramdisk $(RECOVERY_KERNEL_DUMMY_RAMDISK) \
	--second $(RECOVERY_KERNEL_DUMMY_SECOND) \
	--dtb $(INSTALLED_DTBIMAGE_TARGET) \
	--recovery_dtbo $(INSTALLED_DTBOIMAGE_TARGET) \
	--cmdline "bootopt=64S3,32N2,64N2 unmovable_isolate1=2:256M,3:312M,4:348M buildvariant=$(TARGET_BUILD_VARIANT)" \
	--kernel_offset 0x00008000 \
	--ramdisk_offset 0x11a88000 \
	--second_offset 0x00e88000 \
	--tags_offset 0x07808000 \
	--header_version 2

.PHONY: recoveryimage
recoveryimage: dtboimage recovery_ramdiskimage $(INSTALLED_RECOVERYIMAGE_TARGET)

$(INSTALLED_RECOVERYIMAGE_TARGET): $(MKBOOTIMG) $(AVBTOOL) $(recovery_ramdisk) $(INTERNAL_BOOTIMAGE_FILES) $(BOOTIMAGE_EXTRA_DEPS) $(INSTALLED_KERNEL_TARGET) $(INSTALLED_DTBIMAGE_TARGET) $(INSTALLED_DTBOIMAGE_TARGET) $(RECOVERY_KERNEL_DUMMY_RAMDISK) $(RECOVERY_KERNEL_DUMMY_SECOND)
	$(call pretty,"Target recovery image: $@")
	$(hide) $(MKBOOTIMG) $(INTERNAL_CUSTOM_RECOVERYIMAGE_ARGS) $(INTERNAL_MKBOOTIMG_VERSION_ARGS) --output $@
	$(hide) $(call assert-max-image-size,$@,$(BOARD_BOOTIMAGE_PARTITION_SIZE))
	$(hide) $(AVBTOOL) add_hash_footer \
		--image $@ \
		--partition_size $(BOARD_RECOVERYIMAGE_PARTITION_SIZE) \
		--partition_name recovery $(INTERNAL_AVB_RECOVERY_SIGNING_ARGS) \
		$(BOARD_AVB_RECOVERY_ADD_HASH_FOOTER_ARGS)

INSTALLED_RADIOIMAGE_TARGET += $(INSTALLED_RECOVERYIMAGE_TARGET)

#
# recovery_ramdisk.img
#
INSTALLED_RECOVERY_RAMDISKIMAGE_TARGET := $(PRODUCT_OUT)/recovery_ramdisk.img

INTERNAL_CUSTOM_RECOVERY_RAMDISKIMAGE_ARGS := \
	--base 0x80000000 \
	--pagesize 2048 \
	--kernel /dev/null \
	--ramdisk $(recovery_ramdisk) \
	--cmdline "slub_min_objects=12 unmovable_isolate1=2:192M,3:224M,4:256M buildvariant=$(TARGET_BUILD_VARIANT)" \
	--kernel_offset 0x00008000 \
	--ramdisk_offset 0x02000000 \
	--second_offset 0x00f00000 \
	--tags_offset 0x00000100 \
	--header_version 0

.PHONY: recovery_ramdiskimage
recovery_ramdiskimage: recoveryvendorimage $(INSTALLED_RECOVERY_RAMDISKIMAGE_TARGET)

$(INSTALLED_RECOVERY_RAMDISKIMAGE_TARGET): $(MKBOOTIMG) $(AVBTOOL) $(recovery_ramdisk) $(INSTALLED_RECOVERYIMAGE_TARGET) $(INSTALLED_RECVENDORIMAGE_TARGET)
	@echo "----- Making recovery ramdisk image ------"
	$(hide) $(MKBOOTIMG) $(INTERNAL_CUSTOM_RECOVERY_RAMDISKIMAGE_ARGS) $(INTERNAL_MKBOOTIMG_VERSION_ARGS) --output $@
	$(hide) $(call assert-max-image-size,$@,$(BOARD_RECRAMDISKIMAGE_PARTITION_SIZE))
	$(hide) $(AVBTOOL) add_hash_footer \
		--image $@ \
		--partition_size $(BOARD_RECRAMDISKIMAGE_PARTITION_SIZE) \
		--partition_name recovery $(INTERNAL_AVB_RECOVERY_SIGNING_ARGS) \
		$(BOARD_AVB_RECOVERY_ADD_HASH_FOOTER_ARGS)

INSTALLED_RADIOIMAGE_TARGET += $(INSTALLED_RECOVERY_RAMDISKIMAGE_TARGET)

#
# ramdisk-recovery_vendor.img
#
INSTALLED_RECVENDOR_RAMDISK_TARGET := $(PRODUCT_OUT)/ramdisk-recovery_vendor.img
INSTALLED_RECVENDOR_RAMDISK_PLACEHOLDER_TARGET := $(PRODUCT_OUT)/ramdisk-recovery_vendor

$(INSTALLED_RECVENDOR_RAMDISK_PLACEHOLDER_TARGET):
	$(hide) mkdir -p $@/vendor
	$(hide) touch $@/vendor/placeholder

$(INSTALLED_RECVENDOR_RAMDISK_TARGET): $(MKBOOTFS) $(MINIGZIP) $(INSTALLED_RECVENDOR_RAMDISK_PLACEHOLDER_TARGET)
	$(call pretty,"Target recovery_vendor ramdisk image: $@")
	$(hide) $(MKBOOTFS) -d $(PRODUCT_OUT) $(INSTALLED_RECVENDOR_RAMDISK_PLACEHOLDER_TARGET) | $(MINIGZIP) > $@

#
# recovery_vendor.img
#
INSTALLED_RECVENDORIMAGE_TARGET := $(PRODUCT_OUT)/recovery_vendor.img
INTERNAL_CUSTOM_RECVENDORIMAGE_ARGS := \
	--base 0x10078000 \
	--pagesize 2048 \
	--kernel /dev/null \
	--ramdisk $(INSTALLED_RECVENDOR_RAMDISK_TARGET) \
	--cmdline "buildvariant=$(TARGET_BUILD_VARIANT)" \
	--kernel_offset 0x00008000 \
	--ramdisk_offset 0x11a88000 \
	--second_offset 0x00e88000 \
	--tags_offset 0x07808000 \
	--header_version 0

.PHONY: recoveryvendorimage
recoveryvendorimage: $(INSTALLED_RECVENDORIMAGE_TARGET)

$(INSTALLED_RECVENDORIMAGE_TARGET): $(MKBOOTIMG) $(AVBTOOL) $(INSTALLED_RECVENDOR_RAMDISK_TARGET)
	$(call pretty,"Target recovery_vendor image: $@")
	$(hide) $(MKBOOTIMG) $(INTERNAL_CUSTOM_RECVENDORIMAGE_ARGS) $(INTERNAL_MKBOOTIMG_VERSION_ARGS) --output $@
	$(hide) $(call assert-max-image-size,$@,$(call get-hash-image-max-size,$(BOARD_RECVENDORIMAGE_PARTITION_SIZE)))
	$(hide) $(AVBTOOL) add_hash_footer \
		--image $@ \
		--partition_size $(BOARD_RECVENDORIMAGE_PARTITION_SIZE) \
		--partition_name recovery $(INTERNAL_AVB_RECOVERY_SIGNING_ARGS) \
		$(BOARD_AVB_RECOVERY_ADD_HASH_FOOTER_ARGS)

INSTALLED_RADIOIMAGE_TARGET += $(INSTALLED_RECVENDORIMAGE_TARGET)
