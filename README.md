# DotFiles

My dotfiles for my development environment.

## Setting up a new machine

Git clone this repo to the machine.

Then use the symlink-dotfiles.sh script to automatically create symlinks for the dotfiles in the directory you just cloned. By default, it does not overwrite whatever you may have in that directory; you will need to delete any dotfiles in your home directory that you wish to autolink.

```
bash symlink-dotfiles.sh
```
