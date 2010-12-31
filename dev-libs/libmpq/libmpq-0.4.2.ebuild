# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libdaemon/libdaemon-0.12.ebuild,v 1.9 2008/03/09 23:21:08 eva Exp $

inherit libtool

DESCRIPTION="Library for manipulating mpq archives"
HOMEPAGE="https://libmpq.org/wiki"
SRC_URI="https://libmpq.org/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-libs/zlib
	app-arch/bzip2"
RDEPEND="${DEPEND}"

#RESTRICT="fetch"

#pkg_nofetch() {
#    ewarn "Because the website uses a self-signed certificate"
#    ewarn "and I don't know how to tell emerge how to download"
#    ewarn "the source file you'll have to do it on your own."
#    ewarn
#    ewarn "Place the downloaded file into ${PORTDIR}/distfiles"
#    ewarn
#    ewarn "E.g. you can use the following command to download:"
#    ewarn "wget --no-check-certificate -O ${PORTDIR}/distfiles/${P}.tar.bz2 ${SRC_URI}"
#}

src_unpack() {
	unpack ${A}

	elibtoolize
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	doman doc/man*/*
	dodoc AUTHORS
	dodoc ChangeLog
	dodoc FAQ
	dodoc NEWS
	dodoc README
	dodoc THANKS
	dodoc TODO
}
