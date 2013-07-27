set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name='ics'

"hi NonText ctermfg=7 guifg=238
hi NonText ctermfg=241 guifg=#606060 gui=None
"hi SpecialKey ctermfg=2 cterm=bold
hi SpecialKey ctermfg=112 cterm=bold guifg=#99CC00 gui=bold
"hi Directory ctermfg=12 cterm=bold
hi Directory ctermfg=25 cterm=bold guifg=#0131B7 gui=bold
"hi ErrorMsg ctermfg=1 ctermbg=0
hi ErrorMsg ctermfg=203 ctermbg=233 guifg=#FF4444 guibg=bg
"hi IncSearch cterm=NONE ctermbg=7
hi IncSearch cterm=NONE ctermbg=241 gui=None guibg=#606060
"hi Search ctermbg=3
hi Search ctermbg=227 guibg=#FFEE30
"hi MoreMsg ctermfg=6
hi MoreMsg ctermfg=74 guifg=#33B5E5 gui=None
"hi ModeMsg ctermfg=7 cterm=NONE
hi ModeMsg ctermfg=241 cterm=NONE guifg=#606060 gui=None
"hi LineNr ctermfg=7
hi LineNr ctermfg=241 guifg=#606060
"hi CursorLineNr ctermfg=11 cterm=bold
hi CursorLineNr ctermfg=214 cterm=bold guifg=#F39C12 gui=bold
hi Question ctermfg=64 guifg=#3D9900 gui=None
hi StatusLine ctermfg=74 ctermbg=238 cterm=bold guifg=#33B5E5 guibg=#424242 gui=bold
hi StatusLineNC ctermfg=255 ctermbg=241 cterm=None guifg=#EAEAEA guibg=#606060 gui=None
hi VertSplit ctermfg=255 ctermbg=241 cterm=None guifg=#EAEAEA guibg=#606060 gui=None
hi Title ctermfg=241 cterm=bold guifg=#606060 gui=bold
hi Visual ctermbg=238 ctermfg=255 cterm=None guibg=#424242 guifg=#EAEAEA
hi VisualNOS ctermbg=238 ctermfg=255 cterm=None guibg=#424242 guifg=#EAEAEA
hi WarningMsg ctermfg=227 guifg=#FFEE30
hi WildMenu guibg=#33B5E5 guifg=#141515
hi Normal guibg=#141515 guifg=#eaeaea
