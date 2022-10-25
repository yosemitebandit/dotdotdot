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
set tabstop=4
set shiftwidth=4
set softtabstop=4
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
set statusline=[%l,%v\ %P%M]\ %f\ %r%h%w\ (%{&ff})

" searching, patterns
set ignorecase
set smartcase
set smarttab
set hlsearch
set incsearch

" display
"colorscheme delek

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
nnoremap <Leader>w <C-w>w

call plug#begin()
  Plug 'preservim/nerdtree'
  Plug 'psliwka/vim-smoothie'
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'psf/black', { 'branch': 'stable' }
call plug#end()

" Fzf
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <Leader>f :Rg<CR>

" NerdTree
nnoremap <silent> <Leader>n :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$']
let g:NERDTreeDirArrows=0

" Python-black
augroup black_on_save
  autocmd!
  autocmd BufWritePre *.py Black
augroup end

" easymotion
"map <Leader> <Plug>(easymotion-prefix)
