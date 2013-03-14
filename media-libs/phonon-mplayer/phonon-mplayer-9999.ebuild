# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/phonon-mplayer/phonon-mplayer-9999.ebuild$

EAPI="3"

inherit cmake-utils git-2 flag-o-matic

DESCRIPTION="Phonon MPlayer backend"
HOMEPAGE="https://projects.kde.org/projects/kdesupport/phonon/phonon-mplayer"
EGIT_REPO_URI="git://anongit.kde.org/${PN}"

LICENSE="LGPL-2.1"
KEYWORDS=""
SLOT="0"
IUSE="debug"

RDEPEND="
	media-video/mplayer
	>=media-libs/phonon-4.4.4
	|| ( >=x11-libs/qt-gui-4.6.0:4
	     >=dev-qt/qtgui-4.6.0:4 )
"
DEPEND="${RDEPEND}
	>=dev-util/automoc-0.9.87
	virtual/pkgconfig
"

src_prepare() {
	einfo "Include /usr/include/ directory ..."
	sed -e "/find_package/a include_directories(/usr/include/)" \
		-i CMakeLists.txt \
		&& einfo "Done!" \
		|| die "Failed!"
}

src_configure() {
	append-cppflags -fPIC
	cmake-utils_src_configure
}
