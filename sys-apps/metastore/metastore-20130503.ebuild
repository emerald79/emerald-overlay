# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit git-2

DESCRIPTION="Tool to store the metadata of files,directories,links in a file tree"
HOMEPAGE="http://david.hardeman.nu/software.php"
EGIT_REPO_URI="https://github.com/przemoc/metastore.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

EGIT_COMMIT="d5a3600ae32b4d43c91bda2cc8cd554b04c119c6"

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc README || die "docs install failed"
}
