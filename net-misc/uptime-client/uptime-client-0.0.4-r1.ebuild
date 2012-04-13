# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

DESCRIPTION="uptime client for uptime.uhuc.de"
HOMEPAGE="http://uptime.uhuc.de"
SRC_URI="http://www.emi-sama.de/distfiles/${PN}-${PV}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=dev-lang/python-2.5.0[xml]"

RESTRICT_PYTHON_ABIS="3.*"

src_prepare() {
	sed -i -e 's,#!/usr/bin/env python,#!/usr/bin/env python2,' \
		"${S}"/src/uptime_client.py || die "sed failed"
	sed -i -e 's#utime_client\.xml#/etc/uptime-client.conf#' \
		"${S}"/src/uptime_client.py || die "sed failed"
	sed -i -e 's#kromonos.net#uptime.uhuc.de#;s#9090#54296#' \
		"${S}"/src/utime_client.xml.example || die "sed failed"

	echo "#$(( $RANDOM % 60 )) * * * * /usr/bin/uptime-client" > "${S}"/uptime-client.cron
}

src_install() {
	newbin src/uptime_client.py uptime-client || die
	insinto /etc
	newins src/utime_client.xml.example uptime-client.conf || die
	exeinto /etc/cron.d
	newexe uptime-client.cron uptime-client || die

	dodoc AUTHORS NEWS README || die "dodoc failed"
}

pkg_postinst() {
	ewarn "This release has a new cron script!"
	ewarn "Remove the old one in /etc/cron.hourly"
	ewarn "and activate the uptime client in the new one!"
}
