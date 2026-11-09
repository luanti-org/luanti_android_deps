#!/bin/bash -e
ver=1.12.1

download () {
	get_tar_archive libzip "https://libzip.org/download/libzip-${ver}.tar.gz"
}

build () {
	cmake $srcdir/libzip "${CMAKE_FLAGS[@]}" \
		-DBUILD_SHARED_LIBS=OFF \
		-DBUILD_{EXAMPLES,OSSFUZZ,REGRESS}=OFF -DENABLE_{BZIP2,LZMA,ZSTD}=OFF
	make

	make_install_copy
}
