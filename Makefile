include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-passwall-offline
PKG_VERSION:=1.0
PKG_RELEASE:=1

LUCI_TITLE:=Passwall Offline Installer
LUCI_PKGARCH:=all
LUCI_DEPENDS:=+luci-base +uclient-fetch +wget-ssl

include $(TOPDIR)/feeds/luci/luci.mk
# call BuildPackage - OpenWrt build system

