# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit pax-utils unpacker

MY_DL=${P}-1_amd64

DESCRIPTION="OBS web-socket plugin"
HOMEPAGE="https://github.com/Palakis/obs-websocket"
SRC_URI="https://github.com/Palakis/${PN}/releases/download/${PV}/${MY_DL}.deb -> ${P}.deb"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

RDEPEND="
	media-video/obs-studio
"

S=${WORKDIR}

QA_PREBUILT="
	usr/lib/obs-plugins/obs-websocket.so
"

src_install() {
	insinto /usr/lib64/obs-plugins
	doins -r usr/lib/obs-plugins/obs-websocket.so

	insinto /usr/share/obs/
	doins -r usr/share/obs/obs-plugins
	fperms +x /usr/lib64/obs-plugins/obs-websocket.so

	pax-mark -m "${ED}"/usr/lib64/obs-plugins/obs-websocket.so
}
