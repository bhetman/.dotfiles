" Allow manpage browsing from within Vim
runtime ftplugin/man.vim

" Remove the startup splash
set shortmess+=I

" Make Vim more responsive
set timeoutlen=500
set ttimeoutlen=100

if has('gui_running')
  " Remove the toolbar
  set guioptions-=T
  " Remove the menubar
  set guioptions-=m
endif

" Enable UTF-8 editing
if has("multi_byte")
  set encoding=utf-8
  setglobal fileencoding=utf-8
  set fileencodings=utf-8
endif

" Create undo file
set undofile

" Allow backspacing over autoindent, line breaks, and the start of insert
set backspace=indent,eol,start

" Allow editing of new buffers when unsaved buffers exist
set hidden

" Always show the ruler
set ruler

" Show commands entered in normal mode
set showcmd

" When doing command completion (with tab) show the longest available match
" first, then complete full matches
set wildmode=longest,full

" Relative line numbering
set relativenumber

" Highlight search matches
set hlsearch

" Incrementally search
set incsearch

" Make global substitution default (the g flag now disables global substitution)
set gdefault

" Change cursor shape based on Vim mode. This is terminal dependent.
" This would be a good place to define cursor color
if &term =~ '^xterm'
  let &t_SI = "\<Esc>[3 q"
  let &t_EI = "\<Esc>[1 q"
elseif &term == 'konsole'
  let &t_SI = "\<Esc>]50;CursorShape=2\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
" This should work for 'linux' but doesn't for some reason.
"elseif &term == 'linux'
  "let &t_SI = "\033[?2c"
  "let &t_EI = "\033[?6c"
  "let &t_SI = "\e[?2c"
  "let &t_EI = "\e[?6c"
  "let &t_SI = "\<Esc>[?2c"
  "let &t_EI = "\<Esc>[?6c"
endif

" When using the mouse to select text, don't select the line numbers.
if &term != 'linux'
  set mouse=a
endif

" Enable Filetype detection, filetype plugins, and filetype indentation
filetype plugin indent on

" Enable syntax highlighting
syntax on

" Use syntax based folding
set foldmethod=syntax

" Don't auto close folds
set foldlevelstart=99

" Enable Omni Complete
set omnifunc=syntaxcomplete#Complete

" Set the colorscheme
colorscheme Tomorrow-Night-Bright

" Enable Spelling
set spell
set spelllang=en_us

"TODO: omnicomplete
