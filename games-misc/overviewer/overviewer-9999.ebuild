# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit git-2 distutils-r1

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
