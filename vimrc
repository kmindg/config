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
set cinoptions+=j1,(0,:0,l1,g0
syntax on
"set textwidth=79
set fileencodings=ucs-bom,utf-8,cp936,default,latin1
" :h ture-color
set termguicolors
set t_8f=[38;2;%lu;%lu;%lum
set t_8b=[48;2;%lu;%lu;%lum

" vim-plug "
call plug#begin('~/.vim/plugged')

" My bundles here:
" original repos on GitHub
Plug 'ervandew/supertab'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'easymotion/vim-easymotion'
Plug 'jrosiek/vim-mark'
Plug 'emezeske/manpageview'
Plug 'majutsushi/tagbar'
Plug 'davidhalter/jedi-vim'
Plug 'rust-lang/rust.vim'
Plug 'tommcdo/vim-kangaroo'
Plug 'tpope/vim-fugitive'
Plug 'justinmk/vim-syntax-extra'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'vimwiki/vimwiki'
Plug 'w0rp/ale'
Plug 'CharlesGueunet/VimFilify'

call plug#end()

" Tagbar "
"nnoremap <Leader>tb :TagbarOpenAutoClose<CR>

nmap <Leader>ss :cs find s <C-R>=expand("<cword>")<CR><CR>:bot cw<CR>
nmap <Leader>sg :cs find g <C-R>=expand("<cword>")<CR><CR>:bot cw<CR>
nmap <Leader>sc :cs find c <C-R>=expand("<cword>")<CR><CR>:bot cw<CR>
nmap <Leader>st :cs find t <C-R>=expand("<cword>")<CR><CR>:bot cw<CR>
nmap <Leader>se :cs find e <C-R>=expand("<cword>")<CR><CR>:bot cw<CR>
nmap <Leader>sf :cs find f <C-R>=expand("<cfile>")<CR><CR>:bot cw<CR>
nmap <Leader>si :cs find i <C-R>=expand("<cfile>")<CR><CR>:bot cw<CR>
nmap <Leader>sd :cs find d <C-R>=expand("<cword>")<CR><CR>:bot cw<CR>

" tags.sh example:
" #!/bin/bash
" mkdir -p .gtags_tmp
" find cyc_platform cyc_app -type f -a \( -name "*.cpp" -o -name "*.hpp" -o -name "*.c" -o -name "*.h" -o -name '*.cxx' -o -name '*.hxx' -o -name '*.py' \) | gtags --gtagslabel native-pygments -f - .gtags_tmp
" mv .gtags_tmp/G* ./
" rm -r .gtags_tmp
nmap <silent> <Leader>u :!./tags.sh&<CR>:silent cscope reset<CR>

" mark "
nmap <unique> <silent> <Leader>N <Plug>MarkAllClear
let g:mwDefaultHighlightingPalette = 'extended'
let g:mwDefaultHighlightingNum = 9

" SuperTab-continued "
"set completeopt-=preview

autocmd BufNewFile,BufRead *.ovsschema set filetype=json

if executable('rg')
  " Use rg over grep
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
elseif executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor\ --vimgrep
endif

nnoremap <Leader>s <ESC>
nnoremap <Leader>ex :Ex<CR>
"tnoremap <Esc> <C-W>N

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
if has("cscope")
    set csprg='gtags-cscope'
	set cst
	set nocsverb
	set cscopequickfix=s-,c-,d-,i-,t-,e-
	set csverb
endif


" gtags & fzf
function! s:GT()
    call fzf#run({'source': 'global -q -t .* | sed "s/\t.*//"', 'sink': 'tag', 'options': '-m --tiebreak=begin --prompt "Gtags>"'})
endfunction
command! GT call s:GT()

" kangaroo
nmap <Leader>t <Esc>zP

" rust.vim
autocmd BufRead,BufNewFile Cargo.toml,Cargo.lock,*.rs compiler cargo

" highlight tailing space
let c_space_errors = 1

" Ultisnips
let g:UltiSnipsExpandTrigger="<leader>e"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsListSnippets="<leader>l"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" ALE
let g:ale_enabled=0
let g:ale_c_build_dir='cyc_app/cyclone/debug/simulation'
let g:ale_c_parse_compile_commands=1
let g:ale_cpp_cppcheck_options='--enable=warning,style,performance,information,missingInclude --suppress=cstyleCast'
let g:ale_linters = { 'c': ['clangcheck', 'clangtidy', 'cppcheck'],
            \ 'cpp': ['clangcheck', 'clangtidy', 'cppcheck'] }
let g:ale_python_pylint_executable='pylint2'

augroup ale_config
    autocmd FileType c,cpp let g:custom_cpp_options = Filify#process('.ale_config', {'default_return':'-std=c++11 -Wall'})
    autocmd FileType c,cpp let g:ale_cpp_clang_options = g:custom_cpp_options
    autocmd FileType c,cpp let g:ale_cpp_gcc_options = g:custom_cpp_options
augroup END
