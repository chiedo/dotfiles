" Requirements:
" - Install Vundle: https://github.com/VundleVim/Vundle.vim
" Required Vundle setup:
filetype off
set nocompatible
set runtimepath+=~/.vim/bundle/Vundle.vim
set encoding=utf-8

" Vundle plugins
call vundle#begin()
    Plugin 'tpope/vim-sensible'
    Plugin 'vim-python/python-syntax'
    Plugin 'terryma/vim-multiple-cursors'
    Plugin 'VundleVim/Vundle.vim'
    Plugin 'w0rp/ale'
    Plugin 'beanworks/vim-phpfmt'
    Plugin 'cakebaker/scss-syntax.vim'
    "Plugin 'vim-syntastic/syntastic'
    Plugin 'leafgarland/typescript-vim'
    "Plugin 'chiedo/vim-case-convert'
    "Plugin 'chiedo/vim-dr-replace'
    Plugin 'chiedo/vim-live-reload'
    "Plugin 'chiedo/vim-px-to-em'
    "Plugin 'chiedo/vim-sort-blocks-by'
    "Plugin 'panozzaj/vim-autocorrect'
    "Plugin 'jiangmiao/auto-pairs'
    Plugin 'danro/rename.vim'
    "Plugin 'fatih/vim-go'
    "Plugin 'lumiliet/vim-twig'
    "Plugin 'ntpeters/vim-better-whitespace'
    Plugin 'nathanaelkane/vim-indent-guides'
    Plugin 'pangloss/vim-javascript'
    Plugin 'mxw/vim-jsx'
    "Plugin 'tpope/vim-sleuth'
    "Plugin 'tristen/vim-sparkup'
    "Plugin 'triglav/vim-visual-increment'
    "Plugin 'vim-scripts/Align'
    Plugin 'nanotech/jellybeans.vim'
    "Plugin 'scrooloose/nerdcommenter'
    "Plugin 'scrooloose/syntastic'
    "Plugin 'jmcantrell/vim-virtualenv'
    "Plugin 'mhinz/vim-signify'
    "Plugin 'lilydjwg/colorizer'
    Plugin 'elixir-editors/vim-elixir'
    "Plugin 'vasconcelloslf/vim-interestingwords'
    "Plugin 'tmhedberg/matchit'
    "Plugin 'bronson/vim-trailing-whitespace'
    "Plugin 'bling/vim-airline'
    "Plugin 'Valloric/YouCompleteMe'
    "Plugin 'SirVer/ultisnips'
    "Plugin 'honza/vim-snippets'
    "Plugin 'bentayloruk/vim-react-es6-snippets'
    Plugin 'kien/ctrlp.vim'
    "Plugin 'tpope/vim-fugitive'
    "Plugin 'othree/javascript-libraries-syntax.vim'
    "Plugin 'jelera/vim-javascript-syntax'
    "Plugin 'mustache/vim-mustache-handlebars'
    "Plugin 'briancollins/vim-jst'
call vundle#end()

filetype on
filetype plugin indent on
syntax on
set background=dark
set relativenumber
set cursorline

colors jellybeans

set expandtab
set smarttab

set shiftwidth=2
set softtabstop=2
set tabstop=2

set autoindent

"experimental
set smartindent
" The following replacing the above may fix indent issues I've been having
"set cindent

set incsearch

set ignorecase

set smartcase

"Variable highlighting
"autocmd CursorMoved * exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))



" When I close a tab, remove the buffer
set nohidden

set statusline+=%c, "cursor column
set statusline+=%l/%L "cursor line/total lines
set statusline+=%F
set statusline+=\ %P "percent through file
set laststatus=2

set nu

"File perecentage"
set ruler

set clipboard=unnamed

" mouse support
if has("mouse")
    if !has('nvim')
        set mouse=a
        set ttymouse=xterm2
    endif
endif

"Added this for the align plugin
set nocp


"For Eclim
filetype plugin  on

"No annoying swap files
set noswapfile

"Helptags

"Easymotion needs
let g:EasyMotion_leader_key = '<Leader>'

"Turn on indent guides by default
let g:indent_guides_enable_on_vim_startup = 1

" Lint JS
"let g:syntastic_javascript_checkers = ['eslint']
let g:ale_linters = {'javascript': ['eslint']}
let g:ale_fixers = {'javascript': ['eslint']}
let g:ale_fixers = {'js': ['eslint']}
let g:ale_fixers = {'jsx': ['eslint']}

" Lint RB
"let g:syntastic_ruby_checkers = ['rubocop']
"let g:syntastic_ruby_exec = '/usr/local/opt/rbenv/versions/2.2.3/bin/ruby'
let g:ale_linters = {'rb': ['rubocop']}
let g:ale_fixers = {'rb': ['rubocop']}

" Lint Elixir
let g:ale_linters = {'exs': ['credo']}
let g:ale_fixers = {'exs': ['credo']}

" Lint PHP
" Didn't work so used phpfmt instead
"let g:syntastic_javascript_checkers = ['eslint']
"let b:ale_linters = {'php': ['php-cs-fixer']}

"Lint CSS
let g:ale_linters = {'css': ['stylelint']}
let g:ale_linters = {'scss': ['stylelint']}
let g:ale_fixers = {'css': ['stylelint']}
let g:ale_fixers = {'scss': ['stylelint']}

"Lint Python
let g:ale_linters = {'py': ['pylint']}
let g:ale_fixers = {'py': ['pylint']}

" Enable lint fixing on save
let g:ale_fix_on_save = 1

"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 1

" Better airline stuff
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 0

"always show column number
set ruler

"stop from saving twice
set nowritebackup

"no more tab limit
set tabpagemax=100

"Fix backspace bug
set backspace=2

" Allow jsx syntax with .js extension
let g:jsx_ext_required = 0

" Update to use the font for airline plugin
if has("gui_running")
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
        set guifont=Source\ Code\ Pro\ for\ Powerline "
    endif
endif

" In your ~/.vimrc
"
" Normal mode
"nnoremap <C-j> :m .+1<CR>==
"nnoremap <C-k> :m .-2<CR>==

" Insert mode
"inoremap <C-j> <ESC>:m .+1<CR>==gi
"inoremap <C-k> <ESC>:m .-2<CR>==gi

" Visual mode
"vnoremap <C-j> :m '>+1<CR>gv=gv
"vnoremap <C-k> :m '<-2<CR>gv=gv

" Load autocorrections
source ~/.vim/autocorrections.vim

" Vim-javascript configs
let g:javascript_enable_domhtmlcss=1

" make sure that paste and delete no longer overwrite the buffer when pasting
" and deleteing
nnoremap d "_d
vnoremap d "_d
vnoremap p "_dP

"Git Gutter
map <F3> :SignifyToggle<CR>

"Matt Tricks
map <leader>so :source $MYVIMRC
nnoremap Y y$
let g:interestingWordsGUIColors = ['#8CCBEA', '#A4E57E', '#FFDB72', '#FF7272', '#FFB3FF', '#9999FF']
nnoremap <silent> <leader>k :call InterestingWords('n')<cr>
nnoremap <silent> <leader>k :call UncolorAllWords()<cr>

if !has('nvim')
  if version >= 704
    " YouCompleteMe stuff
    let g:ycm_confirm_extra_conf=0
    let g:ycm_add_preview_to_completeopt=0
    let g:ycm_key_list_select_completion = ['<C-TAB>', '<Down>']
    let g:ycm_key_list_previous_completion = ['<C-S-TAB>', '<Up>']
    let g:SuperTabDefaultCompletionType = '<C-Tab>'

    "" UtilSnip YouCompleteMe Playing together
    "function! g:UltiSnips_Complete()
        "call UltiSnips#ExpandSnippet()
        "if g:ulti_expand_res == 0
            "if pumvisible()
                "return "\<C-n>"
            "else
                "call UltiSnips#JumpForwards()
                "if g:ulti_jump_forwards_res == 0
                   "return "\<TAB>"
                "endif
            "endif
        "endif
        "return ""
    "endfunction

    "au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
    "let g:UltiSnipsJumpForwardTrigger="<tab>"
    "let g:UltiSnipsListSnippets="<c-e>"
    " this mapping Enter key to <C-y> to chose the current highlight item
    " and close the selection list, same as other IDEs.
    " CONFLICT with some plugins like tpope/Endwise
    inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  endif
endif

"""""" Auto insert-mode for paste
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()


"Make Vim treat rabl file as rb
au BufRead,BufNewFile *.rabl setf ruby

" Control P (ctrlp) stuff
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|.git\|vendor\|bower_components'

" Remove whitespace on save
"autocmd BufEnter * EnableStripWhitespaceOnSave

""" Cheatsheet
"" In Vim
" Update all open tabs - :tabdo %s/searchfor/relacewith/g | update
" ctrl + E - Spark up
" ctrl + A - Increment number in selected numbers
" ciw - Replace current word
" :Rename newname - rename the current window
" " 0 p - Paste withoun overwriting buffer
" :g/string/d - Get all lines containing a string and delete them
" :g!/string/d - Get all lines not containing a string and delete them
" Cntrl + j - Move selected text or current line up
" Cntrl + k - Move selected text or current line down
" Nerd commenter
"" <Leader>cc - comment single line comment of highligted text
"" <Leader>cs - comment mulit line comment of highligted text
"" <Leader>cu - uncomment commented highlighted text
" gg - go to the top of the page
" GG - go to the bottom of the page
" :Em - convert all selected pixels to ems
" :Px - convert all selected ems to pixels
" :LiveReload! - Make the current file automatically update as it is changed externally. This command toggles. A
" :Search and replace on all files
"   :args *.extension_name
"   :argdo %s/searchfor/replacewith/ge
"   :argdo update
" Open multiple tabs at once from within vim
"   :args *.extension_name | argdo tabe | tabdo syntax on
" cntrl x cntrl f - File name completion
" F3 - toggle on and off git gutter
" <Leader>k - make an interesting word highlighted
" <Leader>K - make all interesting words unhighlighted
" :Errors then :lne or :pne to traverse errors
" :bufdo! COMMAND - command across all tabs
" cntrl-p
" Multiple cursors: Cntrl n as many times to find matches on current word.
" Then v to get into visual mode where I can do stuff


"" In Terminal
" vim -p * - Open multiple files at once in multiple tabs
" grep -ril 'SEARCH' . | xargs -o vim -p - Open multiple files found by grep
"   search
" Cmd + Shift + left or right - switch terminal tab
" perl -p -i -e 's/oldstring/newstring/g' `grep -ril searchpattern *` -
"   find and replace all files matched by grep
" xxd filename.blah | vim -   Note the dash to the left is important. Opens a
" file in binary

