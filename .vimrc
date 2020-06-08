" Settings before loading plugins
let g:ale_cache_executable_check_failures = 1
" Plugins
call plug#begin('~/.vim/plugged')
Plug  'jiangmiao/auto-pairs'
Plug  'ctrlpvim/ctrlp.vim'
Plug 'FelikZ/ctrlp-py-matcher'
Plug 'Shougo/deoplete.nvim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'rgarver/Kwbd.vim'
Plug 'makerj/vim-pdf'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp' Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'kien/rainbow_parentheses.vim'
" Plug 'ervandew/supertab'
" Plug 'aclaimant/syntastic-joker'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'guns/vim-clojure-highlight'
Plug 'guns/vim-clojure-static'
Plug 'guns/vim-sexp'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-salve'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'vim-syntastic/syntastic'
Plug 'hashivim/vim-terraform'
Plug 'airblade/vim-gitgutter'
" Plug 'roxma/vim-hug-neovim-rpc'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'natebosch/vim-lsc'
Plug 'dense-analysis/ale'
if has('nvim')
"  Plug 'neoclide/coc.nvim', {'branch': 'release', 'for': ['json', 'java', 'vim', ]}
endif
" Plug 'prabirshrestha/async.vim'
" Plug 'prabirshrestha/vim-lsp'
" Plug 'mattn/vim-lsp-settings'
" Plug 'lighttiger2505/deoplete-vim-lsp'
call plug#end()

if has('nvim')
" source ~/.config/nvim/config/coc.vim
  source ~/.config/nvim/config/ale.vim
  set shortmess-=F
endif
syntax on
filetype plugin indent on

" set background=dark

" Alt key mappings. Not needed for neovim
" https://stackoverflow.com/questions/6778961/alt-key-shortcuts-not-working-on-gnome-terminal-with-vim
if !has('nvim')
  let c='a'
  let cc='A'
  while c <= 'z'
    exec "set <A-".c.">=\e".c
    exec "set <A-".cc.">=\e".cc
    exec "imap \e".c." <A-".c.">"
    exec "imap \e".cc." <A-".cc.">"
    let c = nr2char(1+char2nr(c))
    let cc = nr2char(1+char2nr(cc))
  endw
endif
set timeout ttimeoutlen=50

set hidden
set nu " set line numbers. can be toggled using <leader>ln
set tagstack
set tabstop=2 " number of visual spaces per tab
set softtabstop=2 " number of spaces in tab when editing
set shiftwidth=2 " number of spaces when shifting
set expandtab " tabs are spaces
set signcolumn=yes
set cursorline " highlight current line
set wildmenu " visual autocomplete for command menu
set lazyredraw " redraw only when we need to
" set shellcmdflag=-ic

set showmatch " highlight matching
set incsearch " search as characters are entered
set hlsearch " highlight matches
set nocompatible

" Custom mappings
let mapleader=" "
nnoremap <leader><space> :nohlsearch<CR>
if has('nvim')
  "tnoremap <Esc> <C-\><C-n>
  nnoremap <leader>t :terminal tig %<CR>i
  nnoremap <leader>ts :terminal tig status<CR>i
else
  nnoremap <leader>t :!tig %<CR>
  nnoremap <leader>ts :!tig status<CR>
endif
nnoremap <leader>p :se paste!<CR>
" nnoremap <leader>s :Grep '' **/*<Left><Left><Left><Left><Left><Left>
nnoremap <leader>s :Grep ''<Left>
nnoremap <leader>' :bn<CR>
nnoremap <leader>; :bp<CR>

nnoremap <leader>q :cclose<CR>
nnoremap <leader>ln :se nu!<CR>
nnoremap <leader>ls :NERDTreeToggle<CR>
nnoremap <leader>lf :NERDTreeFind<CR>
nnoremap <leader>hh <C-w>h
nnoremap <leader>ll <C-w>l
nnoremap <leader>jj <C-w>j
nnoremap <leader>kk <C-w>k
nnoremap <leader>[ :bp<CR>
nnoremap <leader>] :bn<CR>
nnoremap <A-b> :b
nnoremap <A-P> :CtrlPBuffer<CR>
nnoremap q: <nop>
nnoremap Q: <nop>
" paste does not change content of yank register
xnoremap p pgvy
" close buffer without removing window
nmap <leader>c <Plug>Kwbd

command! Bd call Bd()

" Markdown plugin
autocmd BufRead *.md nnoremap <C-m> :!grip --export % /tmp/%.html && google-chrome /tmp/%.html<CR>

let g:vim_markdown_folding_disabled = 1
let vim_markdown_override_foldtext = 0
let g:vim_markdown_new_list_item_indent = 2
let @q = 'di""hp'
let &grepprg="ag --nogroup --column --nocolor --vimgrep"

function! Grep(...)
    return system(join(extend([&grepprg], a:000), ' '))
endfunction

" Close all buffers except current one
function! Bd(...)
    execute "%bd|e#"
endfunction

function! TabChange(spaces)
  let &tabstop=a:spaces " number of visual spaces per tab
  let &softtabstop=a:spaces " number of spaces in tab when editing
  let &shiftwidth=a:spaces " number of spaces when shifting
endfunction

command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr Grep(<q-args>)
command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr Grep(<q-args>)

augroup quickfix
    autocmd!
    autocmd QuickFixCmdPost cgetexpr cwindow
    autocmd QuickFixCmdPost lgetexpr lwindow
augroup END

" Evaluate Clojure buffers on load
autocmd BufRead *.clj try | silent! Require | catch /^Fireplace/ | endtry
" Map tf to terraform
autocmd BufRead,BufNewFile *.tf set filetype=terraform
" Map bzl to python
autocmd BufRead,BufNewFile *.bzl set filetype=python
" Map ansible files
autocmd BufRead,BufNewFile */ansible/*/*.yml set filetype=ansible syntax=yaml
autocmd VimEnter * RainbowParenthesesToggle
autocmd Syntax * RainbowParenthesesLoadRound
autocmd Syntax * RainbowParenthesesLoadSquare
autocmd Syntax * RainbowParenthesesLoadBraces 

" PyMatcher for CtrlP
if !has('python3')
    echo 'In order to use pymatcher plugin, you need +python compiled vim'
else
    let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
endif
let g:ctrlp_user_command = 'ag -l --nocolor -g "" %s'
let g:ctrlp_lazy_update = 350
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|class|o)$',
  \
  \ }

" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'dark'

let g:deoplete#enable_at_startup = 1

let g:lsc_auto_map = {'defaults': v:true, 'PreviousReference': '', 'NextReference': ''}
let g:lsc_server_commands = {'java': '/home/iftikhso/code/external/java-language-server/dist/lang_server_linux.sh'}

let g:sexp_filetypes = "clojure, scheme, list, timl, python"
" Language Server Settings
" let g:lsp_signs_enabled = 1
" let g:lsp_diagnostics_enabled = 1
" let g:lsp_diagnostics_echo_cursor = 1

" Put these lines at the very end of your vimrc file.
" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
colorscheme gruvbox
