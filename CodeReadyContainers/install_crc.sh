#change this directory if required
CRC_DIR=~/.crc

usage() {
    echo "./install_crc.sh <crc version>"
}

CRC_VERSION=latest
ARCH=amd64
TMP_OUTPUT_DIR=output

if [ "$#" -gt 1 ]; then
    echo "Illegal number of parameters"
elif [ "$#" -eq 1 ]; then
    CRC_VERSION=$1
fi

echo "installing crc version: $CRC_VERSION"

mkdir -p $CRC_DIR

mkdir -p $TMP_OUTPUT_DIR

wget -q https://mirror.openshift.com/pub/openshift-v4/clients/crc/$CRC_VERSION/crc-linux-$ARCH.tar.xz
tar -xvf crc-linux-$ARCH.tar.xz -C $TMP_OUTPUT_DIR --strip-components 1

mv -f $TMP_OUTPUT_DIR/* $CRC_DIR
rm crc-linux-$ARCH.tar.xz
rm -rf $TMP_OUTPUT_DIR

cd $CRC_DIR
chmod +x crc

ln -sf $CRC_DIR/crc ~/bin/crc

crc version