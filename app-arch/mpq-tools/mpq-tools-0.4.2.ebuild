# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/mpq-tools/mpq-tools-0.4.2.ebuild,v 1.0 2008/03/09 23:21:08 eva Exp $

inherit libtool

DESCRIPTION="Tools for manipulating mpq archives"
HOMEPAGE="https://libmpq.org/wiki/MpqTools"
SRC_URI="https://libmpq.org/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="~dev-libs/libmpq-${PV}
	app-arch/bzip2"
RDEPEND="${DEPEND}"

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
