# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

DESCRIPTION="A tool for creating machine images"
HOMEPAGE="http://www.packer.io"
SRC_URI=""

EGIT_REPO_URI="git://github.com/mitchellh/packer.git"
EGIT_COMMIT="v${PV}"
EGIT_CHECKOUT_DIR="${WORKDIR}/go/src/github.com/mitchellh/packer"

inherit git-r3 eutils

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="
	>=dev-lang/go-1.6
	dev-vcs/git
"
RDEPEND=""

S="${EGIT_CHECKOUT_DIR}"

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	export GOPATH="${WORKDIR}/go"
	export PATH="${GOPATH}/bin:${PATH}"

	# apply patches if any
#	if declare -p PATCHES | grep -q "^declare -a "; then
#		[[ -n ${PATCHES[@]} ]] && eapply "${PATCHES[@]}"
#	else
#		[[ -n ${PATCHES} ]] && eapply ${PATCHES}
#	fi
	eapply_user
}

src_compile() {
	emake deps releasebin || die "make failed"
}

src_install() {
	dobin "${GOPATH}"/bin/packer*
}

