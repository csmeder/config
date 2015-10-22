set nocompatible          " don't attempt to be compatible with old-style vi

behave xterm
filetype plugin indent on
syntax on

" editor behavior
set wildmenu              " show matches on tab-completion
set incsearch             " show matches while typing search string
set noshowmatch           " don't jump to matching bracket after typing closing bracket
set foldmethod=syntax     " fold code as defined by syntax
set foldlevel=3

" indentation preferences
set smarttab
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent

" C formatting options
set cinoptions=t0,+2s,g0
set cinwords=if,unless,else,while,until,do,for,switch,case
set cindent
set formatoptions=croql

" display options
set number                " show line numbers
set ruler                 " show current line, column, and relative position in file
set showmode              " show current mode (insert, replace, visual)
set list                  " show tabs as '^I'
set listchars=trail:~     " show trailing whitespace

" highlight past 80 columns
highlight OverLength cterm=reverse
match OverLength /\%81v.*/

" syntax highlighting for sass files
au BufNewFile,BufRead *.scss set filetype=sass

" to write to protected files
cmap w!! %!sudo tee %

colorscheme desert
