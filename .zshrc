# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt incappendhistory
# End of lines configured by zsh-newuser-install

# Turn stderr (fd 2) red. See https://github.com/sickill/stderred for more. To
# enable set $stderreddir to the location of the libstderred.so shared object.
stderreddir="$HOME/src/stderred/build/libstderred.so"
if [[ -e $stderreddir ]]; then
  export LD_PRELOAD=$stderreddir${LD_PRELOAD:+:$LD_PRELOAD}
fi

# For fortune on login (only for non root)
if [[ ! $UID -eq 0 ]]; then
  command fortune -a
fi

setopt extendedglob

# Prevent > from clobbering files. Use >! to force.
setopt noclobber

# Allow clobbering with !!
setopt histallowclobber

# Ignore history duplicates
# Note: this still allows duplicates separated by at least one other command.
setopt histignoredups

# Prune dups from the history first
setopt histexpiredupsfirst

# Don't save commands beginning with a space in the history
# Note: !! will still work
setopt histignorespace

# Clean up commands before inserting into the history
setopt histreduceblanks

# Allow peeking at the history without ruining the numbering
# And don't store functions (They can be long)
setopt histnostore
setopt histnofunctions

# Don't beep if a menu is produced
setopt nolistbeep

# When first completion is ambigious show menu anyway
unsetopt listambiguous

# When changing directories, actually follow links
setopt chaselinks

# Order completions the right way
setopt listrowsfirst

# Only show RPROMPT on the last line
setopt transientrprompt

# Display pid when suspending jobs
setopt longlistjobs

# Silently auto pushd on cd
# Also limit the size of the directory stack
# Enable cd -num syntax to reference
# the num-th entry in the directory stack
setopt pushdsilent
setopt autopushd
setopt pushdminus
DIRSTACKSIZE=15

setopt rcexpandparam

setopt completeinword

autoload -U compinit promptinit colors
compinit
promptinit
colors

PS1="%{$fg[cyan]%U%}%m%{%u$reset_color%}\
%(!.%{$fg[red]%}#%{$reset_color%}.>) "

RPS1="%{$fg_bold[green]%}%~%{$reset_color%}\
%(?..%{$fg_bold[red]%}(%?%)%{$reset_color%})\
%(1j.%{$fg_bold[blue]%}:%j%{$reset_color%}.)"

zstyle ':completion:*' menu select
zstyle ':completion:*' use-compctl false
# Display completion group names and group them together
zstyle ':completion:*:descriptions' format '%U%d%u'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' completer _expand _complete _match _ignored\
	_correct _approximate _prefix

eval $(dircolors -b)
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
alias ls='ls --color=auto --group-directories-first -x'
alias grep='grep --color=auto'

### VI MODE INDICATOR
# The functions update-cursor and init-cursor are called by zle-keymap-select,
# zle-keymap-select, and zle-line-init. Together they indicate the current
# mode when using vi key bindings. For more info see man 5 terminfo, man 1M
# infocmp, man 1 tput, man 4 console_codes,
# and http://invisible-island.net/xterm/ctlseqs/ctlseqs.html
# Note: konsole's $TERM value must be 'konsole'; see below.

# By default konsole sets $TERM to xterm (I suspect this is for
# legacy and/or compatibility reasons). However, this hinders our ability
# to indicate the current mode, because konsole uses it's own method to
# change the cursor shape. Manually change konsole's environment settings
# to report 'konsole' in order to make this function work.
 
function update-cursor () {
  # Save the cursor position.
  case "$TERM" in 
    (konsole) ;& # Fall through.
    (xterm) echo -ne "\033[s";;
    (linux) echo -ne "\e[s";;
    (*) return;;
  esac

  # Update the cursor shape.
  case "$KEYMAP" in
    (vicmd) echo -ne "$block";;
    (viins|main) echo -ne "$underline";;
  esac

  # Restore the cursor position.
  case "$TERM" in
    (konsole) ;& # Fall through.
    (xterm) echo -ne "\033[u";;
    (linux) echo -ne "\e[u";;
    (*) ;;
  esac
}

function init-cursor () {
  case "$TERM" in
    (xterm) block="\033[1 q";underline="\033[3 q";;
    (konsole)
      block=$($(which konsoleprofile) "CursorShape=0");
      underline=$($(which konsoleprofile) "CursorShape=2");;
    (linux) block="\e[?6c";underline="\e[?2c";;
    (*) block="";underline="";;
  esac
}

function zle-keymap-select () {
  update-cursor
}; zle -N zle-keymap-select

function zle-line-init () {
  init-cursor
  update-cursor
}; zle -N zle-line-init

# When commands are executed return the cursor to the block shape. This forces
# consistency in programs like Vim, which do not reset the cursor on starup.
function zle-line-finish () {
  zle -K vicmd
  update-cursor
}; zle -N zle-line-finish

### FIX KEYS
# from http://zshwiki.org/home/zle/bindkeys

autoload zkbd
function zkbd_file() {
    [[ -f ~/.zkbd/${TERM}-${VENDOR}-${OSTYPE} ]] \
    	&& printf '%s' ~/".zkbd/${TERM}-${VENDOR}-${OSTYPE}" && return 0
    [[ -f ~/.zkbd/${TERM}-${DISPLAY} ]] \
    	&& printf '%s' ~/".zkbd/${TERM}-${DISPLAY}" && return 0
    return 1
}

[[ ! -d ~/.zkbd ]] && mkdir ~/.zkbd
keyfile=$(zkbd_file)
ret=$?
if [[ ${ret} -ne 0 ]]; then
    zkbd
    keyfile=$(zkbd_file)
    ret=$?
fi
if [[ ${ret} -eq 0 ]] ; then
    source "${keyfile}"
else
    printf 'Failed to setup keys using zkbd.\n'
fi
unfunction zkbd_file; unset keyfile ret

# setup keys accordingly
[[ -n "${key[Home]}" ]] && bindkey "${key[Home]}" vi-beginning-of-line
[[ -n "${key[Home]}" ]] && bindkey -a "${key[Home]}" vi-beginning-of-line
[[ -n "${key[End]}" ]] && bindkey "${key[End]}" vi-end-of-line
[[ -n "${key[End]}" ]] && bindkey -a "${key[End]}" vi-end-of-line
[[ -n "${key[Insert]}" ]] && bindkey "${key[Insert]}" overwrite-mode
[[ -n "${key[Delete]}" ]] && bindkey "${key[Delete]}" delete-char
[[ -n "${key[Delete]}" ]] && bindkey -a "${key[Delete]}" delete-char
[[ -n "${key[PageUp]}" ]] && bindkey "${key[PageUp]}" up-history
[[ -n "${key[PageUp]}" ]] && bindkey -a "${key[PageUp]}" up-history
[[ -n "${key[PageDown]}" ]] && bindkey "${key[PageDown]}" down-history
[[ -n "${key[PageDown]}" ]] && bindkey -a "${key[PageDown]}" down-history
bindkey "^r" redo
bindkey -a "^r" redo
bindkey "^_" undo
bindkey -a "u" undo
bindkey -a "/" history-incremental-pattern-search-backward
bindkey -a "?" history-incremental-pattern-search-forward
bindkey "\e[Z" reverse-menu-complete
bindkey -a "\e[Z" reverse-menu-complete
bindkey "^g" send-break
bindkey -a "^g" send-break
bindkey "^I" complete-word
bindkey -a "^I" complete-word

# possibilities for the future
# setopt nullglob
# setopt sharehistory
# setopt autonamedirs
# setopt correct
# setopt cbases
# zstyle cache
# suffix aliases (alias -s)
