"ll comfortable_motion#flick(40)
""" Plugins
set nocompatible					" Requirde
filetype off						" Requirde
set rtp+=~/.vim/bundle/Vundle.vim	" Requirde
call vundle#begin()					" Requirde
Plugin 'VundleVim/vundle.vim'		" Plugin Manager

Plugin 'vim-airline/vim-airline'	" Fancy Vim Status Line
Plugin 'vim-airline/vim-airline-themes' " Themes for vim-airline
"Plugin 'yuttie/comfortable-motion.vim'	" Smooth scrolling in vim (CAUSES SCREEN TEARING ON MY LAPTOP)
Plugin 'mbbill/undotree'			" Undotree (:UndotreeToggle)
Plugin 'thaerkh/vim-workspace'		" Enable session storing and migration (:ToggleWorkspace)
"Plugin 'tpope/vim-surround'		" Easy editing of surrounding characters (WANT TO READ MORE DOCUMENTATION BEFORE TRYING OUT
"Plugin 'terryma/vim-multiple-cursors'	" Use multiple cursors to edit text faster (WANT TO READ MORE DOCUMENTATION BEFORE TRYING OUT

call vundle#end()					" Requirde
filetype plugin indent on			" Requirde

" Arline
"let g:airline_powerline_fonts=1
let g:airline_extensions=[]

" Comfortable Motion
"let g:comfortable_motion_no_default_key_mappings=1 " Disable the default key mappings
"noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(40)<CR>
"noremap <silent> <ScrollWheelUp> :call comfortable_motion#flick(-40)<CR>

""" General
" UI
set number " Turn on line numbering
set ruler " Display coordinates and scroll % in bottom right
set laststatus=2 " Always show status line
"set cursorline " show underline on currently selected line
"set colorcolumn=100 " Mark the column to show max width
"set virtualedit=all " Allow the cursor to go anywhere

" Fold
set foldenable " Enable folding
set foldcolumn=2 " Set Folding column 
set foldmethod=manual " Set folding detection method
set foldlevelstart=99 " Start with everything unfolded
let g:airline_highlighting_cache=1

" Colours
" colorscheme ksyrx " Change colour scheme

" Syntax
filetype on
filetype plugin on
syntax on " enable color highlight
set showmatch " Show matching bracket when typing  

" Spell
"set spell " Enable spell checking
"setlocal spell spelllang=en_us " Set spell check locale

" Indentation
set tabstop=4 " How many spaces is a tab
set autoindent " copy indentation from current line when starting a new one
set noexpandtab " Tabs aren't expanded into spaces

" Search
set hlsearch " Highlight all matches when searching
set incsearch " Begin searching immediately
set ignorecase " Ignore case in search
set smartcase " Override the 'ignorecase' if search has upper case

" Mouse
set mouse=a " Enable Mouse

" Hotkeys
" remove all trailing whitespace
nmap <F5> :let _s=@/<bar>:%s/\s\+$//e<Bar>:let @/=_s<bar><cr> 
" hide/show numbers column and fold column
nmap <F9> :set nonumber foldcolumn=0<cr>
nmap <F10> :set number foldcolumn=2<cr>


" Autocmd
autocmd BufRead,BufNewFile *.txt setlocal spell " auto enable spell check for *.txt files







""" DON"T KNOW WHAT THIS DOES YET< BUT WANT TO LEARN
" autocompletion enable/disable
"nmap <F11> :AcpEnable
"nmap <F12> :AcpDisable

" if you want retab something file (put this inside vim command line)
" set ts=2 noet | retab! | set et ts=4 | retab

" auto completion
imap {<CR> {<CR><CR>}<UP><TAB>
"inoremap ( ()<left>
"inoremap { {}<left>
