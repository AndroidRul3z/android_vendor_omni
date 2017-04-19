# Common settings and files
-include vendor/purity/config/common.mk

# Add tablet overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/purity/overlay/common_tablet

PRODUCT_CHARACTERISTICS := tablet

