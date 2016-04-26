""" https://github.com/yosemitebandit/dotdotdot
"""

" pull in the machine env var
let machine=$MACHINE
let bits=$BITS

" setup vundle as per the docs
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" utils
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'scrooloose/syntastic'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'terryma/vim-smooth-scroll'
Plugin 'tpope/vim-sleuth'
Plugin 'wincent/terminus'
Plugin 'luochen1990/rainbow'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Chiel92/vim-autoformat'
if machine != 'mac'
  if bits == 64
    Plugin 'Valloric/YouCompleteMe'
  endif
else
  Plugin 'Shougo/neocomplcache.vim'
  Plugin 'vim-scripts/OnSyntaxChange'
endif
" langs
Plugin 'tclem/vim-arduino'
Plugin 'vim-scripts/openscad.vim'
Plugin 'lepture/vim-jinja'
Plugin 'fatih/vim-go'
Plugin 'fatih/vim-nginx'
Plugin 'cespare/vim-toml'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'JulesWang/css.vim'
Plugin 'tpope/vim-markdown'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'guns/vim-clojure-static'
Plugin 'tpope/vim-fireplace'
Plugin 'rust-lang/rust.vim'
Plugin 'racer-rust/vim-racer'

call vundle#end()
filetype plugin indent on
" /vundle-setup

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
syntax on                     " syntax highlighing
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

" set working directory (??)
nnoremap <leader>. :lcd %:p:h<CR>

" movement and editing
set ruler                   " show the cursor position all the time
set backspace=2             " Allow backspacing over autoindent, EOL, and BOL
set showmatch               " Briefly jump to a paren once it's balanced
set nowrap                  " don't wrap text
set linebreak               " don't wrap textin the middle of a word
set autoindent              " always set autoindenting on
set tabstop=2               " <tab> inserts 2 spaces
set shiftwidth=2            " but an indent level is 2 spaces wide.
set softtabstop=2           " <BS> over an autoindent deletes both spaces.
set expandtab               " Use spaces, not tabs, for autoindent/tab key.
set shiftround              " rounds indent to a multiple of shiftwidth
set matchpairs+=<:>         " show matching <> (html mainly) as well
set foldlevel=99            " don't fold by default
set nostartofline           " don't go to the start of a line for certain commands (ctrl-d, buffer switches, etc)

" reading and writing
set noautowrite             " Never write a file unless I request it.
set noautowriteall          " NEVER.
set noautoread              " Don't automatically re-read changed files.
set modeline                " Allow vim options to be embedded in files;
set modelines=5             " they must be within the first or last 5 lines.
set ffs=unix,dos,mac        " Try recognizing dos, unix, and mac line endings.

" messages, status and info
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

" searching, patterns
set ignorecase              " Default to using case insensitive searches,
set smartcase               " unless uppercase letters are used in the regex.
set smarttab                " Handle tabs more intelligently
set hlsearch                " Highlight searches by default.
set incsearch               " Incrementally search while typing a /regex

" display
colorscheme delek
if has("gui_running")
    " remove menu bar, toolbar and sidebars
    set guioptions-=m
    set guioptions-=T
    set guioptions-=L
    set guioptions-=l
    set guioptions-=R
    set guioptions-=r
    set guioptions-=b
    " use adobe's font
    set guifont=Source\ Code\ Pro\ 14
endif

" leader tricks
" quit window on <leader>q
nnoremap <leader>q :q<CR>
" hide matches on <leader>space
nnoremap <leader><space> :nohlsearch<cr>
" remove trailing whitespace on <leader>S
nnoremap <leader>S :%s/\s\+$//<cr>:let @/=''<CR>

" center the screen
nnoremap <space> zz

" use ag (the silver searcher) or ack instead of grep
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
else
  set grepprg=ack
endif

" disable Q and the dreaded Ex mode
nnoremap Q <nop>

" setting paste mode
map <leader>a :set paste!<CR>

" find/replace in a visually selected block
vmap <leader>r :s/\%V

" tagbar
nmap <leader>ta :TagbarToggle<CR>

" ctrlp
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

" NerdTree
map <leader>n :NERDTreeToggle<CR>
" switching around windows - nerdtree and splits
nnoremap <Leader>w <C-w>w
" hide certain files in nerdtree
let NERDTreeIgnore = ['\.pyc$']
let g:NERDTreeDirArrows=0

" smooth-scroll
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 10, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 10, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 10, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 10, 4)<CR>

" easymotion
map <Leader> <Plug>(easymotion-prefix)

" Syntastic - turn off by default.
let g:syntastic_mode_map = {
  \ 'mode': 'passive',
  \ 'active_filetypes': [],
  \ 'passive_filetypes': ['html'] }
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_python_pylint_checker_args = '--load-plugins pylint_django'
let g:syntastic_javascript_checkers = ['jshint']
" Let's just not use signs (those little left-sidebar symbols).
let g:syntastic_enable_signs=0
" toggle a active / passive mode on <leader>z
" (and then you can actually trigger a syntax check by saving)
nnoremap <leader>z :SyntasticToggleMode<CR>
" toggle :Errors pane with <leader>er
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

" Neocomplcache.vim
if machine == 'mac'
  let g:acp_enableAtStartup = 0
  let g:neocomplcache_enable_at_startup = 1
  let g:neocomplcache_min_syntax_length = 4
  inoremap <expr><C-g> neocomplcache#undo_completion()
  " tab completion
  inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
  " enable omni completions
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  " change popup menu color
  highlight Pmenu ctermbg=8 guibg=#606060
  highlight PmenuSel ctermbg=1 guifg=#dddd00 guibg=#1f82cd
  highlight PmenuSbar ctermbg=0 guibg=#d6d6d6
endif

if machine == 'mac'
  " OnSyntaxChange - disabling Neocomplcache in comments
  call OnSyntaxChange#Install('Comment', '^Comment$', 0, 'i')
  autocmd User SyntaxCommentEnterI silent! NeoComplCacheLock
  autocmd User SyntaxCommentLeaveI silent! NeoComplCacheUnlock
endif

" Airline
" Show the bar even when only one file is open and force 256 color-mode.
set laststatus=2
set t_Co=256
let g:airline_theme='luna'
let g:airline#extensions#branch#displayed_head_limit = 10
let g:airline#extensions#syntastic#enabled = 0
" Disable the mode, filetype and encoding sections.
let hostname=system('hostname -s| tr -d "\n"')
let g:airline_section_a = '%{hostname}'
let g:airline_section_x = 0
let g:airline_section_y = 0

" terminus
" Don't change the cursor when in insert mode.
let g:TerminusCursorShape = 0

" rainbow parens
let g:rainbow_active = 1


" jinja/html
autocmd BufNewFile,BufRead *.mako,*.mak,*.jinja2 setlocal ft=html
autocmd FileType html,xhtml,xml,css setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
let g:html_indent_inctags = "html,body,head,table,tbody,thead,tr,th,td,p,h1,h2,h3,h4,h5,h6,form,hr,i,img,pre,textarea,ul,li,span,div,abbr"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

" js
au BufRead *.js set makeprg=jshint\ %
au BufRead *.js set formatoptions=tnq

" python
" Note that vim-sleuth should be setting shiftwidth heuristically.
au FileType python setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2 nosmartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
au BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
" chars should go up to but not past the bar
" pep8 is 79 max, GSG is 80, github works best with 79..
au FileType python set colorcolumn=79
highlight ColorColumn ctermbg=Black
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
let g:go_fmt_command = "goimports"

" jinja
au BufNewFile,BufRead *.html,*.htm,*.shtml,*.stm set ft=jinja

" markdown
" treat .md files and extension-less READMEs as markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufNewFile,BufReadPost README set filetype=markdown

" svg
" via http://ku1ik.com/2011/09/08/formatting-xml-in-vim-with-indent-command.html
au FileType svg setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

" jsx from react
let g:jsx_ext_required = 0

" clojure
"au BufRead,BufNewFile *.clj set filetype=clojure

" rust
au BufRead,BufNewFile *.rs set filetype=rust
au FileType rust nmap <leader>f :Autoformat<CR>
