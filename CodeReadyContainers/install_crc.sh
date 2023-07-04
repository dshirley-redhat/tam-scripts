#change this directory if required
CRC_DIR=~/crc
VERSION=2.22.1
ARCH=amd64


mkdir $CRC_DIR
wget https://mirror.openshift.com/pub/openshift-v4/clients/crc/$VERSION/crc-linux-$ARCH.tar.xz
tar -xvf crc-linux-$ARCH.tar.xz

mv crc-linux-$VERSION-$ARCH/* $CRC_DIR
rm crc-linux-$ARCH.tar.xz
rm -r crc-linux-$VERSION-$ARCH

cd $CRC_DIR
chmod +x crc