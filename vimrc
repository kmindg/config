"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Author: Archer Gong
" Font: DejaVu Sans Mono

let mapleader=","
let maplocalleader=","

" vim commom setting "
"scriptencoding utf-8
"set encoding=utf-8
colo desert
set scrolloff=2
set ignorecase
set smartcase
set number
set laststatus=2
set hidden
set nowrap
" workaround ESC delay under putty
set timeout
set timeoutlen=1000
set ttimeoutlen=100
set tabstop=4
"set softtabstop=4
set shiftwidth=4
set smarttab
set expandtab
set history=500		" keep 500 lines of command line history
set ruler		    " show the cursor position all the time
set showcmd		    " display incomplete commands
set incsearch		" do incremental searching
set hlsearch
set cinoptions+=(0,:0,l1
syntax on
"set textwidth=79
set fileencodings=ucs-bom,cp936,utf-8,default,latin1

" vim-plug "
call plug#begin('~/.vim/plugged')

" My bundles here:
" original repos on GitHub
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Felikz/ctrlp-py-matcher'
Plug 'EasyMotion'
Plug 'The-NERD-tree'
Plug 'vim-scripts/Mark--Karkat'
Plug 'emezeske/manpageview'
"Plug 'Valloric/YouCompleteMe'
"Plug 'rdnetto/YCM-Generator'
"Plug 'Syntastic'
"Plug 'Lokaltog/powerline'
Plug 'SuperTab'
Plug 'taglist.vim'
"Plug 'Tagbar'
"Plug 'elzr/vim-json'
"Plug 'Rip-Rip/clang_complete'
Plug 'christoomey/vim-tmux-navigator'
"Plug 'tpope/vim-dispatch'

call plug#end()

" Tagbar "
"nnoremap <silent> <F5> :TagbarOpen fj<CR>
"nnoremap <silent> <F6> :TagbarToggle<CR>

" taglist "
"nnoremap <silent> <F5> :TlistToggle<CR>
nnoremap <Leader>tl :TlistToggle<CR>
let Tlist_Use_Right_Window = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Show_One_File = 1
let Tlist_Sort_Type = "name"
let Tlist_WinWidth = 40

" cscope "
if has("cscope")
	" set csprg=/usr/local/bin/cscope
	set csto=1
	set cst
	set nocsverb
	set cscopequickfix=s-,c-,d-,i-,t-,e-
	" add any database in current directory
	if filereadable("cscope.out")
		cs add cscope.out
		" else add database pointed to by environment
	elseif $CSCOPE_DB != ""
		cs add $CSCOPE_DB
	endif
	set csverb
endif

nmap <Leader>ss :cs find s <C-R>=expand("<cword>")<CR><CR>:bot cw<CR>
nmap <Leader>sg :cs find g <C-R>=expand("<cword>")<CR><CR>:bot cw<CR>
nmap <Leader>sc :cs find c <C-R>=expand("<cword>")<CR><CR>:bot cw<CR>
nmap <Leader>st :cs find t <C-R>=expand("<cword>")<CR><CR>:bot cw<CR>
nmap <Leader>se :cs find e <C-R>=expand("<cword>")<CR><CR>:bot cw<CR>
nmap <Leader>sf :cs find f <C-R>=expand("<cfile>")<CR><CR>:bot cw<CR>
nmap <Leader>si :cs find i <C-R>=expand("<cfile>")<CR><CR>:bot cw<CR>
nmap <Leader>sd :cs find d <C-R>=expand("<cword>")<CR><CR>:bot cw<CR>

" cscope.tags.sh example:
" #!/bin/bash
" find . -type f -a \( -path "*interface*" -o -path "*disk/interface*" -o -path "*disk/fbe*" \) -a \( -name "*.cpp" -o -name "*.hpp" -o -name "*.c" -o -name "*.h" \) > cscope.files || echo "find failed!"
" ( cscope -Rbq -i cscope.files ) &
" ( ctags --tag-relative=yes -L cscope.files --c++-kinds=+p --fields=+iaS --extra=+q -I ~/.vim/tags_ignore ) &
" wait
nmap <silent> <Leader>u :!./cscope.tags.sh<CR>:cscope reset<CR>

" YouCompleteMe "
"let g:ycm_key_invoke_completion = '<C-\>'

" powerline "
" set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
" let g:Powerline_symbols = 'fancy'
" set t_Co=256

" NERDTree "
let NERDTreeChDirMode=2

" bbye "
set rtp+=~/.vim/plugin/bbye
"nnoremap <leader>bd :Bdelete<CR>
nnoremap <leader>q :Bdelete<CR>

" CtrlP "
let g:ctrlp_working_path_mode = 0
let g:ctrlp_by_filename = 1
" ctrlp-py-matcher
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

" mark "
nmap <unique> <silent> <Leader>N <Plug>MarkAllClear

" SuperTab-continued "
set completeopt-=preview

" EasyMotion "
let g:EasyMotion_keys = 'bceghijklmnopqrstuvwxyz1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZasdf'

autocmd BufNewFile,BufRead *.ovsschema set filetype=json

" The Silver Searcher "
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" clang_complete "
"let g:clang_library_path="/home/agong/local/clang+llvm-3.4-x86_64-unknown-ubuntu12.04/lib/"
"let g:clang_make_default_keymappings=0
let g:clang_jumpto_declaration_key="<Leader>]"
"let g:clang_jumpto_declaration_in_preview_key="<Leader>tttttt"
let g:clang_jumpto_back_key="<Leader>t"


map ,s <ESC>
