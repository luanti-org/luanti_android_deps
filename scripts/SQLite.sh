#!/bin/bash -e
ver=3490100

download () {
	get_tar_archive sqlite-autoconf "https://www.sqlite.org/2025/sqlite-autoconf-${ver}.tar.gz"
}

build () {
	$srcdir/sqlite-autoconf/configure --host=$CROSS_PREFIX \
		--disable-shared --enable-static \
		--disable-fts{3,4,5} --disable-rtree
	make

	make_install_copy
}
