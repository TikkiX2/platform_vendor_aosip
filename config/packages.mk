# Required packages
PRODUCT_PACKAGES += \
    PixelThemes \
    ThemePicker

ifeq ($(filter-out Official CI, $(AOSIP_BUILDTYPE)),)
    PRODUCT_PACKAGES += \
        Updater
endif

# Extra tools in AOSiP
PRODUCT_PACKAGES += \
    7z \
    awk \
    bash \
    bzip2 \
    curl \
    getcap \
    htop \
    lib7z \
    libsepol \
    nano \
    pigz \
    powertop \
    setcap \
    unrar \
    unzip \
    vim \
    wget \
    zip

# DerpFest packages
PRODUCT_PACKAGES += \
    OmniRecord \
    OmniStyle \
    PixelLiveWallpaperPrebuilt

# Cutout control overlay
PRODUCT_PACKAGES += \
    NoCutoutOverlay

# Filesystems tools
PRODUCT_PACKAGES += \
    fsck.exfat \
    fsck.ntfs \
    mke2fs \
    mkfs.exfat \
    mkfs.ntfs \
    mount.ntfs

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full \
    librsjni

# Accents
PRODUCT_PACKAGES += \
    AccentColorYellowOverlay \
    AccentColorVioletOverlay \
    AccentColorTealOverlay \
    AccentColorRedOverlay \
    AccentColorQGreenOverlay \
    AccentColorPinkOverlay \
    AccentColorLightPurpleOverlay \
    AccentColorIndigoOverlay \
    AccentColorFlatPinkOverlay \
    AccentColorCyanOverlay \
    AccentColorBlueGrayOverlay \
    AccentColorMintOverlay  \
    BBarOff-common \
    BBarOff-systemUI 
