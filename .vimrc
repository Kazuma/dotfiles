" ソフトタブの設定
set expandtab

" ファイル中の<TAB>文字を指定文字分で表示する
set tabstop=4

" vim が挿入するインデントやシフトオペレータで挿入/削除されるインデントの幅
set shiftwidth=4

" <TAB>を押した時に挿入される空白数
set softtabstop=4

" スマートインデントを有効にする
set smartindent

" □とか○の文字があってもカーソル位置がずれないようにする
"if exists('&ambiwidth')
  set ambiwidth=double
"  endif

" ウィンドウの幅より長い行は折り返して、次の行に続けて表示する
set wrap

" 入力中のコマンドをステータス行に表示
set showcmd

" ステータスラインを常に表示
set laststatus=2

" ステータスラインに表示する情報の指定
set statusline=%<%F\ %r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%{synIDattr(synID(line('.'),col('.'),1),'name')}\ %l/%L(%P)%m

" マウスを使用可能にする
set mouse=a

" 256 Colors
set t_Co=256

" スキーマ指定
colorscheme BlackSea

"検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase

"検索文字列に大文字が含まれている場合は区別して検索する
set smartcase

" 最後まで検索したら先頭へ戻る
set wrapscan

" 検索結果文字列のハイライトを有効にする
set hlsearch

"検索時にインクリメンタルサーチを行う
set incsearch
set showmode

" 起動時のメッセージを表示しない
set shortmess+=I

" 行番号を表示
set number

" 閉じ括弧が入力されたとき、対応する括弧を表示
set showmatch

" クリップボードをWindowsと連携
set clipboard=unnamed

" シンタックスハイライトを有効にする
syntax on

" 改行コードの自動認識
set fileformats=unix,dos,mac

" ルーラー(右下に表示される行・列の番号)を表示
set ruler

" viとの互換性をなくす
set nocompatible

" ビープ音を鳴らさない
set vb t_vb=

" コマンドライン補完を拡張モードにする
set wildmenu

" 文字コードの設定
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,euc-jp,cp932,iso-2022-jp

" バックスペースですべて消せるように
set backspace=indent,eol,start

" インデントを使えるようにする
filetype indent on

" 文字列中のSQLをハイライトする
let php_sql_query=1 

" 文字列中のHTMLをハイライトする
let php_htmlInStrings=1 

" Enterを押したときに補完のポップアップを消す
inoremap <expr> <CR> pumvisible() ? "\<C-Y>\<CR>":"\<CR>"

" プラグインを使えるようにする
filetype plugin on

" <TAB>で補完
function! InsertTabWrapper()
    let col = col('.') - 1
        if !col || getline('.')[col - 1] !~ '\k'
            return "\<TAB>"
        else
            if pumvisible()
                return "\<C-N>"
            else
                return "\<C-N>\<C-P>"
            end
        endif
endfunction
" Remap the tab key to select action with InsertTabWrapper
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
 
" 画面分割時に自動で幅を決める
nnoremap <C-w>h <C-w>h:call <SID>good_width()<Cr>
nnoremap <C-w>l <C-w>l:call <SID>good_width()<Cr>
nnoremap <C-w>H <C-w>H:call <SID>good_width()<Cr>
nnoremap <C-w>L <C-w>L:call <SID>good_width()<Cr>
function! s:good_width()
    if winwidth(0) < 84
        vertical resize 84
    endif
    endfunction

" 行末の不要なスペースを削除する
function! RTrim()
%s/\s\+$//e
endfunction
autocmd BufWritePre *.php,*.rb,*.js,*.tpl,*.ihtml,*.bat call RTrim()

" Escの2回押しでハイライト消去
nnoremap <Esc><Esc> :<C-u>set nohlsearch<Return>
nnoremap / :<C-u>set hlsearch<Return>/


"===============================================
" Plugin
"===============================================
" pathogen.vim の設定
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype on

" Markdown の拡張子設定
autocmd BufRead,BufNewFile *.md       setfiletype mkd
autocmd BufRead,BufNewFile *.mkd      setfiletype mkd
autocmd BufRead,BufNewFile *.mkdn     setfiletype mkd
autocmd BufRead,BufNewFile *.mdown    setfiletype mkd
autocmd BufRead,BufNewFile *.markdown setfiletype mkd

" qfixapp の設定
set runtimepath+=~/.vim/bundle/qfixapp/ftplugin/qfixapp          " qfixapp に runtimepath を通す
let QFixHowm_Key = 'g'                                           " キーマップリーダー
let QFixHowm_RootDir = '~/Dropbox/howm'                          " howm_dir ルートディレクトリ
lef howm_dir = '~/Dropbox/howm'                                  " howm_dir ホームディレクトリ
let howm_filename = '%Y/%m/%Y-%m-%d-%H%M%S.howm'                 " ファイル名
let howm_fileencoding = 'utf-8'                                  " 文字コード
let howm_fileformat = 'unix'                                     " ファイルフォーマット
let mygrepprg = 'grep'                                           " 内蔵 grep
let MyGrep_ShellEncoding = 'utf-8'                               " シェルの文字コード

" Neocomplcache の設定
let g:neocomplcache_enable_at_startup = 1                       " Neocomplcache の自動起動設定
let g:neocomplcache_max_list = 50                               " Neocomplcache のリスト表示件数
let g:neocomplcache_max_filename_width = 15                     " Neocomplcache の表示文字数
let g:neocomplcache_auto_completion_start_length = 1            " Neocomplcache のリスト表示開始文字数
let g:neocomplcache_enable_smart_case = 1                       " Use smartcase.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '' ,
    \ 'php' : $HOME.'/.vim/bundle/php/dict/php.dict'
    \ }


"===============================================
" PHP
"===============================================
" php の関数辞書
autocmd FileType php  :set dictionary=~/.vim/bundle/php/dict/php.dict
autocmd FileType php  :nmap ,l :call PHPLint()<CR>

function PHPLint()
    let result = system( &ft . ' -l ' . bufname(""))
        echo result
endfunction


"===============================================
" Perl
"===============================================
" perltidy
map ,pt <ESC>:%! perltidy<CR>
map ,ptv <ESC>:%'<, '>! perltidy<CR>
" Perl 辞書ファイル読み込み
autocmd FileType perl :set dictionary+=~/.vim/bundle/perl/dict/perl_functions.dict
