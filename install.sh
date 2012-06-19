#!/bin/bash
# A rudimentary install script.
# This script symlinks the dotfiles in this repo into their proper places.

# There are only a few files we need to link, so iterating over this variable
# will do. If this install procedure gets any more complex a new method should
# be found.
FILES=".vimrc
.zshrc
.zshenv
.nethackrc"

for file in $FILES
do
  if [[ ! -e $file ]]; then
    continue
  fi
  ln -s "$PWD/$file" "$HOME"
done

exit 0
