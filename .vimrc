" vim-plug https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-surround'

Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
let g:vim_markdown_folding_disabled = 1

Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-sensible'
Plug 'leafgarland/typescript-vim'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }

Plug 'Quramy/tsuquyomi'
Plug 'mattn/emmet-vim'


" Initialize plugin system
call plug#end()

nnoremap <C-p> :GitFiles<cr>
nnoremap <C-b> :Buffers<cr>

func! SearchFiles()
    system('git status')
    echo('hello')
endfunc

" To make working fzf.vim, see https://github.com/junegunn/fzf#as-vim-plugin
set rtp+=/usr/local/opt/fzf

set noswapfile " do not create .swp files
syntax on

set t_Co=256

" Status line
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

" Spell check settings
set spell spelllang=en_us
set spellfile=~/.vim/spell/en.utf-8.add
set spellcapcheck=


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

