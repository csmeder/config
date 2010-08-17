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


"-----------------------------------------------------------------
" When editing an .html,.css, or .gtpl file, make Firefox refresh
" after the buffer is saved, preserving the current scroll offset.
"
" Requires:
"       [1]  MozRepl must be installed & running in Firefox
"
"       [2]  Netcat (nc) must be on your path.
"
"       [3]  Firefox & vim are both on the same machine (localhost).
"            Actually, you can fix that if you want by adjusting
"            this script + your MosRepl settings but it's probably
"            a bit of a security risk.
"
" Ok, here's how it works:
"
"   I use echo + netcat (nc) to send a dopey little MosRepl
"   script (see below) to Firefox. All the output is tossed
"   away (2>&1 > /dev/null) because MozRepl is chatty.
"
"   Global variables are used (vimXo, vimYo) to capture the X,Y
"   offset of the web page for vim. Maybe there's a way to not
"   use a global, but I don't know that that might be. After saving
"   the buffer and reloading the browser, scroll to the X,Y offset.
"
" See also:
"   http://wiki.github.com/bard/mozrepl/tutorial
"   http://forums.whirlpool.net.au/forum-replies-archive.cfm/495300.html
"
" Aside:  Line continuation in vimscript is a bit weird;
"         it comes at start of the line you want merged,
"         rather than at the end of the line being broken.
"-----------------------------------------------------------------
autocmd BufWriteCmd *.html,*.css,*.gtpl,*.sass,*.erb :call Refresh_firefox()
function! Refresh_firefox()
  if &modified
    write
    silent !echo  'vimYo = content.window.pageYOffset;
                 \ vimXo = content.window.pageXOffset;
                 \ BrowserReload();
                 \ content.window.scrollTo(vimXo,vimYo);
                 \ repl.quit();'  |
                 \ nc localhost 4242 2>&1 > /dev/null
  endif
endfunction
"-----------------------------------------------------------------
