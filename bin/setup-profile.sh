#!/bin/bash

set -euo pipefail

cd ~
mkdir -p bin
cd bin
ln -s ~/Code/profile/bin/termtitle.sh .
# TODO: make sure git-praise is present, and/or fetch it.
# TODO: make sure ruby is installed.
ln -s ~/Code/git-praise/git-praise .
cd ..

mv ~/.bashrc ~/.bashrc-backup
mv ~/.profile ~/.profile-backup

ln -s ~/Code/profile/bashrc .bashrc
ln -s ~/Code/profile/gitconfig .gitconfig
ln -s ~/Code/profile/profile .profile
ln -s ~/Code/profile/vim .vim
ln -s ~/Code/profile/vimrc .vimrc

cd .vim
git submodule update --init --recursive
cd ..

# TODO: make sure vim is installed.
