" =========================
" Disable cursor/arrow keys
" =========================
map <Left>  <NOP>
map <Right> <NOP>
map <Up>    <NOP>
map <Down>  <NOP>
"
" ==========================================================
" Shortcuts
" ==========================================================
set nocompatible              " Don't be compatible with vi
let mapleader=","             " change the leader to be a comma vs slash
let maplocalleader=","        " change the local leader to be a comma

" Seriously, guys. It's not like :W is bound to anything anyway.
command! W :w

" Reload Vimrc
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" ==========================================================
" open/close the quickfix window
nmap <leader>c :copen<CR>
nmap <leader>cc :cclose<CR>

" Pathogen - Allows us to organize our vim plugins
" ==========================================================
" Load pathogen with docs for all plugins
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" ==========================================================
" Basic Settings
" ==========================================================
syntax on                       " syntax highlighing
filetype on                     " try to detect filetypes
filetype plugin indent on       " enable loading indent file for 
                                " filetype
set number                      " Display line numbers
set numberwidth=1               " using only 1 column (and 1 space) 
                                " while possible
set background=dark             " We are using dark background in vim
set title                       " show title in console title bar
set wildmenu                    " Menu completion in command mode on 
                                " <Tab>
set wildmode=longest:full,full  " <Tab> cycles between all matching 
                                " choices.
set cmdheight=2                 " Set two lines for cmdline
set lines=56                    " Default 56 lines
set columns=80                  " Set width to 80 characters
set textwidth=69                " Default wrap at 69
set colorcolumn=+2              " Add a column to show textwidth

" don't bell or blink
set noerrorbells
set vb t_vb=

" Ignore these files when completing
set wildignore+=*.o,*.obj,.git,*.pyc

" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

""" Insert completion
" don't select first item, follow typing in autocomplete
set completeopt=menuone,longest,preview
set pumheight=6             " Keep a small completion window

""" Moving Around/Editing
set ruler                   " show the cursor position all the time
set nostartofline           " Avoid moving cursor to BOL when jumping around
set virtualedit=block       " Let cursor move past the last char in <C-v> mode
set scrolloff=3             " Keep 3 context lines above and below the cursor
set backspace=2             " Allow backspacing over autoindent, EOL, and BOL
set showmatch               " Briefly jump to a paren once it's balanced
set nowrap                  " don't wrap text
set linebreak               " don't wrap textin the middle of a word
set autoindent              " always set autoindenting on
set smartindent             " use smart indent if there is no indent file
set tabstop=4               " <tab> inserts 4 spaces 
set shiftwidth=4            " but an indent level is 2 spaces wide.
set softtabstop=4           " <BS> over an autoindent deletes both spaces.
set expandtab               " Use spaces, not tabs, for autoindent/tab key.
set shiftround              " rounds indent to a multiple of shiftwidth
set matchpairs+=<:>         " show matching <> (html mainly) as well
set foldmethod=indent       " allow us to fold on indents
set foldlevel=99            " don't fold by default

" don't outdent hashes
inoremap # #

" close preview window automatically when we move around
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

"""" Reading/Writing
set noautowrite             " Never write a file unless I request it.
set noautowriteall          " NEVER.
set noautoread              " Don't automatically re-read changed files.
set modeline                " Allow vim options to be embedded in files;
set modelines=5             " they must be within the first or last 5 lines.
set ffs=unix,dos,mac        " Try recognizing dos, unix, and mac line endings.

"""" Messages, Info, Status
set ls=2                    " allways show status line
set vb t_vb=                " Disable all bells.  I hate ringing/flashing.
set confirm                 " Y-N-C prompt if closing with unsaved changes.
set showcmd                 " Show incomplete normal mode commands as I type.
set report=0                " : commands always print changed line count.
set shortmess+=a            " Use [+]/[RO]/[w] for modified/readonly/written.
set ruler                   " Show some info, even without statuslines.
set laststatus=2            " Always show statusline, even if only 1 window.
set statusline=[%l,%v\ %P%M]\ %f\ %r%h%w\ (%{&ff})\ %{fugitive#statusline()}

" displays tabs with :set list & displays when a line runs off-screen
set listchars=tab:>-,eol:$,trail:-,precedes:<,extends:>
"set list

""" Searching and Patterns
set ignorecase              " Default to using case insensitive searches,
set smartcase               " unless uppercase letters are used in the regex.
set smarttab                " Handle tabs more intelligently 
set hlsearch                " Highlight searches by default.
set incsearch               " Incrementally search while typing a /regex

"""" Display
if has("gui_running")
    " Remove menu bar
    set guioptions-=m

    " Remove toolbar
    set guioptions-=T
endif

" Set CTRL-j enter <CR> without entering insert mode
nnoremap <NL> i<CR><ESC>

" Copy/Paste from clipboard
map <leader>p "+p
map <leader>y "+y

" Set colorscheme
colorscheme ir_black
hi Pmenu    guibg=#22aaaa guifg=White ctermbg=DarkGray ctermfg=White
hi PmenuSel guibg=DarkRed guifg=White ctermbg=DarkRed ctermfg=White

" Fast quit
nnoremap <leader>q :q<CR>

" Fase save
nnoremap <leader>w :w<cr>

" hide matches on <leader>space
nnoremap <leader><space> :nohlsearch<cr>

" Select the item in the list with enter
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
