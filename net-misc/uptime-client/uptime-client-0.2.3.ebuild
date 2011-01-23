# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

DESCRIPTION="uptime client for uptime.uhuc.de"
HOMEPAGE="http://uptime.uhuc.de"
#SRC_URI="http://git.kromonos.net/uptime.clt/snapshot/uptime.clt-${PV}.tar.gz"
SRC_URI="http://www.emi-sama.de/distfiles/uptime.clt-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=dev-lang/python-2.5.0[xml]"

RESTRICT_PYTHON_ABIS="3.*"

MY_S="${S/%${P}/uptime.clt-${PV}}"
S="${MY_S}"

src_prepare() {
	sed -i -e 's#utime_client\.xml#/etc/uptime-client.conf#' \
		"${S}"/client.py || die "sed failed"
	sed -i -e 's#kromonos.net#uptime.uhuc.de#;s#9090#54296#' \
		"${S}"/utime_client.xml.example || die "sed failed"

	echo "#/usr/bin/uptime-client" > "${S}"/uptime-client.cron
}

src_install() {
	newbin client.py uptime-client
	insinto /etc
	newins utime_client.xml.example uptime-client.conf
	exeinto /etc/cron.hourly
	newexe uptime-client.cron uptime-client

	dodoc TODO || die "dodoc failed"
}
