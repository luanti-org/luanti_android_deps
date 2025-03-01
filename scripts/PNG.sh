#!/bin/bash -e
png_ver=1.6.47

download () {
	get_tar_archive libpng "https://download.sourceforge.net/libpng/libpng-${png_ver}.tar.gz"
}

build () {
	$srcdir/libpng/configure --host=$CROSS_PREFIX
	make
	make_install_copy
}
