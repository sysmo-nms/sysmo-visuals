INKSCAPE ?= inkscape
IMAGEMAGICK ?= convert
SRC_DIR   = source
BUILD_DIR = build
TMP_DIR = /tmp/sysmo-identity-tmp
WHITE     = --export-background=ffffffff
LOGO_SRC = $(SRC_DIR)/sysmo-logo-src.svg
LOGO_SQR_SRC = $(SRC_DIR)/sysmo-logo-square-src.svg
LOGO_RECT_SRC = $(SRC_DIR)/sysmo-logo-rect-src.svg
INST_SRC = $(SRC_DIR)/sysmo-installer-icon-src.svg
INFO_SRC = $(SRC_DIR)/dialog-information.svg
WARN_SRC = $(SRC_DIR)/dialog-warning.svg
LOGIN_SRC = $(SRC_DIR)/system-log-in.svg
OP_BANNER_SRC = $(SRC_DIR)/sysmo-operator-login-banner.svg
WEB_BANNER_SRC = $(SRC_DIR)/sysmo-web.svg
WEB_FOOTER_SRC = $(SRC_DIR)/sysmo-web-trans.svg

.PHONY: graphics

graphics: $(BUILD_DIR)
graphics: $(TMP_DIR)
graphics: $(BUILD_DIR)/bundle-logo.png
graphics: $(BUILD_DIR)/bundle.ico
graphics: $(BUILD_DIR)/sysmo-white.ico
graphics: $(BUILD_DIR)/sysmo.ico
graphics: $(BUILD_DIR)/sysmo.png
graphics: $(BUILD_DIR)/info.ico
graphics: $(BUILD_DIR)/warning.ico
graphics: $(BUILD_DIR)/logo-medium.png
graphics: $(BUILD_DIR)/website-logo.png
graphics: $(BUILD_DIR)/system-log-in-x16.png
graphics: $(BUILD_DIR)/system-log-in-x22.png
graphics: $(BUILD_DIR)/system-log-in-x32.png
graphics: $(BUILD_DIR)/apple-touch-icon.png
graphics: $(BUILD_DIR)/tile-wide.png
graphics: $(BUILD_DIR)/tile.png
graphics: $(BUILD_DIR)/favicon.ico
graphics: $(BUILD_DIR)/sysmo-web-banner.png
graphics: $(BUILD_DIR)/sysmo-web-footer.png
#graphics: $(BUILD_DIR)/sysmo-icon-white-src.png
#graphics: $(BUILD_DIR)/sysmo-icon-transparent-src.png
#graphics: $(BUILD_DIR)/sysmo-logo-white-src.png
#graphics: $(BUILD_DIR)/sysmo-logo-transparent-src.png

$(BUILD_DIR):
	mkdir $(BUILD_DIR)

$(TMP_DIR):
	mkdir $(TMP_DIR)

############
# INKSCAPE #
############
# The source png icon with white background for imagemagick
$(TMP_DIR)/sysmo-icon-white-src.png: $(LOGO_SRC)
	$(INKSCAPE) -z --export-png=$@ $(WHITE) $?

# The source png icon with transparent background for imagemagick
$(TMP_DIR)/sysmo-icon-transparent-src.png: $(LOGO_SRC)
	$(INKSCAPE) -z --export-png=$@  $?

# The source png info for imagemagick
$(TMP_DIR)/dialog-information.png: $(INFO_SRC)
	$(INKSCAPE) -z --export-png=$@ --export-width=128 $?

$(TMP_DIR)/dialog-warning.png: $(WARN_SRC)
	$(INKSCAPE) -z --export-png=$@ --export-width=128 $?

# The source png logo with white background for imagemagick
#$(BUILD_DIR)/sysmo-logo-white-src.png: $(LOGO_SRC)
#	$(INKSCAPE) -z --export-png=$@ $(WHITE) $?

# The source png logo with transparent background for imagemagick
#$(BUILD_DIR)/sysmo-logo-transparent-src.png: $(LOGO_SRC)
#	$(INKSCAPE) -z --export-png=$@  $?

# The source png installer for imagemagick
$(TMP_DIR)/sysmo-installer-icon-src.png: $(INST_SRC)
	$(INKSCAPE) -z --export-png=$@  --export-width=128 $?

# lgo in icons
$(BUILD_DIR)/system-log-in-x16.png: $(LOGIN_SRC)
	$(INKSCAPE) -z --export-png=$@ -h 16 $?
$(BUILD_DIR)/system-log-in-x22.png: $(LOGIN_SRC)
	$(INKSCAPE) -z --export-png=$@ -h 22 $?
$(BUILD_DIR)/system-log-in-x32.png: $(LOGIN_SRC)
	$(INKSCAPE) -z --export-png=$@ -h 32 $?

# website
$(BUILD_DIR)/apple-touch-icon.png: $(LOGO_SQR_SRC)
	$(INKSCAPE) -z --export-png=$@ -h 180 $?
$(BUILD_DIR)/tile-wide.png: $(LOGO_RECT_SRC)
	$(INKSCAPE) -z --export-png=$@ -h 270 -w 558 $?
$(BUILD_DIR)/tile.png: $(LOGO_SQR_SRC)
	$(INKSCAPE) -z --export-png=$@ -h 558  $?
$(TMP_DIR)/favicon.png: $(LOGO_SRC)
	$(INKSCAPE) -z --export-png=$@ -h 32  $?
$(BUILD_DIR)/favicon.ico: $(TMP_DIR)/favicon.png
	$(IMAGEMAGICK) $? $@
$(BUILD_DIR)/sysmo-web-banner.png: $(WEB_BANNER_SRC)
	$(INKSCAPE) -z --export-png=$@  $?
$(BUILD_DIR)/sysmo-web-footer.png: $(WEB_FOOTER_SRC)
	$(INKSCAPE) -z --export-png=$@  -h 16 $?

# medium logo
$(BUILD_DIR)/logo-medium.png: $(LOGO_SRC)
	$(INKSCAPE) -z --export-png=$@ $(WHITE) -h 128 $?

# the bundle logo image
$(BUILD_DIR)/bundle-logo.png: $(LOGO_SRC)
	$(INKSCAPE) -z --export-png=$@ $(WHITE) -h 61 $?

$(BUILD_DIR)/website-logo.png: $(LOGO_SRC)
	$(INKSCAPE) -z --export-png=$@ -h 120 $?

$(BUILD_DIR)/sysmo.png: $(LOGO_SRC)
	$(INKSCAPE) -z --export-png=$@ -h 61 $?

###############
# IMAGEMAGICK #
###############

$(BUILD_DIR)/warning.ico: $(TMP_DIR)/dialog-warning.png
	$(IMAGEMAGICK) $? -resize 48x48 $@

$(BUILD_DIR)/info.ico: $(TMP_DIR)/dialog-information.png
	$(IMAGEMAGICK) $? -resize 48x48 $@

$(BUILD_DIR)/bundle.ico: $(TMP_DIR)/sysmo-installer-icon-src.png
	$(IMAGEMAGICK) $? -resize 128x128 $@

$(BUILD_DIR)/sysmo-white.ico: $(TMP_DIR)/sysmo-icon-white-src.png
	$(IMAGEMAGICK) $? -resize 64x64 $@

$(BUILD_DIR)/sysmo.ico: $(TMP_DIR)/sysmo-icon-transparent-src.png
	$(IMAGEMAGICK) $? -resize 64x64 $@

clean:
	rm -rf $(BUILD_DIR)
	rm -rf $(TMP_DIR)
