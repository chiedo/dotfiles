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
    ".vscode"
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

# Mac
if [[ "$OSTYPE" == "darwin"* ]]; then
  # Set up a symlink for VSCode settings.json
  ln -sf $DIR/.vscode/settings.json $HOME/Library/Application\ Support/Code/User/settings.json

  # Install Powerline Fonts
  git clone https://github.com/powerline/fonts.git --depth=1
  cd fonts
  ./install.sh
  cd ..
  rm -rf fonts
elif ! [ "$CODESPACES" = true ]; then
  # Set up a symlink for VSCode settings.json
  ln -sf $DIR/.vscode/settings.json $HOME/.config/Code/User/settings.json

  # Install Powerline Fonts
  sudo apt-get install fonts-powerline
#Linux
else
  # No specific symlink is needed. It can use .vscode/settings.json directly
  # Install Powerline Fonts
  sudo apt-get install fonts-powerline
fi

# Make sure BundleInstall has executed
vim -c ':silent! BundleInstall' -c ':BundleInstall' -c ":x" -c ":x"


# Set global gitignore
git config --global core.excludesfile ~/.gitignore_global

echo "All done"
