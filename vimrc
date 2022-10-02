""" https://github.com/yosemitebandit/dotdotdot
"""

" basics
:imap jk <Esc>
:imap jj <Esc>
let mapleader=","
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" change size of vertical splits
nnoremap H :5winc <<CR>
nnoremap L :5winc ><CR>

" new splits open on the right and on the bottom
set splitbelow
set splitright

" syntax
syntax enable
syntax on
filetype on
set numberwidth=1
set background=dark
set title
set wildmenu
set wildmode=full
set fileformat=unix

" don't bell or blink
set noerrorbells
set vb t_vb=
set novisualbell
set t_vb=
autocmd GUIEnter * set visualbell t_vb=

" ignore these files when completing
set wildignore+=*.o,*.obj,.git,*.pyc
set wildignore+=eggs/**
set wildignore+=*.egg-info/**

" movement and editing
set ruler
set backspace=2
set showmatch
set nowrap
set linebreak
set autoindent
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set shiftround
set matchpairs+=<:>
set foldlevel=99
set nostartofline

" reading and writing
set noautowrite
set noautowriteall
set noautoread
set modeline
set modelines=5
set ffs=unix,dos,mac

" messages, status and info
set ls=2
set vb t_vb=
set confirm
set showcmd
set report=0
set shortmess+=a
set ruler
set laststatus=2
set laststatus=1
set statusline=[%l,%v\ %P%M]\ %f\ %r%h%w\ (%{&ff})\ %{fugitive#statusline()}

" searching, patterns
set ignorecase
set smartcase
set smarttab
set hlsearch
set incsearch

" display
colorscheme delek

" leader
nnoremap <leader>q :q<CR>
nnoremap <leader><space> :nohlsearch<cr>
nnoremap <leader>S :%s/\s\+$//<cr>:let @/=''<CR>

nnoremap <space> zz
nnoremap Q <nop>

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
else
  set grepprg=ack
endif


map <leader>a :set paste!<CR>
vmap <leader>r :s/\%V
nmap <leader>ta :TagbarToggle<CR>

" ctrlp
"if executable('ag')
"  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
"  let g:ctrlp_use_caching = 0
"endif

" NerdTree
"map <leader>n :NERDTreeToggle<CR>
" switching around windows - nerdtree and splits
"nnoremap <Leader>w <C-w>w
" hide certain files in nerdtree
"let NERDTreeIgnore = ['\.pyc$']
"let g:NERDTreeDirArrows=0

" smooth-scroll
"noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 10, 2)<CR>
"noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 10, 2)<CR>
"noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 10, 4)<CR>
"noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 10, 4)<CR>

" easymotion
"map <Leader> <Plug>(easymotion-prefix)
