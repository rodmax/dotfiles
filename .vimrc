set noswapfile " do not create .swp files

set t_Co=256

" Status line dfdfdf
set laststatus=2
" define 3 custom highlight groups
hi User1 ctermbg=gray ctermfg=black
hi User2 ctermbg=gray ctermfg=DarkRed
hi User3 ctermbg=gray ctermfg=black

set statusline=

set statusline+=%3*  " switch to User1 highlight
set statusline+=%.60F\  " full filename max length 60

set statusline+=%2*  " switch to User1 highlight
set statusline+=%m
set statusline+=%r

set statusline+=%3*  "switch to User3 highlight
set statusline+=\ line\ %l:%v   "line number
set statusline+=\ \ [total\ %L]   "line number



" tab symbol size 4, replace tab with spaces
set tabstop=4 shiftwidth=4 expandtab

" To view special characters
set listchars=tab:\→\ ,trail:·,nbsp:·
hi SpecialKey ctermfg=gray
set list

" show ^M symbols, prevent adding ^M symbols
set fileformats=unix

" Error highlighting
hi SpellBad cterm=bold ctermfg=white ctermbg=red

" File specific settings
au BufNewFile,BufRead .jshintrc,.csslintrc setlocal filetype=json
au BufNewFile,BufRead Makefile,.gitconfig setlocal noexpandtab

