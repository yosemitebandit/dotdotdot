""" https://github.com/yosemitebandit/dotdotdot
"""

" using vim-plug (needs to be downloaded in autoload)
call plug#begin()

" utils
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'majutsushi/tagbar'
Plug 'Lokaltog/vim-easymotion'
Plug 'bling/vim-airline'
Plug 'terryma/vim-smooth-scroll'
Plug 'tpope/vim-sleuth'
"Plug 'luochen1990/rainbow'
Plug 'scrooloose/nerdcommenter'
"Plug 'Chiel92/vim-autoformat'
Plug 'vim-scripts/restore_view.vim'

" completion
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
set updatetime=300
"Plug 'ncm2/ncm2-path'

if has('nvim')
  "Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  "Plug 'Shougo/deoplete.nvim'
  "Plug 'roxma/nvim-yarp'
  "Plug 'roxma/vim-hug-neovim-rpc'
endif
"let g:deoplete#enable_at_startup = 1

Plug 'davidhalter/jedi'
"Plug 'zchee/deoplete-jedi'
"Plug 'benekastah/neomake'
"Plug 'paretje/neomake', { 'branch': 'highlight' }

" langs
Plug 'tclem/vim-arduino'
"Plug 'vim-scripts/openscad.vim'
Plug 'lepture/vim-jinja'
"Plug 'fatih/vim-go'
"Plug 'zchee/deoplete-go'
Plug 'fatih/vim-nginx'
Plug 'cespare/vim-toml'
Plug 'pangloss/vim-javascript'
"Plug 'othree/yajs.vim'
Plug 'mxw/vim-jsx'
Plug 'JulesWang/css.vim'
Plug 'tpope/vim-markdown'
Plug 'hynek/vim-python-pep8-indent'
Plug 'ekalinin/Dockerfile.vim'
"Plug 'guns/vim-clojure-static'
"Plug 'tpope/vim-fireplace'
"Plug 'rust-lang/rust.vim'
"Plug 'racer-rust/vim-racer'
"Plug 'mustache/vim-mustache-handlebars'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'branch': 'release/1.x',
  \ 'for': [
    \ 'typescript',
    \ 'graphql' ] }
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}



" colors
Plug 'mhartington/oceanic-next'

call plug#end()



" basics
:imap jk <Esc>
:imap jj <Esc>
let mapleader=","
set directory=~/.vim/backup
syntax enable
colorscheme OceanicNext
set background=dark
set nowrap
set ignorecase
set smartcase

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

" center the screen
nnoremap <space> zz

" hide matches on <leader>space
nnoremap <leader><space> :nohlsearch<cr>

" remove trailing whitespace on <leader>S
nnoremap <leader>S :%s/\s\+$//<cr>:let @/=''<CR>

" use ag (the silver searcher) or ack instead of grep
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
else
  set grepprg=ack
endif

" find/replace in a visually selected block
vmap <leader>r :s/\%V

" disable Q and the dreaded Ex mode
nnoremap Q <nop>

" toggling paste mode
map <leader>a :set paste!<CR>

" try to speed things up
set lazyredraw

" nerdtree
map <leader>n :NERDTreeToggle<CR>
" switching around windows - nerdtree and splits
nnoremap <Leader>w <C-w>w
" hide certain files in nerdtree
let NERDTreeIgnore = ['\.pyc$']
let g:NERDTreeDirArrows=0
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'


" smooth-scroll
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 10, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 10, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 10, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 10, 4)<CR>


" ctrlp
if executable('ag')
  let g:ctrlp_user_command = 'ag %s
        \ --nocolor --nogroup --depth 10
        \ --hidden --follow --smart-case
        \ --ignore .git
        \ -g ""'
  let g:ctrlp_use_caching = 0
endif


" easymotion
map <Leader> <Plug>(easymotion-prefix)


" airline
let g:airline_theme='oceanicnext'
set laststatus=2
"let g:airline#extensions#branch#displayed_head_limit = 10
"let g:airline#extensions#syntastic#enabled = 0
" Disable the mode, filetype and encoding sections.
let hostname=system('hostname -s| tr -d "\n"')
let g:airline_section_a = '%{hostname}'
let g:airline_section_x = 0
let g:airline_section_y = 0


" tagbar
nmap <leader>ta :TagbarToggle<CR>


" rainbow parens
"let g:rainbow_active = 1


" deoplete
"let g:deoplete#enable_at_startup = 1
"inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : deoplete#mappings#manual_complete()
"inoremap <Leader><Tab> <Space><Space>
"autocmd CompleteDone * pclose


" ncm2 completion
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
" tab to select from the autocomplete menu
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


" jedi
let g:jedi#auto_initialization = 1
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#popup_on_dot = 0
let g:jedi#completions_command = ""
let g:jedi#show_call_signatures = "1"


" neomake
"let g:neomake_open_list = 2
"let g:neomake_warning_sign = {
"      \ 'text': 'W',
"      \ 'texthl': 'WarningMsg',
"      \ }
"let g:neomake_error_sign = {
"      \ 'text': 'E',
"      \ 'texthl': 'ErrorMsg',
"      \ }
" Neomake on <leader>z
"nnoremap <leader>z :Neomake<CR>
" close the error and scrach and quickfix windows on the bottom
"nnoremap <leader>c :lclose<CR> :pclose<CR> :cclose<CR>


" python
"let g:neomake_python_enabled_makers = ['pylama']
" Set or unset the color column depending on filetype.
fun! SetColorCol()
  if &ft =~ 'python'
    set colorcolumn=88
    set textwidth=88
    highlight ColorColumn ctermbg=8
  else
    set textwidth&
    set colorcolumn&
  endif
endfun
autocmd BufNewFile,BufEnter,BufRead * call SetColorCol()


" docker
au BufNewFile,BufRead *dockerfile* set filetype=Dockerfile

" jsx
let g:jsx_ext_required = 0

" nvim
let g:python_host_prog = '/home/matt/.pyenv/versions/2.7.15/bin/python'
let g:python3_host_prog = '/home/matt/.pyenv/versions/3.6.6/bin/python'

" .culture -> toml
au BufRead,BufNewFile *.culture set filetype=toml
