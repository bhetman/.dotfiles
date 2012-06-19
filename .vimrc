" allow manpage browsing from within vim
"let $PAGER=''
runtime ftplugin/man.vim

" remove the startup splash
set shortmess+=I

if has('gui_running')
  " remove the toolbar
  set guioptions-=T
endif

" create undo file
set undofile

" allow backspacing over autoindent, line breaks, and the start of insert
set backspace=indent,eol,start

" allow editing of new buffers when unsaved buffers exist
set hidden

" ruler
set ruler

" show commands entered in normal mode
set showcmd

" when doing command completion (with tab) show longest match first with a
" list, then full matches
set wildmode=longest,full

" relative line numbering
set relativenumber

" highlight search matches
set hlsearch

" instant search
set incsearch

" make global substitution default (the g flag now disables global substitution)
set gdefault

" Initialize variables for changing cursor shape. This would be a good place
" to define cursor color
"let &t_SI = \""
"let &t_EI = \""
" Change cursor shape based on Vim mode. This is terminal dependent
if &term =~ '^xterm'
  let &t_SI = "\<Esc>[3 q"
  let &t_EI = "\<Esc>[1 q"
elseif &term == "konsole"
  let &t_SI = "\<Esc>]50;CursorShape=2\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
" This should work for \"linux" but doesn't for some reason.
" (remove the leading '\', obviously)
"elseif &term == "linux"
  "let &t_SI = \"\033[?2c"
  "let &t_EI = \"\033[?6c"
  "let &t_SI = \"\e[?2c"
  "let &t_EI = \"\e[?6c"
  "let &t_SI = \"\<Esc>[?2c"
  "let &t_EI = \"\<Esc>[?6c"
endif

" filetype detection, filetype plugins, and filetype indentation
filetype plugin indent on

" syntax highlighting
syntax on

" syntax based folding
set foldmethod=syntax

" don't auto close folds
set foldlevelstart=99

" Omni Complete
set omnifunc=syntaxcomplete#Complete

" colorscheme
colorscheme murphy

" spelling
set spell
set spelllang=en_us

"TODO: omnicomplete
