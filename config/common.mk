PRODUCT_BRAND ?= purity

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

# general properties
PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.com.google.clientidbase=android-google \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.setupwizard.enterprise_mode=1 \
    ro.storage_manager.enabled=true \
    ro.opa.eligible_device=true \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent \
    ro.setupwizard.rotation_locked=true

# enable ADB authentication if not on eng build
ifneq ($(TARGET_BUILD_VARIANT),eng)
ADDITIONAL_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# Recommend using the non debug dexpreopter
USE_DEX2OAT_DEBUG := false

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/purity/prebuilt/bin/backuptool.sh:system/bin/backuptool.sh \
    vendor/purity/prebuilt/bin/backuptool.functions:system/bin/backuptool.functions \
    vendor/purity/prebuilt/bin/50-hosts.sh:system/addon.d/50-hosts.sh \
    vendor/purity/prebuilt/bin/blacklist:system/addon.d/blacklist

# Include hostapd configuration
PRODUCT_COPY_FILES += \
    vendor/purity/prebuilt/etc/hostapd/hostapd_default.conf:system/etc/hostapd/hostapd_default.conf \
    vendor/purity/prebuilt/etc/hostapd/hostapd.deny:system/etc/hostapd/hostapd.deny \
    vendor/purity/prebuilt/etc/hostapd/hostapd.accept:system/etc/hostapd/hostapd.accept

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/purity/prebuilt/etc/sysconfig/backup.xml:system/etc/sysconfig/backup.xml

# init.d support
PRODUCT_COPY_FILES += \
    vendor/purity/prebuilt/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/purity/prebuilt/bin/sysinit:system/bin/sysinit

# userinit support
PRODUCT_COPY_FILES += \
    vendor/purity/prebuilt/etc/init.d/90userinit:system/etc/init.d/90userinit

# Init script file with purity extras
PRODUCT_COPY_FILES += \
    vendor/purity/prebuilt/etc/init.local.rc:root/init.purity.rc

# Enable SIP and VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Custom off-mode charger
ifneq ($(WITH_CM_CHARGER),false)
PRODUCT_PACKAGES += \
    charger_res_images \
    cm_charger_res_images \
    font_log.png \
    libhealthd.cm
endif

# Include explicitly to work around Facelock issues
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full

# Thank you, please drive thru!
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.dun.override=0

# Bluetooth Audio (A2DP)
PRODUCT_PACKAGES += libbthost_if

# Additional packages
-include vendor/purity/config/packages.mk

# Versioning
-include vendor/purity/config/version.mk

# Add our overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/purity/overlay/common
