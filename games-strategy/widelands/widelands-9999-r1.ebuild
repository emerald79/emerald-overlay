# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit eutils versionator games cmake-utils bzr

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
	media-libs/jpeg:7
	media-libs/libpng:0
	media-libs/libsdl[video]
	media-libs/sdl-image[jpeg,png]
	media-libs/sdl-mixer[vorbis]
	media-libs/sdl-gfx
	media-libs/sdl-net
	media-libs/sdl-ttf
	media-libs/tiff"
DEPEND="${RDEPEND}
	dev-libs/boost"

S=${WORKDIR}/${P}

sed_macros() {
	# clean up namespace a little #383179
	# we do it here so we only have to tweak 2 files
	sed -i -r 's:\<(O[FN])\>:_Z_\1:g' "$@" || die
}

src_prepare() {
#	epatch "${FILESDIR}"/${PN}-0.0.15-build.patch
#		"${FILESDIR}"/${PN}-0.0.15-gcc45-fix.patch

	sed -i \
		-e 's:__ppc__:__PPC__:' src/s2map.cc \
		|| die "sed s2map.cc failed"

	sed_macros "${S}"/src/io/filesystem/ioapi.h
	sed_macros "${S}"/src/io/filesystem/unzip.cc
	sed_macros "${S}"/src/io/filesystem/unzip.h
	sed_macros "${S}"/src/io/filesystem/zip.h
}

src_configure() {
	mycmakeargs+=(
	'-DWL_VERSION_STANDARD=true'
	"-DCMAKE_INSTALL_PREFIX=${GAMES_DATADIR}/${PN}"
	"-DCMAKE_BUILD_TYPE=Release"
	"-DWL_INSTALL_PREFIX=${GAMES_PREFIX}"
	"-DWL_INSTALL_DATADIR=${GAMES_DATADIR}/${PN}"
	"-DWL_INSTALL_LOCALEDIR=locale"
	"-DWL_INSTALL_BINDIR=${GAMES_BINDIR}"
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile -j1
}

src_install() {
	cmake-utils_src_install
	dodir "${GAMES_DATADIR}"/"${PN}"
	insinto "${GAMES_DATADIR}"/"${PN}"
	doins -r campaigns fonts global maps music pics sound tribes txts worlds || die
	newicon pics/wl-ico-128.png ${PN}.png
	make_desktop_entry ${PN} Widelands

	dodoc ChangeLog CREDITS
	prepgamesdirs
}
