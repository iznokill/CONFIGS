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

set nocompatible

syntax enable

let python_highlight_all = 1

autocmd FileType make setlocal noexpandtab


call plug#begin()
" rainbow brackets
Plug 'frazrepo/vim-rainbow'

" lightline
Plug 'itchyny/lightline.vim'

"isort sorts python imports
Plug 'fisadev/vim-isort'

"nerdtree
Plug 'preservim/nerdtree'

"nerdtree tabs
Plug 'jistr/vim-nerdtree-tabs'

"Clang-format auto
Plug 'rhysd/vim-clang-format'

"jupiter-vim
Plug 'jupyter-vim/jupyter-vim'

"autoformat python code
Plug 'Chiel92/vim-autoformat'

"autocomplete
Plug 'zxqfl/tabnine-vim'

"enabe sql connect
Plug 'vim-scripts/dbext.vim'

"vim_fugitive
Plug 'tpope/vim-fugitive'

"tag_bar
Plug 'https://github.com/preservim/tagbar'

"yaml formatter
Plug 'tarekbecker/vim-yaml-formatter'

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


" Highlight bad whitespace
highlight BadWhitespace ctermbg=red guibg=red
au BufRead,BufNewFile *.py match BadWhitespace /^\ \+/
au BufRead,BufNewFile *.py match BadWhitespace /\s\+$/

"execute python
nnoremap <silent> <F5> :call SaveAndExecutePython()<CR>
vnoremap <silent> <F5> :<C-u>call SaveAndExecutePython()<CR>

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
    silent execute ".!python " . shellescape(s:current_buffer_file_pathl, 1)

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
" autoformat every file
au BufWrite *.cc :Autoformat
au BufWrite *.hh :Autoformat
au BufWrite *.hxx :Autoformat
au BufWrite *.py :Autoformat
au BufWrite *.c :Autoformat
au BufWrite *.h :Autoformat
au BufWrite *.yaml :YAMLFormat
au BufWrite *.json :%!python -m json.tool









""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Plugin: Lightline                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2
let g:lightline = {
            \ 'colorscheme': 'PaperColor_dark',
            \ 'active': {
                \   'left': [ [ 'mode', 'paste' ], [ 'filename', 'gitversion' ], [ 'tagbar' ] ]
                \ },
                \ 'inactive': {
                    \   'left': [ [ 'filename', 'gitversion' ] ],
                    \   'right': [ [ 'lineinfo' ], [ 'percent' ] ]
                    \ },
                    \ 'component': {
                        \         'tagbar': '%{tagbar#currenttag("%s", "", "f")}',
                        \ },
                        \ 'component_function': {
                            \   'modified': 'LightLineModified',
                            \   'readonly': 'LightLineReadonly',
                            \   'filename': 'LightLineFilename',
                            \   'fileformat': 'LightLineFileformat',
                            \   'filetype': 'LightLineFiletype',
                            \   'fileencoding': 'LightLineFileencoding',
                            \   'mode': 'LightLineMode',
                            \   'gitversion': 'LightLineGitversion',
                            \ },
                            \ }

function! LightLineModified()
    return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
    return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! LightLineGitversion()
    let fullname = expand('%')
    let gitversion = ''
    if fullname =~? 'fugitive://.*/\.git//0/.*'
        let gitversion = 'git index'
    elseif fullname =~? 'fugitive://.*/\.git//2/.*'
        let gitversion = 'git target'
    elseif fullname =~? 'fugitive://.*/\.git//3/.*'
        let gitversion = 'git merge'
    elseif &diff == 1
        let gitversion = 'working copy'
    endif
    return gitversion
endfunction

function! LightLineFilename()
    let fname = expand('%:t')
    return fname == 'ControlP' ? g:lightline.ctrlp_item :
                \ fname == '__Tagbar__' ? g:lightline.fname :
                \ ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
                \ ('' != fname ? fname : '[No Name]') .
                \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFileformat()
    return winwidth(0) > 90 ? &fileformat : ''
endfunction

function! LightLineFiletype()
    return winwidth(0) > 80 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
    return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
    let fname = expand('%:t')
    return fname == '__Tagbar__' ? 'Tagbar' :
                \ fname == 'ControlP' ? 'CtrlP' :
                \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction
