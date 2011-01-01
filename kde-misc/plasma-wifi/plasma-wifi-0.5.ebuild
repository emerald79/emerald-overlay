# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

CONTENT_NUMBER="79476"

DESCRIPTION="KDE 4 plasma applet which displays the WiFi signal strength."
HOMEPAGE="http://www.kde-look.org/content/show.php/Plasma+WiFi?content=79476"
LICENSE="GPL-1"

KEYWORDS="~amd64 ~ppc ~x86"

SLOT="0"

IUSE=""

SRC_URI="http://www.kde-look.org/CONTENT/content-files/${CONTENT_NUMBER}-plasma-wifi-${PV}.tgz"

DEPEND="|| ( kde-base/kdelibs:4.3
	     kde-base/kdelibs:4.4
	     kde-base/kdelibs:4.5
	)"
RDEPEND=${DEPEND}

S="${WORKDIR}/plasma-wifi-${PV}"

src_unpack() {
	unpack ${A}
}

src_prepare() {
	sed -r -i -e 's/find_package\(Plasma REQUIRED\)/ /g' CMakeLists.txt
	sed -r -i -e 's/PLASMA_LIBS/KDE4_PLASMA_LIBS/g' CMakeLists.txt
}
