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

" C言語向けインデント
"set cindent

" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
  endif

" ウィンドウの幅より長い行は折り返して、次の行に続けて表示する
set wrap

" コマンドをステータス行に表示
set showcmd

" ステータスラインを常に表示
set laststatus=2

" ステータスラインに表示する情報の指定
set statusline=%<%F\ %r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%4v(ASCII=%03.3b,HEX=%02.2B)\ %l/%L(%P)%m

" マウスを使用可能にする
set mouse=a

" 256 Colors
set t_Co=256

" スキーマ指定
colorscheme BlackSea

" 検索時に大文字小文字を区別しない
set ignorecase

" 最後まで検索したら先頭へ戻る
set wrapscan

" 検索結果文字列のハイライトを有効にする
set hlsearch

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
" fileencodingsの設定ではencodingの値を一番最後に記述する
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,euc-jp,cp932,iso-2022-jp
set fileencodings+=,ucs-2le,ucs-2,utf-8

" バックスペースですべて消せるように
set backspace=indent,eol,start

" インデントを使えるようにする
filetype indent on

" 文字列中のSQLをハイライトする
let php_sql_query=1 

" 文字列中のHTMLをハイライトする
let php_htmlInStrings=1 

" php の関数辞書
autocmd FileType php  :set dictionary=~/.vim/dict/php.dict

" Enterを押したときに補完のポップアップを消す
inoremap <expr> <CR> pumvisible() ? "\<C-Y>\<CR>":"\<CR>"

" プラグインを使えるようにする
filetype plugin on

" Neocomplcacheの自動起動設定
let g:neocomplcache_enable_at_startup = 1
" Neocomplcacheのリスト表示件数
let g:neocomplcache_max_list = 50
" Neocomplcacheの表示文字数
let g:neocomplcache_max_filename_width = 15
" Neocomplcacheのリスト表示開始文字数
let g:neocomplcache_auto_completion_start_length = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '' ,
    \ 'php' : $HOME.'/.vim/dict/php.dict'
    \ }

" 日本語をキャッシュしない
"let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

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
" Autocompletion using the TAB key
 
function PHPLint()
let result = system( &ft . ' -l ' . bufname(""))
echo result
endfunction

autocmd FileType php  :nmap ,l :call PHPLint()<CR>

