#!/bin/bash

useradd builder -m
echo "builder ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
chmod -R a+rw .

pacman-key --init
pacman -Sy --noconfirm &&

cd ${INPUT_PKGNAME}

ver=$(curl -s https://api.github.com/repos/koreader/koreader/releases/latest | jq '.tag_name'|tr -d 'v"')
sed -i "s/pkgver=.*/pkgver=2021.10.1/" PKGBUILD
sudo -u builder  updpkgsums

rm koreader-$ver-amd64.deb

echo OK
