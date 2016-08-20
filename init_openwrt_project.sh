#!/bin/bash

if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    exit
fi
echo "cloning openwrt into $1"
git clone git://git.openwrt.org/15.05/openwrt.git $1
cd $1
git reset --hard df520761523ad7e6d91841b6b8ea368e255c0baa
echo "preparing feeds.conf"
cp feeds.conf.default feeds.conf
echo src-git linkit https://github.com/MediaTek-Labs/linkit-smart-7688-feed.git >> feeds.conf
sed -i -e 's/openwrt\/packages\.git/zacheusz\/packages\.git/g' feeds.conf
scripts/feeds update -a
scripts/feeds install -a -p packages
rm .config
wget https://raw.githubusercontent.com/zacheusz/st/master/.config
make oldconfig
make -ij V=s tools/install
make -ij V=s toolchain/install

