#!/bin/bash

# Install vundle (required for the vim stuff)
VUNDLE_GIT=https://github.com/VundleVim/Vundle.vim.git
VUNDLE_TARGET=$HOME/.vim/bundle/Vundle.vim
if [ ! -d $VUNDLE_TARGET ]; then
    echo "Installing Vundle..."
    mkdir $HOME/.vim
    mkdir $HOME/.vim/bundle
    git clone $VUNDLE_GIT $VUNDLE_TARGET
    vim -c ':silent! colors' -c ':silent! BundleInstall' -c ':BundleInstall' -c ":x" -c ":x"
else
    echo "Vundle appears to already be installed."
fi

# Create a symlink for each dotfile in the home directory

DOTFILES=(
    ".bash_aliases"
    ".bash_functions"
    ".bash_python_aliases"
    ".gitconfig"
    ".gitignore_global"
    ".tmux.conf"
    ".oh-my-zsh"
    ".vimrc"
    ".zshrc"
)

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

for dotfile in ${DOTFILES[@]}; do
    if [ -h $HOME/$dotfile ]; then  # symlink
        echo "$HOME/$dotfile: overwriting existing symlink..."
        ln -snf $DIR/$dotfile $HOME/$dotfile
    elif [ -e $HOME/$dotfile ]; then  # any other file
        echo "$HOME/$dotfile: file exists, renaming to $HOME/$dotfile.dotfile-backup..."
        mv $HOME/$dotfile $HOME/$dotfile.dotfile-backup-$(date +%s)
        echo "$HOME/$dotfile: creating symlink..."
        ln -s $DIR/$dotfile $HOME/$dotfile
    else  # no file
        echo "$HOME/$dotfile: creating symlink..."
        ln -sf $DIR/$dotfile $HOME/$dotfile
    fi
done

echo "All done"
