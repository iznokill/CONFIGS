" ~/.vimrc


set mouse=a

set autoindent

set cindent

set tabstop=8

set softtabstop=4

set shiftwidth=4

set expandtab

set clipboard=unnamedplus

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


" vim-sensible
Plugin 'tpope/vim-sensible'

"nerdtree
Plugin 'preservim/nerdtree'

"Clang-format
Plugin 'https://github.com/rhysd/vim-clang-format'

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

