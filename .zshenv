export LC_COLLATE=C
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim
export BROWSER=/usr/bin/firefox
export LESSCHARSET=utf-8
export TERMINAL=/usr/bin/xterm

alias view='$(which vim) -R'
export MANPAGER="$SHELL -c 'view -Mn -c \"set ft=man nomod nolist nospell nornu noundofile\" </dev/tty <(col -b -x)'"

# For android SDK
typeset -U PATH
export ANDROID_HOME=$HOME/projects/android/android-sdk-linux_x86
export PATH=$PATH:$ANDROID_HOME/tools

