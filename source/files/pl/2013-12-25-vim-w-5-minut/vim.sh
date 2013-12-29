#!/usr/bin/env bash

git clone git://github.com/amix/vimrc.git ~/.vim_runtime
cd ~/.vim_runtime
sh ./install_awesome_vimrc.sh
git submodule add -f git://github.com/mattn/emmet-vim.git sources_non_forked/emmet-vim
git submodule add -f git://github.com/sjl/gundo.vim.git sources_non_forked/gundo
git submodule add -f git://github.com/scrooloose/nerdcommenter.git sources_non_forked/nerdcommenter
git submodule add -f git://github.com/scrooloose/syntastic sources_non_forked/syntastic
git submodule add -f https://github.com/godlygeek/tabular.git sources_non_forked/tabular
git submodule add -f git://github.com/majutsushi/tagbar sources_non_forked/tagbar
git submodule add -f git://github.com/szw/vim-ctrlspace sources_non_forked/vim-ctrlspace 
git submodule add -f git://github.com/Lokaltog/vim-easymotion.git sources_non_forked/vim-easymotion
git submodule add -f git://github.com/tpope/vim-surround.git sources_non_forked/vim-surround
 
