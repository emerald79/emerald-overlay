# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

EAPI=4

PYTHON_DEPEND="2"

inherit eutils autotools

DESCRIPTION="A DJ console for ShoutCast/IceCast streaming"
HOMEPAGE="http://idjc.sourceforge.net/"
SRC_URI="mirror://sourceforge/idjc/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="aac flac mp3 mp3-streaming mp3-tagging speex"

RDEPEND=">=dev-python/pygtk-2.18:2
	media-libs/libsamplerate
	media-libs/libshout-idjc
	media-libs/libsndfile
	>=media-sound/vorbis-tools-1.2.0
	>=media-libs/mutagen-1.18
	>=media-sound/jack-audio-connection-kit-0.116.0
	aac? ( media-libs/faad2 )
	flac? ( >=media-libs/flac-1.1.3 )
	mp3? ( >=media-libs/libmad-0.15.1b )
	mp3-streaming? ( media-sound/lame )
	mp3-tagging? ( dev-python/eyeD3 )
	speex? ( >=media-libs/speex-1.2_rc1 )"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	# oldest version is >=media-video/ffmpeg-0.4.9_p20080326 anyway...
	for x in $(find . -name "*.[ch]" -print0 | xargs -0 grep -l "#include <ffmpeg/avcodec.h>" ); do
		sed -i -e "/avcodec\.h/s:ffmpeg:libavcodec:" $x;
	done
#	epatch "${FILESDIR}"/idjc-remove-avformatinfo.patch
	eautoreconf
}

src_configure() {
	econf $(use_enable aac) $(use_enable mp3) \
		$(use_enable mp3-streaming lame)
}

src_compile() {
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
}

pkg_postinst() {
	einfo "In order to run idjc you first need to have a JACK sound server running."
	einfo "With all audio apps closed and sound servers on idle type the following:"
	einfo "jackd -d alsa -r 44100 -p 2048"
	einfo "Alternatively to have JACK start automatically when launching idjc:"
	einfo "echo \"/usr/bin/jackd -d alsa -r 44100 -p 2048\" >~/.jackdrc"
	einfo ""
	einfo "If you want to announce tracks playing in idjc to IRC using X-Chat,"
	einfo "copy or link /usr/share/idjc/idjc-announce.py to your ~/.xchat2/ dir."
}
