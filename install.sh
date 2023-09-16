#!/bin/bash

if [ ! -d "$HOME/.vim/plugin" ]
then
  mkdir ~/.vim/plugin
fi

cp arduino-integration.vim ~/.vim/plugin
