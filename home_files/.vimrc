syn on
syntax enable

colorscheme desert
set background=dark

filetype on

" Display line numbers
" set nu

set  showmatch

set  incsearch

set  ignorecase
set  smartcase
set  hlsearch

set  wildmenu    "affiche le menu
set  wildmode =list:longest,list:full    "affiche toutes les possibilités
set  wildignore =*.o,*.r,*.so,*.sl,*.tar,*.tgz    "ignorer certains types de fichiers pour la complétion des includes

" draw a line under the current sursor line
"set  cursorline

set  history=200

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /

" Shortcuts
iab ret return

if has("autocmd")
    filetype plugin indent on
        autocmd FileType text setlocal textwidth=78

    autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
    \ endif
endif

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()
