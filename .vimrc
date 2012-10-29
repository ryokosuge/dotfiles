" ********** vim の設定 ********** "
"-------------------------------------------------------------------------------
""" vendle.vim プラグイン
"-------------------------------------------------------------------------------

set nocompatible

filetype off

set rtp+=~/dotfiles/vimfiles/vundle.git/
call vundle#rc()

" ********** githubにあるプラグイン ********** "
" ex) 'account / repository'
Bundle 'Shougo/neocomplcache'
Bundle 'thinca/vim-quickrun'
Bundle 'Shougo/unite.vim'
Bundle 'othree/html5.vim'
Bundle 'hail2u/vim-css3-syntax'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-cucumber'
Bundle 'itspriddle/vim-javascript-indent'
Bundle 'kchmck/vim-coffee-script'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'groenewege/vim-less'
" ********** vim-scriptにあるプラグイン ********** "
" ex) 'file_name'
Bundle 'JavaScript-syntax'
" ********** githubにないプラグイン ********** "
" ex) 'git:// fullpath '
syntax on
"
filetype plugin indent on
"
"-------------------------------------------------------------------------------
""" 初期設定
"-------------------------------------------------------------------------------
set encoding=utf-8
set ruler
" 行番号を表示
set number
" ファイル名を表示
set title
" 閉じ括弧が入力された時、対応する括弧を表示する
set showmatch
"
set showcmd
"-------------------------------------------------------------------------------
"" タブ設定
"-------------------------------------------------------------------------------
" ファイルの<tab>が対応する空白の数
set tabstop=4
" シフト移動幅
set shiftwidth=4
" タブの代わりに空白文字を使う
set expandtab
"-------------------------------------------------------------------------------
"" インデント設定
"-------------------------------------------------------------------------------
" 新しい行のインデントを現在行と同じにする
set autoindent
" 新しい行を作った時に高度な自動インデントを行う
set smartindent
"-------------------------------------------------------------------------------
"" 検索設定
"-------------------------------------------------------------------------------
" 検索時に大文字小文字を区別しない
set ignorecase
" 検索をファイルの先頭にループしない
set nowrapscan

"-------------------------------------------------------------------------------
"" バックアップファイルとswapの設定
"-------------------------------------------------------------------------------
" swapファイルを作成しない
:set noswapfile
" backupファイルを作成しない
:set nobackup
"-------------------------------------------------------------------------------
"" ファイルの種類とomni
"-------------------------------------------------------------------------------
autocmd BufNewFile,BufRead *.vimrc set filetype=vim
autocmd BufNewFile,BufRead *.phtml set filetype=html
autocmd BufNewFile,BufRead *.less set filetype=less
autocmd FileType eruby,html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
" sql syntax in string
let php_sql_query=1
" html syntax in string
let php_htmlInStrings=1
" ban short tag
let php_noShortTags=1

"-------------------------------------------------------------------------------
"" ステータスライン
"-------------------------------------------------------------------------------
"ステータスライン表示
set laststatus=2
set statusline=%f%=%<%m%r[%{(&fenc!=''?&fenc:&enc)}][%{&ff}][%Y][%v,%l/%L]

" 挿入モードをステータスラインの色で判断
if !exists('g:hi_insert')
    let g:hi_insert = 'highlight StatusLine guifg=White guibg=DarkCyan gui=none ctermfg=White ctermbg=DarkCyan cterm=none'
endif

if has('unix') && !has('gui_running')
    inoremap <silent> <ESC> <ESC>
    inoremap <silent> <C-[> <ESC>
endif

if has('syntax')
    augroup InsertHook
        autocmd!
        autocmd InsertEnter * call s:StatusLine('Enter')
        autocmd InsertLeave * call s:StatusLine('Leave')
    augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
    if a:mode == 'Enter'
        silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
        silent exec g:hi_insert
    else
        highlight clear StatusLine
        silent exec s:slhlcmd
    endif
endfunction

function! s:GetHighlight(hi)
    redir => hl
    exec 'highlight '.a:hi
    redir END
    let hl = substitute(hl, '[\r\n]', '', 'g')
    let hl = substitute(hl, 'xxx', '', '')
    return hl
endfunction

"----------------------------------------------------
"" オートコマンド
"----------------------------------------------------
if has("autocmd")
    " ファイルタイプ別インデント、プラグインを有効にする
    filetype plugin indent on
    " カーソル位置を記憶する
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif
endif

"-------------------------------------------------------------------------------
""" キーバインド
"-------------------------------------------------------------------------------
"""カーソルキーを封印
map <Up> <Nop>
map <Right> <Nop>
map <Down> <Nop>
map <Left> <Nop>
imap <Up> <Nop>
imap <Right> <Nop>
imap <Down> <Nop>
imap <Left> <Nop>

" 挿入モードでのカーソル移動
inoremap <C-k> <Up>
inoremap <C-l> <Right>
inoremap <C-j> <Down>
inoremap <C-h> <Left>

"-------------------------------------------------------------------------------
""" ハイライト設定
"-------------------------------------------------------------------------------
" 検索
set hlsearch
" <ESC> を連打で検索ハイライトをキャンセル
nmap <Esc><ESC> :nohlsearch<CR><ESC>
" 全角スペースのハイライト
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme       * call ZenkakuSpace()
        autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
    augroup END
    call ZenkakuSpace()
endif
" カレントウィンドウにのみ罫線を引く
augroup cch
    autocmd! cch
    autocmd WinLeave * set nocursorline
    autocmd WinEnter,BufRead * set cursorline
augroup END

"-------------------------------------------------------------------------------
""" Opsplore プラグイン
"-------------------------------------------------------------------------------
" ファイルエクスプローラーの横幅
:let s:split_width=100
noremap <C-O><C-P> :Opsplore<CR>

"-------------------------------------------------------------------------------
""" quickbuf プラグイン
"-------------------------------------------------------------------------------
let g:qb_hotkey = "<C-B>"

"-------------------------------------------------------------------------------
""" unite.vim プラグイン
"-------------------------------------------------------------------------------
" 入力モードで開始する
let g:unite_enable_start_insert=0
" バッファ一覧
noremap <C-U><C-B> :Unite buffer<CR>
" ファイル一覧
noremap <C-U><C-F> :UniteWithBufferDir -buffer-name=files file<CR>
" 最近使ったファイルの一覧
noremap <C-U><C-R> :Unite file_mru<CR>
" レジスタ一覧
noremap <C-U><C-Y> :Unite -buffer-name=register register<CR>
" ファイルとバッファ
noremap <C-U><C-U> :Unite buffer file_mru<CR>
" 全部
noremap <C-U><C-A> :Unite UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

"-------------------------------------------------------------------------------
""" neocomplcache.vim プラグイン
"-------------------------------------------------------------------------------
" AutoComplPop を無効かする設定
let g:acp_enableAtStartup=0
" neocomplcache を起動時に有効化
let g:neocomplcache_enable_at_startup = 1
" neocomplcache の smart case 機能を有効化
let g:Neocomplcache_SmartCase=1
" neocomplcache の calme case 機能を有効化
let g:Neocomplcache_EnableCamelCaseCompletion=1
" neocomplcache の _区切りの補完を有効化
let g:Neocomplcache_EnableUnderbarCompletion=1
" neocomplcache のシンタックスをキャッシュするときの最小文字を3にする
let g:Neocomplcache_MinSyntaxLength=3
" manual completion の長さの設定
let g:NeoComplCache_ManualCompletionStartLength =0
" Print caching percent in statusline
let g:NeoComplCache_CahingPercentInStatusline=1

" 辞書の登録
let g:NeoComplCache_DictionaryFileTypeLists = {
    \ 'default' : '',
    \ }

" Define Keyword.
if !exists('g:NeoComplCache_KeywordPatterns')
    let g:NeoComplCache_KeywordPatterns = {}
endif

let g:NeoComplCache_KeywordPatterns['default'] = '\v\h\w*'
let g:NeoComplCache_SnippetsDir=$HOME.'/snippets'

noremap <C-N><C-C><C-E> :NeoComplCacheEnable<CR>
noremap <C-N><C-C><C-D> :NeoComplCacheDisable<CR>

