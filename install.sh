#!/bin/bash
# A rudimentary install script.
# This script symlinks the dotfiles in this repo into their proper places.

# There are only a few files we need to link, so iterating over this variable
# will do. If this install procedure gets more complex a better method should be
# found.
FILES=".vimrc
.zshrc
.zshenv
.nethackrc"

# Loop over the files and (after checking for existence) link the file into the
# home directory.
for file in $FILES
do
  if [[ ! -e $file ]]; then
    continue
  fi
  ln -s "$PWD/$file" "$HOME"
  ret=$?
  if [[ $ret -gt 0 ]]; then
    echo "Could not create symlink for $file (ln returned $ret)."
  fi
done

exit 0
