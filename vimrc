" MyVimrc
call plug#begin('~/.vim/plugged')

"Paths
let $VIMFILES=$HOME.'/.vim' "设定用户vim配置目录$VIMFILES
"let helptags=$VIMFILES.'/doc' "设定帮助文档目录

"Chinese 配置多语言环境  UTF-8 编码
language messages zh_CN.utf-8
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,chinese

set termencoding=utf-8
set formatoptions+=mM
set fencs=utf-8,gbk

"要查看所有的历史记录,用命令: ":history" 列出的是冒号的历史记录,要查看搜索命令的历史记录,用: ":history /"
set history=50

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keymap
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=',' " 设置leader键

" 快捷加载,当输入',ss'时，加载 .vimrc 文件
map <silent> <leader>ss :source ~/.vimrc<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UI & Color & Theme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set guioptions-=r
set guioptions-=L
set guioptions-=T

syntax enable                  " syntex highlight
Plug 'sheerun/vim-polyglot'
Plug 'tomasr/molokai'
colorscheme molokai
set guifont=Inconsolata:h15
set number " show line number
set laststatus=2 " always show statusbar
" set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set statusline=
set statusline +=%1*\ %n\ %*            "buffer number
set statusline +=%5*%{&ff}%*            "file format
set statusline +=%3*%y%*                "file type
set statusline +=%4*\ %<%F%*            "full path
set statusline +=%2*%m%*                "modified flag
set statusline +=%1*%=%5l%*             "current line
set statusline +=%2*/%L%*               "total lines
set statusline +=%1*%4v\ %*             "virtual column number
set statusline +=%2*0x%04B\ %*          "character under cursor}

set cursorline
set ruler " noruler
set showcmd
set cmdheight=1 " 设定命令行的行数为 1


" NerdTree use <F2>
Plug 'scrooloose/nerdtree'
let g:NERDTreeWinPos='left'
let g:NERDTreeWinSize=31
let g:NERDTreeChDirMode=1
let g:NERDTreeShowHidden=1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
" let g:NERDTreeSortOrder           " 排序规则
" let g:NERDTreeIgnore           " 默认的忽略文件
" let g:NERDTreeMouseMode        " 指定鼠标模式（1.双击打开；2.单目录双文件；3.单击打开）
let g:NERDTreeShowBookmarks=0    "  是否默认显示书签列表
let g:NERDTreeBookmarksFile=$VIMFILES.'/NERDTreeBookmarks.txt'
let NERDTreeIgnore=['\.DS_Store$']
map <F2> :NERDTreeToggle<CR>
" imap <F2> <ESC>:NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Xuyuanp/nerdtree-git-plugin'
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }


" Plug 'fholgado/minibufexpl.vim'
" " let g:miniBufExplMapWindowNavVim = 1
" let g:miniBufExplMapWindowNavArrows = 1
" let g:miniBufExplMapWindowNavVim = 1
" let g:miniBufExplMapCTabSwitchBufs = 1
" let g:miniBufExplModSelTarget = 1
" let g:miniBufExplorerMoreThanOne=0


" Tagbar  use <F3>
" ------------------------------------------------------------
Plug 'majutsushi/tagbar'
let g:tagbar_ctags_bin = '/usr/local/ctags/bin/ctags'
let g:tagbar_width = 30
let g:tagbar_iconchars = ['▸', '▾']
let g:tagbar_autoshowtag = 1
map <F3> :TagbarToggle<CR>
imap <F3> <ESC>:TagbarToggle<CR>

function! AutoLoadCTagsAndCScope()
let max = 5
let dir = './'
let i = 0
let break = 0
while isdirectory(dir) && i < max
    if filereadable(dir . 'cscope.out')
        execute 'cs add ' . dir . 'cscope.out'
        let break = 1
    endif
    if filereadable(dir . 'tags')
        execute 'set tags =' . dir . 'tags'
        let break = 1
    endif
    if break == 1
        execute 'lcd ' . dir
        break
    endif
    let dir = dir . '../'
    let i = i + 1
endwhile
endf
nmap <F5> :call AutoLoadCTagsAndCScope()<CR>
"call AutoLoadCTagsAndCScope()

Plug 'tpope/vim-fugitive'

" AirLine
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" let g:airline_theme='powerlineish'
let g:airline_left_sep = '' " ▶
let g:airline_right_sep = '◀'
let g:airline_symbols = {}
let g:airline_symbols.linenr = 'L'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_enable_fugitive=1
let g:airline_section_b='%{fugitive#statusline()}'
let g:airline_section_c="%F"
let g:airline_section_x="%y"
" let g:airline_section_y='BN: %{bufnr("%")}' " buffer num
"设置顶部tabline栏符号显示"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#buffer_nr_format = '%s:'
let g:airline#extensions#tabline#fnamemod = ':p:t'
let g:airline#extensions#tabline#fnamecollapse = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = '◀'
let g:airline#extensions#tabline#right_alt_sep = ''




" let g:airline#extensions#whitespace#enabled = 0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File & Save
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set confirm
set autoread " 文件被外部的其它程序所修改后自动在Vim加载
set noswapfile "不生成交换文件
set wildmenu "在输入命令时列出匹配项目

map <TAB> :bn<CR>
map <C-TAB> :bp<CR>

" ctrlp
Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_root_markers = ['package.json']
set wildignore+=*/vendor/*

" Strip trailing whitespace
fun! StripTrailingWhitespace()
    " Don't strip on these filetypes
    if &ft =~ 'markdown'
        return
    endif
    %s/\s\+$//e
endfun

autocmd BufWritePre * call StripTrailingWhitespace()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hlsearch
set showmatch
set incsearch
set ignorecase smartcase " 搜索时忽略大小写，但在有一个或以上大写字母时仍保持对大小写敏感

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Edit & Syntax
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup " 覆盖文件时不备份

set expandtab
set tabstop=4 "tabwidth
set softtabstop=4 " 使得按退格键时可以一次删掉 4 个空格
set shiftwidth=4 " 设定 << 和 >> 命令移动时的宽度
"set smarttab " 开启时，在行首按TAB将加入sw个空格，否则加入ts个空格。
set smartindent " 开启新行时使用智能自动缩进

" indent guide
Plug 'nathanaelkane/vim-indent-guides'

" text align
Plug 'junegunn/vim-easy-align'

"nerdcommenter
Plug 'scrooloose/nerdcommenter'
let NERDSpaceDelims=1 " 让注释符与语句之间留一个空格
let NERDCompactSexyComs=1 " 多行注释时样子更好看

set tags=tags
set tags+=/Users/guojikai/workspace/stonechat/api_v1/tags
set tags+=/Users/guojikai/workspace/stonechat/api_v2/tags
set tags+=/Users/guojikai/workspace/tuanpu/web_v1/tags

set nofoldenable " 禁止折叠
set foldmethod=syntax " 设置语法折叠
set foldcolumn=0 " 设置折叠区域的宽度
setlocal foldlevel=1 " 设置折叠层数为
" set foldclose=all " 设置为自动关闭折叠
" nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
" 用空格键来开关折叠

" auto complete
Plug 'Shougo/neocomplete.vim'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'

"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 2
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" keymap
:inoremap ( ()<left>
        " :inoremap ) =ClosePair(')')
:inoremap { {}<left>
    " :inoremap } =ClosePair('}')
    " :inoremap [ []
    " :inoremap ] =ClosePair(']')
    " :inoremap < <>
    " :inoremap > =ClosePair('>')

    " function ClosePair(char)
    " if getline('.')[col('.') - 1] == a:char
    " return ""
    " else
    " return a:char
    " endif
    " endf

"-----------------------------------------------------------------
" syntax check
"-----------------------------------------------------------------
Plug 'scrooloose/syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_enable_highlighting = 0
" let g:syntastic_mode_map = { 'passive_filetypes': ['sass', 'haml'] }

"-----------------------------------------------------------------
" For Special File Type
"-----------------------------------------------------------------
" set file extension
au BufNewFile,BufRead *.twig set filetype=jinja
au BufNewFile,BufRead *.conf set filetype=nginx


" File: JSON
map <silent> <leader>js <Esc>:%!python -m json.tool<CR>

" File: Markdown
Plug 'godlygeek/tabular' | Plug 'plasticboy/vim-markdown'
let g:vim_markdown_folding_disabled = 1

" File: PHP

call plug#end()

