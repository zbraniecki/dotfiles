#!/bin/bash

if [ -z $1 ]; then
    echo "Specify the path to the configs dir"
    exit 99
fi

# Create required directories
mkdir -p ~/.local/bin
mkdir -p ~/.local/env
mkdir -p ~/.local/bkp/vim/swap


# Symlink the config files in ~/
configs=`pwd $1`
for i in `ls -1 $configs`; do
    if [[ $i == "install.sh" ]]; then
        continue
    fi
    if [[ $i == bashrc ||
          $i == profile ||
          $i == vimrc ||
          $i == vim ||
          $i == hgrc ||
          $i == gitconfig ]]; then
        dotfile=$HOME/.$i
	if [ ! -e $dotfile ]; then
	    ln -s $configs/$i $dotfile
	    echo "$dotfile created"
	else
	    echo "$dotfile already exists"
	fi
    fi
    if [[ $i == extra ||
          $i == gitignore_global ||
          $i == hgignore ]]; then
        dotfile=$HOME/.local/$i
	if [ ! -e $dotfile ]; then
	    ln -s $configs/$i $dotfile
	    echo "$dotfile created"
	else
	    echo "$dotfile already exists"
	fi
    fi
done
 
ln -s $configs/ssh/* $HOME/.ssh/

