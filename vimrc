" Vim configuration file. Set to be programmer friendly.
"
" This file does not include any configuration for the GUI since .gvimrc
" is sourced just for that reason.

"============================== Miscellaneous ===========================
set nocompatible        " Turn off strict compatibility with vi.
set nobackup            " Don't keep a backup file
set noswapfile          " Don't keep swapfiles
set viminfo='20,<50,s100,h  " 50 lines of registers
set history=50          " Keep 50 lines of command line history
set noerrorbells        " Silence error bells/beeps
set ttyscroll=1         " Does something about screen redrawing...
set shell=/bin/bash
set wildmode=longest,list " Let me tab complete file names
set autowrite           " Automatically save before commands like :next and :make
"set list                " Show whitespace
set tabpagemax=20       " Allow up to 20 tabs simultaneously
set sessionoptions+=unix,slash " Make sessions compatible between Unix and MS-Windows.
if has("multi_byte")
    set encoding=utf-8      " Display digraphs better. Default is latin1.
endif

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

" Turn on write backups to avoid the case where the disk has become full and
" to the file will truncate what we have.  This option writes to a temporary
" file and when successful, moves the temporary into the original.
set writebackup

" Automatically update buffer contents if the file has not been modified
" inside of Vim and is updated on disk.  Nothing is updated if the file
" is removed from disk.
set autoread

" Keep Vim from detaching from the terminal when spawning gvim.  We place
" this option here since by the time the .gvimrc file has been read, it
" is too late.
set guioptions+=f

" Make pattern matching case insensitive unless explicitly requested.  That is
" if the pattern consists of only lower case letters, be insensitive, otherwise
" be sensitive.
set smartcase

"================================ Formatting ============================
set expandtab           " Always convert tabs to spaces
set backspace=2         " Allow backspacing over everything in insert mode
"set smartindent         " Enable smart indenting
"set tabstop=4           " Set tab width to 4 spaces

" Make groups of 4 spaces behave like a single tab.  That is, hitting
" backspace will delete all 4 spaces.
set softtabstop=4

" Default indentation level.  How many columns to indent by when you use the
" >> command.
set shiftwidth=4

" Be smart about indenting things?  Should make TAB indent things.
set smarttab

" Automatically indent things according to where the previous line started.
" This should cover files that don't have indentexprs associated with them.
set autoindent

"================================ Display ===============================
set showmode            " Show what mode the editor is currently in (visual, insert, etc)
set noerrorbells        " Disable the bell.
set showcmd             " Show (partial) command in status line.
set incsearch           " Incremental search
set scrolloff=3         " Always try to keep the cursor within 3 lines of the top/bottom
set laststatus=2        " Always show status bar
set wrap                " Display long lines across multiple lines (instead of continuing off the window)
set linebreak           " Wrap long lines at a space instead of in the middle of a word
set hls                 " Make sure search highlighting is active.
"set showmatch           " Show matching brackets.

" Have text wrap at 80 characters.  Newlines aren't inserted into the data
" stream.  We specifically control when text wraps and when comments wrap.
set textwidth=80

" Text never wraps, comments do.
set formatoptions-=t
set formatoptions+=c

" Disable the introduction screen that is normally displayed when starting
" Vim.
set shortmess=I

" Display a status line indicating the current line and column number.  This
" goes well with the mode display that we set later.
set ruler

if has('autocmd')
    " Disable the bell's annoying friend; visual bell.  Do it in a way that is
    " compatible across all architectures that support gvim and not just
    " Unix variants.
    autocmd VimEnter * set vb t_vb=""
endif

"set t_Co=256            " Set terminal colors to 256.
"let g:molokai_original=1
"colorscheme molokai
"colorscheme wombat      " Use more interesting colors
colorscheme desert      " Use more interesting colors
"colorscheme elflord      " Use more interesting colors
if &diff
"   colorscheme evening " Better colors for vimdiff
   colorscheme jellybeans " Better colors for vimdiff
endif

"========================== File Type Specifics ======================
if has('autocmd')
    " Makefiles have to have tabs in them or make will complain very loudly.
    autocmd FileType make set noexpandtab

    " Indent intelligently when editing C source code.
    autocmd FileType c,cpp,fortran set cindent

    " Perl code looks pretty close to C, so use smart indenting
    autocmd FileType perl set smartindent

    " Specify how C source code should be indented.  This can be interpreted as:
    "
    "   :0   indent case statement labels to the same column as the opening switch
    "   l1   align statements in a case offset from where the case label opened
    "   g0   place C++ scope declarations (public/private/protected) on the first
    "        column of the block that encloses them.
    "   (0   line up columns after opening a parenthesis but before it is closed.
    "   +2s  this might help with continuing lines, probably mostly unnecessary
    "        for now.
    autocmd FileType c,cpp set cinoptions=:0l1g0(0+2s

    " Remove trailing whitespace when saving certain file types.
    autocmd FileType c,cpp,fortran,matlab autocmd BufWritePre * :%s/\s\+$//e

    " Use improved matching logic for Matlab.
    autocmd FileType matlab source $VIMRUNTIME/macros/matchit.vim

    autocmd FileType text set textwidth=0
endif

let fortran_do_enddo=1
let fortran_more_precise=1
let fortran_have_tabs=1
filetype plugin indent on
if has('syntax') && (&t_Co > 2)
    syntax enable
endif

"============================== Shortcuts ==============================
" Use ,/ or ,# or ," or ,; or ,! or ,% to comment out a line (depending on what
" does the job) and use ,c to uncomment.
" The // and ! versions are built to respect leading whitespace and to ignore empty lines.
" All of these commands clear the search highlighting afterwards for cleanliness.
nnoremap ,/ :s/^\(\s*\)\(.\)/\1\/\/\2/<CR>:noh<CR>
nnoremap ,# :s/^/#/<CR>:noh<CR>
nnoremap ," :s/^/"/<CR>:noh<CR>
nnoremap ,; :s/^/;/<CR>:noh<CR>
nnoremap ,! :s/^\(\s*\)\(.\)/\1!\2/<CR>:noh<CR>
nnoremap ,% :s/^/% /<CR>:noh<CR>
nnoremap ,c :s/^\(\s*\)\(\(\/\/\)\\|\(\#\)\\|\(\"\)\\|\(\;\)\\|\(\!\)\\|\(% \)\)/\1/<CR>:noh<CR>

" If using the above shortcuts and searching for multiple items to comment/
" uncomment, use this to search for the next desired item.
nnoremap ,n q/kk<CR>n

" Pasting from the web or an external source will use all my autoindent
" and the code will come up garbled. By pressing F2, I can enter <paste>
" mode, and all those will be ignored, and Ctrl+Shift+V will paste my
" buffer respecting its original form.
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

" Clear search highlighting.
nmap <F3> :noh<CR>
imap <F3> :noh<CR>i

" Switch on/off line numbering.
nmap <F4> :set number!<CR>
imap <F4> :set number!<CR>i

" Remove trailing whitespace.
nmap <F5> :%s/\s\+$//e<CR>
imap <F5> :%s/\s\+$//e<CR>i

" Shortcut to make an if block in C. A more complicated/robust solution for
" Fortran allowing for more block types exists in
" ~/.vim/ftplugin/fortran_codecomplete.vim.
if has('autocmd')
    autocmd FileType c,cpp nmap <F7> o{<CR>}<ESC>O
    autocmd FileType c,cpp imap <F7> <CR>{<CR>}<ESC>O
    autocmd FileType tex nmap <F7> o\begin{quotation}<CR>\end{quotation}<ESC>O
    autocmd FileType tex imap <F7> <CR>\begin{quotation}<CR>\end{quotation}<ESC>O
endif

" Create nice brackets for a new scope and place the cursor in the middle.
nnoremap ,{ o{<ESC>o}<ESC>O
" If a line has been broken past where you want and you want to instead break
" at an earlier point, go to that point and try this.
nnoremap ,<CR> i<CR><ESC>$a<DEL><ESC>ldwi <ESC>

"============================== Inactive ==============================
" Maintain 'persist' data, but keep my workspace clean
"set backup
"set backupdir=~/.vim/backup   " previous versions of files are placed here
"set directory=~/.vim/tmp      " .swp files, etc. are stored here

" Adjust title to include filename. Doesn't blend well with tabs.
"let &titlestring = "[vim(" . expand("%:t") . ")]"
"if &term == "screen"
"   set t_ts=^[k
"   set t_fs=^[\
"endif
"if &term == "screen" || &term == "xterm"
"   set title
"endif

