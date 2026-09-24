" =========================
" ~/.vimrc
"
" =========================

" --- Basic ---
" --- ALE ---
syntax on

set signcolumn=no
set number
set autoindent
set smartindent
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set noshowmode
" --- Syntax highlighting ---
syntax enable
set background=dark
set termguicolors
" --- Cursor ---
set guicursor=a:block
highlight Cursor guibg=Red guifg=Black
" --- jj = Escape ---
inoremap jj <Esc>

" --- ; = : in Normal mode ---
nnoremap ; :

" --- Persistent undo ---
set undofile
set undodir=~/.vim/undo
set history=1000

" --- Persistent command/search history ---
set viminfo='1000,<1000,s100,h

" --- Make sure undo directory exists ---
if !isdirectory(expand('~/.vim/undo'))
    call mkdir(expand('~/.vim/undo'), 'p')
endif

" --- Highlight current line number red ---
highlight CursorLineNr guifg=red ctermfg=red
set cursorline
highlight LineNr guifg=#666666 ctermfg=8
highlight CursorLineNr guifg=white
set nocursorline
" --- Search highlighting ---
set hlsearch
set incsearch

" --- Better indentation ---
filetype plugin indent on

" --- Show matching brackets ---
set showmatch

" --- Don't wrap code ---
set nowrap
" Enable line highlighting and relative numbering
set number

" Customize the current line number color
" guifg changes text color, guibg changes the number's background color
highlight CursorLineNr ctermfg=Yellow gui=bold


" Error line highlighting
nnoremap <C-L> :nohlsearch<CR>

" For the currently selected/active search term
hi CurSearch ctermbg=Green ctermfg=Black guibg=Green guifg=Black
set timeout
set timeoutlen=150
set makeprg=go\ build\ .
set shellcmdflag=-c
autocmd BufRead,BufNewFile *.vala set filetype=c

" 1. --- Plugin Management (Example using vim-plug) ---
call plug#begin('~/.vim/plugged')
Plug 'nordtheme/vim'
Plug 'dense-analysis/ale'
call plug#end()

" 2. --- Nord Color Scheme Setup ---
syntax enable
colorscheme nord

" 3. --- Keep Terminal Background Color Unchanged ---
" This overrides Nord's default background, forcing it to be transparent/none.
" Must be placed AFTER the 'colorscheme nord' command.
function! NormaliseBackground()
    highlight Normal ctermbg=NONE guibg=NONE
    highlight NonText ctermbg=NONE guibg=NONE
    highlight LineNr ctermbg=NONE guibg=NONE
    highlight SignColumn ctermbg=NONE guibg=NONE
    highlight EndOfBuffer ctermbg=NONE guibg=NONE
endfunction

autocmd ColorScheme nord call NormaliseBackground()
" Run it immediately for the current session
call NormaliseBackground()

" 4. --- Custom Cyan Highlights for ALE ---
" Assign cyan styling for ALE errors, warnings, and their respective signs.
" Nord's cyan color is #88C0D0 (Nord 8) or ANSI color 6.
highlight ALEError ctermbg=NONE ctermfg=6 guibg=NONE guifg=#88C0D0 cterm=underline gui=underline
highlight ALEWarning ctermbg=NONE ctermfg=14 guibg=NONE guifg=#8FBCBB cterm=underline gui=underline
highlight ALEErrorSign ctermbg=NONE ctermfg=6 guibg=NONE guifg=#88C0D0
highlight ALEWarningSign ctermbg=NONE ctermfg=14 guibg=NONE guifg=#8FBCBB

" (Optional) Customize ALE sign icons to keep the gutter clean
let g:ale_sign_error = '●'
let g:ale_sign_warning = '▲'



" --- 1. ALE Configuration for Go ---
" Explicitly tell ALE to use 'gopls' and 'gofmt'/'goimports' for Go files
let g:ale_linters = {
\   'go': ['gopls', 'govet'],
\}

let g:ale_fixers = {
\   'go': ['gofmt', 'goimports'],
\}

" Automatically fix/format Go files whenever you save (:w)
let g:ale_fix_on_save = 1

" --- 2. Re-apply your Transparent Nord + Cyan ALE Highlights ---
" (Ensuring these remain active after adding your Go configuration)
syntax enable
colorscheme nord

function! NormaliseBackground()
    highlight Normal ctermbg=NONE guibg=NONE
    highlight NonText ctermbg=NONE guibg=NONE
    highlight LineNr ctermbg=NONE guibg=NONE
    highlight SignColumn ctermbg=NONE guibg=NONE
    highlight EndOfBuffer ctermbg=NONE guibg=NONE
endfunction

autocmd ColorScheme nord call NormaliseBackground()
call NormaliseBackground()

" Cyan styling for Go linting errors/warnings
highlight ALEError ctermbg=NONE ctermfg=6 guibg=NONE guifg=#88C0D0 cterm=underline gui=underline
highlight ALEWarning ctermbg=NONE ctermfg=14 guibg=NONE guifg=#8FBCBB cterm=underline gui=underline
highlight ALEErrorSign ctermbg=NONE ctermfg=6 guibg=NONE guifg=#88C0D0
highlight ALEWarningSign ctermbg=NONE ctermfg=14 guibg=NONE guifg=#8FBCBB

