#!/bin/bash

if [ -z $1 ]; then
    echo "Specify the path to the configs dir"
    exit 99
fi

# Symlink the config files in ~/
configs=`pwd $1`
for i in `ls -1 $configs`; do
    if [[ $i == "install.sh" ||
          $i == bashrc ||
          $i == profile ]]; then
        continue
    fi
    dotfile=$HOME/.$i
    if [ ! -e $dotfile ]; then
        ln -s $configs/$i $dotfile
        echo "$dotfile created"
    else
        echo "$dotfile already exists"
    fi
done 

# Create required directories
mkdir -p ~/src
mkdir -p ~/.bkp/vim/swap
mkdir -p ~/.irclogs
