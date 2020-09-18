#!/bin/bash

# Create a symlink for each dotfile in the home directory

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

DOTFILES=(
    ".bash_aliases"
    ".bash_functions"
    ".bash_python_aliases"
    ".gitconfig"
    ".gitignore_global"
    ".tmux.conf"
    ".vim"
    ".vimrc"
)

for dotfile in ${DOTFILES[@]}; do
    if [ -h ~/$dotfile ]; then  # symlink
        echo "~/$dotfile: overwriting existing symlink..."
        ln -snf $DIR/$dotfile ~/$dotfile
    elif [ -e ~/$dotfile ]; then  # any other file
        echo "~/$dotfile: file exists, skipping..."
    else  # no file
        echo "~/$dotfile: creating symlink..."
        ln -s $DIR/$dotfile ~/$dotfile
    fi
done

# Install vundle (required for the vim stuff)
VUNDLE_GIT=https://github.com/VundleVim/Vundle.vim.git
VUNDLE_TARGET=~/.vim/bundle/Vundle.vim
if [ ! -d $VUNDLE_TARGET ]; then
    echo "Installing Vundle..."
    git clone $VUNDLE_GIT $VUNDLE_TARGET
else
    echo "Vundle appears to already be installed."
fi
