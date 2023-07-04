#change this directory if required
CRC_DIR=~/.crc
CRC_VERSION=2.22.1
ARCH=amd64

mkdir -p $CRC_DIR
wget https://mirror.openshift.com/pub/openshift-v4/clients/crc/$CRC_VERSION/crc-linux-$ARCH.tar.xz
tar -xvf crc-linux-$ARCH.tar.xz

mv -f crc-linux-$CRC_VERSION-$ARCH/* $CRC_DIR
rm crc-linux-$ARCH.tar.xz
rm -r crc-linux-$CRC_VERSION-$ARCH

cd $CRC_DIR
chmod +x crc

ln -sf $CRC_DIR/crc ~/bin/crc

crc version