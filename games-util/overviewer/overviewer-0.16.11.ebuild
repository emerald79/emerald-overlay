# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7,8} )

inherit distutils-r1

DESCRIPTION="The Minecraft Overviewer tool that renders a Google Maps-like map interface"
HOMEPAGE="https://overviewer.org"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/overviewer/Minecraft-Overviewer"
else
	BUILD_NUMBER="179"
	SRC_URI="https://overviewer.org/builds/src/${BUILD_NUMBER}/${P}.tar.gz"
	S="${WORKDIR}/Minecraft-Overviewer-${PV}"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"

IUSE="+jpeg"

DEPEND="${PYTHON_DEPENDS}
	dev-python/pillow[jpeg?,${PYTHON_USEDEP}]
	!games-misc/overviewer
	dev-python/numpy[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

pkg_postinst(){
	elog "To use this tool, you must have a Minecraft installation first!"
	elog "To run this tool, the binary name is ${PN}.py"
}
