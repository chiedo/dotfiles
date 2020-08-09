# DotFiles

My dotfiles for my development environment.

## Setting up a new machine

1. Git clone this repo to the machine
2. Symlink each of the dotfiles needed to the ~/ directory for that machine.

## How to symlink each dotfile

Take an example dotfile under the name `.example` on an OSX machine or the following on a linux machine. Keeping in mind that the absolute path below is a personal convention of mine.

```
# Be sure to use an absolute path
ln -nfs /Users/chiedo/github.com/chiedo/dotfiles/.gitconfig /Users/chiedo/.gitconfig
```

Or for an Ubuntu box
```
# Be sure to use an absolute path
ln -nfs /home/chiedo/github.com/chiedo/dotfiles/.gitconfig /home/chiedo/.gitconfig
```
