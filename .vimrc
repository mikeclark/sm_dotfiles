" Use the Solarized Dark theme
set background=dark
colorscheme solarized
let g:solarized_termtrans=1

" Make Vim more useful
set nocompatible
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed
" Enhance command-line completion
set wildmenu
" Allow cursor keys in insert mode
set esckeys
" Allow backspace in insert mode
set backspace=indent,eol,start
" Optimize for fast terminal connections
set ttyfast
" Add the g flag to search/replace by default
set gdefault
" Use UTF-8 without BOM
set encoding=utf-8 nobomb
" Change mapleader
let mapleader=","
" Don’t add empty newlines at the end of files
set binary
set noeol
" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
	set undodir=~/.vim/undo
endif

" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

" Respect modeline in files
set modeline
set modelines=4
" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure
" Enable line numbers
set number
" Enable syntax highlighting
syntax on
" Highlight current line
set cursorline
" Make tabs as wide as four spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set list
" Highlight searches
set hlsearch
" Ignore case of searches
set ignorecase
" Highlight dynamically as pattern is typed
set incsearch
" Always show status line
set laststatus=2
" Enable mouse in all modes
set mouse=a
" Disable error bells
set noerrorbells
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Show the cursor position
set ruler
" Don’t show the intro message when starting Vim
set shortmess=atI
" Show the current mode
set showmode
" Show the filename in the window titlebar
set title
" Show the (partial) command as it’s being typed
set showcmd
" Use relative line numbers
if exists("&relativenumber")
	set relativenumber
	au BufReadPost * set relativenumber
endif
" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Strip trailing whitespace (,ss)
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>
" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>
" Trim whitespace on save
autocmd BufWritePre * :%s/\s\+$//e
" Automatic commands
if has("autocmd")
	" Enable file type detection
	filetype on
	" Treat .json files as .js
	autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
	autocmd BufNewFile,BufRead *.php setfiletype php syntax=php
	" Treat .md files as Markdown
	autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif

inoremap jj <ESC>

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=$HOME
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
"Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'altercation/vim-colors-solarized'
"Plugin 'valloric/youcompleteme'
Plugin 'tpope/vim-fugitive'
"Bundle 'mattn/webapi-vim'
"Bundle 'mattn/gist-vim'
"Plugin 'jeetsukumaran/vim-buffergator'
"Bundle 'joonty/vim-phpqa.git'
Plugin 'scrooloose/syntastic'
Plugin 'SirVer/ultisnips'
Plugin 'ryanss/vim-hackernews'
"Plugin 'beanworks/vim-phpfmt'
Bundle 'stephpy/vim-php-cs-fixer'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" ctrlp ignore
let g:ctrlp_custom_ignore = {
  \ 'dir': '\v[\/](\.git|node_modules|\.sass-cache|bower_components|bui‌​ld)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Use the right side of the screen
"let g:buffergator_viewport_split_policy = 'R'

" I want my own keymappings...
let g:buffergator_suppress_keymaps = 1

" Looper buffers
"let g:buffergator_mru_cycle_loop = 1

" Go to the previous buffer open
"nmap <leader>jj :BuffergatorMruCyclePrev<cr>

" to the next buffer open
"nmap <leader>kk :BuffergatorMruCycleNext<cr>

" View the entire list of buffers open
"nmap <leader>bl :BuffergatorOpen<cr>

" Shared bindings from Solution #1 from earlier
nmap <leader>T :enew<cr>
nmap <leader>bq :bp <BAR> bd #<cr>

" Folding
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2

"syntastic

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_php_checkers=['php', 'phpcs']
let g:syntastic_php_phpcs_args='--standard=PSR2 --exclude=PSR1.Classes.ClassDeclaration,PSR1.Methods.CamelCapsMethodName,Squiz.Classes.ValidClassName -n'

let g:gist_show_privates = 1
let g:gist_post_private = 1

let php_sql_query=1
let php_htmlInStrings=1
let php_noShortTags=1
let php_folding=0
let php_baselib=1
let php_asp_tags=0
let php_parent_error_close=1
let php_parent_error_open=1
"let php_sync_method=10  " Sync only 10 lines backwards
let php_alt_comparisons=1
let php_alt_assignByReference=1

" snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'
"let g:UltiSnipsSnippetsDir='~/.vim/snippets/UltiSnips'
"let g:UltiSnipsSnippetDirectories=["UltiSnips"]

"let g:phpfmt_standard = 'PSR2'
"let g:phpfmt_autosave = 0
"let g:phpfmt_command = '/usr/local/bin/phpcbf'
let g:php_cs_fixer_rules = "@PSR2"
let g:php_cs_fixer_php_path = "/usr/bin/php"
let g:php_cs_fixer_enable_default_mapping = 1
let g:php_cs_fixer_dry_run = 0
let g:php_cs_fixer_verbose = 0

"fix windows line endings (ctrl-v, ctrl-m)
nmap <leader>le :%s/\r$//g<CR>
"find php short tags (but don't replace)
nmap <leader>st :/<?\($\<bar>[^(p<bar>P)]\)<CR>
