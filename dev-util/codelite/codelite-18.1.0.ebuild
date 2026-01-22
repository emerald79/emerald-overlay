# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

WX_GTK_VER="3.2-gtk3"
CMAKE_MAKEFILE_GENERATOR="emake"

inherit cmake xdg wxwidgets multilib

ASIO_VER="b73dc1d2c0ecb9452a87c26544d7f71e24342df6"
CCWRAPPER_VER="67713440e867493e74ce5c7ce0352b81eb4b726b"
CJSON_VER="fd1ac4f1791b403af1f7350b1195ac114f9b792b"
CTAGS_VER="930be27ea34f28bea45a2af76b974734de8fbcc5"
DTL_VER="f2651ff29d42abd036980e42d6ee26e598720508"
HUNSPELL_VER="1d9a9ca8841ac0cd591c95b162301d2502641901"
LEXILLA_VER="8502988a5eb83fcd281ee5a38533a9f170e6b2bf"
LIBSSH_VER="f3fe85f45ef1158c3f97a6abe804df2bcb0df352"
LLAMACPP_VER="c3776cacabce2ee35f172fb72be7a519752125fa"
OPENSSLCMAKE_VER="da217f13d734fe51ccc2d9b986d5f16ccba14bdd"
TINYJSON_VER="a6b0d0d31a05a9f55b4944b3b20f769305eb583a"
WEBSOCKETPP_VER="c6d7e295bf5a0ab9b5f896720cc1a0e0fdc397a7"
WXDAP_VER="e390b824ba0ab29e7665229f84f9fa44e8bef468"
WXSFCODE_VER="b5dc09a9b94b9955ef98111d0f311cb43f32f649"
YAMLCPP_VER="2f86d13775d119edbb69af52e5f566fd65c6953b"
ZLIB_VER="0f51fb4933fc9ce18199cb2554dacea8033e7fd3"

DESCRIPTION="A Free, open source, cross platform C,C++,PHP and Node.js IDE"
HOMEPAGE="http://www.codelite.org"
SRC_URI="
	https://github.com/eranif/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/chriskohlhoff/asio/archive/${ASIO_VER}.tar.gz -> asio-${ASIO_VER}.tar.gz
	https://github.com/eranif/cc-wrapper/archive/${CCWRAPPER_VER}.tar.gz -> cc-wrapper-${CCWRAPPER_VER}.tar.gz
	https://github.com/DaveGamble/cJSON/archive/${CJSON_VER}.tar.gz -> cJSON-${CJSON_VER}.tar.gz
	https://github.com/eranif/ctags/archive/${CTAGS_VER}.tar.gz -> ctags-${CTAGS_VER}.tar.gz
	https://github.com/cubicdaiya/dtl/archive/${DTL_VER}.tar.gz -> dtl-${DTL_VER}.tar.gz
	https://github.com/hunspell/hunspell/archive/${HUNSPELL_VER}.tar.gz -> hunspell-${HUNSPELL_VER}.tar.gz
	https://github.com/eranif/lexilla/archive/${LEXILLA_VER}.tar.gz -> lexilla-${LEXILLA_VER}.tar.gz
	https://git.libssh.org/projects/libssh.git/snapshot/${LIBSSH_VER}.tar.xz -> libssh-${LIBSSH_VER}.tar.xz
	https://github.com/ggerganov/llama.cpp/archive/${LLAMACPP_VER}.tar.gz -> llama.cpp-${LLAMACPP_VER}.tar.gz
	https://github.com/janbar/openssl-cmake/archive/${OPENSSLCMAKE_VER}.tar.gz -> openssl-cmake-${OPENSSLCMAKE_VER}.tar.gz
	https://github.com/eranif/tinyjson/archive/${TINYJSON_VER}.tar.gz -> tinyjson-${TINYJSON_VER}.tar.gz
	https://github.com/zaphoyd/websocketpp/archive/${WEBSOCKETPP_VER}.tar.gz -> websocketpp-${WEBSOCKETPP_VER}.tar.gz
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
	"${FILESDIR}/${PN}-18.1_don-t-strip-during-install.patch"
	"${FILESDIR}/${PN}-18.1-disable-automatic-ccache-configuration.patch"
)


src_unpack() {
	unpack ${A}

	mv -f asio-"${ASIO_VER}" asio
	mv -f cc-wrapper-"${CCWRAPPER_VER}" cc-wrapper
	mv -f cJSON-"${CJSON_VER}" cJSON
	mv -f ctags-"${CTAGS_VER}" ctags
	mv -f dtl-"${DTL_VER}" dtl
	mv -f hunspell-"${HUNSPELL_VER}" hunspell
	mv -f lexilla-"${LEXILLA_VER}" lexilla
	mv -f "${LIBSSH_VER}" libssh
	mv -f llama.cpp-"${LLAMACPP_VER}" llama.cpp
	mv -f openssl-cmake-"${OPENSSLCMAKE_VER}" openssl-cmake
	mv -f tinyjson-"${TINYJSON_VER}" tinyjson
	mv -f websocketpp-"${WEBSOCKETPP_VER}" websocketpp
	mv -f wxdap-"${WXDAP_VER}" wxdap
	mv -f wxsf-code-"${WXSFCODE_VER}" wxsf-code
	mv -f yaml-cpp-"${YAMLCPP_VER}" yaml-cpp
	mv -f zlib-"${ZLIB_VER}" zlib

	mv -f -t "${S}"/submodules/ asio cc-wrapper cJSON ctags dtl hunspell lexilla libssh llama.cpp openssl-cmake websocketpp wxdap wxsf-code yaml-cpp zlib
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
