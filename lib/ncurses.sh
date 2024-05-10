#!/usr/bin/env bash

set -e

SCRIPTF=$(realpath "$0")  # full path
SCRIPT=$(basename $SCRIPTF) # file
SCRIPTD=$(dirname "$SCRIPTF") # folder

# Read env variables for CC, C++, LD, etc
source $SCRIPTD/../scripts/cosmic.sh

cd $ROOT/tmp/
echo $PWD

# ncurses (new curses) library
# https://invisible-island.net/ncurses/
#
NAME="${SCRIPT%.*}"

mkdir $NAME
wget -nv -O $NAME.tar.gz https://ftp.gnu.org/gnu/ncurses/ncurses-6.5.tar.gz
tar xf $NAME.tar.gz --strip-components=1 -C $NAME
echo "Archive downloaded and extracted"

cd $ROOT/tmp/$NAME
echo $PWD

# Configure ...
./configure --enable-static --disable-shared \
    --disable-lib-suffixes\
    --disable-stripping \
    --enable-widec \
    --with-curses-h \
    --with-termlib \
    --with-ticlib \
    --without-ada \
    --without-cxx \
    --without-cxx-binding\
    --without-debug \
    --without-dlsym \
    --without-libtool \
    --without-manpages \
    --without-pcre2 \
    --without-sysmouse\
    --without-tack\
    --without-tests \
    --without-tests \
    --prefix=$ROOT/o/ \
    CFLAGS="-Os"

# Build ...
ape make
# Install ...
ape make install
