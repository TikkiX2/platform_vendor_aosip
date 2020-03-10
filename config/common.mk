PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    dalvik.vm.debug.alloc=0 \
    keyguard.no_require_sim=true \
    media.recorder.show_manufacturer_and_model=true \
    net.tethering.noprovisioning=true \
    persist.sys.disable_rescue=true \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent \
    ro.carrier=unknown \
    ro.com.android.dataroaming=false \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.config.bt_sco_vol_steps=30 \
    ro.config.media_vol_steps=30 \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.opa.eligible_device=true \
    ro.setupwizard.enterprise_mode=1 \
    ro.storage_manager.enabled=true \
    ro.com.google.ime.bs_theme=true \
    ro.com.google.ime.theme_id=5 \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html

ifeq ($(DERP_BUILD_ZIP_TYPE), VANILLA)
PRODUCT_PACKAGES += \
    libjni_latinimegoogle
endif

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/aosip/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/aosip/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/aosip/prebuilt/common/bin/50-base.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/50-base.sh \
    vendor/aosip/prebuilt/common/bin/blacklist:$(TARGET_COPY_OUT_SYSTEM)/addon.d/blacklist

ifneq ($(AB_OTA_PARTITIONS),)
PRODUCT_COPY_FILES += \
    vendor/aosip/prebuilt/common/bin/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    vendor/aosip/prebuilt/common/bin/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    vendor/aosip/prebuilt/common/bin/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh
endif

# Offline charger
PRODUCT_PACKAGES += \
    charger_res_images \
    product_charger_res_images

# Configs
PRODUCT_COPY_FILES += \
    vendor/aosip/prebuilt/common/etc/sysconfig/aosip-power-whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/aosip-power-whitelist.xml \
    vendor/aosip/prebuilt/common/etc/sysconfig/dialer_experience.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/dialer_experience.xml \
    vendor/aosip/prebuilt/common/etc/sysconfig/turbo.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/turbo.xml

# Copy all AOSiP-specific init rc files
$(foreach f,$(wildcard vendor/aosip/prebuilt/common/etc/init/*.rc),\
	$(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_SYSTEM)/etc/init/$(notdir $f)))

# Don't compile SystemUITests
EXCLUDE_SYSTEMUI_TESTS := true

# Don't include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Permissions
PRODUCT_COPY_FILES += \
    vendor/aosip/prebuilt/common/etc/permissions/privapp-permissions-aosip-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-aosip.xml \
    vendor/aosip/prebuilt/common/etc/permissions/privapp-permissions-aosip.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-aosip.xml \
    vendor/aosip/prebuilt/common/etc/permissions/privapp-permissions-elgoog.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-elgoog.xml

# Lawnchair
ifeq ($(LAWNCHAIR_OPTOUT),)
PRODUCT_COPY_FILES += \
    vendor/aosip/prebuilt/common/etc/permissions/privapp-permissions-lawnchair.xml:system/etc/permissions/privapp-permissions-lawnchair.xml \
    vendor/aosip/prebuilt/common/etc/sysconfig/lawnchair-hiddenapi-package-whitelist.xml:system/etc/sysconfig/lawnchair-hiddenapi-package-whitelist.xml
endif

PRODUCT_PROPERTY_OVERRIDES += \
    ro.boot.vendor.overlay.theme=com.potato.overlay.lawnconf

# Lawnchair Default Configuration
ifeq ($(LAWNCHAIR_OPTOUT),)
PRODUCT_PACKAGES += \
    LawnConf
endif

# Enable Android Beam on all targets
PRODUCT_COPY_FILES += \
    vendor/aosip/prebuilt/common/etc/permissions/android.software.nfc.beam.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.nfc.beam.xml

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Include overlays
PRODUCT_PACKAGE_OVERLAYS += \
    vendor/aosip/packages/overlays/Common

# Disable vendor restrictions
PRODUCT_RESTRICT_VENDOR_FILES := false

# Overlays
include vendor/overlay/overlays.mk

# Packages
include vendor/aosip/config/packages.mk

# Versioning
include vendor/aosip/config/version.mk

# Allows registering device to Google easier for gapps
# Integrates package for easier Google Pay fixing
PRODUCT_PACKAGES += \
    sqlite3

PRODUCT_DEXPREOPT_SPEED_APPS += \
    Settings \
    SystemUI

# PixelSetupWizard overlay
PRODUCT_PACKAGES += \
    PixelSetupWizardOverlay \
    PixelSetupWizardAodOverlay

# Themed bootanimation
TARGET_MISC_BLOCK_OFFSET ?= 0
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.misc.block.offset=$(TARGET_MISC_BLOCK_OFFSET)
PRODUCT_PACKAGES += \
    misc_writer_system \
    themed_bootanimation

PRODUCT_PACKAGES += \
    BrightnessSliderOverlay

ifeq ($(DERP_BUILD_ZIP_TYPE), GAPPS)
# GApps
include vendor/gapps/config.mk
endif

# Pixel Style
include vendor/pixelstyle/config.mk

ifeq ($(DERP_BUILD_ZIP_TYPE), GAPPS)
# Customization
include vendor/google/customization/config.mk
endif
