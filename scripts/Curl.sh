#!/bin/bash -e
mbedtls_ver=3.6.5
curl_ver=8.17.0

download () {
	get_tar_archive mbedtls "https://github.com/Mbed-TLS/mbedtls/releases/download/mbedtls-${mbedtls_ver}/mbedtls-${mbedtls_ver}.tar.bz2"
	get_tar_archive curl "https://curl.se/download/curl-${curl_ver}.tar.gz"
}

build () {
	# Build mbedtls first
	mkdir -p mbedtls
	local mbedtls=$PWD/mbedtls
	pushd $srcdir/mbedtls
	make -s clean # necessary
	make library
	make DESTDIR=$mbedtls install
	popd

	$srcdir/curl/configure --host=$CROSS_PREFIX \
		--with-mbedtls="$mbedtls" --without-libpsl \
		--disable-shared --enable-static --disable-{debug,verbose} \
		--disable-{proxy,cookies,crypto-auth,manual,ares,ftp,unix-sockets} \
		--disable-{ldap,rtsp,dict,telnet,tftp,pop3,imap,smtp,gopher,mqtt}
	make
	make_install_copy

	# For mbedtls install only the libraries
	cp $mbedtls/lib/*.a $pkgdir/
}
