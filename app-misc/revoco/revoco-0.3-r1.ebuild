# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit toolchain-funcs linux-info

DESCRIPTION="Tool for controlling Logitech MX Revolution mouses"
HOMEPAGE="http://goron.de/~froese/"
SRC_URI=""

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

RDEPEND=">=sys-fs/udev-104"

CONFIG_CHECK="USB_HIDDEV"
ERROR_USB_HIDDEN="You need to the CONFIG_USB_HIDDEV option turned on."

S=${WORKDIR}

src_compile() {
	$(tc-getCC) -DVERSION=${PV} ${CFLAGS} ${LDFLAGS} \
		"${FILESDIR}/${P}.c" -o "${PN}" || die "Failed to compile ${PN}"
}

src_install() {
	dobin ${PN} || die
}

pkg_postinst() {
	elog "Your user needs to be in the usb group to use revoco."
}
