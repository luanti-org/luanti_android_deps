#!/bin/bash -e
ndk_version=r29
ndk_version_n=29.0.14206865

# Build tools and stuff
sudo apt-get update
sudo apt-get install -y wget unzip zip gcc-multilib make cmake

# NDK
if [ -d "/usr/local/lib/android/sdk/ndk/${ndk_version_n}" ]; then
	echo "Found system-wide NDK"
	ndkpath="/usr/local/lib/android/sdk/ndk/${ndk_version_n}"
else
	wget --progress=bar:force "http://dl.google.com/android/repository/android-ndk-${ndk_version}-linux.zip"
	unzip -q "android-ndk-${ndk_version}-linux.zip"
	rm "android-ndk-${ndk_version}-linux.zip"
	ndkpath="$PWD/android-ndk-${ndk_version}"
fi
if ! grep -qF "${ndk_version_n}" "${ndkpath}/source.properties"; then
	echo "NDK version mismatch"
	exit 1
fi

printf 'export ANDROID_NDK="%s"\n' "${ndkpath}" >env.sh
