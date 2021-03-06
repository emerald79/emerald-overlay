# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=3

inherit eutils

DESCRIPTION="This KCM allows you to easily configure the standard Qt graphics system"
HOMEPAGE="http://kde-apps.org/content/show.php?content=129817"
SRC_URI="http://kde-apps.org/CONTENT/content-files/129817-kcm-qt-graphicssystem-1.2.tar.xz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	kde-base/kdelibs
	>=dev-qt/qtgui-4.7.0:4
	>=dev-qt/qtcore-4.7.0:4
	"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PF}"

src_compile() {
	cmake -DCMAKE_INSTALL_PREFIX=/usr "${S}"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
