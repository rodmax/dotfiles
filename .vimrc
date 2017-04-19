set noswapfile " do not create .swp files
set statusline=[line=%04l,%04v]\ [total=%L]\ %=%.60F

" tab symbol size 4, replace tab with spaces
set tabstop=4 shiftwidth=4 expandtab

" To view special characters
set listchars=tab:\→\ ,trail:·,nbsp:·
hi SpecialKey ctermfg=Gray
set list

" show ^M symbols, prevent adding ^M symbols
set fileformats=unix

" Error highlighting
hi SpellBad cterm=bold ctermfg=white ctermbg=red

" File specific settings
au BufNewFile,BufRead .jshintrc,.csslintrc setlocal filetype=json
au BufNewFile,BufRead Makefile,.gitconfig setlocal noexpandtab

