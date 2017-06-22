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
set fileencodings=ucs-bom,utf-8,cp936,default,latin1
set splitbelow
set splitright
" :h ture-color
set termguicolors
set t_8f=[38;2;%lu;%lu;%lum
set t_8b=[48;2;%lu;%lu;%lum

" vim-plug "
call plug#begin('~/.vim/plugged')

" My bundles here:
" original repos on GitHub
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdtree'
Plug 'jrosiek/vim-mark'
Plug 'emezeske/manpageview'
Plug 'Valloric/YouCompleteMe', { 'for': ['c', 'cpp', 'rust'], 'do': './install.py --clang-completer --racer-completer' }
Plug 'majutsushi/tagbar'
Plug 'davidhalter/jedi-vim'
Plug 'rust-lang/rust.vim'
Plug 'tommcdo/vim-kangaroo'

call plug#end()

" Tagbar "
"nnoremap <Leader>tb :TagbarOpenAutoClose<CR>

" taglist "
"nnoremap <Leader>tl :TlistToggle<CR>
"let Tlist_Use_Right_Window = 1
"let Tlist_GainFocus_On_ToggleOpen = 1
"let Tlist_Show_One_File = 1
"let Tlist_Sort_Type = "name"
"let Tlist_WinWidth = 40

" cscope "
if has("cscope")
	" set csprg=/usr/local/bin/cscope
    set csprg='gtags-cscope'
	"set csto=1
	set cst
	set nocsverb
	set cscopequickfix=s-,c-,d-,i-,t-,e-
	set csverb
endif

nmap <Leader>ss :cs find s <C-R>=expand("<cword>")<CR><CR>:bot cw<CR>
nmap <Leader>sg :cs find g <C-R>=expand("<cword>")<CR><CR>:bot cw<CR>
" use cscope to find caller
nmap <Leader>sc :set csprg=cscope<CR>:cs kill 0<CR>:cs add cscope.out<CR>:cs find c <C-R>=expand("<cword>")<CR><CR>:bot cw<CR>:set csprg=gtags-cscope<CR>:cs kill 0<CR>:cs add GTAGS<CR>
nmap <Leader>st :cs find t <C-R>=expand("<cword>")<CR><CR>:bot cw<CR>
nmap <Leader>se :cs find e <C-R>=expand("<cword>")<CR><CR>:bot cw<CR>
nmap <Leader>sf :cs find f <C-R>=expand("<cfile>")<CR><CR>:bot cw<CR>
nmap <Leader>si :cs find i <C-R>=expand("<cfile>")<CR><CR>:bot cw<CR>
nmap <Leader>sd :cs find d <C-R>=expand("<cword>")<CR><CR>:bot cw<CR>

" tags.sh example:
" #!/bin/bash
" find . -type f -a \( -path "*interface*" -o -path "*disk/interface*" -o -path "*disk/fbe*" \) -a \( -name "*.cpp" -o -name "*.hpp" -o -name "*.c" -o -name "*.h" \) > tags.files || echo "find failed!"
" ( cscope -Rbq -i tags.files ) &
" ( gtags -f tags.files ) &
" #( ctags -L tags.files --c++-kinds=+p --fields=+iaS --extra=+q -I ~/.vim/tags_ignore ) &
" wait
nmap <silent> <Leader>u :!./tags.sh&<CR>:silent cscope reset<CR>
function! CtagsUpdate()
    "let l:result = system("ctags --c++-kinds=+p --fields=+iaS --extra=+q -a \"" . expand("%") . "\" &")
    let l:result = system("cscope -b -i tags.files &")
endfunction
autocmd BufWritePost *.h call CtagsUpdate()
autocmd BufWritePost *.hpp call CtagsUpdate()
autocmd BufWritePost *.c call CtagsUpdate()
autocmd BufWritePost *.cpp call CtagsUpdate()
autocmd BufWritePost *.cxx call CtagsUpdate()

" NERDTree "
let NERDTreeChDirMode=2

" mark "
nmap <unique> <silent> <Leader>N <Plug>MarkAllClear
let g:mwDefaultHighlightingPalette = 'extended'
let g:mwDefaultHighlightingNum = 9

" SuperTab-continued "
set completeopt-=preview

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

" neocomple "
"let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
"let g:neocomplete#auto_completion_start_length = 5
"let g:neocomplete#sources#syntax#min_keyword_length = 3
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"


map ,s <ESC>

" nvim config
if has('nvim')
    "set mouse=

    if exists(':tnoremap')
        tnoremap <C-h> <C-\><C-n><C-w>h
        tnoremap <C-j> <C-\><C-n><C-w>j
        tnoremap <C-k> <C-\><C-n><C-w>k
        tnoremap <C-l> <C-\><C-n><C-w>l
    endif

    if exists(':term')
        nnoremap <Leader>tc  :tabnew<CR>:term<CR>
        nnoremap <Leader>ts  <C-w>s<C-w>j:term<CR>
        nnoremap <Leader>tv  <C-w>v<C-w>l:term<CR>
    endif
endif

" fzf
nnoremap <C-p> :FZF<CR>

" max window toggle
nnoremap <C-W>o :call Maximize_Window()<CR>
nnoremap <C-W>u :call Undo_Maximize_Window()<CR>

function! Maximize_Window()
    if exists("s:maximize_session")
        call delete(s:maximize_session)
        unlet s:maximize_session
        unlet s:maximize_hidden_save
    endif

    let s:maximize_hidden_save = &hidden
    let s:maximize_session = tempname()
    set hidden
    exec "mksession! " . s:maximize_session
    only
endfunction

function! Undo_Maximize_Window()
    if exists("s:maximize_session")
        exec "source " . s:maximize_session
        call delete(s:maximize_session)
        unlet s:maximize_session
        let &hidden=s:maximize_hidden_save
        unlet s:maximize_hidden_save
    endif
endfunction

" gtags
"let Gtags_Auto_Map = 1
let Gtags_Auto_Update = 1
let Gtags_No_Auto_Jump = 1
let Gtags_Close_When_Single = 1

" gtags-cscope
let GtagsCscope_Auto_Load = 1
let GtagsCscope_Quiet = 1

" gtags & fzf
function! s:GT()
    call fzf#run({'source': 'global -t .* | sed "s/\t.*//"', 'sink': 'tag', 'options': '-m --tiebreak=begin --prompt "Gtags>"'})
endfunction
command! GT call s:GT()

" kangaroo
nmap <Leader>t <Esc>zP

" YCM
"let g:ycm_rust_src_path = '~/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'
nmap <Leader>] <Esc>zp:YcmCompleter GoTo<CR>
