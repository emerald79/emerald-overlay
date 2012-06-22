# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
PYTHON_DEPEND="2:2.6:2.7"

inherit eutils git python

DESCRIPTION="Generates large resolution images of a Minecraft map"
HOMEPAGE="http://overviewer.org"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
DEPEND="dev-python/imaging
	dev-python/numpy"
RDEPEND="${DEPEND}"

EGIT_REPO_URI="git://github.com/overviewer/Minecraft-Overviewer.git"

IUSE=""

src_compile() {
	python2 setup.py build || die compile failed!
}

src_install() {
	python2 setup.py install --no-compile -O2 --root ${D} || die install failed!
}
