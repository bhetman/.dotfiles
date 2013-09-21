#!/bin/zsh
# A rudimentary install script.
# This script symlinks the dotfiles in this repo into their proper places.

FILES=(.vimrc .zshrc .zshenv .nethackrc .Xresources .xinitrc .Xmodmap
  .xbindkeysrc i3)
typeset -A destdir
destdir=(i3 $HOME/.config)

zparseopts -D -A opts -- v -verbose

if (( ${+opts[-v]} || ${+opts[--verbose]} )); then
  debug=1
fi
# Loop over the files and (after ensuring the destination doesn't already exist)
# link the file into $destdir if specified, falling back to $HOME otherwise.
for file in $FILES
do
  dest=$HOME
  if [[ -n $destdir[$file] ]]; then
    dest=$destdir[$file]
    if [[ ! -e $dest ]]; then
      if (( $debug )); then
        echo "Creating $dest"
      fi
      mkidr -p $dest
    fi
  fi
  if [[ ! -e $dest/$file ]]; then
    if (( $debug )); then
      echo -n "Linking $file..."
    fi
    ln -s $PWD/$file $dest
    if [[ ret=$? -gt 0 ]]; then
      echo -e "\tCould not create symlink for $file (ln returned $ret)."
      continue
    fi
    if (( $debug )); then
      echo "Success!"
    fi
  fi
done

exit 0
