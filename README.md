# DotFiles

My dotfiles for my development environment.

## Setting up a new machine

1. Git clone this repo to the machine
2. Symlink each of the dotfiles needed to the ~/ directory for that machine.

## How to symlink each dotfile

The symlink-dotfiles.sh script is available to automatically create symlinks for the dotfiles in this directory. By default, it does not overwrite whatever you may have in that directory; you will need to delete any dotfiles in your home directory that you wish to autolink.

```
bash symlink-dotfiles.sh
```
