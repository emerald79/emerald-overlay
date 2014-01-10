# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

WX_GTK_VER="3.0"

inherit eutils wxwidgets

DESCRIPTION="open-source, cross platform IDE for the C/C++ programming languages"
HOMEPAGE="http://www.codelite.org/"
SRC_URI="mirror://sourceforge/codelite/Releases/${P}/${P}-gtk.src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm ~mips ~ppc ~ppc64 ~sh ~sparc ~sparc-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="cscope debug git mysql postgres subversion"

DEPEND="x11-libs/wxGTK:3.0[X]
	net-libs/libssh
	cscope? ( dev-util/cscope )
	git? ( dev-vcs/git )
	mysql? ( virtual/mysql )
	postgres? ( dev-db/postgresql-base )
	subversion? ( dev-vcs/subversion )"

RDEPEND="${DEPEND}"

src_prepare () {
	sed -i -e 's,set( PLUGINS_DIR "${CL_PREFIX}/${CL_INSTALL_LIBDIR}/codelite"),set( PLUGINS_DIR "${CL_PREFIX}/libexec/codelite"),' "${S}/CMakeLists.txt"
}

src_configure () {
	local config="-DPLUGINS_DIR=/usr/libexec/codelite"
	use debug && config+=" -DCMAKE_BUILD_TYPE=Debug" \
		|| config+=" -DCMAKE_BUILD_TYPE=Release"
	use mysql && config+=" -DWITH_MYSQL=1" || config+=" -DWITH_MYSQL=0"
#	econf \
#		$(use_enable debug) \
#		$(use_enable mysql) \
#		$(use_enable postgres) \
#		--plugins-dir=/usr/libexec/codelite \
#		|| die "configure failed"
	cmake -G "Unix Makefiles" "${config}" "${S}"
}

src_install () {
	emake -j1 DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS

	# reverting the makefiles 666 chmod for this file
	chmod 0644 "${D}"/usr/share/codelite/codelite-icons.zip
}
