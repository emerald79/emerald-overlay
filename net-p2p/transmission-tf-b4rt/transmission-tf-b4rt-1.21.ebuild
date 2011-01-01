# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/transmission/transmission-1.20.ebuild,v 1.1 2008/05/13 02:54:27 compnerd Exp $

inherit eutils

DESCRIPTION="Simple BitTorrent client"
HOMEPAGE="http://www.transmissionbt.com/"
SRC_URI="http://download.transmissionbt.com/transmission/files/${P/-tf-b4rt/}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-libs/glib-2.16
		 >=dev-libs/openssl-0.9.8"
DEPEND="${RDEPEND}
		sys-devel/gettext
		>=dev-util/pkgconfig-0.19"

S="${WORKDIR}/${P/-tf-b4rt/}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/tf-b4rt-${PV}.patch"
}

src_compile() {
	econf --enable-cli --disable-gtk --disable-libnotify --disable-wx --disable-daemon --with-wx-config=no --program-suffix=-tf-b4rt || die "configure failed"
	emake || die "build failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS NEWS
}
