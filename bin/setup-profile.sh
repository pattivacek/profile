#!/bin/bash

set -euo pipefail

cd ~
mkdir -p bin
cd bin
ln -s ~/Code/profile/bin/termtitle.sh .
cd ..

rm -f .bashrc .profile
ln -s ~/Code/profile/bashrc .bashrc
ln -s ~/Code/profile/gitconfig .gitconfig
ln -s ~/Code/profile/profile .profile
ln -s ~/Code/profile/vim .vim
ln -s ~/Code/profile/vimrc .vimrc

cd .vim
git submodule update --init --recursive
cd ..
