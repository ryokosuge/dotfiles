" ********** vim の設定 ********** "
set nocompatible

filetype off

set rtp+=~/dotfiles/vimfiles/vundle.git/
call vundle#rc()

Bundle 'Shougo/neocomplcache'
Bundle 'thinca/vim-quickrun'

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

" **********ステータスライン表示*************** "

set laststatus=2

set statusline=%f%=%<%m%r[%{(&fenc!=''?&fenc:&enc)}][%{&ff}][%Y][%v,%l/%L]

" ********************************************* "
