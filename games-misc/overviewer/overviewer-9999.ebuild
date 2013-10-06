# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
PYTHON_COMPAT=(python2_6 python2_7)

inherit eutils git-2 python-single-r1

DESCRIPTION="Generates large resolution images of a Minecraft map"
HOMEPAGE="http://overviewer.org"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
DEPEND="virtual/python-imaging
	dev-python/numpy"
RDEPEND="${DEPEND}"

EGIT_REPO_URI="git://github.com/overviewer/Minecraft-Overviewer.git"

IUSE=""

pkg_setup() {
	python-single-r1_pkg_setup
}

src_compile() {
	${PYTHON} setup.py build || die compile failed!
}

src_install() {
	${PYTHON} setup.py install --no-compile -O2 --root "${D}" || die install failed!

	python_fix_shebang "${D}"
}
