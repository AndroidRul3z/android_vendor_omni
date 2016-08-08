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
    ro.opa.eligible_device=true
    persist.sys.root_access=1

# enable ADB authentication if not on eng build
ifneq ($(TARGET_BUILD_VARIANT),eng)
ADDITIONAL_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/purity/prebuilt/bin/backuptool.sh:system/bin/backuptool.sh \
    vendor/purity/prebuilt/bin/backuptool.functions:system/bin/backuptool.functions \
    vendor/purity/prebuilt/bin/50-hosts.sh:system/addon.d/50-hosts.sh \
    vendor/purity/prebuilt/bin/blacklist:system/addon.d/blacklist

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

# custom sounds
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.ringtone=omni_ringtone1.ogg \
    ro.config.notification_sound=omni_notification1.ogg \
    ro.config.alarm_alert=omni_alarm1.ogg

# Custom off-mode charger
ifneq ($(WITH_CM_CHARGER),false)
PRODUCT_PACKAGES += \
    charger_res_images \
    cm_charger_res_images \
    font_log.png \
    libhealthd.cm
endif

PRODUCT_COPY_FILES += \
    vendor/purity/prebuilt/sounds/camera_click_48k.ogg:system/media/audio/ui/camera_click.ogg \
    vendor/purity/prebuilt/sounds/VideoRecord_48k.ogg:system/media/audio/ui/VideoRecord.ogg \
    vendor/purity/prebuilt/sounds/VideoStop_48k.ogg:system/media/audio/ui/VideoStop.ogg \
    vendor/purity/prebuilt/sounds/omni_ringtone1.ogg:system/media/audio/ringtones/omni_ringtone1.ogg \
    vendor/purity/prebuilt/sounds/omni_ringtone2.ogg:system/media/audio/ringtones/omni_ringtone2.ogg \
    vendor/purity/prebuilt/sounds/omni_ringtone3.ogg:system/media/audio/ringtones/omni_ringtone3.ogg \
    vendor/purity/prebuilt/sounds/omni_alarm1.ogg:system/media/audio/alarms/omni_alarm1.ogg \
    vendor/purity/prebuilt/sounds/omni_alarm2.ogg:system/media/audio/alarms/omni_alarm2.ogg \
    vendor/purity/prebuilt/sounds/omni_notification1.ogg:system/media/audio/notifications/omni_notification1.ogg \
    vendor/purity/prebuilt/sounds/omni_lowbattery1.ogg:system/media/audio/ui/omni_lowbattery1.ogg \
    vendor/purity/prebuilt/sounds/omni_lock_phone.ogg:system/media/audio/ui/omni_lock_phone.ogg \
    vendor/purity/prebuilt/sounds/omni_unlock_phone.ogg:system/media/audio/ui/omni_unlock_phone.ogg

# Additional packages
-include vendor/purity/config/packages.mk

# Versioning
-include vendor/purity/config/version.mk

# Add our overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/purity/overlay/common

# Enable dexpreopt for all nightlies
ifeq ($(ROM_BUILDTYPE),NIGHTLY)
    ifeq ($(WITH_DEXPREOPT),)
        WITH_DEXPREOPT := true
    endif
endif
# and weeklies
ifeq ($(ROM_BUILDTYPE),WEEKLY)
    ifeq ($(WITH_DEXPREOPT),)
        WITH_DEXPREOPT := true
    endif
endif
# and security releases
ifeq ($(ROM_BUILDTYPE),SECURITY_RELEASE)
    ifeq ($(WITH_DEXPREOPT),)
        WITH_DEXPREOPT := true
    endif
endif
# but not homemades
ifeq ($(ROM_BUILDTYPE),HOMEMADE)
    WITH_DEXPREOPT := true
endif
