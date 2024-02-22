# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

WX_GTK_VER="3.2-gtk3"
CMAKE_MAKEFILE_GENERATOR="emake"

inherit cmake xdg wxwidgets multilib

CTAGS_VER="3e173d8d82fd2d3534feff0d822d6de36ca3d74e"
WXDAP_VER="f8f7afaecf522c7a1126e798310b1e5f986ace6a"
YAMLCPP_VER="1b50109f7bea60bd382d8ea7befce3d2bd67da5f"

DESCRIPTION="A Free, open source, cross platform C,C++,PHP and Node.js IDE"
HOMEPAGE="http://www.codelite.org"
SRC_URI="
	https://github.com/eranif/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/eranif/ctags/archive/${CTAGS_VER}.tar.gz -> ctags-${CTAGS_VER}.tar.gz
	https://github.com/eranif/wxdap/archive/${WXDAP_VER}.tar.gz -> wxdap-${WXDAP_VER}.tar.gz
	https://github.com/jbeder/yaml-cpp/archive/${YAMLCPP_VER}.tar.gz -> yaml-cpp-${YAMLCPP_VER}.tar.gz
	"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="lldb pch sftp"

DEPEND="
	dev-db/sqlite:3
	net-libs/libssh
	x11-libs/wxGTK:${WX_GTK_VER}[X]
	lldb? ( dev-debug/lldb:= )
	"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-17.0_dont_strip.patch"
	"${FILESDIR}/${PN}-17-disable-automatic-ccache-configuration.patch"
)

src_unpack() {
	unpack ${A}

	mv -f ctags-"${CTAGS_VER}" ctags
	mv -f wxdap-"${WXDAP_VER}" wxdap
	mv -f yaml-cpp-"${YAMLCPP_VER}" yaml-cpp

	mv -f -t "${S}"/ ctags wxdap yaml-cpp
}

src_prepare() {
	sed -i -e 's,llvm-\([0-9]\+\)/,llvm/\1/,' "${S}/cmake/Modules/FindLibClang.cmake"
	sed -i -e 's,llvm-\([0-9]\+\)/,llvm/\1/,' "${S}/cmake/Modules/FindLibLLDB.cmake"
	sed -i -e 's,/lib[^/x36]*$,/'"$(get_libdir)"',' "${S}/cmake/Modules/FindLibClang.cmake"
	sed -i -e 's,/lib[^/x36]*$,/'"$(get_libdir)"',' "${S}/cmake/Modules/FindLibLLDB.cmake"

	setup-wxwidgets
	eapply_user

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_LLDB=$(usex lldb)
		-DWITH_PCH=$(usex pch)
		-DENABLE_SFTP=$(usex sftp)
	)

	cmake_src_configure
}

pkg_postinst() {
	xdg_pkg_postinst
}

pkg_postrm() {
	xdg_pkg_postrm
}
