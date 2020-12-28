" ~/.vimrc


set mouse=a

set autoindent

set cindent

set tabstop=8

set softtabstop=4

set shiftwidth=4

set expandtab

set clipboard=unnamedplus

syntax enable

let python_highlight_all = 1

autocmd FileType make setlocal noexpandtab


" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" rainbow brackets
Plugin 'https://github.com/frazrepo/vim-rainbow'

" lightline
Plugin 'https://github.com/itchyny/lightline.vim'

"isort sorts python imports
Plugin 'fisadev/vim-isort'


" vim-sensible
Plugin 'tpope/vim-sensible'

"nerdtree
Plugin 'preservim/nerdtree'
"nerdtree tabs
Bundle 'jistr/vim-nerdtree-tabs'


"Clang-format auto
Plugin 'https://github.com/rhysd/vim-clang-format'

"execute python inside vim
Plugin 'jpalardy/vim-slime'
Plugin 'hanschen/vim-ipython-cell'

"vim-repl
Bundle 'sillybun/vim-repl'

"jupiter-vim
Plugin 'jupyter-vim/jupyter-vim'

"ipython
Plugin 'https://github.com/ivanov/vim-ipython'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

runtime! plugin/sensible.vim

set encoding=utf-8 fileencodings=
syntax on

" colorscheme onedark

set number
set cc=80

autocmd Filetype make setlocal noexpandtab

"autoenable clang-formating
autocmd FileType c ClangFormatAutoEnable

set list listchars=tab:»·,trail:·

" enable rainbow brackets
let g:rainbow_active = 1


"set lightline scheme
let g:lightline = {
     \ 'colorscheme': 'PaperColor_dark',
      \ }

" per .git vim configs

" just `git config vim.settings "expandtab sw=4 sts=4"` in a git repository

" change syntax settings for this repository
let git_settings = system("git config --get vim.settings")
if strlen(git_settings)
	exe "set" git_settings
endif

" key map nerdtree
map <C-n> :NERDTreeTabsOpen  <CR>
map <C-f> :NERDTreeTabsClose  <CR>



"show hiddenfiles nerdtree
let NERDTreeShowHidden=1

"enable kite for the following languages
let g:kite_supported_languages = ['python', 'javascript', 'go']

"set tab as the autocomplete button
let g:kite_tab_complete=1

"doc for kite
let g:kite_documentation_continual=1
nmap <silent> <buffer> gK <C-d>(kite-docs)


"status bar with kite
set statusline=%<%f\ %h%m%r%{kite#statusline()}%=%-14.(%l,%c%V%)\ %P
set laststatus=2


" Highlight bad whitespace
highlight BadWhitespace ctermbg=red guibg=red
au BufRead,BufNewFile *.py match BadWhitespace /^\ \+/
au BufRead,BufNewFile *.py match BadWhitespace /\s\+$/

"isort for python version
let g:vim_isort_python_version = 'python3'

" Create a function to open a neovim terminal in a small split window and run python 
function! Termpy()
  exec winheight('%') winwidth('%')/4. "vsp" | terminal python3 %
endfunction
"set splitright

function! Termqt()
  exec winheight('%') winwidth('%')/4. "vsp" | terminal  %
endfunction

" Press F5 to run python script into separate term window 
nnoremap <F5> :w <CR> :call Termqt() <CR>
nnoremap <F6> :bd!<CR>

