#!/bin/bash

set -ex

# Install ccache from source.
# Needs specific branch to work with nvcc (ccache/ccache#145)
# Also pulls in a commit that disables documentation generation,
# as this requires asciidoc to be installed (which pulls in a LOT of deps).
pushd /tmp
git clone https://github.com/pietern/ccache -b ccbin
pushd ccache
./autogen.sh
./configure --prefix=/usr/local
make "-j$(nproc)" install
popd
popd

# Install sccache from pre-compiled binary.
curl https://s3.amazonaws.com/ossci-linux/sccache -o /usr/local/bin/sccache
chmod a+x /usr/local/bin/sccache
