inoremap <silent> jj <ESC>

set laststatus=2
set t_Co=256
set encoding=utf-8

set hlsearch
set ignorecase
set smartcase
set wrapscan

set autoindent

set title
set ruler
set number
set wildmenu
set showcmd

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab

augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.sh,*.html,*.js,*.json,*.css,*.yaml,*.yml setlocal tabstop=2 shiftwidth=2 softtabstop=2
augroup END

set clipboard=unnamed
set nocompatible
set backspace=indent,eol,start
set whichwrap=b,s,h,l,<,>,[,]

set timeout timeoutlen=1000 ttimeoutlen=50

nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk

if &term =~ '^screen'
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif
