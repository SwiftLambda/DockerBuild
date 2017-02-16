set nocompatible              " be improved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.config/nvim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'ctrlpvim/ctrlp.vim'

" Languages
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'keith/swift.vim'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

" themes
Plugin 'arcticicestudio/nord-vim'

" Highlight indent
Plugin 'nathanaelkane/vim-indent-guides'

" Autocomplete
Plugin 'Shougo/deoplete.nvim'
Plugin 'mitsuse/autocomplete-swift'

" NerdTree explorer
Plugin 'scrooloose/nerdtree'

" Status bar
Plugin 'itchyny/lightline.vim'

" Super tab
Plugin 'ervandew/supertab'

" Syntax checking
Plugin 'scrooloose/syntastic'

" Fix indentation
Plugin 'junegunn/vim-easy-align'

" Tagbar to view tags in right hand column
Plugin 'majutsushi/tagbar'

call vundle#end() " required

filetype plugin indent on

set nobackup
set nowb
set noswapfile
set lazyredraw
set hid

" Turn on the WiLd menu
set wildmenu

" Set command-line completion mode
set wildmode=list:longest,full

" Highlight current line - allows you to track cursor position more easily
set cursorline

" Completion options (select longest + show menu even if a single match is found)
set completeopt=longest,menuone

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
    set wildignore+=.git\*,.hg\*,.svn\*
endif

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Text formatting
set guifont=Source\ Code\ Pro\ 15
set sw=2
set ts=2
set softtabstop=2
set expandtab
set number
set clipboard=unnamed

" Make sure that coursor is always vertically centered on j/k moves
set so=999

" add vertical lines on columns
set colorcolumn=80,120

syntax on
colorscheme nord
highlight Comment ctermfg=magenta

" Indent guide
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors           = 1

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
    set wildignore+=.git\*,.hg\*,.svn\*
endif

" lightbar settings
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'filename' ] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ],
      \              [ 'percent' ], 
      \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'readonly': 'LightLineReadonly',
      \   'modified': 'LightLineModified',
      \   'filename': 'LightLineFilename',
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

function! LightLineModified()
    if &filetype == "help"
        return ""
    elseif &modified
        return "+"
    elseif &modifiable
        return ""
    else
        return ""
    endif
endfunction

function! LightLineReadonly()
    if &filetype == "help"
        return ""
    elseif &readonly
        return ''
    else
        return ""
    endif
endfunction

function! LightLineFilename()
    return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
           \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
           \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height = 3
let g:syntastic_ruby_checkers = ['mri', 'rubocop']
let g:syntastic_swift_checkers = ['swiftpm', 'swiftlint']
let g:syntastic_ignore_files = ['\.s$']

augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.swift,*.go,*.c,*.cpp,*.rb,*.js,*.yaml,*.yml,*.js call s:syntastic()
augroup END
function! s:syntastic()
  SyntasticCheck
    call lightline#update()
endfunction

"Ctrl P settings
let g:ctrlp_max_files=10000
let g:ctrlp_max_depth=40
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:100'

" Vim Test
let g:test#preserve_screen = 1

" Disableneocomplete.
let g:neocomplete#enable_at_startup = 0

" Path to python interpreter for neovim
let g:python3_host_prog  = '/usr/bin/python3'
" Skip the check of neovim module
let g:python3_host_skip_check = 0

" Run deoplete.nvim automatically
let g:deoplete#enable_at_startup = 1

" Custom key commands
let mapleader = ","
let g:mapleader = ","

" Open Ack and put the cursor in the right position
map <leader>a :Ack<space>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

map <C-p>           : CtrlP<CR>
map <C-t>           : CtrlPBufTag<CR>
map <leader>p       : CtrlPBuffer<CR>
map <F6>            : NERDTreeToggle<CR>
map <F8>            : TagbarToggle<CR>
map <silent> <C-k>  : wincmd k<CR>
map <silent> <C-j>  : wincmd j<CR>
map <silent> <C-l>  : wincmd l<CR>
nmap <silent> <C-h>  : wincmd h<CR>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
"
" " Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Markdown settings
let g:vim_markdown_folding_disabled = 1
