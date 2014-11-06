""" https://github.com/yosemitebandit/dotdotdot
"""

""" first setup vundle as per the docs
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
" colorschemes
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-vividchalk'
"Plugin 'w0ng/vim-hybrid'
"Plugin 'chriskempson/base16-vim'
"Plugin 'nanotech/jellybeans.vim'
"Plugin 'xoria256.vim'
" utils
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'majutsushi/tagbar'
"Plugin 'scrooloose/syntastic'
" langs
Plugin 'tclem/vim-arduino'
"Plugin 'tpope/vim-markdown'
Plugin 'godlygeek/tabular'  " required for plasticboy/vim-markdown
Plugin 'plasticboy/vim-markdown'
Plugin 'vim-scripts/openscad.vim'
Plugin 'lepture/vim-jinja'
"Plugin 'jnwhiteh/vim-golang'
"Plugin 'fatih/vim-go'
call vundle#end()
filetype plugin indent on
" /vundle-setup

:imap jk <Esc>
:imap jj <Esc>
let mapleader=","

" remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

syntax enable                 " syntax highlighing
filetype on                   " try to detect filetypes
set numberwidth=1             " using only 1 column (and 1 space) while possible
set background=dark           " We are using dark background in vim
set title                     " show title in console title bar
set wildmenu                  " Menu completion in command mode on <Tab>
set wildmode=full             " <Tab> cycles between all matching choices.

" had some trouble with ^M line endings showing up..
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

" replace the default grep program with ack
set grepprg=ack

" set working directory (??)
nnoremap <leader>. :lcd %:p:h<CR>

""" movement and editing
set ruler                   " show the cursor position all the time
set backspace=2             " Allow backspacing over autoindent, EOL, and BOL
set showmatch               " Briefly jump to a paren once it's balanced
set nowrap                  " don't wrap text
set linebreak               " don't wrap textin the middle of a word
set autoindent              " always set autoindenting on
set smartindent             " use smart indent if there is no indent file
set tabstop=2               " <tab> inserts 2 spaces
set shiftwidth=2            " but an indent level is 2 spaces wide.
set softtabstop=2           " <BS> over an autoindent deletes both spaces.
set expandtab               " Use spaces, not tabs, for autoindent/tab key.
set shiftround              " rounds indent to a multiple of shiftwidth
set matchpairs+=<:>         " show matching <> (html mainly) as well
set foldmethod=marker       " allow us to fold on marks
set foldlevel=99            " don't fold by default
"set iskeyword-=_           " don't skip over underscores on navigation
                            " note that this makes syntax highlighting weird

"""" reading and writing
set noautowrite             " Never write a file unless I request it.
set noautowriteall          " NEVER.
set noautoread              " Don't automatically re-read changed files.
set modeline                " Allow vim options to be embedded in files;
set modelines=5             " they must be within the first or last 5 lines.
set ffs=unix,dos,mac        " Try recognizing dos, unix, and mac line endings.

"""" messages, status and info
set ls=2                    " allways show status line
set vb t_vb=                " Disable all bells.  I hate ringing/flashing.
set confirm                 " Y-N-C prompt if closing with unsaved changes.
set showcmd                 " Show incomplete normal mode commands as I type.
set report=0                " : commands always print changed line count.
set shortmess+=a            " Use [+]/[RO]/[w] for modified/readonly/written.
set ruler                   " Show some info, even without statuslines.
set laststatus=2            " Always show statusline, even if only 1 window.
set laststatus=1            " Always show statusline, even if only 1 window.
set statusline=[%l,%v\ %P%M]\ %f\ %r%h%w\ (%{&ff})\ %{fugitive#statusline()}

""" Searching and Patterns
set ignorecase              " Default to using case insensitive searches,
set smartcase               " unless uppercase letters are used in the regex.
set smarttab                " Handle tabs more intelligently
set hlsearch                " Highlight searches by default.
set incsearch               " Incrementally search while typing a /regex

"""" Display
if has("gui_running")
    colorscheme solarized
    " remove menu bar
    set guioptions-=m
    " remove toolbar
    set guioptions-=T
    " remove all other sidebars.. chaining doesn't work for some reason
    set guioptions-=L
    set guioptions-=l
    set guioptions-=R
    set guioptions-=r
    set guioptions-=b
else
    colorscheme delek
endif

" quit window on <leader>q
nnoremap <leader>q :q<CR>
" hide matches on <leader>space
nnoremap <leader><space> :nohlsearch<cr>
" remove trailing whitespace on <leader>S
nnoremap <leader>S :%s/\s\+$//<cr>:let @/=''<CR>

" backup dirs for swap files
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" tagbar
nmap <leader>ta :TagbarToggle<CR>

" NerdTree
map <leader>n :NERDTreeToggle<CR>
" switching around windows - nerdtree and splits
nnoremap <Leader>w <C-w>w
" hide certain files in nerdtree
let NERDTreeIgnore = ['\.pyc$']

" Syntastic - turn on by default and run a check when the file is opened
let g:syntastic_check_on_open=1
let g:syntastic_mode_map = { 'mode': 'active',
  \ 'active_filetypes': [],
  \ 'passive_filetypes': ['html'] }
let g:syntastic_python_checkers = ['pylint']
" better :sign interface symbols
" on second thought..let's not use signs
let g:syntastic_enable_signs=0
let g:syntastic_error_symbol = "█"
let g:syntastic_style_error_symbol = ">"
let g:syntastic_warning_symbol = "█"
let g:syntastic_style_warning_symbol = ">"
" toggle :Errors pane with ,er
function! ToggleErrors()
  let old_last_winnr = winnr('$')
  lclose
  if old_last_winnr == winnr('$')
    " Nothing was closed, open syntastic error location panel
    Errors
  endif
endfunction
nnoremap <silent> <leader>er :<C-u>call ToggleErrors()<CR>
" close quickfix and scratch windows
nnoremap <leader>c :pc<CR> :ccl<CR>
" or just close scratch on move
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" ctrlp
"map F :CtrlP<CR>

" jinja/html
autocmd BufNewFile,BufRead *.mako,*.mak,*.jinja2 setlocal ft=html
autocmd FileType html,xhtml,xml,css setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" js
au BufRead *.js set makeprg=jslint\ %

" python
au FileType python setlocal expandtab shiftwidth=2 tabstop=4 softtabstop=2 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
au BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
" the pep8 limit is 79, so chars should go up to but not past the bar
" fyi, other standards set 80 as the limit so you can go one past the bar..
au FileType python set colorcolumn=79
highlight ColorColumn ctermbg=DarkBlue
" fix the nonindentation of python comments
" http://stackoverflow.com/questions/2360249
inoremap # X#

" arduino
au BufRead,BufNewFile *.pde set filetype=arduino
au BufRead,BufNewFile *.ino set filetype=arduino
autocmd BufNewFile,BufReadPost *.ino,*.pde set filetype=cpp

" LCM
au BufRead,BufNewFile *.lcm set filetype=cpp

" golang
au BufRead,BufNewFile *.go set filetype=go
" show type info
au FileType go nmap <Leader>i <Plug>(go-info)
" open docs
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
" run / build / test
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>te <Plug>(go-test)
au FileType go nmap <leader>f :GoFmt<CR>
" disable auto-fmt on save..it's a bit aggressive when there are errors
let g:go_fmt_autosave = 0

" jinja
au BufNewFile,BufRead *.html,*.htm,*.shtml,*.stm set ft=jinja

" markdown
" disable folding mode
let g:vim_markdown_folding_disabled=1

" use Adobe's Source Code Pro
if has('gui_running')
    set guifont=Source\ Code\ Pro\ 14
endif

" folding
nnoremap <space> za
vnoremap <space> zf
