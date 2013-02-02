# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils

DESCRIPTION="Tool to temporary rename network interfaces to allow udev to assign ethx names"
HOMEPAGE="https://bugs.gentoo.org/show_bug.cgi?id=453494"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=sys-fs/udev-197"
RDEPEND="sys-apps/iproute2"

src_unpack() {
	mkdir -p "${S}"
}

src_install() {
	newinitd "${FILESDIR}"/ethtmp ethtmp
}

pkg_postinst() {
	ewarn "You need to add ethtmp to the sysinit runlevel for it to work."
}