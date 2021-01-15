"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Author: Archer Gong
" Font: DejaVu Sans Mono

let mapleader=","
let maplocalleader=","

" vim commom setting "
"scriptencoding utf-8
"set encoding=utf-8
set bg=dark
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
if exists('+termguicolors')
    " :h xterm-true-color
    set termguicolors
    set t_8f=[38;2;%lu;%lu;%lum
    set t_8b=[48;2;%lu;%lu;%lum
endif

nnoremap ,tt :term ++close tail -F %<CR>
nmap ,bd :bp<bar>sp<bar>bn<bar>bd<CR>

" vim-plug "
call plug#begin('~/.vim/plugged')

" My bundles here:
" original repos on GitHub
Plug 'ervandew/supertab'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'easymotion/vim-easymotion'
Plug 'inkarkat/vim-ingo-library'
Plug 'inkarkat/vim-mark'
Plug 'emezeske/manpageview'
Plug 'majutsushi/tagbar'
Plug 'davidhalter/jedi-vim'
Plug 'rust-lang/rust.vim'
Plug 'tommcdo/vim-kangaroo'
Plug 'tpope/vim-fugitive'
Plug 'justinmk/vim-syntax-extra'
Plug 'vimwiki/vimwiki'
Plug 'vmchale/ion-vim'
" required by vim-lsp
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'morhetz/gruvbox'
"Plug 'zxqfl/tabnine-vim'
Plug 'vimoutliner/vimoutliner'
Plug 'nathangrigg/vim-beancount'

call plug#end()


" gruvbox "
colo gruvbox
"autocmd vimenter * colorscheme gruvbox
let g:gruvbox_bold=0
let g:gruvbox_italic=1

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
nmap <silent> <Leader>M <Plug>MarkToggle
nmap <silent> <Leader>N <Plug>MarkAllClear
let g:mwDefaultHighlightingPalette = 'extended'
let g:mwDefaultHighlightingNum = 9

" SuperTab "
"set completeopt-=preview
let g:SuperTabDefaultCompletionType = '<c-n>'

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
    call fzf#run({'source': 'global -q -t ".*" | sd "\t.*" ""', 'sink': 'tag', 'options': '-m --tiebreak=begin --prompt "Gtags>"'})
endfunction
command! GT call s:GT()

" kangaroo
nmap <Leader>t <Esc>zP

" rust.vim
autocmd BufRead,BufNewFile Cargo.toml,Cargo.lock,*.rs compiler cargo

" highlight tailing space
" let c_space_errors = 1

" ccls & vim-lsp
let g:lsp_diagnostics_enabled = 0
let g:lsp_signs_enabled = 0
let g:lsp_semantic_enabled = 1
" Register ccls C++ lanuage server.
if executable('ccls')
   au User lsp_setup call lsp#register_server({
       \ 'name': 'ccls',
       \ 'cmd': {server_info->['ccls']},
       \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
       \ 'initialization_options': {
       \   'cache': {'directory': '/tmp/ccls/cache' },
       \   'highlight': {'lsRanges': v:true },
       \   'index': {'initialBlacklist': ["."]},
       \ },
       \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc', 'cxx'],
       \ })
endif
" ccls --index=. --log-file=output --init='{"cache": {"directory": "/tmp/ccls/cache" }}'
" Register python-language-server as python lanuage server.
if executable('pyls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif
" " Key bindings for vim-lsp
"  " TODO: put into ftplugin later
" nnoremap <silent> <Leader>ld :LspDefinition<CR>
" nnoremap <silent> <Leader>lr :LspReferences<CR>
" nnoremap <silent> <Leader>lt :LspDocumentDiagnostic<CR>
" "nnoremap <silent> <Leader>lw :LspWorkspaceSymbol<CR>
" "nnoremap <silent> <Leader>lds :LspDocumentSymbol<CR>
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    "setlocal signcolumn=yes
    "if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> g] <plug>(lsp-definition)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    
    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" beancount
autocmd FileType beancount let b:beancount_root="/home/archer/ledger/main.beancount"
