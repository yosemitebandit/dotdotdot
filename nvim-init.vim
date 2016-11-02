""" https://github.com/yosemitebandit/dotdotdot
"""

" pull in the machine env vars
let machine=$MACHINE
let bits=$BITS


" a function deoplete recommends
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction


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
Plug 'luochen1990/rainbow'
Plug 'scrooloose/nerdcommenter'
Plug 'Chiel92/vim-autoformat'
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'davidhalter/jedi'
Plug 'zchee/deoplete-jedi'
Plug 'benekastah/neomake'
"Plug 'paretje/neomake', { 'branch': 'highlight' }

" langs
Plug 'tclem/vim-arduino'
Plug 'vim-scripts/openscad.vim'
Plug 'lepture/vim-jinja'
Plug 'fatih/vim-go'
Plug 'fatih/vim-nginx'
Plug 'cespare/vim-toml'
"Plug 'pangloss/vim-javascript'
Plug 'othree/yajs.vim'
Plug 'mxw/vim-jsx'
Plug 'JulesWang/css.vim'
Plug 'tpope/vim-markdown'
Plug 'hynek/vim-python-pep8-indent'
Plug 'guns/vim-clojure-static'
Plug 'tpope/vim-fireplace'
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
Plug 'mustache/vim-mustache-handlebars'

" colors
Plug 'mhartington/oceanic-next', { 'commit': 'b938fbcfdf6d66ffc9b9eb945de8b3629c634f65' }

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
        \ --nocolor --nogroup --depth 5
        \ --hidden --follow --smart-case
        \ --ignore .git
        \ -g ""'
  let g:ctrlp_use_caching = 0
endif


" easymotion
map <Leader> <Plug>(easymotion-prefix)


" airline
" Show the bar even when only one file is open and force 256 color-mode.
let g:airline_theme='oceanicnext'
set laststatus=2
let g:airline#extensions#branch#displayed_head_limit = 10
let g:airline#extensions#syntastic#enabled = 0
" Disable the mode, filetype and encoding sections.
let hostname=system('hostname -s| tr -d "\n"')
let g:airline_section_a = '%{hostname}'
let g:airline_section_x = 0
let g:airline_section_y = 0


" tagbar
nmap <leader>ta :TagbarToggle<CR>


" rainbow parens
let g:rainbow_active = 1


" deoplete
let g:deoplete#enable_at_startup = 1
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : deoplete#mappings#manual_complete()
inoremap <Leader><Tab> <Space><Space>


" neomake
let g:neomake_open_list = 2
let g:neomake_warning_sign = {
      \ 'text': 'W',
      \ 'texthl': 'WarningMsg',
      \ }
let g:neomake_error_sign = {
      \ 'text': 'E',
      \ 'texthl': 'ErrorMsg',
      \ }
" Neomake on <leader>z
nnoremap <leader>z :Neomake<CR>
" close the error and scrach windows on the bottom
nnoremap <leader>c :lclose<CR> :pclose<CR>


" rust
au BufRead,BufNewFile *.rs set filetype=rust
au FileType rust nmap <leader>f :Autoformat<CR>
au FileType rust set hidden
let g:racer_cmd = "/Users/matt/.cargo/bin/racer"
let $RUST_SRC_PATH="/usr/local/rust/src"
"autocmd BufEnter,BufWritePost *.rs Neomake! cargo
"autocmd BufWritePost *.rs :Autoformat<CR>


" python
"autocmd BufEnter,BufWritePost *.py Neomake! pylama
au FileType python set colorcolumn=79
au FileType python set textwidth=79
highlight ColorColumn ctermbg=8
let g:neomake_python_enabled_makers = ['pylama']


" mustache
au BufNewFile,BufRead *.tpl set filetype=html.mustache syntax=mustache
