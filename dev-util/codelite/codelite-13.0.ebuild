# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

WX_GTK_VER="3.0"

inherit cmake-utils wxwidgets multilib

DESCRIPTION="A Free, open source, cross platform C,C++,PHP and Node.js IDE"
HOMEPAGE="http://www.codelite.org"
SRC_URI="https://github.com/eranif/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="clang lldb pch sftp"

DEPEND="
	dev-db/sqlite:3
	net-libs/libssh
	clang? ( sys-devel/clang:= )
	lldb? ( dev-util/lldb )
	"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-${PV}_dont_strip.patch"
	epatch "${FILESDIR}/codelite-13.0-Support-building-with-libclang6-5-and-liblldb6-5.patch"

	sed -i -e 's,llvm-\([5-9]\).0/,llvm/\1/,' "${S}/cmake/Modules/FindLibClang.cmake"
	sed -i -e 's,llvm-\([5-9]\).0/,llvm/\1/,' "${S}/cmake/Modules/FindLibLLDB.cmake"
	sed -i -e 's,/lib[^/x36]*$,/'"$(get_libdir)"',' "${S}/cmake/Modules/FindLibClang.cmake"
	sed -i -e 's,/lib[^/x36]*$,/'"$(get_libdir)"',' "${S}/cmake/Modules/FindLibLLDB.cmake"
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_enable clang CLANG)
		$(cmake-utils_use_enable lldb LLDB)
		$(cmake-utils_use_with pch PCH)
		$(cmake-utils_use_enable sftp SFTP)
	)

	cmake-utils_src_configure
}
