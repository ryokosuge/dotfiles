" ********** vim の設定 ********** "
set nocompatible

filetype off

set rtp+=~/dotfiles/vimfiles/vundle.git/
call vundle#rc()

" ********** githubにあるプラグイン ********** "
" ex) 'account / repository'
Bundle 'Shougo/neocomplcache'
Bundle 'thinca/vim-quickrun'
Bundle 'othree/html5.vim'
Bundle 'hail2u/vim-css3-syntax'

" ********** vim-scriptにあるプラグイン ********** "
" ex) 'file_name'

" ********** githubにないプラグイン ********** "
" ex) 'git:// fullpath '

"
filetype plugin indent on
"
" 行番号を表示
set number

" ファイルの<tab>が対応する空白の数
set tabstop=4

" シフト移動幅
set shiftwidth=4

" タブの代わりに空白文字を使う
set expandtab

" ファイル名を表示
set title

" 閉じ括弧が入力された時、対応する括弧を表示する
set showmatch

" 新しい行のインデントを現在行と同じにする
set autoindent

"
set showcmd

" 検索時に大文字小文字を区別しない
set ignorecase

" 検索をファイルの先頭にループしない
set nowrapscan

" 新しい行を作った時に高度な自動インデントを行う
set smartindent

" カレントウィンドウにのみ罫線を引く
augroup cch
    autocmd! cch
    autocmd WinLeave * set nocursorline
    autocmd WinEnter,BufRead * set cursorline
augroup END
" *********   Opsplore[プラグイン] の設定   *********
" ファイルエクスプローラーの横幅
:let s:split_width=100
nnoremap ,o :Opsplore<CR>

" **********ステータスライン表示*************** "

set laststatus=2

set statusline=%f%=%<%m%r[%{(&fenc!=''?&fenc:&enc)}][%{&ff}][%Y][%v,%l/%L]

" ********************************************* "

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

" QuickBuf: qbuf.vim
let g:qb_hotkey = ",b"

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
