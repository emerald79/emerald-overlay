# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit eutils versionator cmake-utils games bzr

EBZR_REPO_URI="lp:widelands"
MY_PV=$(get_version_component_range 3)
DESCRIPTION="A game similar to Settlers 2"
HOMEPAGE="http://www.widelands.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="dev-games/ggz-client-libs
	dev-lang/lua
	>=sys-libs/zlib-1.2.5.1-r1
	media-libs/sdl-image[jpeg,png]
	media-libs/sdl-mixer[vorbis]
	media-libs/sdl-gfx
	media-libs/sdl-net
	media-libs/glew
	media-libs/sdl-ttf"
DEPEND="${RDEPEND}
	dev-libs/boost"

S=${WORKDIR}/${P}

CMAKE_BUILD_TYPE=Release
PREFIX=${GAMES_DATADIR}/${PN}

src_prepare() {
	sed -i -e 's:__ppc__:__PPC__:' src/s2map.cc || die
#	sed -i -e '74i#define OF(x) x' src/io/filesystem/{un,}zip.h || die
#	sed -i -e '22i#define OF(x) x' src/io/filesystem/ioapi.h || die
}

src_configure() {
	mycmakeargs+=(
		'-DWL_VERSION_STANDARD=true'
		"-DWL_INSTALL_PREFIX=${GAMES_PREFIX}"
		"-DWL_INSTALL_DATADIR=${GAMES_DATADIR}/${PN}"
		"-DWL_INSTALL_LOCALEDIR=${GAMES_DATADIR}/${PN}/locale"
		"-DWL_INSTALL_BINDIR=${GAMES_BINDIR}"
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
	newicon pics/wl-ico-128.png ${PN}.png || die
	make_desktop_entry ${PN} Widelands
	dodoc ChangeLog CREDITS
	prepgamesdirs
}
