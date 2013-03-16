# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

EAPI=4

inherit eutils

DESCRIPTION="Shoutcast streaming library for IDJC"
HOMEPAGE="http://idjc.sourceforge.net/"
SRC_URI="mirror://sourceforge/idjc/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ogg speex static-libs vorbis"

RDEPEND=">=dev-python/pygtk-2.18:2
	media-libs/libsamplerate
	media-libs/libsndfile
	>=media-libs/mutagen-1.18
	>=media-sound/jack-audio-connection-kit-0.116.0
	vorbis? ( media-libs/libvorbis )
	ogg? ( media-libs/libogg )
	speex? ( >=media-libs/speex-1.2_rc1 )"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	econf $(use_enable ogg) $(use_enable speex) $(use_enable vorbis) \
		$(use_enable static)
}

src_compile() {
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	use static || prune_libtool_files
}
