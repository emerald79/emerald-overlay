# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/dvisvgm/dvisvgm-1.0.9-r1.ebuild,v 1.3 2011/12/09 12:52:53 naota Exp $

EAPI=4

inherit autotools

DESCRIPTION="Converts DVI files to SVG"
HOMEPAGE="http://dvisvgm.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~ppc-macos ~x64-macos ~x86-macos"
IUSE="test"
# Tests don't work from $WORKDIR: kpathsea tries to search in relative
# directories from where the binary is executed.
# We cannot really use absolute paths in the kpathsea configuration since that
# would make it harder for prefix installs.
RESTRICT="test"

RDEPEND="virtual/tex-base
	app-text/ghostscript-gpl
	>=media-gfx/potrace-1.10-r1
	media-libs/freetype:2
	sys-libs/zlib"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	test? ( dev-cpp/gtest )"

src_prepare() {
	sed -i -e '/^LDFLAGS="$LDFLAGS ${FREETYPE_LIBS}"/s,LDFLAGS,EXTRA_LIBS,g' "${S}"/configure.ac
	eautoreconf
}
