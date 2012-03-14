#!/bin/bash

set -e
set -x

sudo apt-get install libssl-dev
# for some reason this installs over and over again. skip it if we can.
if [[ ! -x /opt/ruby/bin/fpm ]]; then
    sudo gem install fpm
fi

RUBY_VERSION="1.9.3-p125"
SOURCE_FILE_NAME=ruby-${RUBY_VERSION}
INSTALL_DIR=/tmp/installdir
WORKING_DIRECTORY=~/source
PACKAGE_NAME=goodfilms-${SOURCE_FILE_NAME}_x86_64.deb

# clean any previous build artifacts
rm -rf ${INSTALL_DIR}
mkdir ${INSTALL_DIR}

# do all our work in source
mkdir -p ${WORKING_DIRECTORY}
cd ${WORKING_DIRECTORY}

# Download & compile ruby
if [[ ! -f ${SOURCE_FILE_NAME}.tar.gz ]]; then
  wget ftp://ftp.ruby-lang.org//pub/ruby/1.9/${SOURCE_FILE_NAME}.tar.gz
fi
tar -zxvf ${SOURCE_FILE_NAME}.tar.gz
cd ${SOURCE_FILE_NAME}
time (./configure --prefix=/usr && make && make install DESTDIR=${INSTALL_DIR})
cd ..

# package up the newly compiled ruby
fpm -s dir -t deb -n ruby -v ${RUBY_VERSION} -a x86_64 -C /tmp/installdir \
  -p ${PACKAGE_NAME} -d "libstdc++6 (>= 4.4.3)" \
  -d "libc6 (>= 2.6)" -d "libffi5 (>= 3.0.4)" -d "libgdbm3 (>= 1.8.3)" \
  -d "libncurses5 (>= 5.7)" -d "libreadline6 (>= 6.1)" \
  -d "libssl0.9.8 (>= 0.9.8)" -d "zlib1g (>= 1:1.2.2)" \
  usr/bin usr/lib usr/share/man usr/include

# copy the deb package back to your vagrant folder
cp ${PACKAGE_NAME} /vagrant
