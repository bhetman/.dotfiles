#!/bin/bash
# A rudimentary install script.
# This script symlinks the dotfiles in this repo into their proper places.

# There are only a few files we need to link, so iterating over this variable
# will do. If this install procedure gets more complex a better method should be
# found.
FILES=".vimrc
.zshrc
.zshenv
.nethackrc
.Xresources
.xinitrc
.Xmodmap
.xbindkeysrc"

# Loop over the files and (after checking for existence) link the file into the
# home directory.
for file in $FILES
do
  if [[ ! -e "$HOME/$file" ]]; then
    echo -n "Linking $file..."
    ln -s "$PWD/$file" "$HOME"
    if [[ ret=$? -gt 0 ]]; then
      echo -e "\tCould not create symlink for $file (ln returned $ret)."
      continue
    fi
    echo "Success!"
  fi
done

exit 0
