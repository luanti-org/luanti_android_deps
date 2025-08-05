#!/bin/bash -e
ver=1.24.3

download () {
	get_tar_archive openal-soft "https://github.com/kcat/openal-soft/archive/refs/tags/${ver}.tar.gz"
}

build () {
	cmake $srcdir/openal-soft "${CMAKE_FLAGS[@]}" \
		-DLIBTYPE=STATIC -DALSOFT_BACKEND_WAVE=FALSE -DALSOFT_NO_CONFIG_UTIL=TRUE
	make

	make_install_copy
}
