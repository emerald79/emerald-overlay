# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/arpwatch-ng/arpwatch-ng-1.7.ebuild,v 1.6 2007/11/14 04:24:43 beandog Exp $

EAPI="2"

inherit eutils versionator

DESCRIPTION="An ethernet monitor program that keeps track of ethernet/ip address pairings"
HOMEPAGE="http://freequaos.host.sk/arpwatch/"
SRC_URI="http://freequaos.host.sk/arpwatch/arpwatch-NG${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="fancy-mac update-ethercodes vlan"

DEPEND="net-libs/libpcap
	!net-analyzer/arpwatch
	sys-apps/sed
	|| ( sys-apps/gawk sys-apps/mawk )"

RDEPEND="${DEPEND}"

S="${WORKDIR}/arpwatch-NG${PV}"

src_prepare() {
	epatch "${FILESDIR}"/makefile-var.patch
	if use vlan; then
		epatch "${FILESDIR}"/add-vlan-support-remove-fddi-general-improvements.patch
		epatch "${FILESDIR}"/add-vlan-configure-option.patch
	fi

	if use update-ethercodes; then
		ewarn "Updating ethercodes.dat requires internet connection"
		cd "${S}"/contrib
		./ieee_ethercodes_up.sh
		if [[ -s new_ethercodes.dat ]]; then
			cat new_ethercodes.dat > "${S}"/ethercodes.dat
		else
			ewarn "ethercodes.dat not updated."
		fi
	fi
}

pkg_preinst() {
	enewuser arpwatch
}

src_configure() {
	local myconf=
	use fancy-mac && myconf="${myconf} --enable-fancy-mac"
	use vlan && myconf="${myconf} --enable-vlan-tag"

	econf \
		${myconf} \
		|| die "econf failed"
}

src_install () {
	dosbin arpwatch arpsnmp arpfetch contrib/arp2ethers contrib/massagevendor contrib/bihourly || die
	doman arpwatch.8 arpsnmp.8 arpfetch.8 contrib/arp2ethers.8 contrib/bihourly.8 || die

	insinto /usr/share/arpwatch
	doins ethercodes.dat || die

	insinto /usr/share/arpwatch/awk
	doins contrib/duplicates.awk contrib/euppertolower.awk contrib/p.awk contrib/e.awk contrib/d.awk || die

	keepdir /var/lib/arpwatch
	dodoc README CHANGES FAQ VERSION

	newinitd "${FILESDIR}"/arpwatch.initd arpwatch
	newconfd "${FILESDIR}"/arpwatch.confd arpwatch
}

pkg_postinst() {
	# Workaround bug #141619 put this in src_install when bug'll be fixed.
	chown arpwatch:0 "${ROOT}var/lib/arpwatch"

	elog "For security reasons arpwatch-ng by default runs as an unprivileged user."
	ewarn "Note: some scripts require snmpwalk utility from net-analyzer/net-snmp"
}
