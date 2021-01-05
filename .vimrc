" ~/.vimrc


set mouse=a

set autoindent

set cindent

set tabstop=8

set softtabstop=4

set shiftwidth=4

set expandtab

set number

set cc=80

set clipboard=unnamedplus

syntax enable

let python_highlight_all = 1


autocmd FileType make setlocal noexpandtab

call plug#begin()
" rainbow brackets
Plug 'https://github.com/frazrepo/vim-rainbow'

" lightline
Plug 'https://github.com/itchyny/lightline.vim'

"isort sorts python imports
Plug 'fisadev/vim-isort'

"nerdtree
Plug 'preservim/nerdtree'

"nerdtree tabs
Plug 'https://github.com/jistr/vim-nerdtree-tabs'

"Clang-format auto
Plug 'https://github.com/rhysd/vim-clang-format'

"jupiter-vim
Plug 'jupyter-vim/jupyter-vim'

"autoformat python code
Plug 'Chiel92/vim-autoformat'

"autocomplete
Plug 'zxqfl/tabnine-vim'

call plug#end()
filetype plugin indent on

runtime! plugin/sensible.vim

set encoding=utf-8 fileencodings=
syntax on

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
map <C-n> <plug>NERDTreeTabsOpen<CR>
map <C-f> <plug>NERDTreeTabsClose<CR>

"show hiddenfiles nerdtree
let NERDTreeShowHidden=1

"enable kite for the following languages
let g:kite_supported_languages = ['python', 'javascript', 'go']
"set tab as the autocomplete button
let g:kite_tab_complete=1


" Highlight bad whitespace
highlight BadWhitespace ctermbg=red guibg=red
au BufRead,BufNewFile *.py match BadWhitespace /^\ \+/
au BufRead,BufNewFile *.py match BadWhitespace /\s\+$/

"execute python
nnoremap <silent> <F5> :call SaveAndExecutePython()<CR>
vnoremap <silent> <F5> :<C-u>call SaveAndExecutePython()<CR>

" CREDIT: https://gist.github.com/vishnubob/c93b1bdc3d5df64a8bc29246adfa8c6c
" https://stackoverflow.com/questions/18948491/running-python-code-in-vim
function! SaveAndExecutePython()
    " SOURCE [reusable window]: https://github.com/fatih/vim-go/blob/master/autoload/go/ui.vim

    " save and reload current file
    silent execute "update | edit"

    " get file path of current file
    let s:current_buffer_file_path = expand("%")

    let s:output_buffer_name = "Python"
    let s:output_buffer_filetype = "output"

    " reuse existing buffer window if it exists otherwise create a new one
    if !exists("s:buf_nr") || !bufexists(s:buf_nr)
        silent execute 'botright vsplit new ' . s:output_buffer_name
        let s:buf_nr = bufnr('%')
    elseif bufwinnr(s:buf_nr) == -1
        silent execute 'botright vsplit new'
        silent execute s:buf_nr . 'buffer'
    elseif bufwinnr(s:buf_nr) != bufwinnr('%')
        silent execute bufwinnr(s:buf_nr) . 'wincmd w'
    endif

    silent execute "setlocal filetype=" . s:output_buffer_filetype
    setlocal bufhidden=delete
    setlocal buftype=nofile
    setlocal noswapfile
    setlocal nobuflisted
    setlocal winfixheight
    " setlocal cursorline " make it easy to distinguish
    setlocal nonumber
    setlocal norelativenumber
    setlocal showbreak=""

    " clear the buffer
    setlocal noreadonly
    setlocal modifiable
    %delete _

    " add the console output
    silent execute ".!python " . shellescape(s:current_buffer_file_path, 1)

    " resize window to content length
    " Note: This is annoying because if you print a lot of lines then your code buffer is forced to a height of one line every time you run this function.
    "       However without this line the buffer starts off as a default size and if you resize the buffer then it keeps that custom size after repeated runs of this function.
    "       But if you close the output buffer then it returns to using the default size when its recreated
    "execute 'resize' . line('$')

    " make the buffer non modifiable
    setlocal readonly
    setlocal nomodifiable
    if (line('$') == 1 && getline(1) == '')
        q!
    endif
    silent execute 'wincmd p'
endfunction

au BufWrite * :Autoformat
