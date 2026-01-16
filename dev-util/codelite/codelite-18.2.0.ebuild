# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

WX_GTK_VER="3.2-gtk3"
CMAKE_MAKEFILE_GENERATOR="emake"

inherit cmake xdg wxwidgets multilib

ASIO_VER="b73dc1d2c0ecb9452a87c26544d7f71e24342df6"
ASSISTANT_VER="2ff677d4b28908e66400adddc799b6d5d932d1c9"
CCWRAPPER_VER="53464674ff2c287dfd68f05030d1d79e02d4974c"
CJSON_VER="fd1ac4f1791b403af1f7350b1195ac114f9b792b"
CTAGS_VER="ac5c942b422ca6dc6cdbfd2a0c2d481af1f18f02"
DTL_VER="32567bb9ec704f09040fb1ed7431a3d967e3df03"
HUNSPELL_VER="1d9a9ca8841ac0cd591c95b162301d2502641901"
LEXILLA_VER="8502988a5eb83fcd281ee5a38533a9f170e6b2bf"
LIBSSH_VER="854795c654eda518ed6de6c1ebb4e2107fcb2e73"
LUA_VER="bb8dc5ff01cf725dff2a8dcfe08fb0b81a9a7729"
LUABRIDGE_VER="a78d4f1469890eb4e795709848ebf57b002ad369"
OPENSSLCMAKE_VER="7042229f977ca801983116593b2bbd73ae7f2657"
TINYJSON_VER="d51ef6fc646d60c1400ebde767ebfdd2b7361482"
WXDAP_VER="e390b824ba0ab29e7665229f84f9fa44e8bef468"
WXSFCODE_VER="b5dc09a9b94b9955ef98111d0f311cb43f32f649"
YAMLCPP_VER="2f86d13775d119edbb69af52e5f566fd65c6953b"
ZLIB_VER="0f51fb4933fc9ce18199cb2554dacea8033e7fd3"

DESCRIPTION="A Free, open source, cross platform C,C++,PHP and Node.js IDE"
HOMEPAGE="http://www.codelite.org"
SRC_URI="
	https://github.com/eranif/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/chriskohlhoff/asio/archive/${ASIO_VER}.tar.gz -> asio-${ASIO_VER}.tar.gz
	https://github.com/eranif/assistant/archive/${ASSISTANT_VER}.tar.gz -> assistant-${ASSISTANT_VER}.tar.gz
	https://github.com/eranif/cc-wrapper/archive/${CCWRAPPER_VER}.tar.gz -> cc-wrapper-${CCWRAPPER_VER}.tar.gz
	https://github.com/DaveGamble/cJSON/archive/${CJSON_VER}.tar.gz -> cJSON-${CJSON_VER}.tar.gz
	https://github.com/eranif/ctags/archive/${CTAGS_VER}.tar.gz -> ctags-${CTAGS_VER}.tar.gz
	https://github.com/cubicdaiya/dtl/archive/${DTL_VER}.tar.gz -> dtl-${DTL_VER}.tar.gz
	https://github.com/hunspell/hunspell/archive/${HUNSPELL_VER}.tar.gz -> hunspell-${HUNSPELL_VER}.tar.gz
	https://github.com/eranif/lexilla/archive/${LEXILLA_VER}.tar.gz -> lexilla-${LEXILLA_VER}.tar.gz
	https://git.libssh.org/projects/libssh.git/snapshot/${LIBSSH_VER}.tar.xz -> libssh-${LIBSSH_VER}.tar.xz
	https://github.com/eranif/lua/archive/${LUA_VER}.tar.gz -> lua-${LUA_VER}.tar.gz
	https://github.com/eranif/LuaBridge/archive/${LUABRIDGE_VER}.tar.gz -> LuaBridge-${LUABRIDGE_VER}.tar.gz
	https://github.com/eranif/openssl-cmake/archive/${OPENSSLCMAKE_VER}.tar.gz -> openssl-cmake-${OPENSSLCMAKE_VER}.tar.gz
	https://github.com/eranif/tinyjson/archive/${TINYJSON_VER}.tar.gz -> tinyjson-${TINYJSON_VER}.tar.gz
	https://github.com/eranif/wxdap/archive/${WXDAP_VER}.tar.gz -> wxdap-${WXDAP_VER}.tar.gz
	https://github.com/eranif/wxsf-code/archive/${WXSFCODE_VER}.tar.gz -> wxsf-code-${WXSFCODE_VER}.tar.gz
	https://github.com/jbeder/yaml-cpp/archive/${YAMLCPP_VER}.tar.gz -> yaml-cpp-${YAMLCPP_VER}.tar.gz
	https://github.com/madler/zlib/archive/${ZLIB_VER}.tar.gz -> zlib-${ZLIB_VER}.tar.gz
	"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="lldb pch sftp"

DEPEND="
	dev-db/sqlite:3
	sys-devel/bison
	sys-devel/flex
	x11-libs/wxGTK:${WX_GTK_VER}[X]
	lldb? ( llvm-core/lldb:= )
	"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-18.0_don-t-strip-during-install.patch"
	"${FILESDIR}/${PN}-18-disable-automatic-ccache-configuration.patch"
)


src_unpack() {
	unpack ${A}

	mv -f asio-"${ASIO_VER}" asio
	mv -f assistant-"${ASSISTANT_VER}" assistant
	mv -f cc-wrapper-"${CCWRAPPER_VER}" cc-wrapper
	mv -f cJSON-"${CJSON_VER}" cJSON
	mv -f ctags-"${CTAGS_VER}" ctags
	mv -f dtl-"${DTL_VER}" dtl
	mv -f hunspell-"${HUNSPELL_VER}" hunspell
	mv -f lexilla-"${LEXILLA_VER}" lexilla
	mv -f "${LIBSSH_VER}" libssh
	mv -f lua-"${LUA_VER}" lua
	mv -f LuaBridge-"${LUABRIDGE_VER}" LuaBridge
	mv -f openssl-cmake-"${OPENSSLCMAKE_VER}" openssl-cmake
	mv -f tinyjson-"${TINYJSON_VER}" tinyjson
	mv -f wxdap-"${WXDAP_VER}" wxdap
	mv -f wxsf-code-"${WXSFCODE_VER}" wxsf-code
	mv -f yaml-cpp-"${YAMLCPP_VER}" yaml-cpp
	mv -f zlib-"${ZLIB_VER}" zlib

	mv -f -t "${S}"/submodules/ asio assistant cc-wrapper cJSON ctags dtl hunspell lexilla libssh lua LuaBridge openssl-cmake wxdap wxsf-code yaml-cpp zlib
	mv -f -t "${S}"/submodules/cc-wrapper/ tinyjson
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
		-DPREVENT_WX_ASSERTS=1
		-DWITH_NATIVEBOOK=1
	)

	cmake_src_configure
}

pkg_postinst() {
	xdg_pkg_postinst
}

pkg_postrm() {
	xdg_pkg_postrm
}
