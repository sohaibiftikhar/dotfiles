" Map the <leader> to space
let mapleader=" "
" Settings before loading plugins
if has('nvim')
" Plugins
call plug#begin('~/.vim/plugged')
Plug  'jiangmiao/auto-pairs'
Plug 'nvim-lua/plenary.nvim' " Nvim function helpers.
Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
Plug 'nvim-tree/nvim-tree.lua'
Plug 'rgarver/Kwbd.vim'
Plug 'kien/rainbow_parentheses.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'guns/vim-sexp'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-salve'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'qpkorr/vim-renamer'
Plug 'hashivim/vim-terraform'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'natebosch/vim-lsc'
Plug 'cespare/vim-toml'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'folke/trouble.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'simrat39/rust-tools.nvim'
Plug 'rafamadriz/friendly-snippets'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'jparise/vim-graphql'
" Purescript
Plug 'purescript-contrib/purescript-vim'
" CoPilot
Plug 'github/copilot.vim'
" CoPilot Chat
" Plug 'zbirenbaum/copilot.lua'
Plug 'nvim-lua/plenary.nvim'
Plug 'CopilotC-Nvim/CopilotChat.nvim', { 'branch': 'canary' }

call plug#end()

if has('nvim')
  lua require('config')
  packadd termdebug
  set shortmess-=F
endif
syntax on
filetype plugin indent on

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
set ignorecase
set smartcase " enabled smart case searching
set tagstack
set tabstop=4 " number of visual spaces per tab
set softtabstop=4 " number of spaces in tab when editing
set shiftwidth=4 " number of spaces when shifting
set expandtab " tabs are spaces
set list " enable listchars
set listchars=tab:>. " display tabs as > followed by dots (.). So a typical tab with four spaces is >...
set signcolumn=yes
set cursorline " highlight current line
set wildmenu " visual autocomplete for command menu
set lazyredraw " redraw only when we need to
set textwidth=120 " width after which vim will wrap text
" set shellcmdflag=-ic

set showmatch " highlight matching
set incsearch " search as characters are entered
set hlsearch " highlight matches
set nocompatible " for all practical cases a noop
set colorcolumn=80,120,140 " 120 character vertical line

let $FZF_DEFAULT_COMMAND='ag --column --nocolor -g ""'

" Custom mappings
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
" nnoremap <leader>s :Grep ''<Left>
nnoremap <C-P> :Files<CR>
nnoremap <A-P> :Buffers<CR>

command! -bang -nargs=* MyAg
  \ call fzf#vim#ag(
    \ <q-args>,
    \ "--ignore-dir={staging,out,build,__pycache_}
            \ -G '\.(cc|inl|hh|cpp|h|hpp|c|py|yml|yaml|js|graphql|mk|Makefile|cmake|CMakeLists.txt|tf)$'",
    \ fzf#vim#with_preview({'options': '--exact --delimiter : --nth 4..'}),
    \ <bang>0)
command! -bang -nargs=1 Cag call CustomAg(<q-args>)
command! -bang -nargs=1 Fag call FileAg(<q-args>)
command! -bang -nargs=* Sag
  \ call fzf#vim#ag(
    \ <q-args>,
    \ "-G '^\./src/'",
    \ fzf#vim#with_preview({'options': '--exact --delimiter : --nth 4..'}),
    \ <bang>0)
nnoremap <leader>S :MyAg<CR>
nnoremap <leader>f :Fag 
nnoremap <leader>s :Cag 


nnoremap <leader>q :cclose<CR>
nnoremap <leader>z :pclose<CR>
nnoremap <leader>ln :se nu!<CR>
nnoremap <leader>ls :NvimTreeToggle<CR>
nnoremap <leader>tt :TroubleToggle<CR>
nnoremap <leader>lf :NvimTreeFindFile<CR>
nnoremap <leader>hh <C-w>h
nnoremap <leader>ll <C-w>l
nnoremap <leader>jj <C-w>j
nnoremap <leader>kk <C-w>k
" vmap <leader>y :w !nc -q0 localhost 5556<CR><CR>
" vmap <leader>y :w !xclip -selection clipboard<CR><CR>
vmap <leader>y :w !pbcopy<CR><CR>
nnoremap <leader>[ :bp<CR>
nnoremap <leader>] :bn<CR>
nnoremap <A-b> :b
nnoremap q: <nop>
nnoremap Q: <nop>
" Remove trailing whitepsace
nnoremap <silent> <leader>ts :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

" paste does not change content of yank register
xnoremap p pgvy
" close buffer without removing window
nmap <leader>c <Plug>Kwbd

command! Bd call Bd()
command! -nargs=1 TabChange call TabChange(<q-args>)
command! FixImports :!autoflake --in-place --remove-all-unused-imports %
command! Ccformat :!clang-format -i %
command! Scratch :e /tmp/scratch.md
command! Config :e ~/.config/nvim/lua/config.lua
command! Reload :source ~/.vimrc

" Invoke ag on a custom user specified directory.
function! CustomAg(directory)
    call fzf#vim#ag(
        \ "",
        \ "-G '\." . a:directory . "/'",
        \ fzf#vim#with_preview({'options': '--exact --delimiter : --nth 4..'}),
        \ 0)
endfunction

function! FileAg(pattern)
    call fzf#vim#ag(
        \ "",
        \ "-G '" . a:pattern . "'",
        \ fzf#vim#with_preview({'options': '--exact --delimiter : --nth 4..'}),
        \ 0)
endfunction



function! BzlFormat()
  execute "!yapf -i %"
  execute "!buildifier %"
endfunction

command! Bzlformat call BzlFormat()

function! PlzFormat()
  execute "!plz format -w %"
endfunction

command! PlzFormat call PlzFormat()

" Markdown plugin
autocmd BufRead *.md nnoremap <C-m> :!grip --export % /tmp/expand('%:t').html && google-chrome /tmp/%.html<CR>

let g:termdebug_wide=1
let g:vim_markdown_folding_disabled = 1
let vim_markdown_override_foldtext = 0
let g:vim_markdown_new_list_item_indent = 2
let @q = 'di""hp'
let &grepprg="ag --nogroup --column --nocolor --vimgrep"

function! Grep(...)
    return system(join(extend([&grepprg], a:000), ' '))
endfunction

" Close all buffers except current one "
function! Bd(...)
    execute "%bd|e#"
endfunction

" Change the tab spaces for the function.
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

" Map tf to terraform
autocmd BufRead,BufNewFile *.tf set filetype=terraform
autocmd BufRead,BufNewFile *.geojson set filetype=json
" Map bzl to python
autocmd BufRead,BufNewFile *.bzl set filetype=python
" Map build system files to python
autocmd BufRead,BufNewFile *.bzl set syntax=python
autocmd BufRead,BufNewFile *.build_defs set syntax=python
" Remove autoindent for python files
autocmd FileType python setlocal indentkeys-=<:>
" Use tabs for Makefiles
autocmd FileType make setlocal noexpandtab
" Map ansible files
autocmd BufRead,BufNewFile */ansible/*/*.yml set filetype=ansible syntax=yaml
autocmd VimEnter * RainbowParenthesesToggle
autocmd Syntax * RainbowParenthesesLoadRound
autocmd Syntax * RainbowParenthesesLoadSquare
autocmd Syntax * RainbowParenthesesLoadBraces

" Renamer
" let g:RenamerShowHidden = 1
" let b:RenamerShowHiddenEnabled = 1
let b:renamerShowHiddenEnabled = 1

" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'dark'

" vim-surround
let g:surround_{char2nr('/')} = "/* \r */"
let g:lsc_auto_map = {'defaults': v:true, 'PreviousReference': '', 'NextReference': ''}
let g:sexp_filetypes = "scheme, list, timl, python"

" Put these lines at the very end of your vimrc file.
" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
" packloadall

" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
endif
colorscheme gruvbox
