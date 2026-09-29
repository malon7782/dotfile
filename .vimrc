call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug '/home/malon/malon7782/vim-mail'
Plug 'sainnhe/everforest'
Plug 'airblade/vim-gitgutter'
call plug#end()

let g:mail_root = '/home/malon/Mail'
let g:mail_from = 'Tian Yuchen <a3205153416@gmail.com>'

filetype plugin indent on
syntax on

set termguicolors
set background=light
colorscheme everforest

set updatetime=100
set number
set cursorline
set showcmd
set showmode
set mouse=a
set clipboard=unnamedplus
set laststatus=2
set undofile
set directory^=$HOME/.vim/swap//
set tags=./tags;,tags
set pastetoggle=<F2>

set tabstop=8
set shiftwidth=8
set softtabstop=8
set noexpandtab
set autoindent
set cindent
set smartindent

set ignorecase
set smartcase
set incsearch
set hlsearch
set list
set listchars=tab:▸\ ,trail:·,extends:>,precedes:<

nnoremap <F5> :w<CR>:!gcc % -o %:r -lm -lncurses && ./%:r<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"

augroup python_settings
    autocmd!
    autocmd FileType python setlocal tabstop=4
    autocmd FileType python setlocal shiftwidth=4
    autocmd FileType python setlocal softtabstop=4
    autocmd FileType python setlocal expandtab
    autocmd FileType python setlocal autoindent
    autocmd FileType python setlocal smartindent
augroup END

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

