#!/bin/bash

# Install vundle (required for the vim stuff)
VUNDLE_GIT=https://github.com/VundleVim/Vundle.vim.git
VUNDLE_TARGET=$HOME/.vim/bundle/Vundle.vim
if [ ! -d $VUNDLE_TARGET ]; then
    echo "Installing Vundle..."
    mkdir $HOME/.vim
    mkdir $HOME/.vim/bundle
    git clone $VUNDLE_GIT $VUNDLE_TARGET
else
    echo "Vundle appears to already be installed."
fi


# Create a symlink for each dotfile in the home directory

DOTFILES=(
    ".bash_aliases"
    ".bash_functions"
    ".bash_python_aliases"
    ".autocorrections.vim"
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

# Set up a symlink for VSCode settings.json
ln -sf $DIR/vscode/settings.json $HOME/Library/Application\ Support/Code/User/settings.json
ln -sf $DIR/vscode/settings.json $HOME/.config/Code/User/settings.json

# Make sure BundleInstall has executed
vim -c ':silent! colors' -c ':silent! BundleInstall' -c ':BundleInstall' -c ":x" -c ":x"

# Install Powerline Fonts
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

# Set global gitignore
git config --global core.excludesfile ~/.gitignore_global

echo "All done"
