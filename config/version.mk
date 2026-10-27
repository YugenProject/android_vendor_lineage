PRODUCT_VERSION_MAJOR = 1
PRODUCT_VERSION_MINOR = 0

# Distro codename, surfaced in Settings > About phone
LINEAGE_VERSION_CODENAME := akatsukui

# Build flavor shown in the Soong banner and OTA package name.
ifeq ($(WITH_GMS),true)
    YUGEN_BUILD_VARIANT := GMS
else
    YUGEN_BUILD_VARIANT := VANILLA
endif

ifeq ($(LINEAGE_VERSION_APPEND_TIME_OF_DAY),true)
    LINEAGE_BUILD_DATE := $(shell date -u +%Y%m%d_%H%M%S)
else
    LINEAGE_BUILD_DATE := $(shell date -u +%Y%m%d)
endif

# Yugen build type may be set through the environment or product configuration.
# Accepted release types are RELEASE, NIGHTLY, SNAPSHOT, and EXPERIMENTAL.

# Maintainer name shown in Settings and build properties.
YUGEN_MAINTAINER_NAME ?= Yugen Team

# Filter out random types, so it'll reset to TEZUKURI
ifeq ($(filter RELEASE NIGHTLY SNAPSHOT EXPERIMENTAL,$(YUGEN_BUILDTYPE)),)
    YUGEN_BUILDTYPE := TEZUKURI
    LINEAGE_EXTRAVERSION :=
endif

ifeq ($(YUGEN_BUILDTYPE), TEZUKURI)
    ifneq ($(TARGET_TEZUKURI_BUILD_ID),)
        LINEAGE_EXTRAVERSION := -$(TARGET_TEZUKURI_BUILD_ID)
    endif
endif

LINEAGE_VERSION_SUFFIX := $(LINEAGE_BUILD_DATE)-$(YUGEN_BUILDTYPE)$(LINEAGE_EXTRAVERSION)-$(LINEAGE_BUILD)

# Machine-parseable version, kept free of the codename so that anything parsing
# <major>.<minor>-<date>-<type>-<device> keeps working.
LINEAGE_UPDATE_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(LINEAGE_VERSION_SUFFIX)

# Human-facing version, used for the build banner and the flashable zip name.
LINEAGE_VERSION := $(YUGEN_BUILD_VARIANT)-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(LINEAGE_VERSION_CODENAME)-$(LINEAGE_VERSION_SUFFIX)

# Display version
LINEAGE_DISPLAY_VERSION := $(PRODUCT_VERSION_MAJOR)-$(LINEAGE_VERSION_SUFFIX)

# LineageOS version properties
PRODUCT_PRODUCT_PROPERTIES += \
    ro.lineage.version=$(LINEAGE_UPDATE_VERSION) \
    ro.lineage.display.version=$(LINEAGE_DISPLAY_VERSION) \
    ro.lineage.build.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) \
    ro.lineage.releasetype=$(YUGEN_BUILDTYPE) \
    ro.yugen.version.codename=$(LINEAGE_VERSION_CODENAME) \
    ro.yugen.build.variant=$(YUGEN_BUILD_VARIANT) \
    ro.yugen.build.type=$(YUGEN_BUILDTYPE) \
    ro.yugen.maintainer=$(YUGEN_MAINTAINER_NAME)
