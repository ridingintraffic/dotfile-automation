autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" let g:auto_save = 1  " enable AutoSave on Vim startup
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo

Plugin '907th/vim-auto-save'

Plugin 'tpope/vim-fugitive'

" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"

execute pathogen#infect()
syntax on
filetype plugin indent on
set nocompatible

set statusline=%F%m%r%h%w\
set statusline=%<%f\ %h%m%r\ %y%=%{v:register}\ %-14.(%l,%c%V%)\ %P
" easier switch to split
 nmap <C-h> <C-w>h
 nmap <C-l> <C-w>l
 nmap <C-k> <C-w>k
 nmap <C-j> <C-w>j
"
" " copy paste from system clipboard
 vmap ç "*y
 vmap ≈ "*d
 nmap √ :set paste<CR>"*p:set nopaste<CR>
 imap √ <ESC>:set paste<CR>"*p:set nopaste<CR>a
 map Y :.w !pbcopy<CR><CR>

" line numbers, yes
set number
set nuw=6  " number width to 6 makes things look a little neater
" indenting
filetype indent on
set expandtab       " Use softtabstop spaces instead of tab characters for
"indentation - abbr et
set shiftwidth=4    " Indent by 4 spaces when using >>, <<, == etc. - abbr
" sw
set softtabstop=4   " Indent by 4 spaces when pressing <TAB> - abbr sts
set tabstop=4       " Indent by 4 spaces when pressing <TAB> - abbr ts
set smartindent     " Automatically inserts indentation in some cases
set smarttab        " A <Tab> in front of a line inserts blanks according to
"'shiftwidth'.  'tabstop' or 'softtabstop' is used in other places.  A <BS>
" will delete a 'shiftwidth' worth of space at the start of the line.

" Ignore case when searching
set ignorecase

 " When searching try to be smart about cases
set smartcase


" word wrap, no
set nowrap

" highlight next search item
set hls
nnoremap <Leader>n :nohls<cr>
autocmd BufWinEnter * highlight NextItem ctermbg=112 guibg=#87d700 ctermfg=236 guifg=#303030
nnoremap <silent> n n:call HLNext(80)<cr>
nnoremap <silent> N N:call HLNext(80)<cr>
function! HLNext (blinktime)
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat = '\c\%#\%('.@/.'\)'
    let ring = matchadd('NextItem', target_pat, 101)
    redraw
    exec 'sleep ' . float2nr(a:blinktime) . 'm'
    call matchdelete(ring)
    redraw
endfunction

" json formatting
au! BufRead,BufNewFile *.json set filetype=json
augroup json_autocmd
   autocmd!
   autocmd FileType json set autoindent
   autocmd FileType json set formatoptions=tcq2l
   autocmd FileType json set textwidth=78 shiftwidth=4
   autocmd FileType json set softtabstop=4 tabstop=4
   autocmd FileType json set expandtab
   autocmd FileType json set foldmethod=syntax
augroup END

